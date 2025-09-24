# Aligning genomic sequence reads against reference genome sequences, using [BWA-MEM](https://doi.org/10.48550/arXiv.1303.3997)

Get reference genome assemblies:

```
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/Xe173.fasta .
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/85-10.fasta .
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/LMG_930.fasta .
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/X22.fasta .
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/X13.fasta .
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/X31.fasta .
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/66b.fasta .
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/Tu-10.fasta .
```

Get Sequence reads from Sequence Read Archive (SRA):

```
### Serbia Xeu strains
fasterq-dump SRR24958750 SRR24958751 SRR24958752 

### Xeu Tu-10
fasterq-dump SRR23352206

### Xeu 66b
fasterq-dump SRR4714703

### Vietnam Xeu strains
fasterq-dump SRR26670402 SRR26670404 SRR26670403 SRR26670400 SRR26670399

### Canada Xeu strains
fasterq-dump SRR16936518 SRR16936575 SRR16936578 SRR16936582 SRR16936540
```

Compress the FASTQ files, using gzip:

```
for i in *.fastq; do echo $i; gzip $i; done
```

Perform quality control on the sequence reads prior to alignment, using [TrimGalore](http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/):

```
for i in SRR24958750 SRR24958751 SRR24958752 SRR23352206 SRR4714703 SRR26670402 SRR26670404 SRR26670403 SRR26670400 SRR26670399 SRR16936518 SRR16936575 SRR16936578 SRR16936582 SRR16936540; do
    trim_galore -q 30 --paired "$i"_1.fastq.gz "$i"_2.fastq.gz
done
```

Remove the original FASTQ files to free up some disk space:

```
for i in SRR24958750 SRR24958751 SRR24958752 SRR23352206 SRR4714703 SRR26670402 SRR26670404 SRR26670403 SRR26670400 SRR26670399 SRR16936518 SRR16936575 SRR16936578 SRR16936582 SRR16936540; do
    echo $i
    rm "$i"*.fastq.gz
done
```

Rename the cleaned FASTQ files:

```
mv SRR24958750_1_val_1.fq.gz X31.1.fq.gz
mv SRR24958750_2_val_2.fq.gz X31.2.fq.gz
mv SRR24958751_1_val_1.fq.gz X22.1.fq.gz
mv SRR24958751_2_val_2.fq.gz X22.2.fq.gz
mv SRR24958752_1_val_1.fq.gz X13.1.fq.gz
mv SRR24958752_2_val_2.fq.gz X13.2.fq.gz

mv SRR23352206_1_val_1.fq.gz Tu-10.1.fq.gz
mv SRR23352206_2_val_2.fq.gz Tu-10.2.fq.gz

mv SRR4714703_1_val_1.fq.gz 66b.1.fq.gz
mv SRR4714703_2_val_2.fq.gz 66b.2.fq.gz

mv SRR26670402_1_val_1.fq.gz VTM12.1.fq.gz
mv SRR26670402_2_val_2.fq.gz VTM12.2.fq.gz
mv SRR26670404_1_val_1.fq.gz VTM4.1.fq.gz
mv SRR26670404_2_val_2.fq.gz VTM4.2.fq.gz
mv SRR26670403_1_val_1.fq.gz VTM10.1.fq.gz
mv SRR26670403_2_val_2.fq.gz VTM10.2.fq.gz
mv SRR26670400_1_val_1.fq.gz VTM15.1.fq.gz
mv SRR26670400_2_val_2.fq.gz VTM15.2.fq.gz
mv SRR26670399_1_val_1.fq.gz VTM16.1.fq.gz
mv SRR26670399_2_val_2.fq.gz VTM16.2.fq.gz

mv SRR16936518_1_val_1.fq.gz DC_97_P1A.1.fq.gz
mv SRR16936518_2_val_2.fq.gz DC_97_P1A.2.fq.gz
mv SRR16936575_1_val_1.fq.gz DC99P1A1.1.fq.gz
mv SRR16936575_2_val_2.fq.gz DC99P1A1.2.fq.gz
mv SRR16936578_1_val_1.fq.gz DC99P1B1.1.fq.gz
mv SRR16936578_2_val_2.fq.gz DC99P1B1.2.fq.gz
mv SRR16936582_1_val_1.fq.gz DC_96-5.1.fq.gz
mv SRR16936582_2_val_2.fq.gz DC_96-5.2.fq.gz
mv SRR16936540_1_val_1.fq.gz DC_96-3.1.fq.gz
mv SRR16936540_2_val_2.fq.gz DC_96-3.2.fq.gz
```


