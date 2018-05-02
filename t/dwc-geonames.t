use strict;
use warnings;
use utf8;

use DwC;

use Test::More tests => 5;
BEGIN { use_ok('DwC::Plugin::GeoNames') };

my $dwc = DwC->new({
  locality => 'Oslo'
});

DwC::Plugin::GeoNames->augment($dwc);

ok($$dwc{countryCode} eq "NO");
ok($$dwc{country} eq "Norway");
ok($$dwc{decimalLatitude} == 59.91273);
ok($$dwc{decimalLongitude} == 10.74609);

