### Download FASTQ files of genomic sequence reads from Sequence Read Archive
for i in SRR24958750 SRR24958751 SRR24958752; do
    echo $i
    fasterq-dump $i
    gzip $i*.fastq
done


### Filter and trime
for i in SRR24958750 SRR24958751 SRR24958752; do
    echo $i
    trim_galore -q 30 --paired "$i"_1.fastq.gz "$i"_2.fastq.gz
done

### Run plasmidSPAdes
for i in SRR24958750 SRR24958751 SRR24958752; do
    echo $i
    plasmidspades.py -1 "$i"_1.fastq.gz -2 "$i"_2.fastq.gz -o "$i"_plasmid_assembly
done

### Run plasmidSPAdes
for i in SRR24958750 SRR24958751 SRR24958752; do
    echo $i
    plasmidspades.py -1 "$i"_1_val_1.fq.gz -2 "$i"_2_val_2.fq.gz -o "$i"_trimmed__plasmid_assembly
done

### Run Unicycler
conda activate unicycler_env
conda list -n unicycler_env > unicycler_env_packages.txt
conda env export > unicycler_env.yaml
for i in SRR24958750 SRR24958751 SRR24958752; do
    echo $i
    unicycler --mode conservative -1 "$i"_1_val_1.fq.gz -2 "$i"_2_val_2.fq.gz -o "$i"_trimmed_unicycler_assembly
done

