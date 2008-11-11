use strict;
use warnings;
use Test::More 'no_plan';

use MooseX::Types::Rx;

my $t = rx_type({
  type => '//arr',
  length   => { min => 3, max => 3 },
  contents => '//int',
});

ok $t->check([ 1, 2, 3]);

use lib 't/lib';
use MTRXY;

ok(
  eval { MTRXY->new({ digits => [ 1, 2, 3 ]}); 1 },
  "we can make an object with data that validates against the Rx TC",
);

my $ok  = eval { MTRXY->new({ digits => [ 1, 3 ]}); 1 },
my $err = $@;
ok(
  ! $ok,
  "we can't make an object with data that doesn't validate against the Rx TC",
);

like($err, qr/Rx\(/, "we get a Rx-related TC error");
