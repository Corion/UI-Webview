#!perl
use 5.020;
use feature 'signatures';
no warnings 'experimental::signatures';

use threads;
use UI::Webview 'WEBVIEW_HINT_NONE';

my $ui_thread = threads->create(sub {
    state $w = UI::Webview::webview_create(0,undef);
    UI::Webview::webview_set_title($w, "Perl Example");
    UI::Webview::webview_set_size($w, 480, 320, WEBVIEW_HINT_NONE);
    UI::Webview::webview_set_html($w, "<p>This is Perl using webview!</p>");
    UI::Webview::webview_run($w);
    UI::Webview::webview_destroy($w);
});

$| = 1;
while(1) {
    sleep 1;
    print "\r", scalar localtime;
}
