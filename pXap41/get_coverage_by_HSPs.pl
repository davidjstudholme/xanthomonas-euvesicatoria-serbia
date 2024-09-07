#!/usr/bin/perl -w

use strict;
use warnings ;

my $usage  = "$0 blastn output (-outfmt 6)\n";
my  $file = shift or die $usage;

my  %query_positions_covered;

open (FILE, "<$file") or die $!;
while (<FILE>) {
    my @fields = split /\s+/;

    my ($qseqid,
	$sseqid,
	$pident,
	$length,
	$mismatch,
	$gapopen,
	$qstart,
	$qend,
	$sstart,
	$send,
	$evalue,
	$bitscore)= @fields;

    for my  $i ($qstart .. $qend) {
	$query_positions_covered{$i}++;
    }
    
}

my  $coverage  = scalar (keys  %query_positions_covered);

print "$file";
print "\t";
print "$coverage";
print "\n";
