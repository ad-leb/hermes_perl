package Proto;




our $proto = undef;
our $_default = {
	config						=> 'protocols.conf',
};











sub AUTOLOAD
{
	my ($str) = ( $AUTOLOAD =~ /::(.*)$/ );

	read_config() if !$proto;

	return $proto->{$str};
}



sub read_config
{
	my $name;


	open my $fd, $_default->{config} or die "Can't open $_default->{config}!\n";
	foreach (<$fd>)
	{
		next if /^$/ or /^\s*\#/;

		$name = $1					if /^\s*\[(.*)\]\s*\#?.*$/;
		$proto->{$name}{$1} = $2	if /^\s+(.*):\s+(.*)\s*\#?.*$/;
	}
	close $fd;
}


























1;
