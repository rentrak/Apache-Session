#############################################################################
#
# Apache::Session::Generate::MD5;
# Generates session identifier tokens using MD5
# Copyright(c) 2000 Jeffrey William Baker (jwbaker@acm.org)
# Distribute under the Artistic License
#
############################################################################

package Apache::Session::Generate::MD5;

use strict;
use vars qw($VERSION);
use MD5;

$VERSION = '1.01';

sub generate {
    my $session = shift;
    my $length = 32;
    
    if (exists $session->{args}->{IDLength}) {
        $length = $session->{args}->{IDLength};
    }
    
    $session->{data}->{_session_id} = 
        substr(MD5->hexhash(MD5->hexhash(time(). {}. rand(). $$)), 0, $length);
    

}

1;

=pod

=head1 NAME

Apache::Session::Generate::MD5 - Use MD5 to create random object IDs

=head1 SYNOPSIS

 use Apache::Session::Generate::MD5;
 
 $id = Apache::Session::Generate::MD5::generate();

=head1 DESCRIPTION

This module fulfills the ID generation interface of Apache::Session.  The
IDs are generated using a two-round MD5 of a random number, the time since the
epoch, the process ID, and the address of an anonymous hash.  The resultant ID
number is highly entropic on Linux and other platforms that have good
random number generators.  You are encouraged to investigate the quality of
your system's random number generator if you are using the generated ID
numbers in a secure environment.

This modules takes one argument in the usual Apache::Session style.  The
argument is IDLength, and the value, between 0 and 32, tells this module
where to truncate the session ID.  Without this argument, the session ID will
be 32 hexadecimal characters long, equivalent to a 128-bit key.

=head1 AUTHOR

This module was written by Jeffrey William Baker <jwbaker@acm.org>.

=head1 SEE ALSO

L<Apache::Session>