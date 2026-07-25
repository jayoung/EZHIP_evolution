############## general sequence analysis functions


###### read_seq_file_JY is a utility function to read a fasta file
## reads file, and parses out seq IDs and description lines
## returns a list of the sequences (as DNAStringSet etc) and a tibble of seq_ids and descriptions
## type can be DNA or AA 
read_seq_file_JY <- function(seq_file, 
                             type="DNA", 
                             strip_afterDot=FALSE,
                             nrec = -1L  # for testing purposes, read the first few records
) {
    if(!file.exists(seq_file)) {
        stop("\n\nERROR - seqfile does not exist: ",seq_file, "\n\n")
    }
    if (type=="DNA") {
        seqs <- seq_file |> readDNAStringSet(nrec=nrec)
    }
    if (type=="AA") {
        seqs <- seq_file |> readAAStringSet(nrec=nrec)
    }
    if(!exists("seqs")) {
        stop("\n\nERROR - you specified an invalid type. Should be DNA, AA\n\n")
    }
    headers_split <- names(seqs) |> strsplit(" ")
    info_tbl <- tibble(seq_id = sapply(headers_split, "[[", 1),
                       seq_len = width(seqs),
                       desc = sapply(headers_split, function(x) {
                           if(length(x)>1) {
                               return( paste(x[2:length(x)], collapse=" ")  )
                           } else { return(NA) }
                       }))
    
    return(list(seqs=seqs, info=info_tbl))
}




############## functions for logo plots

##### get_most_common_eachPos: a function that takes a PCM and returns the most common residue at each position.
## if there's a tie we arbitrarily choose
get_most_common_eachPos <- function(my_pcm) {
    row_ids <- rownames(my_pcm)
    result_each_pos <- apply(my_pcm, 2, function(x) {
        most_common <- which.max(x)[1]
        output <- list(residue=row_ids[most_common], freq=x[most_common]/sum(x))
        return(output)
    })
    results <- tibble(pos = 1:length(result_each_pos),
                      most_common = sapply(result_each_pos, "[[", "residue"),
                      most_common_freq = sapply(result_each_pos, "[[", "freq"))
    return(results)
}


###### logo plot color schemes



#### Our preferred color scheme, based on color scheme used here: https://weblogo.threeplusone.com/ 
##  code for weblogo color scheme is found here: https://github.com/gecrooks/weblogo/blob/master/weblogo/colorscheme.py
## and looks like this:
# chemistry = ColorScheme(
#     [
#         SymbolColor("GSTYC", "green", "polar"),
#         SymbolColor("NQ", "purple", "neutral"),
#         SymbolColor("KRH", "blue", "basic"),
#         SymbolColor("DE", "red", "acidic"),
#         SymbolColor("PAWFLIMV", "black", "hydrophobic"),
#     ],
#     alphabet=seq.unambiguous_protein_alphabet,
# )

