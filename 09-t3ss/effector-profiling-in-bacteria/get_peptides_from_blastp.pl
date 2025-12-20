#!/usr/bin/perl

use strict ;
use warnings ;
use Bio::SearchIO;
use Bio::SeqIO;
use CGI;



my $file = shift or die "Usage: $0 <blastp file> <proteome file>\n";
my $proteome_file = shift or die "Usage: $0 <blastp file> <proteome file>\n";

my %peptides;

my $parser = new Bio::SearchIO(-format => 'blast', -file => $file) ; 

while (my $result = $parser->next_result) {
    
    my $query_acc = $result->query_accession;
    my $query_length = $result->query_length;
    my $query_desc = $result->query_description;
    $query_desc = $file unless defined $query_desc;
    
    if(my $hit = $result->next_hit) {
	my $hit_desc = $hit->description();
	my $hit_acc = $hit->accession();
	
	if ($hit_acc =~ m/\|([\w\d]+)/) {
	    $hit_acc = $1;
	}
	
	while(my $hsp = $hit->next_hsp) {
	    my $hit_start = $hsp->start('hit') ;
	    my $hit_end = $hsp->end('hit') ;
	    my $query_start = $hsp->start('query');
	    my $query_end = $hsp->end('query');
	    my $query_string = $hsp->query_string ;
	    my $hit_string = $hsp->hit_string ;
	    my $frac_identical = $hsp->frac_identical; 
	    my $homology_string = $hsp->homology_string;
	    my $hit_strand = $hsp->strand('hit');
	    my $expect = $hsp->significance;
	    
	    $peptides{$query_acc} = $query_desc;
	    
	}
    }
}



### Now get the sequences from the FastA files
my $inseq = Bio::SeqIO->new('-file' => "<$proteome_file",
			    '-format' => 'fasta' ) ;

while (my $seq_obj = $inseq->next_seq ) {
    
    my $id = $seq_obj->id ;
    my $seq = $seq_obj->seq ;
    my $desc = $seq_obj->description ;
    
    
    
    if(defined $peptides{$id}) {
	print ">$id $desc\n$seq\n";
	
	
    }
}
