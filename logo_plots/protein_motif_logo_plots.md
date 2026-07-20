protein_motif_logo_plots
================
Janet Young

2026-07-20

# Read MEME output

Read meme.txt file using universalmotif::read_meme

``` r
meme_dir <- here("logo_plots/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme/")

meme_txt_file <- paste0(meme_dir, "meme.txt")

suppressMessages( meme_output <- universalmotif::read_meme(
    meme_txt_file, 
    readsites=TRUE, readsites.meta = TRUE ) )
# message = Could not find strand info, assuming +.
```

## Parse MEME output to get all instances

Put motif information into a simpler tbl called `all_motif_instances`
that has one row for every motif instance.

``` r
all_motif_instances <- lapply(names(meme_output[["sites.meta"]]), function(x) {
    meme_output[["sites.meta"]][[x]] |> 
        as_tibble() |> 
        mutate(motif_long_name=x) 
}) |> 
    bind_rows() |> 
    clean_names() |> 
    dplyr::rename(query_seq=sequence, 
                  instance_pval=pvalue, 
                  instance_seq=site) |> 
    relocate(motif_long_name)
```

Rename motifs based on their order in the human sequence
(`Human_EZHIP`), so that new names are EZHIP-1 to EZHIP-10:

``` r
human_motif_instances <- all_motif_instances |> 
    filter(query_seq=="Human_EZHIP") |> 
    arrange(position) |> 
    mutate(ezhip_motif_index=row_number()) |> 
    mutate(motif_id = paste0("EZHIP-", ezhip_motif_index)) |> 
    relocate(motif_id, ezhip_motif_index)
```

Get a simple tbl called `EZHIP_motif_summary` with one row for each of
the ten motifs, and add on the EZHIP-1-style name

``` r
EZHIP_motif_summary <- lapply(meme_output[["motifs"]], function(x) {
    output <- x |>
        as.data.frame()|>
        as_tibble() |> 
        mutate(eval_string = x@extrainfo) |> 
        mutate(width= ncol(x))
}) |> 
    bind_rows() |> 
    select(-family, -organism, -alphabet, -pval, -qval, -bkgsites, -strand) |> 
    dplyr::rename(motif_long_name=name,
                  orig_name=altname) |> 
    mutate(orig_index = as.integer(str_remove_all(orig_name, "MEME-"))) |> 
    left_join(human_motif_instances |>
                  select(motif_id, motif_long_name, ezhip_motif_index),
              by="motif_long_name") |> 
    relocate(motif_id, orig_name, orig_index, ezhip_motif_index) |> 
    arrange(ezhip_motif_index)
```

## Get PCMs for each motif, determine most common amino acids and their frequencies

Get each motif as a PCM (position count matrix)

``` r
meme_output_pcms <- lapply(meme_output[["motifs"]], function(x) {
    ## colnames are initially the amino acids in the motif name/consensus, rather than positions
    output <- convert_type(x,"PCM")@motif 
    colnames(output) <- 1:dim(output)[2]
    return(output)
})
names(meme_output_pcms) <- sapply(meme_output[["motifs"]], function(x) {x@name})
```

Now for each motif, we find the most common amino acid at each position,
and its frequency.

``` r
motifs_most_common_each_pos <- lapply(names(meme_output_pcms), function(x) {
    meme_output_pcms[[x]] |> 
        get_most_common_eachPos() |> 
        mutate(motif_long_name=x)
}) |> 
    bind_rows() |> 
    left_join(EZHIP_motif_summary |> 
                  select(motif_long_name, motif_id, ezhip_motif_index, orig_name),
              by="motif_long_name") |> 
    relocate(motif_long_name, motif_id, ezhip_motif_index, orig_name) |> 
    arrange(ezhip_motif_index, pos)|> 
    mutate(most_common_perc = 100*most_common_freq)
```

## Output fasta files of all instances for each motif

We use these to make HMMs to search genomes for additional homologs