##### reproduce that color scheme in R. First put the color scheme into a named character vector
weblogo_chemistry_color_scheme <- character()
## polar
for (x in strsplit("GSTYC", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "green3"
}
## neutral
for (x in strsplit("NQ", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "purple"
}
## basic
for (x in strsplit("KRH", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "blue"
}
## acidic
for (x in strsplit("DE", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "red"
}
## hydrophobic
for (x in strsplit("PAWFLIMV", split="")[[1]]) {
    weblogo_chemistry_color_scheme[x] <- "black"
}

### use ggseqlogo::make_col_scheme
weblogo_chemistry_color_scheme_ggseqlogo <- make_col_scheme(
    chars=names(weblogo_chemistry_color_scheme),
    cols=weblogo_chemistry_color_scheme)




############# functions related to motif search output


### add_EZHIP_motif_diag: add 'motif diagram' (e.g. 1-2-3-4-5-6-6-6-7-8-9-10) based on the ezhip_motif_index column
add_EZHIP_motif_diag <- function(parsed_mast_output) {
    parsed_mast_output |> 
        # mutate(sequence_name = factor(sequence_name)) |> 
        group_by(sequence_name) |> 
        arrange(hit_start) |> 
        mutate(motif_diag_ezhip = paste(ezhip_motif_index, collapse="-") ) |> 
        ungroup() |> 
        arrange(sequence_name)
}


#### show_fimo_match_alignment = a small function to take any row from a FIMO output table and show how the motif looks
show_fimo_match_alignment <- function(dat, 
                                      include_genome=FALSE,
                                      include_proteome=FALSE,
                                      include_description=TRUE) {
    formatted <- sapply(1:nrow(dat), function(i) {
        dat_row <- dat[i,]
        query <- dat_row$motif_id
        hit <- dat_row$matched_sequence
        ## get match row
        match_row <- ""
        for (i in 1:nchar(query)) {
            if(substr(query, i, i) == substr(hit, i, i)) {
                match_row <- paste0(match_row, "|")
            } else {
                match_row <- paste0(match_row, " ")
            }
        }
        output <- paste0("\n\n#### ")
        if(include_genome) {
            output <- paste0(output,
                             "genome:  ", dat_row$genome, "\n")
        } 
        if(include_proteome) {
            output <- paste0(output,
                             "proteome:  ", dat_row$proteome, "\n")
        } 
        output <- paste0(output, "match:   ", dat_row$sequence_name, " ; p-value=", dat_row$p_value, "\n")
        if(include_description) {
            output <- paste0(output,
                             "description:  ", dat_row$desc, "\n")
        } 
        output <- paste0(output, 
                         "motif_consensus:   ", query, "\n",
                         "matches:           ", match_row, "\n",
                         "motif_match:       ", hit, "\n")
        return(output)
    })
    cat (formatted)
}


##### parse_mast_xml
## this is the version to use now
## guide to XML parsing https://y-rosenthal.github.io/DataManagementUsingR/web-000220-parsingXmUsingR-v001.html

### parsing the mast.txt and mast.hitlist files was less reliable than this
## example, from the supp dataset S1 output:
# Cow,_Ancestral_X has 8 motifs in when I parse meme.txt and hitlist but 9 when I parse xml
# the p-values reported in the meme.txt parsing for individual hits are also less impressive
# the xml version 
## so, the hitlist file seems to be missing some motif instances, and it is reporting p-values that are higher than the xml and html file are reporting. I think I will NOT use the hitlist parsing method

parse_mast_xml <- function(mast_xml_file,
                           quiet=TRUE) {
    require(xml2)
    if(!file.exists(mast_xml_file)) {
        stop("\n\nERROR - the mast_xml_file you supplied doesn't exist: ", 
             mast_xml_file, "\n\n")
    }
    if(!quiet) { cat("Reading xml file\n")}
    mast_xml <- mast_xml_file |> read_xml()
    
    ### get info on the motifs we searched with
    if(!quiet) { cat("Getting query motif info\n")}
    motif_nodes <- xml_find_all(mast_xml, "//motifs/motif")
    motifs_tbl <- tibble(motif_long_name = xml_attr(motif_nodes,"id"),
                         orig_name = xml_attr(motif_nodes,"alt"),
                         motif_length=xml_attr(motif_nodes,"length"),
                         meme_evalue=xml_attr(motif_nodes,"evalue"))
    motifs_tbl <- motifs_tbl |> 
        mutate(motif_index = 1:nrow(motifs_tbl)) |> 
        mutate(motif_length = as.integer(motif_length))
    
    
    ### get seqname and evalue for each database seq.
    # I get the evalue tag (not the combined_pvalue tag) - I checked and that's the overall evalue reported in mast.html
    ## not sure whether converting e-value to numeric will always work - some numbers might be too small, so I might need to parse in a more sophisticated way. Or just ignore diffs between very small numbers. I think it was on the MEME output where I had to just keep p-values as characters, not numeric
    
    if(!quiet) { cat("Getting database seq info\n")}
    score_nodes <- xml_find_all(mast_xml, "//sequences/sequence/score")
    sequence_nodes <- xml_find_all(mast_xml, "//sequences/sequence")
    each_seq_tbl <- tibble(sequence_name = xml_attr(sequence_nodes,"name"),
                           sequence_description = xml_attr(sequence_nodes,"comment"),
                           target_e_value_orig = xml_attr(score_nodes,"evalue")) |> 
        mutate(target_e_value=as.numeric(target_e_value_orig))
    
    ### get motif matches for each database seq
    if(!quiet) { cat("Getting motif match locations\n")}
    motif_hits_allseqs_tbl <- lapply(1:length(sequence_nodes), function(i) {
        sequence_name <- each_seq_tbl |> 
            dplyr::slice(i) |> 
            pull(sequence_name)
        
        motif_segs_xml <- xml_find_all(sequence_nodes[i], "seg")
        motif_segs_tbl <- tibble(hit_region_start = xml_attr(motif_segs_xml,"start"),
                                 fake_col="fake")
        
        # many segs have just one hit per seg, but sometimes there's >1
        this_seq_all_segs_hits <- lapply(1:length(motif_segs_xml), function(j) {
            
            ### get the hit_region_sequence
            this_segs_sequence <- xml_find_all(motif_segs_xml[j], "data") |>
                as_list() |> 
                unlist() 
            this_segs_tbl <- tibble(hit_region_start = xml_attr(motif_segs_xml[j],"start"),
                                    hit_region_sequence = this_segs_sequence,
                                    fake_col="fake") |> 
                mutate(hit_region_start=as.integer(hit_region_start))
            
            motif_hits_xml <- xml_find_all(motif_segs_xml[j], "hit")
            motif_hits_tbl <- tibble(sequence_name=sequence_name, 
                                     hit_start = xml_attr(motif_hits_xml,"pos"),
                                     motif_index = xml_attr(motif_hits_xml,"idx"),
                                     p_value_orig = xml_attr(motif_hits_xml,"pvalue"),
                                     match = xml_attr(motif_hits_xml,"match"),
                                     ## for left_join
                                     fake_col="fake") |> 
                mutate(hit_start=as.integer(hit_start)) |> 
                mutate(motif_index=as.integer(motif_index)+1)  |> 
                ## p_value_orig is a character. I'll keep the p_value_orig because R sometimes cannot handle super small numbers and might convert to 0
                ## not sure whether this will always work - some numbers might be too small, so I might need to parse in a more sophisticated way. Or just ignore diffs between very small numbers. I think it was on the MEME output where I had to just keep p-values as characters, not numeric
                mutate(p_value = as.numeric(p_value_orig)) |> 
                ## the left join should repeat set info as needed
                left_join(this_segs_tbl, by="fake_col") |> 
                select(-fake_col) |> 
                relocate(hit_region_start, .after=sequence_name)
            
        })
        return(this_seq_all_segs_hits)
    }) |> 
        bind_rows() |> 
        mutate(hit_region_sequence = str_remove_all(hit_region_sequence, "\\n|\\t"))
    # return(motif_hits_allseqs_tbl)## xx troubleshoot
    
    ### add sequence info to motif matches
    if(!quiet) { cat("Adding database seq info to motif matches\n")}
    motif_hits_allseqs_tbl <- motif_hits_allseqs_tbl |> 
        left_join(each_seq_tbl, by="sequence_name") |> 
        relocate(sequence_description, target_e_value_orig, target_e_value, .after=sequence_name)
    
    ### add motif info to motif matches
    if(!quiet) { cat("Adding query motif info motif matches\n")}
    motif_hits_allseqs_tbl <- motif_hits_allseqs_tbl |> 
        left_join(motifs_tbl, by="motif_index")  |> 
        mutate(hit_end = hit_start + motif_length - 1) |>
        relocate(hit_end, .after=hit_start) |>
        select(-meme_evalue, -motif_index, -motif_length)
    
    if(!quiet) { cat("Adding motif counts\n")}
    motif_counts <- motif_hits_allseqs_tbl |> 
        group_by(sequence_name) |> 
        summarise(num_motifs = dplyr::n(),
                  num_diff_motifs = length(unique(orig_name))) |> 
        ungroup()
    motif_hits_allseqs_tbl <- left_join(motif_hits_allseqs_tbl, 
                                        motif_counts, 
                                        by="sequence_name") |> 
        relocate(num_motifs, num_diff_motifs, motif_long_name, orig_name, 
                 .after=target_e_value)
    
    ### get the sequence of the match
    motif_hits_allseqs_tbl <- motif_hits_allseqs_tbl |> 
        mutate(hit_start_within_region = hit_start + 1 - hit_region_start) |> 
        mutate(hit_end_within_region = hit_end + 1 - hit_region_start)
    
    motif_hits_allseqs_tbl$matched_seq <- sapply(1:nrow(motif_hits_allseqs_tbl), function(k) {
        substr(deframe(motif_hits_allseqs_tbl[k,"hit_region_sequence"]), 
               start=deframe(motif_hits_allseqs_tbl[k,"hit_start_within_region"]), 
               stop=deframe(motif_hits_allseqs_tbl[k,"hit_end_within_region"]))
    })
    
    motif_hits_allseqs_tbl <- motif_hits_allseqs_tbl |> 
        select(-hit_start_within_region, -hit_end_within_region)
    
    ## finished:
    return(motif_hits_allseqs_tbl)
}



### show_mast_hits_summary_level - small function to display hits from a summary-level mast output tbl
show_mast_hits_summary_level <- function(x, 
                                         include_proteome=FALSE,
                                         include_genome=FALSE,
                                         include_description=TRUE,
                                         extra_cols=NULL) {
    
    columns_to_take <- c("sequence_name", "target_e_value_orig", "num_diff_motifs", 
                         "motif_diag_ezhip")
    if(include_proteome) { columns_to_take <- c("proteome", columns_to_take)}
    if(include_genome) { columns_to_take <- c("genome", columns_to_take)}
    if(include_description) { columns_to_take <- c(columns_to_take, "sequence_description")}
    if(!is.null(extra_cols)) { columns_to_take <- c(columns_to_take, extra_cols)}
    x |> 
        select(matches(columns_to_take)) |> 
        rename_with(~ str_replace_all(., "_", " ")) |>
        kable() |> 
        kable_styling(full_width = FALSE)
}


##### MAST output - function to show each motif for any number of rows. See also show_all_mast_motifs_per_target_seq which calls this function.
show_each_mast_motif <- function(mast_output_rows,
                                 extra_cols=NULL) {
    for(i in 1:nrow(mast_output_rows)) {
        temp_string <- paste0(
            "\n## ", 
            mast_output_rows$ezhip_motif_index[i], " ; motif start pos ", mast_output_rows$hit_start[i], "\n",
            mast_output_rows$motif_long_name[i], "\n",
            mast_output_rows$match[i], "\n",
            mast_output_rows$matched_seq[i], "\n")
        cat( temp_string)
    }
}

##### MAST output - function to show MAST motif matches organized by target seqs then by position (>1 match per target seq)
show_all_mast_motifs_per_target_seq <- function(mast_output_rows, 
                                                num_targets=0, ## 0 to take all targets
                                                include_genome = FALSE,
                                                include_description = TRUE,
                                                show_target_orf_coords = FALSE) {
    
    cols_to_take <- c("sequence_name", "target_e_value", "sequence_description")
    if(show_target_orf_coords) {
        cols_to_take <- c(cols_to_take,  "chromosome", "start", "end", "strand")
    }
    if(include_genome) {
        cols_to_take <- c("genome", cols_to_take)
    } 
    each_target <- mast_output_rows |> 
        select(all_of(cols_to_take)) |> 
        unique() 
    
    if (num_targets >0) {
        each_target <- each_target |> 
            slice_head(n=num_targets)
    }
    for (j in 1:nrow(each_target)) {
        each_target_header <- "\n\n########"
        if(include_genome) {
            each_target_header <- paste0(each_target_header, " genome: ", each_target$genome[j])
        }
        each_target_header <- paste0(each_target_header, " target: ", each_target$sequence_name[j])
        if(include_description) {
            each_target_header <- paste0(each_target_header, 
                                         "; description ", each_target$sequence_description[j])
        }
        
        if(show_target_orf_coords) {
            each_target_header <- paste0(each_target_header, 
                                         "\ncoords ", 
                                         each_target$chromosome[j], ":", 
                                         each_target$start[j], "-", 
                                         each_target$end[j], " (",
                                         each_target$strand[j], ")")
        }
        
        cat(each_target_header, "\n")
        target_motifs <- mast_output_rows |> 
            filter(sequence_name==each_target$sequence_name[j]) |> 
            arrange(hit_start)
        show_each_mast_motif(target_motifs)
    }
}




##### parse_getorf_seq_description is a little function to split seq descriptions that were output by getorf into something more useful
# examples: 
# [14514137 - 14516353] Canis lupus familiaris isolate Tasha breed boxer chromosome X, whole genome shotgun sequence
# [81398207 - 81396969] (REVERSE SENSE) Canis lupus familiaris isolate Tasha breed boxer chromosome 4, whole genome shotgun sequence

parse_getorf_seq_description <- function(my_tbl, 
                                         description_colname = "sequence_description",
                                         sequence_name_colname = "sequence_name") {
    
    if(!description_colname %in% colnames(my_tbl)) {
        stop("\n\nERROR - the tbl should contain a column called ",description_colname, "\n\n")
    }
    if(!sequence_name_colname %in% colnames(my_tbl)) {
        stop("\n\nERROR - the tbl should contain a column called ",sequence_name_colname, "\n\n")
    }
    
    ## rename cols if needed to sequence_description and sequence_name
    if (description_colname != "sequence_description") {
        colnames(my_tbl)[which(colnames(my_tbl)==description_colname)] <- "sequence_description"
    }
    if (sequence_name_colname != "sequence_name") {
        colnames(my_tbl)[which(colnames(my_tbl)==sequence_name_colname)] <- "sequence_name"
    }
    
    my_coords <- my_tbl |>
        ## parse sequence_description to get the coordinates and strand
        mutate(strand = case_when(str_detect(sequence_description, "REVERSE SENSE") ~ "-",
                                  TRUE ~ "+")) |>
        mutate(sequence_description_v2=str_remove_all(sequence_description, "[\\[\\]]")) |>
        separate_wider_delim(sequence_description_v2, delim = " ", too_many="drop",
                             names=c("coord1", NA, "coord2"),
                             cols_remove=TRUE)  |>
        mutate(across(.cols=c(coord1, coord2), .fns=as.numeric))  |> 
        mutate(start = case_when(strand=="+" ~ coord1, 
                                 TRUE ~ coord2)) |> 
        mutate(end = case_when(strand=="+" ~ coord2, 
                               TRUE ~ coord1)) |> 
        mutate(width=end+1-start) |> 
        select(-coord1, -coord2) 
    ### now split individual sequence to get accession. 
    # It might have one underscore, e.g. JARVKP010005522.1_1435 
    # or two, e.g. NC_134530.1_191014
    # or three, e.g. chrUn_NW_019368931v1_5
    acc_splits <- strsplit(my_coords$sequence_name, "_")
    accs <- lapply(acc_splits, function(x) {
        if(!length(x) %in% c(2,3,4,5)) {
            stop("\n\nERROR - don't know how to parse this seqname to get accession: ",x,"\n\n")
        }
        if(length(x)==2) { output <- x }
        if (length(x)==3) {
            output <- c(paste(x[1],x[2],sep="_"),
                        x[3])
        }
        if (length(x)==4) {
            output <- c(paste(x[1],x[2],x[3],sep="_"),
                        x[4])
        }
        if (length(x)==5) {
            output <- c(paste(x[1],x[2],x[3],x[4],sep="_"),
                        x[5])
        }
        return(output)
    })
    my_coords <- my_coords |>
        mutate(chromosome=sapply(accs, "[[", 1)) |> 
        relocate(chromosome, start, end, strand, width) 
    
    if ("genome" %in% colnames(my_coords)) {
        my_coords <- my_coords |> 
            relocate(genome) 
    }
    
    ## rename cols back again if needed to sequence_description and sequence_name
    if (description_colname != "sequence_description") {
        colnames(my_coords)[which(colnames(my_coords)=="sequence_description" )] <- description_colname
    }
    if (sequence_name_colname != "sequence_name") {
        colnames(my_coords)[which(colnames(my_coords)== "sequence_name" )] <- sequence_name_colname
    }
    return(my_coords)
}



##### readHmmerDomtbl is a function to read the --domtbl output of hmmsearch or hmmscan
# hmmsearch = search profile (HMM) against sequence database
# hmmscan = search sequence against profile database (HMMs)
# by default I do NOT parse the descriptions for the target seqs, but there is an option to do so
readHmmerDomtbl <- function(file, get_descriptions=FALSE) {
    if(!file.exists(file)) {stop("\n\nERROR - file ",file," does not exist\n\n")}
    
    colnames_after_reading_tbl <- c("target_name","target_accession","target_len",
                                    "query_name","query_accession","query_len",
                                    "target_eval", "target_score", "target_bias",
                                    "domain_index", "domain_count", 
                                    "domain_condEval", "domain_indEval", 
                                    "domain_score", "domain_bias",
                                    "hmm_start", "hmm_end", 
                                    "ali_start","ali_end", "ali_env_start","ali_env_end",
                                    "accuracy")
    
    dat_orig <- scan(file, what="character", sep="\n", quiet=TRUE, 
                     comment.char ="#")
    if(length(dat_orig) > 0) {
        dat_split <- strsplit(dat_orig, "\\s+")
        # the 'description' field does not parse well (contains spaces). First I parse all the other fields (and leave description for later)
        dat <- lapply(dat_split, function(x) { x[1:22] } )
        dat <- data.frame(dat)
        colnames(dat) <- NULL
        dat <- t(dat)
        colnames(dat) <- colnames_after_reading_tbl
        dat <- as_tibble(dat) 
    } else {
        ## make an empty tibble with the same colnames
        # dat <- tibble(.rows=0)
        return(NULL)
    }
    dat <- dat |> 
        select(-target_accession, -query_accession, -target_bias, -domain_bias) |> 
        mutate(across( c(-target_name,-query_name), as.numeric )) 
    
    ## maybe extract the description
    if (get_descriptions) {
        dat$description <- sapply(dat_split, function(x) { 
            desc <- x[23:length(x)] 
            desc <- paste(desc, collapse=" ")
            return(desc)
        } )
    }
    
    ## add some useful columns
    dat <- dat |> 
        mutate(ali_width = ali_end + 1 - ali_start) |> 
        relocate(ali_width, .after=ali_end)
    return(dat)
}



###### summarise_hmmsearch_results_each_ORF - go from a one-row-per-motif version of hmmsearch output, to a one-row-per-target version
summarise_hmmsearch_results_each_ORF <- function(hmmsearch_filt_tbl, 
                                                 include_coords_columns=TRUE) {
    hmmsearch_filt_tbl_split <- split(hmmsearch_filt_tbl, hmmsearch_filt_tbl$target_name)
    output <- lapply(hmmsearch_filt_tbl_split, function(x) {
        
        cols_to_take <- c("genome", "target_name")
        if (include_coords_columns) {
            cols_to_take <- c(cols_to_take, "target_len_nt", "chromosome", "start", "end", "strand")
        }
        cols_to_take <- c(cols_to_take, "target_len_aa")
        
        ## deal with the columns where everything should reduce to one row:
        output_pt1 <- x |> 
            select(all_of(cols_to_take)) |> 
            unique()
        if(nrow(output_pt1) != 1) {
            stop("\n\nERROR - something is wrong\n\n")
        }
        ## deal with columns where I need to summarize
        output_pt2 <- x |> 
            summarise(best_target_eval = min(target_eval),
                      num_motifs = dplyr::n(),
                      num_diff_motifs = length(unique(query_name)),
                      best_target_score = max(target_score),
                      total_target_score = sum(target_score),
                      total_ali_width = sum(ali_width)) 
        
        
        output_pt1and2 <- bind_cols(output_pt1, output_pt2)
        
        ## motif diagrams
        output_pt1and2$motif_diag_ezhip <- x |> 
            arrange(ali_start) |> 
            pull(ezhip_motif_index) |> 
            paste(collapse = "-")
        
        ## motifs_present (unique motifs)
        output_pt1and2$motifs_present <- x |> 
            arrange(ezhip_motif_index) |>
            pull(ezhip_motif_index) |> 
            unique() |> 
            paste(collapse = ",")
        
        return(output_pt1and2)
        
    }) |> 
        bind_rows() |> 
        arrange(best_target_eval)
    
    return(output)
    
}

### display hmmsearch output for individual motif matches
show_hmmsearch_hit_table <- function(hmm_hittable, 
                                     include_description=FALSE, 
                                     include_genome=TRUE) {
    cols_to_take <- c("target_name")
    if(include_description) {
        cols_to_take <- c(cols_to_take, "desc")
    }
    cols_to_take <- c(cols_to_take, 
                      "target_len_aa", "query_name", 
                      "target_eval", "domain_score", "domain_condEval",
                      "ali_start", "ali_end")
    if(include_genome) {
        cols_to_take <- c("genome", cols_to_take)
    }
    
    hmm_hittable |> 
        select(all_of(cols_to_take)) |> 
        rename_with(~ str_replace_all(., "_", " ")) |>
        kable() |> 
        kable_styling(full_width = FALSE)
}



## for combined motif matches for each target seq
show_hmmsearch_summary_table <- function(hmm_summary_table, 
                                         include_description=FALSE,
                                         include_coords=TRUE,
                                         include_genome=TRUE) {
    cols_to_take <- c("target_name")
    if (include_description) {
        cols_to_take <- c(cols_to_take, "desc")
    }
    cols_to_take <- c(cols_to_take, "target_len_aa", "motif_diag_ezhip",
                      "best_target_eval", "total_ali_width", "total_target_score", 
                      "num_motifs", "num_diff_motifs")
    
    if(include_coords) {
        cols_to_take <- c("chromosome", "start", "end", "strand", cols_to_take)
    }
    
    if(include_genome) {
        cols_to_take <- c("genome", cols_to_take)
    }
    hmm_summary_table |> 
        select(all_of(cols_to_take)) |> 
        rename_with(~ str_replace_all(., "_", " ")) |>
        kable() |> 
        kable_styling(full_width = FALSE)
}


