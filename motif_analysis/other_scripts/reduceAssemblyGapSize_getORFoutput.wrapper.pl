#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;
use File::Find::Rule;

#### goal:  run reduceAssemblyGapSize_getORFoutput.bioperl on many files, using sbatch

my $use_sbatch = 1;
my $threads = 1;
my $memory = "4";   # in Gb
my $walltime = "1-0";
my $debug = 0;

GetOptions("sbatch=i"   => \$use_sbatch,
           "t=i"        => \$threads,
           "memory=s"   => \$memory,
           "wall=s"     => \$walltime,
           "debug"      => \$debug 
           ) or die "\n\nterminating - unknown option(s) specified on command line\n\n"; 



###########


foreach my $file (@ARGV) {
    
    if(!-e $file) {
        die "\n\nTerminating - cannot find file specified on command line: $file.\n\n";
    }
    ## check whether output exists
    my $output = $file;
    $output =~ s/\.fa$//; $output .= ".smallerGaps.min50.fa";
    if (-e $output) {
        print "Skipping file $file - output exists already\n";
        next;
    }
    ## now put together the command
    my $runCommand = "/fh/fast/malik_h/user/jayoung/forOtherPeople/forPravrutha/EZHIP_janet/bin/reduceAssemblyGapSize_getORFoutput.bioperl $file";

    ## run the command, maybe adding sbatch wrapping
    if ($use_sbatch == 1) {
        $runCommand = "sbatch --cpus-per-task=$threads -t $walltime --mem=$memory"."G --job-name=reduceGaps --wrap=\"$runCommand\"";
    }
    if ($debug == 0) { system($runCommand); }

}
