### Download NCBI's datasets utility:
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets

### Use NCBI's datasets utility to download the genome sequences, unzip them and make symlinks in curren directory:
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt --include genome --filename xanthomonas_genome_assemblies.zip
unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .


### Assume that we already installed Platon as instructed at https://github.com/oschwengers/platon?tab=readme-ov-file#installation
conda activate platon_env
conda list -n platon_env > platon_env_packages.txt
conda env export > platon_env.yaml

### Run Platon
platon --db ./db --prefix X31 --output X31.platon --mode accuracy --verbose --threads 12 GCA_030345955.2_ASM3034595v2_genomic.fna
platon --db ./db --prefix X13 --output X13.platon --mode accuracy --verbose --threads 12 GCA_030345975.2_ASM3034597v2_genomic.fna
platon --db ./db --prefix X22 --output X22.platon --mode accuracy --verbose --threads 12 GCA_030345985.2_ASM3034598v2_genomic.fna 
