#!/usr/bin/perl

use strict ;
use warnings ;
use Bio::SearchIO;
use Bio::SeqIO;
use CGI;


my $file = shift or die "Usage: $0 <BLAST output file>\n";



my $cgi = new CGI;
print $cgi->start_html;



print "\n<table border = 1>\n";



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
		
		$hits{$hit_acc} = 1;
		
		print "<tr>";
		print "<td>$query_acc ($query_desc)</td>";
		print "<td>$expect</td>";
		#print "<td><a href=\"http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?CMD=search&DB=protein&term=$hit_acc\" target=_blank>";
		#print "<td><a href=\"http://www.sanger.ac.uk/cgi-bin/Pfam/swisspfamget.pl?name=$hit_acc\" target=_blank>";
		print "<td><a>";
		print "$hit_acc";
		print "</a>";
		print " $hit_desc</td>";
		print "<td><pre><tt>$query_acc $query_start-$query_end\n\n$hit_acc $hit_start-$hit_end ($hit_strand)</tt></pre></td>";
		print "<td><pre><tt>$query_string\n$homology_string\n$hit_string</tt></pre></td>";
		
		print "</tr>\n";
	       
		warn "$query_acc\t$expect\t$query_start-$query_end\t$hit_acc\t$hit_desc\n";
		warn "$query_string\n$homology_string\n$hit_string\n\n";
	    }
	}
    }

    my $hits = keys %hits;
#    print "$query_acc\t$hits hits\n\n";


}


	  


print "</table>\n";

print $cgi->end_html;
