#!/usr/bin/perl



### david.studholme@bbsrc.ac.uk


use strict;
use warnings ;
use Bio::SeqIO ;

my $sequence_file = shift or die "Usage: $0 <sequence file>\n" ;

my $inseq = Bio::SeqIO->new('-file' => "<$sequence_file",
			    '-format' => 'fasta' ) ;

while (my $seq_obj = $inseq->next_seq ) {
  
    my $id = $seq_obj->id ;
    my $seq = $seq_obj->seq ;
    my $desc = $seq_obj->description ;

    if ($id =~ m/gb\|\S+\|\:c*(\d+\-\d+)/) {
	$id = "$1";
	print ">$id\n$seq\n";
	
	
    } else {
	die "ID = '$id'\n";
    }
}
