set -o pipefail;

ln -s '/data/dnb10/galaxy_db/files/2/0/8/dataset_208a9290-42ff-4677-bd15-a8d75eb38903.dat' genome.fa && 
hisat2-build -p ${GALAXY_SLOTS:-1} genome.fa genome &&

ln -s '/data/dnb10/galaxy_db/files/9/3/4/dataset_9349bdd3-8265-4293-9940-aeba782eca44.dat' input_f.fastq.gz &&  
ln -s '/data/dnb10/galaxy_db/files/4/1/c/dataset_41cd668a-97ae-4c38-8efc-d3a18762af9a.dat' input_r.fastq.gz &&    

hisat2 -p ${GALAXY_SLOTS:-1} -x 'genome' -1 'input_f.fastq.gz' -2 'input_r.fastq.gz' | 
samtools sort --no-PG -l 0 -T "${TMPDIR:-.}" -O bam | 
samtools view --no-PG -O bam -@ ${GALAXY_SLOTS:-1} -o '/data/jwd02f/main/071/452/71452627/outputs/dataset_b61ba6b0-3cad-40b6-926c-8b9df5f7e752.dat'
