use strict;
use warnings;
use Test::More;
use Kelp::Module::Config;

# Merge different
{
    my $H = {};
    my $A = [];
    my @arr = (
        [ 1, 2, 2 ],
        [ 1, undef, undef ],
        [ 1, $H, $H ],
        [ 1, $A, $A ],
        [ undef, 1, 1 ],
        [ undef, undef, undef ],
        [ $H, $A, $A ],
        [ $A, $H, $H ]
    );
    _try( @arr );
}

# Overwrite
{
    my @arr = (
        [
            { a => 1 },
            { a => 2 },
            { a => 2 }
        ],
        [
            { a => 1, b => 2 },
            { b => 3 },
            { a => 1, b => 3 }
        ],
        [
            {},
            { a => 1 },
            { a => 1 }
        ],
        [
            { a => 1 },
            {},
            { a => 1 }
        ],
        [
            { a => [1,2,3] },
            { a => [4,5] },
            { a => [4,5] },
        ],
        [
            { a => "bar", b => [1,2] },
            { a => [1,2] },
            { a => [1,2], b => [1,2] }
        ],
        [
            { a => { b => 'bar' } },
            { a => { c => 'foo' } },
            { a => { b => 'bar', c => 'foo' } },
        ],
        [
            { a => { b => 'bar' } },
            { a => { b => [1,2] } },
            { a => { b => [1,2] } },
        ],
    );
    _try( @arr );
}

sub _try {
    for (@_) {
        my ( $a, $b, $c ) = @$_;
        is_deeply Kelp::Module::Config::_merge( $a, $b ), $c;
    }
}

done_testing;
