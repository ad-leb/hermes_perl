package Proto;




our $proto;
our $_default = {
	config						=> 'protocols.conf',
};











sub AUTOLOAD
{
	my ($req) = ( $AUTOLOAD =~ /::(.*)$/ );

	read_config() if !$proto;

	return $proto->{$req};
}



sub read_config
{
	my $name;


	open my $fd, $_default->{config} or die "Can't open $_default->{config}!\n";
	foreach (<$fd>)
	{
		next if /^$/ or /^\s*\#/;

		/^\s*\[(.*)\]\s*\#?.*$/
			&& ($name = $1) 
			&& push_value($name, 'name', $name)
		||
		/^\s+(.*):\s+(.*)\s*\#?.*$/
			&& push_value($name, $1, $2)
		;
	}
	close $fd;
}



sub push_value
{
	my ($name, $key, $value) = @_;		$_ = $value;


	s/(^["']*|["';]*$)//g;

	if ( /^\[.*\]$/ ) {						# it's an array
		my @tmp = map { /(\w+)/ } split ',';
		$proto->{$name}{$key} = \@tmp;
	} else {								# it's a string
		$proto->{$name}{$key} = $_;
	}
}


























1;
