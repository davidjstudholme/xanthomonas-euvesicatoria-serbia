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

	bwa mem CP170254.1.fasta VTM4.1.fq.gz VTM4.2.fq.gz > VTM4.versus.CP170254.1.fasta.aln.sam.255098~ && mv VTM4.versus.CP170254.1.fasta.aln.sam.255098~ VTM4.versus.CP170254.1.fasta.aln.sam

	samtools view -bS -q 1 -T CP170254.1.fasta VTM4.versus.CP170254.1.fasta.aln.sam > VTM4.versus.CP170254.1.fasta.aln.bam.255098~ && mv VTM4.versus.CP170254.1.fasta.aln.bam.255098~ VTM4.versus.CP170254.1.fasta.aln.bam

	samtools sort VTM4.versus.CP170254.1.fasta.aln.bam > VTM4.versus.CP170254.1.fasta.aln.bam.sorted.bam

	samtools rmdup -s VTM4.versus.CP170254.1.fasta.aln.bam.sorted.bam  VTM4.versus.CP170254.1.fasta.aln.sorted.rmdup.bam.255098~ && mv VTM4.versus.CP170254.1.fasta.aln.sorted.rmdup.bam.255098~ VTM4.versus.CP170254.1.fasta.aln.sorted.rmdup.bam

	samtools index VTM4.versus.CP170254.1.fasta.aln.bam.sorted.bam

	samtools index VTM4.versus.CP170254.1.fasta.aln.sorted.rmdup.bam

