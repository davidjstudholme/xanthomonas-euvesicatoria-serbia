# Assessing quality of the three geome assemblies using [QUAST](https://doi.org/10.1093/bioinformatics/btt086)



Download NCBI's datasets utility, which is needed for obtaining the genome assemblies form the NCBI's databases:

```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets
```

The list of genome accession numbers for the three genomes is specified in [xanthomonas_assm_accs.txt](xanthomonas_assm_accs.txt)
Use NCBI's datasets utility to download the three genome sequences, unzip them and make symlinks in current directory:

```
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt --include genome --filename xanthomonas_genome_assemblies.zip
unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
```

QUAST has been installed via [Conda](https://anaconda.com/).


```
conda activate quast_env
conda list -n quast_env > quast_env_packages.txt
conda env export > quast_env.yaml
```

Details of the Conda environment are specified in these files:

- [quast_env_packages.txt](quast_env_packages.txt)
- [quast_env.yaml](quast_env.yaml)


Execute QUAST on the three genome assemblies:
```
quast *.fna
```

The results of the QUAST analysis can be found in [this folder](quast_results/results_2025_09_22_20_15_44).


