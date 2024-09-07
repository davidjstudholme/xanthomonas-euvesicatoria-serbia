#!/usr/bin/perl -w

use strict;
use warnings ;

my $usage  = "$0 blastn output (-outfmt 6)\n";
my  $file = shift or die $usage;
my $cumulative_length = 0;


open (FILE, "<$file") or die $!;
while (<FILE>) {
    my @fields = split /\s+/;
    my $hsp_length  = $fields[3];
    $cumulative_length  += $hsp_length;
}
print "$file";
print "\t";
print "$cumulative_length";
print "\n";
