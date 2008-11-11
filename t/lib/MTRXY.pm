package MTRXY;
use Moose;
use MooseX::Types::Rx;

has digits => (
  is  => 'rw',
  isa => rx_type({
    type => '//arr',
    length   => { min => 3, max => 3 },
    contents => '//int',
  }),

  required => 1,
);

no Moose;
1;
