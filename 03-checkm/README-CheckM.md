# Assessing quality of the three geome assemblies using [CheckM](https://doi.org/10.1101/gr.186072.114)

Download NCBI's datasets utility, which is needed for obtaining the genome assemblies form the NCBI's databases:

```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/linux-amd64/datasets'
chmod u+x datasets
```

File [xanthomonas_assm_accs.txt](xanthomonas_assm_accs.txt) lists the accession numbers for the genome assemblies to be analysed.
File [genomes.txt](genomes.txt) maps the accession numbers to strain names.
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

- [checkm_env_packages.txt](checkm_env_packages.txt)
- [checkm_env.yaml](checkm_env.yaml)
- [checkm.version.txt](checkm.version.txt)


Run CheckM

```
checkm taxonomy_wf genus Xanthomonas . checkm_out
for i in 1 2 3 4 5 6 7 8 ; do
    echo $i
    checkm qa --out_format $i checkm_out/Xanthomonas.ms checkm_out > checkm_qa.$i.txt
done
```

CheckM results:

- [Results in format #1](checkm_qa.1.txt) Summary of genome assembly completeness, contamination, and strain heterogeneity
- [Results in format #2](checkm_qa.2.txt) Extended summary of genome assembly quality (includes GC, genome size, coding density, ...)
- [Results in format #3](checkm_qa.3.txt) Summary of genome assembly quality for increasingly basal lineage-specific marker sets
- [Results in format #4](checkm_qa.4.txt) List of marker genes for each genome assembly along with the number of times each marker was identified
- [Results in format #5](checkm_qa.5.txt) List of genome assembly id, marker gene id, and called gene id for each identified marker gene
- [Results in format #6](checkm_qa.6.txt) List of marker genes present multiple times in a genome assembly
- [Results in format #7](checkm_qa.7.txt) List of marker genes present multiple times on the same scaffold
- [Results in format #8](checkm_qa.8.txt) List indicating the position of each marker genes within a genome assembly

These formats are described in the [CheckM wiki](https://github.com/Ecogenomics/CheckM/wiki/Genome-Quality-Commands#qa).
