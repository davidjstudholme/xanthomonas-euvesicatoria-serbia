Download NCBI's datasets utility:

```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets
```

Use NCBI's datasets utility to download the genome sequences, unzip them and make symlinks in current directory:

```
./datasets download genome accession --inputfile assm_accs.txt --include genome --filename genome_assemblies.zip
unzip genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
```

Make symlinks to the genome sequence files such that symlinks have informative names and appropriate extensions for input to PhaME:

```
perl rename_files.pl genomes.txt
```


FastANI has already been installed via Conda

```
conda activate fastani_env
conda list -n fastani_env > fastani_env_packages.txt
conda env export > fastani_env.yaml
```

```
fastANI --ql query_list.txt --rl ref_list.txt -o Xeu-fastANI.short.out -t 6 --visualize --matrix
```


