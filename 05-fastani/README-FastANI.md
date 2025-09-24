# Calculating average nucleotide identity (ANI) with FastANI

Download NCBI's datasets utility, which is needed for obtaining the genome assemblies form the NCBI's databases:

```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets
```

File [assm_accs.txt](assm_accs.txt) lists the accession numbers for the genome assemblies to be analysed.
File [genomes.txt](genomes.txt) maps the accession numbers to strain names.
Use NCBI's datasets utility to download the three genome sequences, unzip them and make symlinks in current directory:

```
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt --include genome --filename xanthomonas_genome_assemblies.zip
unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
```

Use script [rename_files.pl](rename_files.pl) to make symlinks to the genome sequence files such that symlinks have informative names and appropriate extensions for input to PhaME:

```
perl rename_files.pl genomes.txt
```


FastANI has been installed via [Conda](https://anaconda.com/).


```
conda activate fastani_env
conda list -n fastani_env > fastani_env_packages.txt
conda env export > fastani_env.yaml
```

Details of oftware versions and the Conda environment are specified in these files:

- [fastani_env_packages.txt](fastani_env_packages.txt)
- [fastani_env.yaml](fastani_env.yaml)

Run FastANI
```
fastANI --ql query_list.txt --rl ref_list.txt -o Xeu-fastANI.short.out -t 6 --visualize --matrix
```


