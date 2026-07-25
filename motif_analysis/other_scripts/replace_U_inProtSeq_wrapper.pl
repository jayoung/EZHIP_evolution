#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;
use File::Find::Rule;

#### goal:  
# use a tsv file containing a list of proteomes that I've downloaded (tsv file is in a different format than the genomes file for the other wrapper script)
# run replace_U_inProtSeq.bioperl on each

## usage: 
# cd  ~/EZHIP_janet/data/motifs/newMEMEfile_2026_04_30b_v2/SupplementaryDataS3_MEMESeqs.lineBreaks.newSheep.fa_meme/meme.txt.MAST.vs.selectedProteomes/meme.txt.MAST.vs.hg38_proteome

# ~/EZHIP_janet/bin/replace_U_inProtSeq_wrapper.pl -tsv /home/jayoung/EZHIP_janet/data/genome_files/various/selected_NCBI_proteome_files.tsv


my $databases_tsv_file = "";

my $use_sbatch = 1;
my $memory = "16";   # in Gb
my $walltime = "1-0";
my $debug = 0;

GetOptions("tsv=s"      => \$databases_tsv_file,
           "sbatch=i"   => \$use_sbatch,
           "memory=s"   => \$memory,
           "wall=s"     => \$walltime,
           "debug"      => \$debug 
           ) or die "\n\nterminating - unknown option(s) specified on command line\n\n"; 



###########

### upfront checks
if ($databases_tsv_file eq "") {
    die "\n\nTERMINATING - you must use the -tsv option to specify a databases_tsv_file specifying genomes that I've run getorf on\n\n";
}
if (!-e $databases_tsv_file) {
    die "\n\nTERMINATING - you specified a database file that does not exist: $databases_tsv_file\n\n";
}

### first read in all possible genomes
open (TSV, "< $databases_tsv_file");
while (<TSV>) {
    my $line = $_; chomp $line; my @f = split /\t/, $line;
    if ($line =~ m/^output_tag/) {next;} # header
    my $proteome = $f[1];
    if(!-e $proteome) {
        print "\n\nWARNING - cannot find proteome file specified in the databases_tsv_file: $proteome. Skipping it for now\n\n";
        next;
    }


    my $command = "sbatch --wrap=\'~/EZHIP_janet/bin/replace_U_inProtSeq.bioperl $proteome\'";

    if (!$debug) {
        system($command);
    } 
    
}
close TSV;
