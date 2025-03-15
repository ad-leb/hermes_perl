package Xml;







sub enc
{
	my ($obj, $name) = @_;						return "<undef></undef>" if !$obj;
	my $str = '';


	$name = spec_char($name);

	$str .= "<$name>";
	if ( $obj =~ /^ARRAY\(0x/ ) {
		map { $str .= enc($obj->[$_], "item_$_") } 0..$#$obj;
	} elsif ( $obj =~ /^HASH\(0x/ ) {
		map { $str .= enc($obj->{$_}, $_) } keys $obj->%*;
	} else {
		$str .= spec_char($obj);
	}
	$str .= "</$name>";


	return $str;
}



sub spec_char
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
