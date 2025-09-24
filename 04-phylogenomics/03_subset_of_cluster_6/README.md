# Phylogenomics using [PhaME](https://doi.org/10.1038/s41598-020-58356-1)

### In the 01_genome_assemblies/ directory

Download NCBI's datasets utility:

```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets
```

Use NCBI's datasets utility to download the genome sequences, unzip them and make symlinks in current (genomes) directory:

```
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt --include genome --filename xanthomonas_genome_assemblies.zip
unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
```

Make symlinks to the genome sequence files such that symlinks have informative names and appropriate extensions for input to PhaME:

```
perl rename_files.pl genomes.txt
```

### In the 02_ref/ directory

Create a symplink to the reference genome sequence:
```
ln -s ../01_genome_assemblies/66b.fasta .
```


### In the 03_wordir/ directory

Make symlinks to the genome sequences, excuding the reference genome:
```
ln -s ../01_genome_assemblies/*.contig .

### Remove duplicate of reference genome
rm 66b.contig
```

### In the 04_phame/ directory

PhaME will take a long time to run, so best to do it in a screen session:

```
screen
```

Already installed PhaME into a Conda environment:

```
conda activate phame_env
```

Run PhaME:

```
phame ./phame.ctl
```

### Results

Results: [03_workdir/results/trees/Xeu_cluster6_subset_all.fasttree](03_workdir/results/trees/Xeu_cluster6_subset_all.fasttree)
