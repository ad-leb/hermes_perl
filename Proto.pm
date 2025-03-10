package Proto;






our $proto = undef;
our $_dflt = {
	config						=> 'protocols.conf',
};





sub get
{
	my ($self, $str) = @_;


	read_config() if !$proto;


	return $proto->{$str};
}
sub read_config
{
	my $name;


	open my $fd, $_dflt->{config} or die "Can't open $_dflt->{config}!\n";
	foreach (<$fd>)
	{
		next if /^$/ or /^\s*\#/;

		$name = $1 if /^\s*\[(.*)\]\s*\#?.*$/;
		$proto->{$name}{$1} = $2 if /^\s+(.*):\s+(.*)\s*\#?.*$/;
	}
	close $fd;
}

























1;
