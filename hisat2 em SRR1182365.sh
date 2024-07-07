set -o pipefail;

ln -s '/data/dnb10/galaxy_db/files/2/0/8/dataset_208a9290-42ff-4677-bd15-a8d75eb38903.dat' genome.fa && 
hisat2-build -p ${GALAXY_SLOTS:-1} genome.fa genome &&

ln -s '/data/dnb10/galaxy_db/files/c/1/e/dataset_c1e988bd-28f9-41d9-98c2-cbeef2e15c6f.dat' input_f.fastq.gz &&  
ln -s '/data/dnb10/galaxy_db/files/a/7/9/dataset_a79c5f71-851b-40e2-b78d-6f70dfa14af1.dat' input_r.fastq.gz &&    

hisat2 -p ${GALAXY_SLOTS:-1} -x 'genome' -1 'input_f.fastq.gz' -2 'input_r.fastq.gz' | 
samtools sort --no-PG -l 0 -T "${TMPDIR:-.}" -O bam | 
samtools view --no-PG -O bam -@ ${GALAXY_SLOTS:-1} -o '/data/jwd02f/main/071/452/71452624/outputs/dataset_c19d5b24-cb9e-4de0-bc61-f7e0381fbde0.dat'