Perform BWA-MEM alignments against each reference genome, using custom wrapper script [do_bwa.pl](do_bwa.pl):

```
for i in 66b.fasta  85-10.fasta  LMG_930.fasta  Tu-10.fasta  X13.fasta  X22.fasta  X31.fasta  Xe173.fasta CP018463.1.fasta CP170254.1.fasta NC_016053.1.fasta  ; do
    perl do_bwa.pl $i
done
```

[Qualimap](https://doi.org/10.1093/bioinformatics/btv566) is already installed via Conda:

```
conda create -n qualimap_env
conda activate qualimap_env
conda install bioconda::qualimap
```

Gather information about the Conda environment:

```
conda activate qualimap_env
conda list -n qualimap_env > qualimap_env_packages.txt
conda env export > qualimap_env.yaml
```

Information about the Conda environment is recorded in these files:

- [qualimap_env_packages.txt](qualimap_env_packages.txt)
- [qualimap_env.yaml](qualimap_env.yaml)


Generate Qualimap input files:

```
for i in *versus.66b.fasta.aln.sorted.rmdup.bam; do echo $i $i; done
for i in *versus.66b.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > 66b.bam_list.txt
for i in *versus.85-10.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > 85-10.bam_list.txt
for i in *versus.LMG_930.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > LMG_930.bam_list.txt
for i in *versus.TU-10.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > Tu-10.bam_list.txt
for i in *versus.X13.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > X13.bam_list.txt
for i in *versus.X22.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > X22.bam_list.txt
for i in *versus.X31.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > X31.bam_list.txt
for i in *versus.Xe73.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > Xe73.bam_list.txt

for i in *versus.CP018463.1.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > CP018463.1.bam_list.txt
for i in *versus.CP170254.1.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > CP170254.1.bam_list.txt
for i in *versus.NC_016053.1.fasta.aln.sorted.rmdup.bam; do echo $i $i; done > NC_016053.1.1.bam_list.txt
```

Run Qualimap:

```
qualimap multi-bamqc --run-bamqc --data LMG_930.bam_list.txt -outdir LMG_930.multi-bamqc -outformat PDF

qualimap multi-bamqc --run-bamqc --data CP018463.1.bam_list.txt -outdir CP018463.1.multi-bamqc -outformat PDF
qualimap multi-bamqc --run-bamqc --data CP170254.1.bam_list.txt -outdir CP170254.1.multi-bamqc -outformat PDF
qualimap multi-bamqc --run-bamqc --data NC_016053.1.bam_list.txt -outdir NC_016053.1.multi-bamqc -outformat PDF
```

Qualimap coverage plots for _Xanthomonas euvesicatoria_ LMG930 plasmid pLMG930.2

- [66b reads versus CP018463.1](66b.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_96-3 reads versus CP018463.1](DC_96-3.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_96-5 reads versus CP018463.1](DC_96-5.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_97_P1A reads versus CP018463.1](DC_97_P1A.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC99P1A1 reads versus CP018463.1](DC99P1A1.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC99P1B1 reads versus CP018463.1](DC99P1B1.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [Tu-10 reads versus CP018463.1](Tu-10.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM10 reads versus CP018463.1](VTM10.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM12 reads versus CP018463.1](VTM12.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM15 reads versus CP018463.1](VTM15.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM16 reads versus CP018463.1](VTM16.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM4 reads versus CP018463.1](VTM4.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X13 reads versus CP018463.1](X13.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X22 reads versus CP018463.1](X22.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X31 reads versus CP018463.1](X31.versus.CP018463.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)


Qualimap coverage plots for _Xanthomonas euvesicatoria_ Xe173 75-kbp plasmid:

- [66b reads versus CP170254.1](66b.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_96-3 reads versus CP170254.1](DC_96-3.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_96-5 reads versus CP170254.1](DC_96-5.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_97_P1A reads versus CP170254.1](DC_97_P1A.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC99P1A1 reads versus CP170254.1](DC99P1A1.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC99P1B1 reads versus CP170254.1](DC99P1B1.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [Tu-10 reads versus CP170254.1](Tu-10.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM10 reads versus CP170254.1](VTM10.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM12 reads versus CP170254.1](VTM12.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM15 reads versus CP170254.1](VTM15.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM16 reads versus CP170254.1](VTM16.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM4 reads versus CP170254.1](VTM4.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X13 reads versus CP170254.1](X13.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X22 reads versus CP170254.1](X22.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X31 reads versus CP170254.1](X31.versus.CP170254.1.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)


Qualimap coverage plots for _Xanthomonas euvesicatoria_ LMG 930 complete genome:
  
- [66b reads versus LMG_930](66b.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_96-3 reads versus LMG_930](DC_96-3.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_96-5 reads versus LMG_930](DC_96-5.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC_97_P1A reads versus LMG_930](DC_97_P1A.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC99P1A1 reads versus LMG_930](DC99P1A1.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [DC99P1B1 reads versus LMG_930](DC99P1B1.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [Tu-10 reads versus LMG_930](Tu-10.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM10 reads versus LMG_930](VTM10.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM12 reads versus LMG_930](VTM12.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM15 reads versus LMG_930](VTM15.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM16 reads versus LMG_930](VTM16.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [VTM4 reads versus LMG_930](VTM4.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X13 reads versus LMG_930](X13.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X22 reads versus LMG_930](X22.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)
- [X31 reads versus LMG_930](X31.versus.LMG_930.fasta.aln.sorted.rmdup_stats/images_qualimapReport/genome_coverage_across_reference.png)


Make [TDF files](https://github.com/igvteam/igv/wiki/TDF-Format) that can be imported into [IGV](https://igv.org/) to generate coverage plots:

```
for i in *.versus.Xe173.fasta.aln.sorted.rmdup.bam; do
    echo $i
    igvtools count $i $i.tdf Xe173.fasta
done

for i in *.versus.85-10.fasta.aln.sorted.rmdup.bam; do
    echo $i
    igvtools count $i $i.tdf 85-10.fasta
done

for i in *.versus.LMG_930.fasta.aln.sorted.rmdup.bam; do
    echo $i
    igvtools count $i $i.tdf LMG_930.fasta
done

for i in *.versus.NC_016053.1.fasta.aln.sorted.rmdup.bam; do
    echo $i
    igvtools count $i $i.Xap41.tdf NC_016053.1.fasta
done

for i in *.versus.X13.fasta.aln.sorted.rmdup.bam; do
    echo $i
    igvtools count $i $i.tdf X13.fasta
done

for i in *.versus.X22.fasta.aln.sorted.rmdup.bam; do
    echo $i
    igvtools count $i $i.tdf X22.fasta
done
```
TDF coverage files:

- [Strain Xe173 complete genome](Xe173_TDF/)
- [Strain 85-10 complete genome/](85-10_TDF/)
- [Strain LMG 930 complete genome/](LMG_930_TDF/)
- [pXap41 plasmid_TDF/](NC_016053.1_TDF/)
- [Strain X13 complete genome](X13_TDF/)
- [Strain X22 complete genome](X22_TDF/)
  
