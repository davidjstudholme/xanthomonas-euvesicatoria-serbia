#!/usr/bin/perl

use strict ;
use warnings ;
use Bio::SearchIO;
use Bio::SeqIO;

my %effector_to_files;
my %file_to_effectors;

while (my $file = shift) {

    warn "Reading file: $file\n";
    
    my $parser = new Bio::SearchIO(-format => 'blast', -file => $file) ; 
    while(my $result = $parser->next_result) {
	my $query_acc = $result->query_accession;
	my $query_desc = $result->query_description;
	my $query_length = $result->query_length;
	
	while(my $hit = $result->next_hit) {
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
		my $length = $hsp->length;
		my $query_string = $hsp->query_string ;
		my $hit_string = $hsp->hit_string ;
		my $frac_identical = $hsp->frac_identical; 
		my $homology_string = $hsp->homology_string;
		my $hit_strand = $hsp->strand('hit');
		
		my $expect = $hsp->significance;
		
		if ($length >= 0.95 *$query_length and
		    $frac_identical >= 0.90) {
		    		    
		    $effector_to_files{$query_acc}{$file} = $frac_identical;
		    $file_to_effectors{$file}{$query_acc} = $frac_identical;
		}
	    }
	}
    }
}

print "File";
for my $effector (sort keys %effector_to_files) {
    print "\t";
    print "$effector";
}
print "\n";

for my $file (sort keys %file_to_effectors) {
    print "$file";
    for my $effector(sort keys %effector_to_files) {
	print "\t";
	if (defined $effector_to_files{$effector}{$file}) {
	    my $frac_identical = $effector_to_files{$effector}{$file};
	    print "$frac_identical";
	} else {
	    print "0";
	}
    }
    print "\n";
    
}

	  
