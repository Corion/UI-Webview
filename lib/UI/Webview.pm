package UI::Webview;

use 5.032001;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use UI::Webview ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	WEBVIEW_DEPRECATED_PRIVATE
	WEBVIEW_HINT_FIXED
	WEBVIEW_HINT_MAX
	WEBVIEW_HINT_MIN
	WEBVIEW_HINT_NONE
	WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL
	WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK
	WEBVIEW_VERSION_MAJOR
	WEBVIEW_VERSION_MINOR
	WEBVIEW_VERSION_NUMBER
	WEBVIEW_VERSION_PATCH
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&UI::Webview::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('UI::Webview', $VERSION);

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

UI::Webview - Perl extension for blah blah blah

=head1 SYNOPSIS

  use UI::Webview;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for UI::Webview, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head2 Exportable constants

  JSON_ACTION_END
  JSON_ACTION_END_STRUCT
  JSON_ACTION_NONE
  JSON_ACTION_START
  JSON_ACTION_START_STRUCT
  JSON_STATE_ESCAPE
  JSON_STATE_LITERAL
  JSON_STATE_STRING
  JSON_STATE_UTF8
  JSON_STATE_VALUE
  PROCESS_PER_MONITOR_DPI_AWARE
  WEBVIEW_API
  WEBVIEW_DEPRECATED_PRIVATE
  WEBVIEW_HINT_FIXED
  WEBVIEW_HINT_MAX
  WEBVIEW_HINT_MIN
  WEBVIEW_HINT_NONE
  WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL
  WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK
  WEBVIEW_VERSION_MAJOR
  WEBVIEW_VERSION_MINOR
  WEBVIEW_VERSION_NUMBER
  WEBVIEW_VERSION_PATCH



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Max Maischein, E<lt>corion@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2023 by Max Maischein

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.32.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
