



Installed BCFtools via Conda:

```
conda create -n bcftools_env
conda activate bcftools_env
conda install bioconda::bcftools
```

Gathered version numbers and information about the Conda environment:

```
conda activate bcftools_env
conda list -n bcftools_env > bcftools_env_packages.txt
conda env export > bcftools_env.yaml
```

Information about version numbers and Conda environment are in these files:

- [bcftools_env_packages.txt](bcftools_env_packages.txt)
- [bcftools_env.yaml](bcftools_env.yaml)

```  
ln -s ../07_bwa_alignments/*.versus.85-10.fasta.aln.sorted.rmdup.bam* .
ln -s ../07_bwa_alignments/85-10.fasta .
```



Identify candidate SNPs using SAMtools version 1.22 and BCFtools version 1.22:

```
for alignmentFile in *.bam; do
    echo $alignmentFile
    bcftools mpileup -Ou -f 85-10.fasta $alignmentFile > $alignmentFile.bcf
done

for alignmentFile in *.bam; do
    echo $alignmentFile
    bcftools call -m -v -Ov $alignmentFile.bcf > $alignmentFile.vcf
done
```


Now we have a set of .vcf files containing candidate SNPs. Use version 1.22 of BCFtools to filter these to keep only high-confidence ones:

```
for alignmentFile in *.bam; do
    bcftools filter --SnpGap 100 --include '(REF="A" | REF="C" | REF="G" | REF="T") & QUAL>=35 & INFO/DP>=5 & TYPE="snp"' $alignmentFile.vcf > $alignmentFile.filtered.vcf
done
```

Generate the mpileup files (.pileup):

```
for alignmentFile in *.bam; do
    samtools mpileup -f 85-10.fasta $alignmentFile > $alignmentFile.pileup
done
```

Now we are ready to generate the table of allele frequencies (considering only sites where read-coverage is at least 10x). Generate the table using [get_snps_from_pileups.pl ](get_snps_from_pileups.pl):

```
perl get_snps_from_pileups.pl 10 *.filtered.vcf *.pileup > snps.csv
```

Results of SNP-calling: 

- [snps.csv](snps.csv) as a tab-delimted table, ready to import into a spreadsheet

Finally, from the table of SNPs, generate a haplotype pseudos-sequence in Nexus format:

```
get_haplotypes_and_aligned_fasta_from_csv.pl snps.csv
```

Results:

- [snps.csv.haplotype.nex](snps.csv.haplotype.nex) in Nexus format, ready to import into [PopArt](https://doi.org/10.1186/s12864-025-11206-8).

Files exported from PopArt:

- [Xeu.snps.csv.haplotype.nex](Xeu.snps.csv.haplotype.nex)
- [Xeu.snps.csv.haplotype.png](Xeu.snps.csv.haplotype.png)
- [Xeu.snps.csv.haplotype.svg](Xeu.snps.csv.haplotype.svg)

