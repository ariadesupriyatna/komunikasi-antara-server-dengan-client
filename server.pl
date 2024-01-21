use IO::Socket::INET;
use Term::ANSIColor;

my $port = 8080;
my $server = IO::Socket::INET->new(LocalPort => $port, Proto => 'tcp', Listen => 5, Reuse => 1) or die "Cannot create socket: $!\n";

print color('bold green');
print "Server listening on port $port\n";
print color('reset');

while (my $client = $server->accept()) {
    my $client_address = $client->peerhost();
    my $client_port    = $client->peerport();
    print color('bold cyan');
    print "Accepted connection from $client_address:$client_port\n";
    print color('reset');

    while (1) {
        my $data = <$client>;
        last unless defined $data;

        chomp $data;
        print color('bold yellow');
        print "Client said: $data\n";
        print color('reset');

        last if $data =~ /^exit$/i;  # Exit loop if client sends 'exit'

        print color('bold magenta');
        print "Your message: ";
        print color('reset');
        
        my $response = <STDIN>;
        chomp $response;

        print $client color('bold white') . $response . color('reset') . "\n";
    }

    close($client);
}

close($server);
