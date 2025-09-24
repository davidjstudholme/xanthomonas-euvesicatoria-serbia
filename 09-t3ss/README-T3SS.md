# Searching genome assemblies for sequence similarity to known T3SS effectors, using TBLASTN

Make symlinks to the genome assembly FASTA files:

```
ln -s ../04-phylogenomics/01_all_xeu/01_genome_assemblies/*.fasta .
```

Create BLAST databases for each genome sequence:

```
for i in *.fasta; do
    echo $i
    formatdb -pF -i $i
done
```
File [euroxanth_effectors_2023-10-03.faa](euroxanth_effectors_2023-10-03.faa) was obtained from the EuroXanth [*Xanthomonas* Dokuwiki](https://doi.org/10.1094/MPMI-11-23-0184-FI).

Perform TBLASTN for each genome against EuroXanth T3SS effectors:

```
for i in *.fasta; do
    echo $i
    tblastn -db $i -query euroxanth_effectors_2023-10-03.faa -evalue 1e-10 -out euroxanth_effectors_2023-10-03.faa.versus.$i.tblastn
done
```

Perform TBLASTN for each genome against [Potnis et al. (2011)](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-12-146#citeas) core effectors:

```
for i in *.fasta; do
    echo $i
    tblastn -db $i -query potnis_2011_core_effectors.faa -evalue 1e-10 -out potnis_2011_core_effectors.faa.versus.$i.tblastn
done
```

Format the TBLASTN results as tables ready for import into a spreadhseet:

```
perl tabulate_blast_results.pl  euroxanth_effectors_2023-10-03.faa.versus.*.tblastn > effector_profile_euroxanth.csv
perl tabulate_blast_results.pl potnis_2011_core_effectors.faa.versus.*.tblastn > effector_profile_potnis_core.csv
```
Tables of results:

- [effector_profile_euroxanth.csv](effector_profile_euroxanth.csv)
- [effector_profile_potnis_core.csv](effector_profile_potnis_core.csv)

Format the results as HTML:
  
```
conda activate bioperl_env
for i in *.tblastn; do
    echo $i
    perl summarise_blast.pl $i > $i.html
done
```

