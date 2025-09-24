
conda create -n bcftools_env
conda activate bcftools_env
#conda install bioconda::bcftools

conda list -n bcftools_env > bcftools_env_packages.txt
conda env export > bcftools_env.yaml






ln -s ../07_bwa_alignments/*.versus.85-10.fasta.aln.sorted.rmdup.bam* .
ln -s ../07_bwa_alignments/85-10.fasta .

### The first step is to identify candidate SNPs using SAMtools version 1.22 and BCFtools version 1.22
for alignmentFile in *.bam; do
    echo $alignmentFile
    bcftools mpileup -Ou -f 85-10.fasta $alignmentFile > $alignmentFile.bcf
done
for alignmentFile in *.bam; do
    echo $alignmentFile
    bcftools call -m -v -Ov $alignmentFile.bcf > $alignmentFile.vcf
done

### So, now we have a set of .vcf files containing candidate SNPs. Let's again use version 1.22 of BCFtools to filter these to keep only high-confidence ones:
for alignmentFile in *.bam; do
    bcftools filter --SnpGap 100 --include '(REF="A" | REF="C" | REF="G" | REF="T") & QUAL>=35 & INFO/DP>=5 & TYPE="snp"' $alignmentFile.vcf > $alignmentFile.filtered.vcf
done

### To generate the mpileup files (.pileup)
for alignmentFile in *.bam; do
    samtools mpileup -f 85-10.fasta $alignmentFile > $alignmentFile.pileup
done

### Now we are ready to generate the table of allele frequencies (considering only sites where read-coverage is at least 10x):
perl get_snps_from_pileups.pl 10 *.filtered.vcf *.pileup > snps.csv


