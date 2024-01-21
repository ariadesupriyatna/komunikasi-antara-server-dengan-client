use IO::Socket::INET;
use Term::ANSIColor;

my $host = 'localhost';
my $port = 8080;

my $client = IO::Socket::INET->new(PeerHost => $host, PeerPort => $port, Proto => 'tcp') or die "Cannot connect to the server: $!\n";

print color('bold green');
print "Connected to server on $host:$port\n";
print color('reset');

while (1) {
    print color('bold magenta');
    print "Your message: ";
    print color('reset');
    
    my $message = <STDIN>;
    chomp $message;

    last if $message =~ /^exit$/i;  # Exit loop if user inputs 'exit'

    print $client color('bold white') . $message . color('reset') . "\n";

    my $response = <$client>;
    last unless defined $response;

    chomp $response;
    print color('bold yellow');
    print "Server said: $response\n";
    print color('reset');
}

close($client);
