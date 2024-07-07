export FC_PATH=$(command -v featureCounts | sed 's@/bin/featureCounts$@@') && 
featureCounts -a '/data/dnb10/galaxy_db/files/0/9/9/dataset_099cbe59-4665-4210-8867-41ad330d3336.dat' \
              -F "GTF" \
              -o "output" \
              -T ${GALAXY_SLOTS:-2} \
              -s 0 \
              -Q 0 \
              -t 'exon' \
              -g 'gene_id' \
              --minOverlap 1 \
              --fracOverlap 0 \
              --fracOverlapFeature 0 \
              -p -B -C '/data/dnb10/galaxy_db/files/9/0/9/dataset_90947fe9-d6dd-4919-836e-1673ba29e07e.dat' && 
grep -v "^#" "output" | sed -e 's|/data/dnb10/galaxy_db/files/9/0/9/dataset_90947fe9-d6dd-4919-836e-1673ba29e07e.dat|SRR11821363|g' > body.txt && 
cut -f 1,7 body.txt > '/data/jwd02f/main/071/455/71455565/outputs/dataset_afbcfca9-4078-4e09-8ad6-635a07b8589d.dat' && 
sed -e 's|/data/dnb10/galaxy_db/files/9/0/9/dataset_90947fe9-d6dd-4919-836e-1673ba29e07e.dat|SRR11821363|g' 'output.summary' > '/data/jwd02f/main/071/455/71455565/outputs/dataset_39adf0af-8970-4a6f-8656-e33276a7d8e4.dat'
