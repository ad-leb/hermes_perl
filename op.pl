#! /usr/bin/perl -w
use lib '.';
use Hermes;
use Data::Dumper;












while ($_ = <STDIN>)
{
	chomp;
	print Dumper(Hermes->$_);
}
