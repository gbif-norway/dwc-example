use strict;
use warnings;
use utf8;


our $VERSION = 0.01;

use Geo::GeoNames;
our $geonames = Geo::GeoNames->new(username => "cypherpunk");

use 5.14.0;

package DwC::Plugin::GeoNames;

# Should return a very short description of what the plugin does
sub description {
  return "A geocoding example, using GeoNames (don't use this in production!)";
}

# Every plugin needs to provide at least one of four functions. Which ones 
# you should choose to implement depends on what the plugin does and where
# in the process you want the code to be run:
# - clean (run first, meant to clean invalid data)
# - validate (add warnings and errors based on the quality of the data)
# - augment (improve data quality)
# - judge (set the _completeness and _incomplete values)
#
# All of these functions take the plugin and the row object as arguments.
# Make any necessary changes to the row object, and add errors / warnings /
# info messages through the log method:
# $dwc->log("warning", "This is probably bad");
# $dwc->log("error", "This is really bad!");
# $dwc->log("info", "Converted UTM verbatimCoordinates to decimal degrees");
sub augment {
  my ($plugin, $dwc) = @_;

  if($$dwc{locality} && !$$dwc{decimalLatitude}) {
    my $result = $geonames->geocode($$dwc{locality});
    if($result && $result->[0]) {
      $$dwc{countryCode} = $result->[0]->{countryCode};
      $$dwc{decimalLatitude} = $result->[0]->{lat};
      $$dwc{decimalLongitude} = $result->[0]->{lng};
      $$dwc{country} = $result->[0]->{countryName};
      $$dwc{locationID} = $result->[0]->{geonameId};
    } else {
      $dwc->log("warning",
        "Couldn't find $$dwc{locality} in GeoNames database");
    }
  }
}

1;

