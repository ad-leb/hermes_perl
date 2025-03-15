package Hermes;
use lib '.';
use Proto;
use Xml;




our $_collection;











sub AUTOLOAD
{
	my ($self) = shift;
	my ($req) = ( $AUTOLOAD =~ /::(.*)$/ );

	
	!$_collection->{$req}
		&& ( $_collection->{$req} = Proto->$req )
		&& ( $_collection->{$req}{ops} = rand(10) )
		&& ( bless $_collection->{$req}, $self )
	;
	$_collection->{$req}->update	if $_collection->{$req};


	return $_collection->{$req};
}



sub update
{
	my ($this) = @_;


	$this->{raw} = undef;

	open my $fd, $this->{source} or die "Can't open $this->{source}!\n";
	foreach (<$fd>)
	{
		next if /$this->{exclude}/;		chomp; s/(^\s+|\s+$)//;

		my @tmp = /$this->{input}/;
		my %tmp;

		map { $_ = ' ' if !$_ } @tmp;						# no need 'undef'!
		map { $tmp{$_} = shift @tmp } $this->{keys}->@*;
		push $this->{raw}->@*, \%tmp;
	}
	close $fd;


	return $this;
}



sub to_xml
{
	my ($this) = @_;


	return Xml::enc($this->{raw}, $this->{name});
}












1;
