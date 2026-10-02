# EZHIP_evolution

Files and scripts related to EZHIP evolution manuscript "Dynamic evolution of EZHIP, an inhibitor of the Polycomb Repressive Complex 2 in mammals", Raman et al 2026. [BioRxiv preprint](https://www.biorxiv.org/content/10.64898/2025.12.12.693809v2).



## Phylogenies

Amino acid phylogenies were made using a command of this form:

```
mpirun -n 10 --oversubscribe \
    phyml-mpi \
        -i input_alignment.phy \
        -d aa --sequential \
        -m JTT \
        --pinv e --alpha e -f e \
        -b 100 > output_tree.nwk
```

## RNA-seq analysis

In the `RNAseq_analysis` directory:
- [`RNAseq_Example_Script.Rmd`](https://github.com/jayoung/EZHIP_evolution/blob/main/RNAseq_analysis/RNAseq_Example_Script.Rmd) is an example script to process output of bedtools multicov (counts RNA-seq reads per gene), convert those counts to RPKM, and plot.
- [`RNAseq_Example_Script.md`](https://github.com/jayoung/EZHIP_evolution/blob/main/RNAseq_analysis/RNAseq_Example_Script.md) is the rendered output of that script

## PAML analysis

PAML was run on in-frame nucleotide alignments using code in Janet Young's [pamlWrapper](https://github.com/jayoung/pamlWrapper) github repository, which includes code to generate the input phylogenies for PAML. 

## Figure 2, protein motif logo plots

In the `logo_plots` directory: 

The `meme_protein_motifs` folder contains:

- the input fasta file for MEME analysis: [`EZHIP_sequences_used_for_MEME_analyses.fa`](motif_analysis/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa)

- [`meme.sh`](motif_analysis/meme_protein_motifs/meme.sh) : the shell script used to run MEME to identify protein motifs, using the same parameters used by the [web implementation of MEME](https://meme-suite.org/meme/tools/meme).

And the R script [`protein_motif_logo_plots.Rmd`](motif_analysis/protein_motif_logo_plots.Rmd) (output rendered [here](motif_analysis/protein_motif_logo_plots.md)) contains code used to:
- read MEME output (`meme.txt`)
- reorder EZHIP motifs based on position in human EZHIP, rather than by best score
- determine conservation levels at each motif position 
- replot motif logo plots using the chosen color scheme, and adding star symbols to residues conserved in >=80% of motif occurrences

## Using EZHIP protein motifs to search genome 6-frame translations and proteomes

There's a paragraph in the revised manuscript that reads:

"We leveraged these motifs to perform more sensitive searches of selected genomes and predicted proteomes, using three methods (Hidden Markov Models, FIMO and MAST searches, see Methods). We found no convincing homology in species outside of placental mammals, confirming our inferred age of EZHIP. Other than EZHIP and some recent duplicates identified using blast searches (see below), we found no evidence for additional paralogs in selected placental mammal genomes. We also looked for additional genes containing only the KLP motif and found no clear matches, including in the genomes of Afrotherian species where EZHIP lacks the KLP. The evolutionary origin of EZHIP and the KLP motif therefore remains unclear."

We provide search output here for full transparency, although there are no figures/tables in the manuscript associated with this statement.

The motif search output files can be downloaded from [Zenodo](https://doi.org/10.5281/zenodo.21629929), and the [R script output](motif_analysis/protein_motif_database_searches_process_output.md) shows details of the top hits among the many unconvincing matches we found.  More notes in [protein_motif_database_searches_README.md](motif_analysis/protein_motif_database_searches_README.md).


## Note about R versions and renv

This repository uses `renv` to control R versions and R package versions. I'm using the Hutch Rstudio server (apptainer version, R 4.5.2). 

Notes on that: I initialized a new Rproject using Rstudio, then used the console to do this:

```
library("renv")
renv::init(bioconductor = "3.22")
```

When I want to install some packages:
- To install a CRAN package I do something like this: `renv::install("tidyverse")`
- To install a Bioconductor package I do this: `renv::install("bioc::Biostrings")`
- To install a package from Github I do this: `renv::install("bioc/memes")`

After I install or update packages, and I'm happy that everything runs OK, I lock the setup: `renv::snapshot()`

The following required packages are not installed:
- BiocVersion  [required by AnnotationDbi, Biobase, BiocFileCache, and 25 others]