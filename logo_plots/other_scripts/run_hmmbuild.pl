#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;
use File::Find::Rule;

#### goal:  
# for each fasta file specified on the command line, run hmmbuild and hmmpress (HMMER package)

#### usage: 
## cd to the directory where our R script output the instances for each motif:
# cd EZHIP_evolution/logo_plots/meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme/motif_instance_fasta_files 
## run this script on each motif
# ../../../other_scripts/run_hmmbuild.pl EZHIP*fasta

my $hmmbuild_options = "";

my $use_sbatch = 0;
my $threads = 4;
my $walltime = "1-0";
my $debug = 0;

GetOptions("opt=s"      => \$hmmbuild_options,
           "sbatch=i"   => \$use_sbatch,
           "t=i"        => \$threads,
           "wall=s"     => \$walltime,
           "debug"      => \$debug 
           ) or die "\n\nterminating - unknown option(s) specified on command line\n\n"; 



###########

foreach my $fasta (@ARGV) {

    my $outStem = $fasta;
    if ($outStem =~ m/\//) {
        $outStem = (split /\//, $outStem)[-1];
    }
    my $hmmOutput = "$outStem.hmm";
    if(-e $hmmOutput) {
        print "    Skipping file $fasta because output exists already\n";
        next;
    }
    my $logFile = "$outStem.hmmbuild.log.txt";

    ## write a shell script
    my $shellScript = "$outStem.hmmbuild.sh";
    open (SH, "> $shellScript");
    print SH "#!/bin/bash\n";
    print SH "source /app/lmod/lmod/init/profile\n\n";
    print SH "module purge\n";
    print SH "module load HMMER/3.4-gompi-2023a\n\n";

    print SH "echo \'\' > $logFile\n";
    print SH "echo \'### Running hmmbuild\' >> $logFile\n";
    print SH "echo \'\' >> $logFile\n";
    print SH "hmmbuild --cpu=$threads $hmmbuild_options $hmmOutput $fasta >> $logFile\n\n";

    print SH "echo \'\' >> $logFile\n";
    print SH "echo \'### Running hmmpress\' >> $logFile\n";
    print SH "echo \'\' >> $logFile\n";
    print SH "hmmpress $hmmOutput >> $logFile\n\n";

    print SH "echo \'\' >> $logFile\n";
    print SH "echo \'### Done\' >> $logFile\n";
    print SH "echo \'\' >> $logFile\n";
    print SH "\nmodule purge\n";
    print SH "\n";
    close SH;

    ## run the shell script, maybe adding sbatch wrapping
    my $runCommand = "bash $shellScript";
    if ($use_sbatch == 1) {
        my $time = "";
        $runCommand = "sbatch --cpus-per-task=$threads -t $walltime --job-name=hmmbuild --wrap=\"$runCommand\"";
    }
    if ($debug == 0) { system($runCommand); }

}
