#!/usr/bin/perl -w

# This program reads in two .xvg files (specified on the command line) and prints out a
# concatenated output file suitable for input into g_sham for generating free energy landscapes.
# The output line contains, for example: time value1 value2
#
# Caveat 1 (should be obvious): both input files must contain the same number of data points
# Caveat 2: the desired quantity should be the second item on the line in the .xvg file (after time)
#
# Values of -data1 and -data2 are the number of the data set in the input .xvg file(s), i.e. 0 would
# be the first column (usually time), 1 would be the first data set, etc.

use strict;

unless (@ARGV) {
    die "Usage: perl sham.pl -i1 input1.xvg -i2 input2.xvg -data1 1 -data2 1 -o graph.xvg\n";
}

my %args = @ARGV;

# define input and output files
my $input1;
my $input2;
my $output;

if (exists($args{"-i1"})) {
    $input1 = $args{"-i1"};
} else {
    die "No -i1 specified!\n";
}

if (exists($args{"-i2"})) {
    $input2 = $args{"-i2"};
} else {
    die "No -i2 specified!\n";
}

if (exists($args{"-o"})) {
    $output = $args{"-o"};
} else {
    $output = "graph.xvg";  # default output name
}

# define input data sets
my $d1;
my $d2;

if (exists($args{"-data1"})) {
    $d1 = $args{"-data1"};
} else {
    $d1 = 1;    # default to first non-time data column
}

if (exists($args{"-data2"})) {
    $d2 = $args{"-data2"};
} else {
    $d2 = 1;
}

open(IN1, "<$input1") || die "$!: Cannot open $input1";
my @in1 = <IN1>;
close(IN1);

open(IN2, "<$input2") || die "$!: Cannot open $input2";
my @in2 = <IN2>;
close(IN2);

# need to chop off the headers first, since they may cause files with the same number of data
# points to have different lengths (one file has more header info than another

my $size1 = scalar(@in1);

for (my $i=0; $i<$size1; $i++) {
    if ($in1[$i] =~ /^[#@]/) {
        splice(@in1, $i, 1);
        $i--;
        $size1--;
    }
}

my $size2 = scalar(@in2);

for (my $j=0; $j<$size2; $j++) {
    if ($in2[$j] =~ /^[#@]/) {
        splice(@in2, $j, 1);
        $j--;
        $size2--;
    }
}

# debug
# print "@in1\n";
# print "@in2\n";

open(OUT, ">>$output") || die "$!: Cannot open $output\n";
print OUT "# graph.xvg for g_sham\n";

for (my $i=0; $i<scalar(@in1); $i++) {
    my $line1 = $in1[$i];
    my $line2 = $in2[$i];

    if (($line1 =~ /^[#@]/) || ($line2 =~ /^[#@]/)) {
        # do nothing, it's a comment - probably not necessary after above cleanup
    } else {
        my @data1 = split(" ", $line1);
        my @data2 = split(" ", $line2);

        my $time = $data1[0];
        my $val1 = $data1[$d1];
        my $val2 = $data2[$d2];

        printf OUT "%8.3f\t%f\t%f\n", $time, $val1, $val2;
    }
}

close(OUT);

exit;
