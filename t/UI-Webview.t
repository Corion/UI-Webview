# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl UI-Webview.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('UI::Webview') };


my $fail = 0;
foreach my $constname (qw(
	JSON_ACTION_END JSON_ACTION_END_STRUCT JSON_ACTION_NONE
	JSON_ACTION_START JSON_ACTION_START_STRUCT JSON_STATE_ESCAPE
	JSON_STATE_LITERAL JSON_STATE_STRING JSON_STATE_UTF8 JSON_STATE_VALUE
	PROCESS_PER_MONITOR_DPI_AWARE WEBVIEW_API WEBVIEW_DEPRECATED_PRIVATE
	WEBVIEW_HINT_FIXED WEBVIEW_HINT_MAX WEBVIEW_HINT_MIN WEBVIEW_HINT_NONE
	WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK
	WEBVIEW_VERSION_MAJOR WEBVIEW_VERSION_MINOR WEBVIEW_VERSION_NUMBER
	WEBVIEW_VERSION_PATCH)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined UI::Webview macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

