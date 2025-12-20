#!/bin/bash

#
# Use the following script template to submit scripts running only a single thread (i.e. using a single core on a single node)
#

#The -V switch means that the same environment variables as currently set will be used on the nodes
#The -cwd switch means run in the current directory
#The -q serial.q switch means run in the serial queue

#$ -V -cwd -q parallel.q
#The following line will kill the job automatically after 72 hrs and 10 mins - please contact the sysadmin before changing
#$ -l h_rt=72:10:00

#$ -pe smp 8 -cwd -V -l mem_total=32G

#Uncomment the following line and enter a valid email address to receive email notification of job completion

# #$ -m e -M myemail@myemail.com 
echo Running on ; hostname

#Place your command lines below this

	bwa mem Xe173.fasta DC_96-3.1.fq.gz DC_96-3.2.fq.gz > DC_96-3.versus.Xe173.fasta.aln.sam.3690590~ && mv DC_96-3.versus.Xe173.fasta.aln.sam.3690590~ DC_96-3.versus.Xe173.fasta.aln.sam

	samtools view -bS -q 1 -T Xe173.fasta DC_96-3.versus.Xe173.fasta.aln.sam > DC_96-3.versus.Xe173.fasta.aln.bam.3690590~ && mv DC_96-3.versus.Xe173.fasta.aln.bam.3690590~ DC_96-3.versus.Xe173.fasta.aln.bam

	samtools sort DC_96-3.versus.Xe173.fasta.aln.bam > DC_96-3.versus.Xe173.fasta.aln.bam.sorted.bam

	samtools rmdup -s DC_96-3.versus.Xe173.fasta.aln.bam.sorted.bam  DC_96-3.versus.Xe173.fasta.aln.sorted.rmdup.bam.3690590~ && mv DC_96-3.versus.Xe173.fasta.aln.sorted.rmdup.bam.3690590~ DC_96-3.versus.Xe173.fasta.aln.sorted.rmdup.bam

	samtools index DC_96-3.versus.Xe173.fasta.aln.bam.sorted.bam

	samtools index DC_96-3.versus.Xe173.fasta.aln.sorted.rmdup.bam

