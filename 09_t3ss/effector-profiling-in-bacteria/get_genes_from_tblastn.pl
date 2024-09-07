#!/usr/bin/perl

use strict ;
use warnings ;
use Bio::SearchIO;
use Bio::SeqIO;
use CGI;


my $file = shift or die "Usage: $0 <BLAST output file>\n";


my %positions;

my $parser = new Bio::SearchIO(-format => 'blast', -file => $file) ; 
while(my $result = $parser->next_result) {
    my $query_acc = $result->query_accession;
    my $query_desc = $result->query_description;
    my $hits_count = 0;
    my %hits;
    my $query_length = $result->query_length;
    
    
    while(my $hit = $result->next_hit) {
	my $hit_desc = $hit->description();
	my $hit_acc = $hit->accession();

	if ($hit_acc =~ m/\|([\w\d]+)/) {
	    $hit_acc = $1;
	}


	$hits_count++;
	my $hsps=0;

	while(my $hsp = $hit->next_hsp) {
	    $hsps++;
	    
	    my $hit_start = $hsp->start('hit') ;
	    my $hit_end = $hsp->end('hit') ;
	    my $query_start = $hsp->start('query');
	    my $query_end = $hsp->end('query');
	    my $length = $hsp->length;
	    my $query_string = $hsp->query_string ;
	    my $hit_string = $hsp->hit_string ;
	    my $frac_identical = $hsp->frac_identical; 
	    my $homology_string = $hsp->homology_string;
	    my $hit_strand = $hsp->strand('hit');

	    

	    my $expect = $hsp->significance;
	    
	    if ( 
		$hsps < 2 and 
		$hits_count < 4  
		
		
		) {
		if ($hit_acc =~ m/(\d+)\-(\d+)/) {
		    my $pos = int(0.5 * ($1 + $2));
		    $positions{$pos} = 1;
		    
		}
	    }
	}
    }
    
}


foreach my $pos (sort {$a<=>$b} keys %positions) {
    
    print"$pos,\n";
    
}
