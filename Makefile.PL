use 5.024004;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'DwC::Plugin::GeoNames',
    VERSION_FROM      => 'lib/DwC/Plugin/GeoNames.pm',
    PREREQ_PM         => { DwC => 0.01, "Geo::GeoNames" => 1.12 },
    ABSTRACT          => 'Example DwC Plugin',
    AUTHOR            => 'umeldt <chris@svindseth.jp>',
    LICENSE           => 'perl',
);

