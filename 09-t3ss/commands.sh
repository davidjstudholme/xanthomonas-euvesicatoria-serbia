### Copy the genome sequences
mkdir tblastn_versus_dokuwiki_effectors
cd tblastn_versus_dokuwiki_effectors
ln -s ../../04-phylogenomics/01_all_xeu/01_genome_assemblies/*.contig .
cd ..

### Activate the Conda environment
conda activate bioperl_env
conda list -n bioperl_env > bioperl_env_packages.txt
conda env export > bioperl_env.yaml

### Create BLAST databases
cd tblastn_versus_dokuwiki_effectors
for i in *.contig; do
    echo $i
    formatdb -pF -i $i
done
cd ..

### TBLASTN againts EuroXanth effectors
cd tblastn_versus_dokuwiki_effectors
for i in *.contig; do
    echo $i
    tblastn -db $i -query ../euroxanth_effectors_2023-10-03.faa -evalue 1e-10 -out euroxanth_effectors_2023-10-03.versus.$i.tblastn
done
cd ..

### TBLASTN against Potnis et al. (2011) core effectors
cd tblastn_versus_dokuwiki_effectors
for i in *.contig; do
    echo $i
    tblastn -db $i -query ../potnis_2011_core_effectors.faa -evalue 1e-10 -out potnis_2011_core_effectors.versus.$i.tblastn
done
cd ..

### Parse the TBLASN results
perl tabulate_blast_results.pl tblastn_versus_dokuwiki_effectors/euroxanth_effectors_2023-10-03.versus.*.tblastn > effector_profile_euroxanth.tsv
perl tabulate_blast_results.pl tblastn_versus_dokuwiki_effectors/potnis_2011_core_effectors.versus.*.tblastn > effector_profile_potnis_core.tsv
for i in tblastn_versus_dokuwiki_effectors/*.tblastn; do
    echo $i
    perl summarise_blast.pl $i > $i.html
done


