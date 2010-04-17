package Dancer::Logger::PSGI;

use strict;
use warnings;
our $VERSION = '0.01';

use Dancer::SharedData;
use base 'Dancer::Logger::Abstract';

sub init {}

sub _log {
    my ( $self, $level, $message ) = @_;
    my $request = Dancer::SharedData->request;
    if ( $request->{env}->{'psgix.logger'} ) {
        $request->{env}->{'psgix.logger'}
            ->( { level => $level, message => $message } );
    }
}

1;
__END__

=head1 NAME

Dancer::Logger::PSGI - PSGI logger handler for Dancer

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

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

L<Plack::Middleware::ConsoleLogger>, L<Plack::Middleware::NullLogger>, L<Plack::Middleware::Log4perl>.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
