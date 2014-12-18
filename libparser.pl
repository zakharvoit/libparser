#!/usr/bin/env perl

use strict;
use warnings;

my $args_size = $#ARGV + 1;
if ($args_size != 3) {
    print "Usage: ./libparser.pl root_directory file_to_process output_file";
    exit 1;
}

my $lib_dir = $ARGV[0];
my $file = $ARGV[1];
my $output = $ARGV[2];

my %already_processed;

sub processFile {
    my $filename = shift;
    if (exists $already_processed{$filename}) {
	return " ";
    }
    $already_processed{$filename} = 1;
    local $/;
    open(my $fh, "<", $filename) or die "Cannot open $filename: $!";
    my $contents = <$fh>;
    $contents =~ s{/\*.*?\*/}{ }gs; # TODO: Improve regex to work on nested /* 
    
    $contents =~ s/#include\s+"(.*)"/processFile($lib_dir."\/$1")/ge;

    $contents;
}

my $contents = processFile $file;
open(my $fh, ">", $output) or die "Cannot open $output: $!";
print $fh $contents;
close($fh);
