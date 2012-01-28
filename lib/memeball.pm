package memeball;
use Dancer ':syntax';

use FindBin;
use Path::Class qw/ dir file /;

our $VERSION = '0.0.1';

my %answers = %{ config->{answers} };

# sanity check
debug "loading possible answers";
for my $filename ( keys %answers ) {
    debug "\t$answers{$filename}";
    next if -f file( $FindBin::Bin, '..', 'public', 'answers', $filename );
    debug "\tfile $filename not found, skipping answer";

    delete $answers{$filename};
}

get '/' => sub {
    template 'index';
};

post '/ask' => sub {

    my $question = param('question');
    my @files = keys %answers;
    my $file = $files[rand @files];

    template answer => {
        question => param('question'),
        answer => $answers{$file},
        pic => $file,
    };

};

true;
