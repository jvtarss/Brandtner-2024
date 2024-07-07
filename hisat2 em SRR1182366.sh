set -o pipefail;

ln -s '/data/dnb10/galaxy_db/files/2/0/8/dataset_208a9290-42ff-4677-bd15-a8d75eb38903.dat' genome.fa && 
hisat2-build -p ${GALAXY_SLOTS:-1} genome.fa genome &&

ln -s '/data/dnb10/galaxy_db/files/8/8/4/dataset_8840c368-2e0a-4105-93ad-967ccd514f86.dat' input_f.fastq.gz &&  
ln -s '/data/dnb10/galaxy_db/files/c/7/5/dataset_c7547432-538d-46b2-9170-09b5224c5826.dat' input_r.fastq.gz &&    

hisat2 -p ${GALAXY_SLOTS:-1} -x 'genome' -1 'input_f.fastq.gz' -2 'input_r.fastq.gz' | 
samtools sort --no-PG -l 0 -T "${TMPDIR:-.}" -O bam | 
samtools view --no-PG -O bam -@ ${GALAXY_SLOTS:-1} -o '/data/jwd05e/main/071/452/71452625/outputs/dataset_e677601a-a09d-40e7-b156-5fbb1539b09c.dat'
