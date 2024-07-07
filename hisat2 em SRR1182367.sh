set -o pipefail;

ln -s '/data/dnb10/galaxy_db/files/2/0/8/dataset_208a9290-42ff-4677-bd15-a8d75eb38903.dat' genome.fa && 
hisat2-build -p ${GALAXY_SLOTS:-1} genome.fa genome &&

ln -s '/data/dnb10/galaxy_db/files/b/5/4/dataset_b5422c32-22d2-4776-afb0-917ac443c17e.dat' input_f.fastq.gz &&  
ln -s '/data/dnb10/galaxy_db/files/a/5/3/dataset_a53e79ca-0dce-44e1-869d-91152ee40df5.dat' input_r.fastq.gz &&    

hisat2 -p ${GALAXY_SLOTS:-1} -x 'genome' -1 'input_f.fastq.gz' -2 'input_r.fastq.gz' | 
samtools sort --no-PG -l 0 -T "${TMPDIR:-.}" -O bam | 
samtools view --no-PG -O bam -@ ${GALAXY_SLOTS:-1} -o '/data/jwd02f/main/071/452/71452626/outputs/dataset_834990f0-d6f8-4f7a-923c-16dc6f914315.dat'
