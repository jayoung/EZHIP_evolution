#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;
use File::Find::Rule;

#### goal:  
# use a tsv file containing a list of proteomes that I've downloaded (tsv file is in a different format than the genomes file for the other wrapper script)
# run run_fimo_memeSuite_new2026.pl on each, using a meme.txt file I specify

#### usage: 
# cd ~/EZHIP_janet/data/motifs/newMEMEfile_2026_04_30b_v2/SupplementaryDataS3_MEMESeqs.lineBreaks.newSheep.fa_meme/meme.txt.FIMO.vs.selectedProteomes

# ~/EZHIP_janet/bin/run_fimo_memeSuite_new2026_wrapper_multiProteomes.pl  \
#     -motifs ../meme.txt
#     -tsv /home/jayoung/EZHIP_janet/data/genome_files/various/selected_NCBI_proteome_files.tsv 


my $databases_tsv_file = "";
my $motif_file = "";

my $fimo_options = "";

my $use_sbatch = 1;
my $memory = "16";   # in Gb
my $walltime = "1-0";
my $debug = 0;

GetOptions("tsv=s"      => \$databases_tsv_file,
           "motifs=s"   => \$motif_file,
           "opt=s"      => \$fimo_options,
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
if ($motif_file eq "") {
     die "\n\nTERMINATING - you must specify a motifs file using the -motifs option\n\n";
}
if (!-e $motif_file) {
     die "\n\nTERMINATING - you specified a motif file that does not exist: $motif_file\n\n";
}

### first read in all possible genomes
open (TSV, "< $databases_tsv_file");
while (<TSV>) {
    my $line = $_; chomp $line; my @f = split /\t/, $line;
    if ($line =~ m/^output_tag/) {next;} # header
    my $proteome = $f[1];
    my $proteomeFixU = $proteome;
    $proteomeFixU =~ s/\.fasta$//; $proteomeFixU =~ s/\.fa$//; 
    $proteomeFixU =~ s/\.faa$//;
    $proteomeFixU .= ".fixU.fa";

    my $tag = $f[0];
    if(!-e $proteomeFixU) {
        print "\n\nWARNING - cannot find proteome (fixU) file specified in the databases_tsv_file: $proteomeFixU. Skipping it for now\n\n";
        next;
    }

    ### construct output dir name and maybe mkdir 
    my $motif_file_noPath = $motif_file;
    if ($motif_file_noPath =~ /\//) {
        $motif_file_noPath = (split /\//, $motif_file_noPath)[-1];
    }
    my $outdir = "$motif_file_noPath.FIMO.vs.$f[0]";

    my $finalOutfile = "$outdir/fimo.txt";
    if (-e $finalOutfile) {
        print "    Skipping this genome, fimo.txt output already exists, in $outdir\n";
        next;
    }

    my $run_fimo_command = "~/EZHIP_janet/bin/run_fimo_memeSuite_new2026.pl -db $proteomeFixU -suff $tag -motif $motif_file $fimo_options";
    if ($debug) {$run_fimo_command .= " -debug";}

    print "Running FIMO against 6-frame ORFs for $tag\n";
    if (!$debug) {
        system($run_fimo_command);
    } else {
        print "run_fimo_command would be:\n\n$run_fimo_command\n\n";
    }
}
close TSV;
