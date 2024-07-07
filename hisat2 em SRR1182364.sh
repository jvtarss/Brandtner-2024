set -o pipefail;

ln -s '/data/dnb10/galaxy_db/files/2/0/8/dataset_208a9290-42ff-4677-bd15-a8d75eb38903.dat' genome.fa && 
hisat2-build -p ${GALAXY_SLOTS:-1} genome.fa genome &&

ln -s '/data/dnb10/galaxy_db/files/e/2/a/dataset_e2a2568b-19ab-44cd-8924-1ee0414b76f4.dat' input_f.fastq.gz &&  
ln -s '/data/dnb10/galaxy_db/files/f/7/d/dataset_f7d6d5fd-47f1-4383-b0a4-c3d18a2f6056.dat' input_r.fastq.gz &&    

hisat2 -p ${GALAXY_SLOTS:-1} -x 'genome' -1 'input_f.fastq.gz' -2 'input_r.fastq.gz' | 
samtools sort --no-PG -l 0 -T "${TMPDIR:-.}" -O bam | 
samtools view --no-PG -O bam -@ ${GALAXY_SLOTS:-1} -o '/data/jwd05e/main/071/452/71452623/outputs/dataset_bc31791b-dfe1-47ed-8067-5281f6f746f1.dat'
