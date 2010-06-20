package Dancer::Logger::PSGI;

# ABSTRACT: PSGI Log handler for Dancer

use strict;
use warnings;

our $VERSION = '0.01';

use Dancer::SharedData;
use base 'Dancer::Logger::Abstract';

sub init {}

sub _log {
    my ( $self, $level, $message ) = @_;
    my $full_message = $self->format_message($level => $message);
    chomp $full_message;

    my $request = Dancer::SharedData->request;
    if ($request->{env}->{'psgix.logger'}) {
        $request->{env}->{'psgix.logger'}->(
            {   level   => $level,
                message => $full_message,
            }
        );
    }
}

1;

=head1 SYNOPSIS

In your Dancer's configuration file:

    logger: PSGI

In your application

    warning "this is a warning"

In your app.psgi

    $app = builder { enable "ConsoleLogger"; $app; }

With L<Plack::Middleware::ConsoleLogger>, all your log will be send to the javascript console of your browser.

=head1 DESCRIPTION

This class is an interface between your Dancer's application and B<psgix.logger>. Message will be logged in whatever logger you decided to use in your L<Plack> handler. If no logger is defined, nothing will be logged.
