package Hermes;
use lib '.';
use Proto;




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


	return $this;
}












1;
