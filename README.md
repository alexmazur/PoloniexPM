# PoloniexPM
Poloniex API Perl

Access to Poloniex API with Perl

## Constructor:
my $pol = Poloniex->new(
    'api_key'    => 'XXX-XXX-XXX-XXX',
    'api_secret' => 'yurLongSecret'
);

my $bal = $pol->get_trading_pairs;

# Prerequested Perl modules:
- JSON::XS
- WWW::Curl::Easy
- LWP::Protocol::https
- Test::More
