#!/bin/bash
source /app/lmod/lmod/init/profile
module purge

## activate some modules installed by Fred Hutch scientific computing staff, needed to run meme that I installed myself
module load GCCcore/11.2.0           
module load Python/3.9.6-GCCcore-11.2.0
module load Ghostscript/9.54.0-GCCcore-11.2.0
module load zlib/1.2.11-GCCcore-11.2.0  
module load OpenMPI/4.1.1-GCC-11.2.0

meme EZHIP_sequences_used_for_MEME_analyses.fa \
     -protein \
     -oc EZHIP_sequences_used_for_MEME_analyses.fa_meme \
     -nostatus -time 14400 \
     -mod zoops \
     -nmotifs 10 \
     -minw 6 -maxw 50 \
     -objfun classic \
     -markov_order 0

mast EZHIP_sequences_used_for_MEME_analyses.fa_meme/meme.xml \
     EZHIP_sequences_used_for_MEME_analyses.fa \
     -oc EZHIP_sequences_used_for_MEME_analyses.fa_meme \
     -nostatus

module purge
