
# *De-novo* assembly of the three genome sequences

### Obtain and prepare the raw sequence data

Download the genomic sequence reads from the Sequence Read Archive (SRA) using NCBI's SRA Toolkit:

```
fasterq-dump --split-files SRR24958750 SRR24958751 SRR24958752
```

Compress the downloaded FASTQ files using gzip:

```
for i in *.fastq; do
    echo $i
    gzip $i
done
```

Perform TrimGalore on each dataset:

```
for i in  SRR24958750 SRR24958751 SRR24958752; do
    echo $i
    trim_galore -q 30 --paired  $i*_1.fastq.gz $i*_2.fastq.gz
done
```

### Run Unicycler to assemble the cleaned sequence reads

Unicycler was installed via Conda:

```
conda activate unicycler_env
conda list -n unicycler_env > unicycler_env_packages.txt
conda env export > unicycler_env.yaml
```
Details of the Conda environment, with software versions:
- [unicycler_env_packages.txt](unicycler_env_packages.txt)
- [unicycler_env.yaml](unicycler_env.yaml)


Perform Unicycler assembly for each of the three genomes:
```
for i in  SRR24958750 SRR24958751 SRR24958752; do
    echo $i
    unicycler -1 $i"_1_val_1.fq.gz"  -2 $i"_2_val_2.fq.gz" -o $i.unicycler
done
```


Make symbolic links to resulting assemblies:

```
for i in  SRR24958750 SRR24958751 SRR24958752 ; do
    echo $i
    ln -s $i.unicycler/assembly.fasta $i.unicycler.assembly.fasta
done
```

The resulting genome assemblies were submitted to GenBank via the NCBI to BioProject [PRJNA985260](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA985260):

| Assemblyaccession  |	WGS accession   |    BioSample    |	Strain |
| ---------          |   -------        |    --------     | ----   |
| GCA_030345955.2    |	JAUALK000000000 |    SAMN35794988 |	X31    |
| GCA_030345975.2    |	JAUALM000000000	|    SAMN35794986 |	X13    |
| GCA_030345985.2    |	JAUALL000000000	|    SAMN35794987 |	X22    |
