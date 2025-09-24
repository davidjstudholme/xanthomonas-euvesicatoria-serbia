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

TBLASTN results formatted as tab-delimited tables:

- [EuroXanth effectors from DokuWiki](effector_profile_euroxanth.csv)
- [Potnis et al. (2011) core effectors](effector_profile_potnis_core.csv)

TBLASTN results formatted as HTML:

- [euroxanth_effectors_2023-10-03.faa.versus.66b.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.66b.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.71-21.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.71-21.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.75-3.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.75-3.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.83M.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.83M.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.85-10.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.85-10.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.85-16.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.85-16.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.86-2.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.86-2.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.86-22.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.86-22.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.86-46.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.86-46.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.87-21.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.87-21.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.87-47.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.87-47.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.89-10.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.89-10.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.ATCC_11633.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.ATCC_11633.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.DC99P1A1.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.DC99P1A1.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.DC99P1B1.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.DC99P1B1.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.E3.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.E3.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.FB570.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.FB570.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.LMG_27970.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.LMG_27970.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.LMG_667.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.LMG_667.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.LMG_905.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.LMG_905.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.LMG_909.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.LMG_909.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.LMG_930.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.LMG_930.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.LMG_933.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.LMG_933.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Ps-1.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Ps-1.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Ps-7.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Ps-7.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Tu-06.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Tu-06.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Tu-08.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Tu-08.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Tu-10.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Tu-10.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Tu-11.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Tu-11.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.VTM10.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.VTM10.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.VTM12.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.VTM12.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.VTM15.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.VTM15.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.VTM16.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.VTM16.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.VTM17.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.VTM17.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.VTM4.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.VTM4.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.WHRI_8301.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.WHRI_8301.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.X13.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.X13.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.X22.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.X22.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.X31.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.X31.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-6.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-6.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-7.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-7.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-8.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-8.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-9.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_93-9.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-1.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-1.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-2.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-2.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-3.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-3.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-4.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-4.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-5.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_96-5.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_97_P1A.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_97_P1A.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_97_P2A.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_97_P2A.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_97_P3A.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_97_P3A.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_98_P2A.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_DC_98_P2A.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xcv_Sspep_92.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xcv_Sspep_92.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xv157.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xv157.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xv_72.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xv_72.fasta.tblastn.html)
- [euroxanth_effectors_2023-10-03.faa.versus.Xv_79.fasta.tblastn.html](euroxanth_effectors_2023-10-03.faa.versus.Xv_79.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.66b.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.66b.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.71-21.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.71-21.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.75-3.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.75-3.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.83M.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.83M.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.85-10.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.85-10.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.85-16.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.85-16.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.86-2.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.86-2.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.86-22.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.86-22.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.86-46.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.86-46.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.87-21.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.87-21.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.87-47.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.87-47.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.89-10.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.89-10.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.ATCC_11633.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.ATCC_11633.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.DC99P1A1.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.DC99P1A1.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.DC99P1B1.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.DC99P1B1.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.E3.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.E3.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.FB570.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.FB570.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.LMG_27970.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.LMG_27970.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.LMG_667.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.LMG_667.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.LMG_905.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.LMG_905.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.LMG_909.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.LMG_909.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.LMG_930.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.LMG_930.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.LMG_933.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.LMG_933.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Ps-1.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Ps-1.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Ps-7.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Ps-7.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Tu-06.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Tu-06.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Tu-08.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Tu-08.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Tu-10.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Tu-10.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Tu-11.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Tu-11.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.VTM10.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.VTM10.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.VTM12.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.VTM12.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.VTM15.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.VTM15.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.VTM16.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.VTM16.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.VTM17.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.VTM17.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.VTM4.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.VTM4.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.WHRI_8301.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.WHRI_8301.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.X13.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.X13.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.X22.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.X22.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.X31.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.X31.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_93-6.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_93-6.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_93-7.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_93-7.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_93-8.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_93-8.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_93-9.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_93-9.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_96-1.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_96-1.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_96-2.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_96-2.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_96-3.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_96-3.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_96-4.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_96-4.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_96-5.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_96-5.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_97_P1A.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_97_P1A.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_97_P2A.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_97_P2A.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_97_P3A.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_97_P3A.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_DC_98_P2A.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_DC_98_P2A.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xcv_Sspep_92.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xcv_Sspep_92.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xv157.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xv157.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xv_72.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xv_72.fasta.tblastn.html)
- [potnis_2011_core_effectors.faa.versus.Xv_79.fasta.tblastn.html](potnis_2011_core_effectors.faa.versus.Xv_79.fasta.tblastn.html)

