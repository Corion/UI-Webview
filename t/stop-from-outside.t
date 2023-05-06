#!perl
use 5.020;
use feature 'signatures';
no warnings 'experimental::signatures';

use threads;
use Thread::Queue;
use UI::Webview 'WEBVIEW_HINT_NONE';

use Test::More tests => 1;

my $html = <<'HTML';
<p>This is Perl using webview!</p>
HTML

my $q = Thread::Queue->new;

my @ctx;
my $ui_thread = threads->create(sub($q) {
    state $w = UI::Webview::webview_create(1,undef);
    UI::Webview::webview_set_title($w, "Perl Example");
    UI::Webview::webview_set_size($w, 480, 320, WEBVIEW_HINT_NONE);
    UI::Webview::webview_set_html($w, $html);
    $q->enqueue($w);
    UI::Webview::webview_run($w);
    # XXX we want to unbind our callback(s) here before trying to exit,
    #     but unbinding doens't really do much in the Webview anyway
#    UI::Webview::webview_unbind($w, $ctx);
    UI::Webview::webview_destroy($w);
}, $q);

#sleep 2;
#
my $w = $q->dequeue;
$| = 1;
sleep 2;
UI::Webview::webview_terminate($w);
$ui_thread->join;

ok 1, "We get here";
