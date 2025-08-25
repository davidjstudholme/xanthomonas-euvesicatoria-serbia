
### Get reference genome assemblies
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/Xe173.fasta .
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/85-10.fasta .
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/LMG_930.fasta .
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/X22.fasta .
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/X13.fasta .
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/X31.fasta .
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/66b.fasta .
ln -s ../01_phylogenomics/01_all_xeu/01_genome_assemblies/Tu-10.fasta .

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

### Gzip the FASTQ files
for i in *.fastq; do echo $i; gzip $i; done

### Perform some QC on the sequence reads prior to alignment
for i in SRR24958750 SRR24958751 SRR24958752 SRR23352206 SRR4714703 SRR26670402 SRR26670404 SRR26670403 SRR26670400 SRR26670399 SRR16936518 SRR16936575 SRR16936578 SRR16936582 SRR16936540; do
    trim_galore -q 30 --paired "$i"_1.fastq.gz "$i"_2.fastq.gz
done

### Remove the original FASTQ files to free up some disk space
for i in SRR24958750 SRR24958751 SRR24958752 SRR23352206 SRR4714703 SRR26670402 SRR26670404 SRR26670403 SRR26670400 SRR26670399 SRR16936518 SRR16936575 SRR16936578 SRR16936582 SRR16936540; do
    echo $i
    rm "$i"*.fastq.gz
done

### Rename the cleaned FASTQ files
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

### Perform BWA alignments
for i in 66b.fasta  85-10.fasta  LMG_930.fasta  Tu-10.fasta  X13.fasta  X22.fasta  X31.fasta  Xe173.fasta; do
    perl do_bwa.pl $i
done

for i in CP018463.1.fasta CP170254.1.fasta NC_016053.1.fasta; do
    perl do_bwa.pl $i
done

### Assume that Qualimap is installed
conda create -n qualimap_env
conda activate qualimap_env
conda install bioconda::qualimap

### Generate Qualimap iput files
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

### Run Qualimap
qualimap multi-bamqc --run-bamqc --data LMG_930.bam_list.txt -outdir LMG_930.multi-bamqc -outformat PDF

qualimap multi-bamqc --run-bamqc --data CP018463.1.bam_list.txt -outdir CP018463.1.multi-bamqc -outformat PDF
qualimap multi-bamqc --run-bamqc --data CP170254.1.bam_list.txt -outdir CP170254.1.multi-bamqc -outformat PDF
qualimap multi-bamqc --run-bamqc --data NC_016053.1.bam_list.txt -outdir NC_016053.1.multi-bamqc -outformat PDF

