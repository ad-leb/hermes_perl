package Xml;





our %const = (
	tab							=> '  ',
	break						=> "\n",
);









sub AUTOLOAD
{
	my ($self, $obj, $name) = @_;
	my ($method) = ($AUTOLOAD =~ /::(.*)/);
	my $str = '<?xml version="1.0" encoding="UTF-8"?>';


	if ($method eq 'pretty') {
		$str .= "\n" . enc_pretty($obj, $name, 0);
	} else {
		$str .= enc($obj, $name);
	}


	return $str;
}








sub enc
{
	my ($obj, $name) = @_;						return "<undef></undef>" if !$obj;
	my $str = '';


	$name = char_entity($name);

	$str .= "<$name>";
	if ( $obj =~ /^ARRAY\(0x/ ) {
		map { $str .= enc($obj->[$_], "item_$_") } 0..$#$obj;
	} elsif ( $obj =~ /^HASH\(0x/ ) {
		map { $str .= enc($obj->{$_}, $_) } keys $obj->%*;
	} else {
		$str .= char_entity($obj);
	}
	$str .= "</$name>";


	return $str;
}



sub enc_pretty
{
	my ($obj, $name, $deep) = @_;										return "<undef></undef>" if !$obj;
	my ($preffix, $terminator) = ($const{tab} x $deep, $const{break});
	my $str = '';


	$name = char_entity($name);

	$str .= $preffix . "<$name>";
	if ( $obj =~ /^ARRAY\(0x/ ) {
		$str .= $terminator;
		map { $str .= enc_pretty($obj->[$_], "item_$_", $deep + 1) } 0..$#$obj;
		$str .= $preffix;
	} elsif ( $obj =~ /^HASH\(0x/ ) {
		$str .= $terminator;
		map { $str .= enc_pretty($obj->{$_}, $_, $deep + 1) } keys $obj->%*;
		$str .= $preffix;
	} else {
		$str .= char_entity($obj);
	}
	$str .= "</$name>" . $terminator;


	return $str;
}



sub char_entity
{
	$_ = shift;

	s/\&/\&amp;/g;
	s/\"/\&quot;/g;
	s/\'/\&apos;/g;
	s/\</\&lt;/g;
	s/\>/\&rt;/g;

	return $_;
}



























1;
