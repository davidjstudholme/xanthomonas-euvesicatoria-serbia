# Assessing quality of the three geome assemblies using [CheckM](https://doi.org/10.1101/gr.186072.114)

Download NCBI's datasets utility, which is needed for obtaining the genome assemblies form the NCBI's databases:

```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets
```

The list of genome accession numbers for the three genomes is specified in [xanthomonas_assm_accs.txt](xanthomonas_assm_accs.txt).
Use NCBI's datasets utility to download the three genome sequences, unzip them and make symlinks in current directory:

```
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt --include genome --filename xanthomonas_genome_assemblies.zip
unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
```

CheckM has been installed via [Conda](https://anaconda.com/).

```
conda activate checkm_env
checkm -h > checkm.version.txt
conda list -n checkm_env > checkm_env_packages.txt
conda env export > checkm_env.yaml
```

Details of oftware versions and the Conda environment are specified in these files:

- [checkm_env_packages.txt](checm_env_packages.txt)
- [checkm_env.yaml](checkm_env.yaml)
- [checkm.version.txt](checkm.version.txt)

```
checkm taxonomy_wf genus Xanthomonas . checkm_out
for i in 1 2 3 4 5 6 7 8 ; do
    echo $i
    checkm qa --out_format $i checkm_out/Xanthomonas.ms checkm_out > checkm_qa.$i.txt
done
```
