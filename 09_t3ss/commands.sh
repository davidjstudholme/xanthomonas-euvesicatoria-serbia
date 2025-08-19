ln -s ../01_genome_assemblies/*.fasta .

for i in *.fasta; do
    echo $i
    formatdb -pF -i $i
done


for i in *.fasta; do
    echo $i
    tblastn -db $i -query euroxanth_effectors_2023-10-03.faa -evalue 1e-10 -out euroxanth_effectors_2023-10-03.faa.versus.$i.tblastn
done


perl tabulate_blast_results.pl  *.tblastn > effector_profile.csv


conda activate bioperl_env
for i in *.tblastn; do
    echo $i
    perl summarise_blast.pl $i > $i.html
done


