#!perl
use 5.020;
use feature 'signatures';
no warnings 'experimental::signatures';

use threads;
use UI::Webview 'WEBVIEW_HINT_NONE';

our $called;

sub static_callback {
     say "In Perl (anonymous)"; $called++
}

my $html = <<'HTML';
<p>This is Perl using webview!</p>
<script>
    window.setTimeout('javascript:window.perl_callback()',1500);
    window.setTimeout('javascript:window.stop_webview()',2000);
</script>
HTML

my @ctx;
#my $ui_thread = threads->create(sub {
    state $w = UI::Webview::webview_create(1,undef);
    UI::Webview::webview_set_title($w, "Perl Example");
    UI::Webview::webview_set_size($w, 480, 320, WEBVIEW_HINT_NONE);
    push @ctx, UI::Webview::webview_bind($w, "perl_callback" => sub($w,$seq,$req) { say "In Perl (anonymous)"; say "$seq: $req"; $called++ }, []);
    push @ctx, UI::Webview::webview_bind($w, "stop_webview" => sub($w,$seq,$req) { UI::Webview::webview_terminate($w) }, []);
    UI::Webview::webview_set_html($w, $html);
    UI::Webview::webview_run($w);
    # XXX we want to unbind our callback(s) here before trying to exit
#    UI::Webview::webview_unbind($w, $ctx);
    UI::Webview::webview_destroy($w);
    say "Done";

#});

#sleep 2;
#
#$| = 1;
#while(1) {
#    sleep 1;
#    printf "%s , called %d times\r", scalar(localtime), $called;
#}