First we add EZHIP-style names to `all_motif_instances` to create
`all_motif_instances_plusInfo`.

``` r
all_motif_instances_plusInfo <- all_motif_instances |> 
    left_join(human_motif_instances |> 
                  select(motif_long_name, motif_id, ezhip_motif_index), 
              by="motif_long_name") |> 
    relocate(motif_id, ezhip_motif_index) |> 
    ## join MEME_style ID back to all_motif_instances
    left_join(EZHIP_motif_summary |> 
                  select(motif_long_name, orig_name, orig_index),
              by="motif_long_name") |> 
    relocate(orig_name, orig_index)
```

Then we use `all_motif_instances_plusInfo` to export fasta files of the
motif instances for each motif (they’ll be aligned by default) so that I
can make HMMs to scan the genome with.

``` r
all_motif_instances_forFasta <- split(all_motif_instances_plusInfo, all_motif_instances_plusInfo$motif_id)

all_motif_instances_forFasta <- lapply(all_motif_instances_forFasta, function(x) {
    aa <- AAStringSet(x$instance_seq)
    names(aa) <- paste(x$motif_id, x$query_seq, sep="_")
    return(aa)
})

## actually write fasta files    
output_dir <- paste0(meme_dir, "motif_instance_fasta_files/")

temp <- lapply(names(all_motif_instances_forFasta), function(x) {
    outfile <- paste0(output_dir, x, ".fasta")
    writeXStringSet(all_motif_instances_forFasta[[x]], filepath = outfile)
    return(NULL)
})
rm(temp)
```

For motif 9 I will also save fasta file for a trimmed version, positions
3-16 - just the more conserved positions (AVRMRASSPSPPGR)

``` r
motif9_trimmed <- narrow(all_motif_instances_forFasta[["EZHIP-9"]], start=3, end=16)
writeXStringSet(motif9_trimmed, filepath = paste0(output_dir, "EZHIP-9-trimmed_3to16.fasta"))
```

Then, on the linux command line, we make HMMs for each motif as follows:

First we change to the directory where our R script output the instances
for each motif:

    cd EZHIP_evolution/logo_plots/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme/motif_instance_fasta_files 

Then we run a script called run_hmmbuild.pl which creates and runs a
shell script for each motif

    ../../../other_scripts/run_hmmbuild.pl EZHIP*fasta

The shell scripts each contain commands like this:

    module load HMMER/3.4-gompi-2023a
    hmmbuild EZHIP-1.fasta.hmm EZHIP-1.fasta
    hmmpress EZHIP-1.fasta.hmm

## Show motif logo plots, adding stars for conserved residues (80% threshold)

Show all logo plots - use \* to highlight residues in \>=80% of motif
instances

