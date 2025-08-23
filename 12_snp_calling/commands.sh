ln -s ../01_genome_assemblies/Xe173.fasta .
ln -s ../01_genome_assemblies/85-10.fasta .
ln -s ../01_genome_assemblies/LMG_930.fasta .
ln -s ../01_genome_assemblies/X22.fasta .
ln -s ../01_genome_assemblies/X13.fasta .
ln -s ../01_genome_assemblies/X31.fasta .
ln -s ../01_genome_assemblies/66b.fasta .
ln -s ../01_genome_assemblies/Tu-10.fasta .

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



for i in SRR24958750 SRR24958751 SRR24958752 SRR23352206 SRR4714703 SRR26670402 SRR26670404 SRR26670403 SRR26670400 SRR26670399 SRR16936518 SRR16936575 SRR16936578 SRR16936582 SRR16936540; do
    trim_galore -q 30 --paired "$i"_1.fastq.gz "$i"_2.fastq.gz
done
