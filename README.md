# PoloniexPM
Poloniex API Perl

Access to Poloniex API with Perl

## Constructor:
my $pol = Poloniex->new(
    'api_key'    => 'XXX-XXX-XXX-XXX',
    'api_secret' => 'yurLongSecret'
);

my $bal = $pol->get_trading_pairs;

## Returms:

- returnTicker
Returns the ticker for all markets. Sample output:

Got get_trading_pairs:{
          'XMR_BLK' => {
                         'low24hr' => '0.00113156',
                         'quoteVolume' => '6493.80371046',
                         'percentChange' => '-0.21269090',
                         'last' => '0.00113156',
                         'lowestAsk' => '0.00119068',
                         'baseVolume' => '8.07245629',
                         'id' => 130,
                         'highestBid' => '0.00110000',
                         'high24hr' => '0.00149884',
                         'isFrozen' => '0'
                       },
          'ETH_ETC' => {
.......
}

# Prerequested Perl modules:
- JSON::XS
- WWW::Curl::Easy
- LWP::Protocol::https
- Test::More
