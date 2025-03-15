#! /usr/bin/perl -w
use lib '.';
use Hermes;












$\ = "\n";
while ($_ = <STDIN>)
{
	tr/ 	//d; chomp;
	print Hermes->$_->to_xml;
}
$\ = '';
