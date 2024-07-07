set -o pipefail;

ln -s '/data/dnb10/galaxy_db/files/2/0/8/dataset_208a9290-42ff-4677-bd15-a8d75eb38903.dat' genome.fa && 
hisat2-build -p ${GALAXY_SLOTS:-1} genome.fa genome &&

ln -s '/data/dnb10/galaxy_db/files/6/c/1/dataset_6c110cb6-4de8-4962-97d4-622e10562411.dat' input_f.fastq.gz &&  
ln -s '/data/dnb10/galaxy_db/files/0/5/f/dataset_05f5054e-0aea-4abd-a0ec-df2ef0fa8919.dat' input_r.fastq.gz &&    

hisat2 -p ${GALAXY_SLOTS:-1} -x 'genome' -1 'input_f.fastq.gz' -2 'input_r.fastq.gz' | 
samtools sort --no-PG -l 0 -T "${TMPDIR:-.}" -O bam | 
samtools view --no-PG -O bam -@ ${GALAXY_SLOTS:-1} -o '/data/jwd05e/main/071/452/71452622/outputs/dataset_90947fe9-d6dd-4919-836e-1673ba29e07e.dat'
