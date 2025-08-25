
#conda activate harvest_env
#conda install -c bioconda parsnp


### Download Xe173 reference genome in GenBank format
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/042/448/555/GCF_042448555.1_ASM4244855v1/GCF_042448555.1_ASM4244855v1_genomic.gbff.gz
gunzip GCF_042448555.1_ASM4244855v1_genomic.gbff.gz

### Run parsnp
parsnp -g GCF_042448555.1_ASM4244855v1_genomic.gbff -d except_Xe173/*.fasta -o parsnp_Xe173
parsnp -r cluster_6_genomes/X13.fasta -d except_X13/*.fasta -o parsnp_X13
parsnp -r cluster_6_genomes/X22.fasta -d except_X22/*.fasta -o parsnp_X22

