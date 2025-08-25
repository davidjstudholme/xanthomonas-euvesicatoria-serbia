for i in 66b.contig DC99P1A1.fasta Tu-10.contig VTM10.fasta VTM15.contig VTM16.fasta X13.contig X22.fasta Xcv_DC_96-3.contig Xcv_DC_96-5.fasta keep 66b.fasta DC99P1B1.contig Tu-10.fasta VTM12.contig VTM15.fasta VTM4.contig X13.fasta X31.contig Xcv_DC_96-3.fasta Xcv_DC_97_P1A.contig DC99P1A1.contig DC99P1B1.fasta VTM10.contig VTM12.fasta VTM16.contig VTM4.fasta X22.contig X31.fasta Xcv_DC_96-5.contig Xcv_DC_97_P1A.fasta; do
    echo $i
    ln -s ../../02_cluster_6_only/01_genome_assemblies/$i .
done
