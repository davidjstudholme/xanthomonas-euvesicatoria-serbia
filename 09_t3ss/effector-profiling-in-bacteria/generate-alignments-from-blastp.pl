#!/usr/bin/perl

use strict ;
use warnings ;
use Bio::SearchIO;
use Bio::SeqIO;
use CGI;


my $file = shift or die;

my $parser = new Bio::SearchIO(-format => 'blast', -file => $file) ; 

while (my $result = $parser->next_result) {
    
    my $query_acc = $result->query_accession;
    my $query_length = $result->query_length;
    my $query_desc = $result->query_description;
    $query_desc = $file unless defined $query_desc;
 
    
    my $tmpfile = "tmp";
    open(TMP, ">$tmpfile") or die "Failed to open file '$tmpfile'\n";
  
    while(my $hit = $result->next_hit) {
	my $hit_desc = $hit->description();

	$hit_desc =~ s/\s+/_/g;

	my $hit_acc = $hit->accession();
	
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

	    print TMP ">$hit_acc\_$hit_desc/$hit_start-$hit_end\n$hit_string\n";
	    
	    
	}
    }

    close TMP;

    
    my $outfile = "$query_acc.$query_desc.aligned.faa";
    $outfile =~ s/\s+/_/g;
    $outfile =~ s/[\(\)]//g;

    system "mafft --maxiterate 1000 $tmpfile > $outfile";
    
}    

