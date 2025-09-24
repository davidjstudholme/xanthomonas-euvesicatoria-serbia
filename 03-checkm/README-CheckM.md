

Download NCBI's datasets utility:
```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets
```

Use NCBI's datasets utility to download the genome sequences, unzip them and make symlinks in curren directory:

```
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt --include genome --filename xanthomonas_genome_assemblies.zip
unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
rm README.md
```

Run checkm
Assumes that checkm is already installed

```
conda activate checkm_env
checkm -h > checkm.version.txt
conda list -n checkm_env > checkm_env_packages.txt
conda env export > checkm_env.yaml
```


```
checkm taxonomy_wf genus Xanthomonas . checkm_out
for i in 1 2 3 4 5 6 7 8 ; do
    echo $i
    checkm qa --out_format $i checkm_out/Xanthomonas.ms checkm_out > checkm_qa.$i.txt
done
```
