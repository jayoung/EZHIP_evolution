#!/bin/bash
source /app/lmod/lmod/init/profile

module purge
module load HMMER/3.4-gompi-2023a

echo '' > EZHIP-5.fasta.hmmbuild.log.txt
echo '### Running hmmbuild' >> EZHIP-5.fasta.hmmbuild.log.txt
echo '' >> EZHIP-5.fasta.hmmbuild.log.txt
hmmbuild --cpu=4  EZHIP-5.fasta.hmm EZHIP-5.fasta >> EZHIP-5.fasta.hmmbuild.log.txt

echo '' >> EZHIP-5.fasta.hmmbuild.log.txt
echo '### Running hmmpress' >> EZHIP-5.fasta.hmmbuild.log.txt
echo '' >> EZHIP-5.fasta.hmmbuild.log.txt
hmmpress EZHIP-5.fasta.hmm >> EZHIP-5.fasta.hmmbuild.log.txt

echo '' >> EZHIP-5.fasta.hmmbuild.log.txt
echo '### Done' >> EZHIP-5.fasta.hmmbuild.log.txt
echo '' >> EZHIP-5.fasta.hmmbuild.log.txt

module purge

