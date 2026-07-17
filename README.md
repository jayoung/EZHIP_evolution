# EZHIP_evolution

Files and scripts related to EZHIP evolution manuscript "Dynamic evolution of EZHIP, an inhibitor of the Polycomb Repressive Complex 2 in mammals", Raman et al 2026

[BioRxiv preprint](https://www.biorxiv.org/content/10.64898/2025.12.12.693809v2)



## PAML analysis

PAML was run on in-frame nucleotide alignments using code in Janet Young's [pamlWrapper](https://github.com/jayoung/pamlWrapper) github repository.

## PHYML


## RNA-seq analysis


## Figure 2, protein motif logo plots

in `logo_plots` directory: 

`meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa` : input fasta file for MEME analysis.

`meme_protein_motifs/meme.sh` : shell script used to run MEME to identify protein motifs, using the same parameters used by the [web implementation of MEME](https://meme-suite.org/meme/tools/meme).

`meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme` : directory containing output of MEME run.

`protein_motif_logo_plots.Rmd` : R code used to:
- read MEME output (`meme.txt`)
- reorder EZHIP motifs based on position in human EZHIP, rather than by best score
- determine conservation levels at each motif position 
- replot motif logo plots, using chosen color scheme, and adding star symbols to residues conserved in >=80% of motif occurrences





## R and renv

Note that this repo uses `renv` to control R versions and R package versions. I'm using   the Hutch Rstudio server (apptainer version, R 4.5.2). I initialized a new Rproject using Rstudio, then used the console to do this:

```
library("renv")
renv::init(bioconductor = "3.22")
```

When I want to install some packages:
- To install a CRAN package I do something like this: `renv::install("tidyverse")`
- To install a Bioconductor package I do this: `renv::install("bioc::Biostrings")`
- To install a package from Github I do this: `renv::install("bioc/memes")`

After I make changes to the installations, and I'm happy that everything runs OK, I lock the setup: `renv::snapshot()`
