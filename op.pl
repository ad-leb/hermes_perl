#! /usr/bin/perl -w
use lib '.';
use Hermes;
use Data::Dumper;







my $log = {
	name						=> 'log',
	asdf						=> [
		'00000',
		'11111',
		'22222',
		'33333',
		'44444',
	],
	qwer						=>  [
		'00000',
		'11111',
		'22222',
		'33333',
		'44444',
	],
	raw							=> [
		'00000',
		'11111',
		'22222',
		'33333',
		'44444',
	],
};


bless $log, 'Hermes';
$log->update;

print Dumper($log);