``` r
new_logo_plots_ggseqlogo <- lapply(1:nrow(EZHIP_motif_summary), function(i) {
    ## so I can make sure they're all on the same scale:
    max_width <-  max(EZHIP_motif_summary$width)
    
    ## get info on THIS motif
    this_motif_info <- EZHIP_motif_summary |> 
        filter(ezhip_motif_index==i)
    
    ## get conserved positions
    temp_df <- motifs_most_common_each_pos |> 
        filter(motif_id==this_motif_info$motif_id) |> 
        filter(most_common_freq>=0.8) |> 
        select(pos, most_common, most_common_freq) |> 
        mutate(y_pos=4.4) |> 
        mutate(symbol="*")
    
    p1 <- convert_type(meme_output[["motifs"]][[this_motif_info$orig_index]],"PPM")["motif"] |> 
        ggseqlogo(col_scheme=weblogo_chemistry_color_scheme_ggseqlogo) +
        guides(fill = "none") 
    
    ## change axis limits
    suppressMessages( p1 <- p1 + 
                          coord_cartesian(xlim=c(1,max_width),
                                          ylim=c(0,4.8)))
    
    ## plot aesthetics
    p1 <- p1 +
        geom_text(data=temp_df, 
                  aes(x=pos, y=y_pos, label=symbol),
                  inherit.aes = FALSE,
                  size=5) + 
        labs(title=this_motif_info$motif_id,
             subtitle=paste0(  "E=", this_motif_info$eval_string, " ; ",
                               "n=", this_motif_info$nsites,
                               " (", this_motif_info$orig_name, ")")) +
        scale_y_continuous(breaks = 0:4) + # Manually specify y-axis ticks 
        theme(spacing=unit(5, "points"),
              axis.text.x=element_blank(), 
              ## y axis:
              axis.line.y=element_line(linewidth=0.25), 
              axis.ticks.y=element_line(linewidth=0.25),
              axis.text.y=element_text(size=6),
              axis.title.y=element_text(size=8),
              title=element_text(size=7),
              plot.subtitle=element_text(size=6)) 
    
    p1
})

names(new_logo_plots_ggseqlogo) <- EZHIP_motif_summary$motif_id

### show all logos:
p1 <- wrap_plots( new_logo_plots_ggseqlogo,
                  ncol = 1, 
                  byrow = FALSE ) +
    plot_annotation(title="EZHIP motifs", 
                    subtitle="* = residues present in >=80% motif instances")

p1
```

![](protein_motif_logo_plots_files/figure-gfm/logo%20plots%20star80-1.png)<!-- -->

``` r
ggsave(p1,
       file=here("logo_plots/Rscript_output/motifs_star80.pdf"),
       height=12, width=5)
```

# Finished - show package versions used

``` r
sessionInfo()
```

    ## R version 4.5.2 (2025-10-31)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.3 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## time zone: Etc/UTC
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats4    stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ##  [1] Biostrings_2.78.0     Seqinfo_1.0.0         XVector_0.50.0       
    ##  [4] IRanges_2.44.0        S4Vectors_0.48.1      BiocGenerics_0.56.0  
    ##  [7] generics_0.1.4        ggseqlogo_0.2.2       universalmotif_1.28.0
    ## [10] janitor_2.2.1         patchwork_1.3.2       here_1.0.2           
    ## [13] lubridate_1.9.5       forcats_1.0.1         stringr_1.6.0        
    ## [16] dplyr_1.2.1           purrr_1.2.2           readr_2.2.0          
    ## [19] tidyr_1.3.2           tibble_3.3.1          ggplot2_4.0.2        
    ## [22] tidyverse_2.0.0      
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] stringi_1.8.7         hms_1.1.4             digest_0.6.39        
    ##  [4] magrittr_2.0.5        evaluate_1.0.5        grid_4.5.2           
    ##  [7] timechange_0.4.0      RColorBrewer_1.1-3    fastmap_1.2.0        
    ## [10] rprojroot_2.1.1       scales_1.4.0          textshaping_1.0.5    
    ## [13] cli_3.6.6             crayon_1.5.3          rlang_1.2.0          
    ## [16] withr_3.0.3           yaml_2.3.12           otel_0.2.0           
    ## [19] tools_4.5.2           tzdb_0.5.0            vctrs_0.7.2          
    ## [22] R6_2.6.1              matrixStats_1.5.0     lifecycle_1.0.5      
    ## [25] snakecase_0.11.1      MASS_7.3-65           ragg_1.5.2           
    ## [28] pkgconfig_2.0.3       pillar_1.11.1         gtable_0.3.6         
    ## [31] Rcpp_1.1.2            glue_1.8.1            systemfonts_1.3.2    
    ## [34] xfun_0.57             tidyselect_1.2.1      MatrixGenerics_1.22.0
    ## [37] rstudioapi_0.19.0     knitr_1.51            dichromat_2.0-0.1    
    ## [40] farver_2.1.2          htmltools_0.5.9       rmarkdown_2.31       
    ## [43] compiler_4.5.2        S7_0.2.1
