[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.18045871.svg)](https://doi.org/10.5281/zenodo.18045871)

# Genome sequencing of _Xanthomonas euvesicatoria_ pv. _euvesicatoria_ strains from pepper (_Capsicum annuum_ L.) reveals distinct genotypes in Serbia

### Tatjana Popović Milovanović, Shannon F. Greer, Renata Iličić, Aleksandra Jelušić, Daisy Bown, Murray Grant, Joana G. Vicente and David J. Studholme.

Preprint available at: https://doi.org/10.1099/acmi.0.001138.v1


This repository contains details of the bioinformatics methods used in our manuscript submitted to the journal Access Microbiology:

1.  [*De-novo* genome assembly from Illumina reads, using Unicycler](01-genome-de-novo-assembly/README.md)
2.  [Quality assessment of the genome assemblies, using QUAST](02-quast/README-QUAST.md)
3.  [Quality assessment of the genome assemblies, using CheckM](03-checkm/README-CheckM.md)
4.  [Phylogenomics, using PhaME](04-phylogenomics/README.md)
5.  [Calculating average nucleotide identity (ANI), with FastANI](05-fastani/README-FastANI.md)
6.  [Alignment of sequence reads against reference genome sequences, using BWA-MEM](06-bwa-alignments/README-BWA.md)
7.  [SNP-calling](07-snp-calling/README.md)
8.  [Identifying T3SS effector genes, using TBLASTN](09-t3ss/README-T3SS.md)
9.  [Identifying plasmid sequences in the genome assemblies, using Platon](10-platon/README-Platon.md)
10. [Identifying plasmid-like contigs with geNomad](12-genomad/commands.sh)
11. [Visualising plasmid sequence comparisons using clinker](11-clinker/commands.sh)
12. [Visualising prophage sequence comparisons using clinker](13-prophage/commands.sh)

Key results files:

1. [Phylogenomics of the whole set of _X. euvesicatoria_ pv. _euvesciatoria_ strains](04-phylogenomics/01_all_xeu/03_workdir/results)
   - [Tree file built using FastTree](04-phylogenomics/01_all_xeu/03_workdir/results/trees/Xeu-all_all.fasttree) [FastTree in iTOL](https://itol.embl.de/tree/14417323151477701766484756)
   - [Tree file built using IQ-Tree](04-phylogenomics/01_all_xeu/03_workdir/results/trees/Xeu-all.IQ-tree_all_snp_alignment.fna.contree) [IQ-TREE in iTOL](https://itol.embl.de/tree/14417323152163721767265233)
   - [Tree file built using RAxML](04-phylogenomics/01_all_xeu/03_workdir/results/trees/RAxML_bipartitionsBranchLabels.Xeu-all.RAxML_all_best) [RAxML tree in iTOL](https://itol.embl.de/tree/14417323152126031767264832) 
2. [Phylogenomics of the strains in Kaur Group I](04-phylogenomics/02_cluster_6_only/03_workdir/results)
3. [Phylogenomics of a subset of strains in Kaur Group I](04-phylogenomics/03_subset_of_cluster_6/03_workdir/results)  
4. [FastANI pairwise scores](05-fastani/Xeu-fastANI.short.out)
5. [Read mapping across plasmid pLMG930.2](06-bwa-alignments/CP018463.1.multi-bamqc/report.pdf)
6. [Read mapping across un-named 75-kb plasmid 2 from strain Xe173 ](06-bwa-alignments/CP170254.1.multi-bamqc/report.pdf)
7. [SNPs among closely-related strains, in NEXUS format](07-snp-calling/snps.csv.haplotype.nex)
8. [TBLASTN coverages of T3SS effector sequences in genome assemblies](09-t3ss/effector_profile_euroxanth.tsv)

