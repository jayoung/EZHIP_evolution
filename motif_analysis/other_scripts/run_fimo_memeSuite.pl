#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;

#### goal:  take a file of meme motifs and use them in a FIMO search

#### usage: 
# cd ~/EZHIP_janet/data/motifs/SupplementaryDataS2_MEMESeqs.txt_memeOutput_webCommand_n10_newMeme
# ~/EZHIP_janet/bin/run_fimo_memeSuite_new2026.pl \
#     -db ../../../zz_manuscript/2025_12_12_bioRxiv/supps/janet_analysis/SupplementaryDataS1_AncestorAndSyntenic_AA_degappedMax.txt.nogaps \
#     -outdir meme.txt.FIMO.vs.bioRxiv.S1nogaps \
#     -suff bioRxiv.S1nogaps

my $database = "";
my $motif_file = "meme.txt";
# my $outdir = "";
my $outfile_suffix = "";

my $fimo_options = "";

my $use_sbatch = 1;
my $memory = "16";   # in Gb
my $walltime = "1-0";
my $debug = 0;

GetOptions("db=s"       => \$database,
           "motifs=s"   => \$motif_file,
           "opt=s"      => \$fimo_options,
        #    "outdir=s"   => \$outdir,
           "suff=s"     => \$outfile_suffix,
           "sbatch=i"   => \$use_sbatch,
           "memory=s"   => \$memory,
           "wall=s"     => \$walltime,
           "debug"      => \$debug 
           ) or die "\n\nterminating - unknown option(s) specified on command line\n\n"; 


## more options, not settable:

## if I'm using meme installed by me
my @modules = ("GCCcore/11.2.0",
               "Python/3.9.6-GCCcore-11.2.0",
               "Ghostscript/9.54.0-GCCcore-11.2.0",
               "zlib/1.2.11-GCCcore-11.2.0",
               "OpenMPI/4.1.1-GCC-11.2.0");

## if I'm using meme installed by scicomp:
# my @modules = ("MEME/5.5.1-gompi-2021b");

###########

### upfront checks
if ($database eq "") {
    die "\n\nTERMINATING - you must specify a database to search using the -db option\n\n";
}
if (!-e $database) {
    die "\n\nTERMINATING - you specified a database file that does not exist: $database\n\n";
}
if (!-e $motif_file) {
     die "\n\nTERMINATING - you specified a motif file that does not exist: $motif_file\n\n";
}
# if ($outdir eq "") {
#     die "\n\nTERMINATING - you must specify an output folder name using the -outdir option\n\n";
# }
if ($outfile_suffix eq "") {
    die "\n\nTERMINATING - you must specify an output filename suffix using the -suff option\n\n";
}


### construct output dir name and maybe mkdir 
my $motif_file_noPath = $motif_file;
if ($motif_file_noPath =~ /\//) {
    $motif_file_noPath = (split /\//, $motif_file_noPath)[-1];
}
my $outdir = "$motif_file_noPath.FIMO.vs.$outfile_suffix";
if(!-e $outdir) { mkdir $outdir; }

### construct other output file names
my $fileStem = "$outdir/fimo." . $outfile_suffix;

my $finalOutfile = "$outdir/fimo.txt";
if (-e $finalOutfile) {
    die "\n\nTerminating - output file exists already, don't want to overwrite: $finalOutfile\n\n";
}

my $shellScript = $fileStem . ".sh";
my $log_file = $fileStem . ".log.txt";

### write shell script
open (SH, "> $shellScript");
print SH "#!/bin/bash\n";
print SH "source /app/lmod/lmod/init/profile\n";
print SH "module purge\n\n";

## load modules
foreach my $module (@modules) {
    print SH "module load $module\n"
}
print SH "\n";

## run FIMO
print SH "echo 'Running FIMO'\n";
print SH "fimo --oc $outdir \\\n";
print SH "     $fimo_options $motif_file \\\n";
print SH "     $database \\\n";
print SH "     2>&1 >> $log_file\n";
print SH "\n";
 
print SH "echo 'Finished'\n";

print SH "module purge\n";
close SH;

## run the shell script, maybe adding sbatch wrapping
my $runCommand = "bash $shellScript 2>&1 >> $log_file";
if ($use_sbatch == 1) {
    my $time = "";
    $runCommand = "sbatch -t $walltime --mem=$memory"."G --job-name=FIMO --wrap=\"$runCommand\"";
}
if ($debug == 0) { system($runCommand); }

