ln -s ../01_genome_assemblies/*.fasta .

for i in *.fasta; do
    echo $i
    formatdb -pF -i $i
done

### TBLASTN againts EuroXanth effectors
for i in *.fasta; do
    echo $i
    tblastn -db $i -query euroxanth_effectors_2023-10-03.faa -evalue 1e-10 -out euroxanth_effectors_2023-10-03.faa.versus.$i.tblastn
done

### TBLASTN against Potnis et al. (2011) core effectors
for i in *.fasta; do
    echo $i
    tblastn -db $i -query potnis_2011_core_effectors.faa -evalue 1e-10 -out potnis_2011_core_effectors.faa.versus.$i.tblastn
done


perl tabulate_blast_results.pl  euroxanth_effectors_2023-10-03.faa.versus.*.tblastn > effector_profile_euroxanth.csv
perl tabulate_blast_results.pl potnis_2011_core_effectors.faa.versus.*.tblastn > effector_profile_potnis_core.csv

conda activate bioperl_env
for i in *.tblastn; do
    echo $i
    perl summarise_blast.pl $i > $i.html
done
