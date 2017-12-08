package Poloniex::Util;

use strict;
use warnings;
use URI::Escape;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(http_build_query);

sub http_build_query {
    my ($data, $prefix, $separator) = @_;

    return http_build_query_iso($data, $prefix, $separator);
}

sub http_build_query_iso {
    my ($data, $prefix, $separator) = @_;

    return serialize($data, $prefix, $separator, \&URI::Escape::uri_escape);
}

sub serialize {
    my ($data, $prefix, $separator, $escaper, $sofar) = @_;

    $separator = '&' unless defined $separator;

    if (ref($data) eq "HASH") {
        return hash_serialize($data, $prefix, $separator, $escaper, $sofar);
    } elsif (ref($data) eq "ARRAY") {
        return array_serialize($data, $prefix, $separator, $escaper, $sofar);
    } elsif (ref($data) eq "") {
        return scalar_serialize($data, $prefix, $separator, $escaper, $sofar);
    } else {
        die "Data type ", ref($data), " not (yet) implemented.";
    }
}

sub hash_serialize {
    my ($data, $prefix, $separator, $escaper, $sofar) = @_;

    my $result = "";

    for my $key (keys %$data) {

        my $newsofar =
          defined $sofar
          ? ($sofar."%5B".$escaper->($key)."%5D")
          : $escaper->($key);

        $result .= $separator if length $result;
        $result .= serialize($data->{$key}, $prefix, $separator, $escaper, $newsofar,);
    }
    return $result;
}

sub array_serialize {
    my ($data, $prefix, $separator, $escaper, $sofar) = @_;

    my $result = "";
    my $idx    = 0;

    for my $element (@$data) {

        my $newsofar =
            defined $sofar  ? ($sofar."%5B".$idx."%5D")
          : defined $prefix ? ("$prefix"."_".$idx)
          :                   $idx;

        $result .= $separator if length $result;
        $result .= serialize($element, $prefix, $separator, $escaper, $newsofar,);
        $idx++;
    }
    return $result;
}

sub scalar_serialize {

    my ($data, $prefix, $separator, $escaper, $sofar) = @_;

    my $escaped_data = defined $data  ? $escaper->($data) : '';
    my $new_sofar    = defined $sofar ? $sofar            : '';

    return "$new_sofar=$escaped_data";
}

1;
