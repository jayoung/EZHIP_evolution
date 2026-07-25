#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;
use File::Find::Rule;

#### goal:  
# run hmmsearch with each HMM file specified on the command line against each translated genome/other protein database specified in a tsv file.

# the database tsv file contains a list of protein databases for hmmsearch, e.g. 6-frame genome translations.    First field = short name for output files (e.g. hg38_6frame). Second field = full path to protein seq file.


#### usage: 
# cd ~/EZHIP_janet/data/motifs/SupplementaryDataS2_MEMESeqs_balanced_subset/EZHIP_balancedSet_n16.fa_meme_webCommand_n10/motifs_hmmsearch_genomes

# ~/EZHIP_janet/bin/run_hmmsearch_many_genomes.pl -tsv /home/jayoung/EZHIP_janet/data/genome_files/various/nine_databases_for_hmmsearch.tsv balEZHIP-9-trimmed_3to16.fasta.hmm

my $databases_tsv_file = "";
my $hmmsearch_options = "";

my $use_sbatch = 1;
my $threads = 4;
my $memory = "4";   # in Gb
my $walltime = "1-0";
my $debug = 0;

GetOptions("tsv=s"      => \$databases_tsv_file,
           "opt=s"      => \$hmmsearch_options,
           "sbatch=i"   => \$use_sbatch,
           "t=i"        => \$threads,
           "memory=s"   => \$memory,
           "wall=s"     => \$walltime,
           "debug"      => \$debug 
           ) or die "\n\nterminating - unknown option(s) specified on command line\n\n"; 



###########

### upfront checks
if ($databases_tsv_file eq "") {
    die "\n\nTERMINATING - you must use the -tsv option to specify a databases_tsv_file specifying genomes that I've downloaded\n\n";
}
if (!-e $databases_tsv_file) {
    die "\n\nTERMINATING - you specified a database file that does not exist: $databases_tsv_file\n\n";
}

### read in genomes file
open (TSV, "< $databases_tsv_file");
my $genomes_searched = 0;
while (<TSV>) {
    my $line = $_; chomp $line; my @f = split /\t/, $line;
    if ($line =~ m/^output_tag/) {next;}
    my $short_name = $f[0];
    my $db_fasta = $f[1];
    if(!-e $db_fasta) {
        die "\n\nWARNING - cannot find fasta file specified in the databases_tsv_file: $db_fasta. Skipping it for now\n\n";
        # next;
    }

    $genomes_searched++;

    ### now go through each query file
    foreach my $query_hmm_file (@ARGV) {
        if (!-e $query_hmm_file) {
            die "\n\nERROR - you specified a query HMM file that doesn't exist: $query_hmm_file\n\n";
        }
        my $query_nodir = $query_hmm_file;
        if ($query_nodir =~ m/\//) {
            $query_nodir = (split (/\//, $query_nodir)) [-1];
        }
        my $outStem = $query_nodir . ".hmmsearch.VS." . $short_name;
        if (-e "$outStem.domtblout.txt") {
            print "output file exists - skipping this one $outStem.domtblout.txt\n";
            next;
        }
        # print "outStem $outStem\n";

        ## write a shell script
        my $shellScript = "$outStem.sh";
        open (SH, "> $shellScript");
        print SH "#!/bin/bash\n";
        print SH "source /app/lmod/lmod/init/profile\n\n";
        print SH "module purge\n";
        print SH "module load HMMER/3.4-gompi-2023a\n\n";

        print SH "hmmsearch $hmmsearch_options \\\n";
        print SH "    -o $outStem.txt \\\n";
        print SH "    --cpu $threads \\\n";
        print SH "    --tblout $outStem.tblout.txt \\\n";
        print SH "    --domtblout $outStem.domtblout.txt \\\n";
        print SH "    $query_hmm_file \\\n";
        print SH "    $db_fasta > $outStem.log.txt\n\n";

        print SH "module purge\n\n";
        close SH;

        ## run the shell script, maybe adding sbatch wrapping
        my $runCommand = "bash $shellScript";
        if ($use_sbatch == 1) {
            $runCommand = "sbatch --cpus-per-task=$threads -t $walltime --job-name=hmmsearch --wrap=\"$runCommand\"";
        }
        if ($debug == 0) { system($runCommand); }
    }
}
close TSV;

print "Searching $genomes_searched genomes\n";
