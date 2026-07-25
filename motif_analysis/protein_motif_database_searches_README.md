Scripts mentioned below are in the `motif_analysis/other_scripts` directory. 

# Genomes and proteomes searched

Two files in the `motif_analysis/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme/sequence_database_lists` directory list 12 species' genome/proteome files that we searched with EZHIP protein motifs. 

Proteome files were downlaoded from NCBI. For use in FIMO and MAST searches, we replaced all selenocysteine residues (encoded by U, an illegal character in MEME suite algorithms) with a cysteine residue, using the script `replace_U_inProtSeq.bioperl` (calling it on each of the 12 proteome files using the `replace_U_inProtSeq_wrapper.pl` script).

Genome assembly fasta files were downloaded from NCBI or UCSC. We generated 6-frame translations of each genome using the EMBOSS package algorithm `getorf` (parameters `-minsize 300 -find 0`). We found that long genome assembly gaps (NNNNNNNNN..., translate to XXX...) caused false positive matches in some MEME suite algorithms, so we processed the `getorf` output to replace any stretch of 12 or more Xs with a run of 9 Xs, using the script `reduceAssemblyGapSize_getORFoutput.bioperl` (called on each genome by `reduceAssemblyGapSize_getORFoutput.wrapper.pl`).

# hmmsearch (HMMER package)

See `protein_motif_logo_plots.md` for notes on building HMMs.

Here I use `hmmsearch` with `--max` option to search genomes or proteomes.

```
cd motif_analysis/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme

mkdir motifs_hmmsearch_genomes_max motifs_hmmsearch_proteomes_max

# 6-frame genome translations
cd motifs_hmmsearch_genomes_max
ln -s ../motif_instance_fasta_files/all* .
../../../other_scripts/run_hmmsearch_wrapper_multiDatabases.pl \
    --opt="--max" \
    -tsv ../sequence_database_lists/selected_genome_6frame_files.tsv \
    all_ten_motifs.hmm 
# check they worked (log files and slurm files should be empty) and tidy up
cat slurm-* *log.txt 
rm slurm-* *log.txt 

# proteomes
cd ../motifs_hmmsearch_proteomes_max
ln -s ../motif_instance_fasta_files/all* .
../../../other_scripts/run_hmmsearch_wrapper_multiDatabases.pl \
    --opt="--max" \
    -tsv ../sequence_database_lists/selected_proteome_files.tsv \
    all_ten_motifs.hmm 
# check they worked (log files and slurm files should be empty) and tidy up
cat slurm-* *log.txt 
rm slurm-* *log.txt 
```

# MAST (MEME suite)

```
cd motif_analysis/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme

mkdir meme.txt.MAST.vs.selectedGenomes_6frames meme.txt.MAST.vs.selectedProteomes 

# genomes
cd meme.txt.MAST.vs.selectedGenomes_6frames
../../../other_scripts/run_mast_memeSuite_wrapper_multiGenomes.pl \
    -tsv ../sequence_database_lists/selected_genome_6frame_files.tsv \
    -motifs ../meme.txt 

# proteomes
cd ../meme.txt.MAST.vs.selectedProteomes/
../../../other_scripts/run_mast_memeSuite_wrapper_multiProteomes.pl \
    -tsv ../sequence_database_lists/selected_proteome_files.tsv \
    -motifs ../meme.txt 
```


# FIMO (MEME suite)

```
cd motif_analysis/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme

mkdir meme.txt.FIMO.vs.selectedGenomes_6frames meme.txt.FIMO.vs.selectedProteomes

# genomes
cd meme.txt.FIMO.vs.selectedGenomes_6frames
../../../other_scripts/run_fimo_memeSuite_wrapper_multiGenomes.pl \
    -tsv ../sequence_database_lists/selected_genome_6frame_files.tsv \
    -motifs ../meme.txt 

# proteomes
cd ../meme.txt.FIMO.vs.selectedProteomes/
../../../other_scripts/run_fimo_memeSuite_wrapper_multiProteomes.pl \
    -tsv ../sequence_database_lists/selected_proteome_files.tsv \
    -motifs ../meme.txt 
```
