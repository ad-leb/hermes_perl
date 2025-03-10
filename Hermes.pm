package Hermes;
use lib '.';
use Proto;





sub new 
{
	my ($self, $str) = @_;
	my $obj = Proto->get($str);


	bless $obj, $self;
	$obj->update();


	return $obj;
}
sub update
{
	my ($this) = @_;


	$this->{raw} = undef;


	return $this;
}












1;
