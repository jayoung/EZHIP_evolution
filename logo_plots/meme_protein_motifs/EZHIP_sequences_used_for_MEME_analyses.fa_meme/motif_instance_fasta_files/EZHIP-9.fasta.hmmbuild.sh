#!/bin/bash
source /app/lmod/lmod/init/profile

module purge
module load HMMER/3.4-gompi-2023a

echo '' > EZHIP-9.fasta.hmmbuild.log.txt
echo '### Running hmmbuild' >> EZHIP-9.fasta.hmmbuild.log.txt
echo '' >> EZHIP-9.fasta.hmmbuild.log.txt
hmmbuild --cpu=4  EZHIP-9.fasta.hmm EZHIP-9.fasta >> EZHIP-9.fasta.hmmbuild.log.txt

echo '' >> EZHIP-9.fasta.hmmbuild.log.txt
echo '### Running hmmpress' >> EZHIP-9.fasta.hmmbuild.log.txt
echo '' >> EZHIP-9.fasta.hmmbuild.log.txt
hmmpress EZHIP-9.fasta.hmm >> EZHIP-9.fasta.hmmbuild.log.txt

echo '' >> EZHIP-9.fasta.hmmbuild.log.txt
echo '### Done' >> EZHIP-9.fasta.hmmbuild.log.txt
echo '' >> EZHIP-9.fasta.hmmbuild.log.txt

module purge

