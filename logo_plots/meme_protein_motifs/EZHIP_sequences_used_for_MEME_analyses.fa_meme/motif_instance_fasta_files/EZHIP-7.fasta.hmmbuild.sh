#!/bin/bash
source /app/lmod/lmod/init/profile

module purge
module load HMMER/3.4-gompi-2023a

echo '' > EZHIP-7.fasta.hmmbuild.log.txt
echo '### Running hmmbuild' >> EZHIP-7.fasta.hmmbuild.log.txt
echo '' >> EZHIP-7.fasta.hmmbuild.log.txt
hmmbuild --cpu=4  EZHIP-7.fasta.hmm EZHIP-7.fasta >> EZHIP-7.fasta.hmmbuild.log.txt

echo '' >> EZHIP-7.fasta.hmmbuild.log.txt
echo '### Running hmmpress' >> EZHIP-7.fasta.hmmbuild.log.txt
echo '' >> EZHIP-7.fasta.hmmbuild.log.txt
hmmpress EZHIP-7.fasta.hmm >> EZHIP-7.fasta.hmmbuild.log.txt

echo '' >> EZHIP-7.fasta.hmmbuild.log.txt
echo '### Done' >> EZHIP-7.fasta.hmmbuild.log.txt
echo '' >> EZHIP-7.fasta.hmmbuild.log.txt

module purge

