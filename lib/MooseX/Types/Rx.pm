package MooseX::Types::Rx;
use Moose;
extends 'Moose::Meta::TypeConstraint';

use Data::Rx;
use JSON 2;

use Sub::Exporter -setup => {
  exports => [ rx_type => \'_rx_type_gen' ],
  groups  => [ default => [ qw(rx_type) ] ],
};

sub _rx_type_gen {
  my ($class, $name, $arg) = @_;

  return sub {
    my $schema = Data::Rx->new->make_schema($_[0]);
    return $class->new({
      name   => 'Rx(' . JSON->new->encode($_[0]) . ')',
      schema => $schema,
    });
  }
}

has schema => (is => 'ro', isa => 'Object', handles => [ qw(check) ]);

no Moose;
1;
