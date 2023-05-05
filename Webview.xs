#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <vendor/webview.h>
#include <Webview_reflect.c>

#include "const-c.inc"

MODULE = UI::Webview		PACKAGE = UI::Webview		PREFIX = Webview_

SV*
Webview_webview_create(debug, parentWindow)
    int debug
    void *parentWindow
CODE:
    RETVAL = newSViv( (u_int64_t) webview_create(debug, parentWindow) );
OUTPUT:
    RETVAL

void *
Webview_webview_destroy(w)
    IV w
CODE:
    webview_destroy((webview_t) w);
OUTPUT:
    RETVAL

void *
Webview_webview_run(w);
    IV w
CODE:
    webview_run((webview_t) w);
OUTPUT:
    RETVAL

void *
Webview_webview_terminate(w);
    IV w
CODE:
    webview_terminate((webview_t) w);
OUTPUT:
    RETVAL

void *
webview_dispatch(w, perl_callback, userargs);
    IV w
CODE:
    void *arg;
    /* void ((*fn)(webview_t w, void *arg)) cb; */
    void *cb;
    arg = 0;
    cb = 0;


    /* Wrap the perl_callback, package the userargs from the AV into *arg, pass on*/

    webview_dispatch((webview_t) w, cb, arg);
OUTPUT:
    RETVAL

void *
Webview_webview_get_window(w);
    IV w
CODE:
    RETVAL = webview_get_window((webview_t) w);
OUTPUT:
    RETVAL

void *
Webview_webview_set_title( w, const char *title);
    IV w
CODE:
    webview_set_title((webview_t) w, title);
OUTPUT:
    RETVAL

#define WEBVIEW_HINT_NONE 0  // Width and height are default size
#define WEBVIEW_HINT_MIN 1   // Width and height are minimum bounds
#define WEBVIEW_HINT_MAX 2   // Width and height are maximum bounds
#define WEBVIEW_HINT_FIXED 3 // Window size can not be changed by a user

void *
Webview_webview_set_size(IV w, int width, int height, int hints);
CODE:
    webview_set_size((webview_t) w, width, height, hints);
OUTPUT:
    RETVAL

void *
Webview_webview_navigate(IV w, const char *url);
CODE:
    webview_navigate((webview_t) w, url);
OUTPUT:
    RETVAL

void *
Webview_webview_set_html(IV w, const char *html);
CODE:
    webview_set_html((webview_t) w, html);
OUTPUT:
    RETVAL

void *
Webview_webview_init(IV w, const char *js);
CODE:
    webview_init((webview_t) w, js);
OUTPUT:
    RETVAL

void *
Webview_webview_eval(IV w, const char *js);
CODE:
    webview_eval((webview_t) w, js);
OUTPUT:
    RETVAL

SV *
Webview_webview_bind(IV w, SV *name, SV *callback, AV *arg);
CODE:
    /* Wrap the callback in a C function */
    /* We leak this memory currently resp. unbinding and cleanup */
    /* is left to the caller */
    Perl_cb_context* ctx;
    //printf("Binding %s to %x\n", name, callback);
    ctx = (Perl_cb_context *) newSV(sizeof(Perl_cb_context));

    ctx->w      = (webview_t) w;
    ctx->seq    = 0;
    ctx->req    = 0;
    ctx->js_name = newSVsv(name);
    SvREFCNT_inc(callback);
    ctx->cb   = callback;
    SvREFCNT_inc(arg);
    ctx->args = arg; /* I think we need to increment the refcount here */

    webview_bind( (webview_t) w, SvPV_nolen(name), &Webview_reflect, ctx);
    printf("Bound %s to %x\n", SvPV_nolen(ctx->js_name), w);

    RETVAL = newSVpvn( ctx, sizeof(*ctx) );
OUTPUT:
    RETVAL

void *
Webview_webview_unbind(IV w, SV *_ctx);
CODE:
    // We need to find our old ctx here, resp. we don't want the name
    // but the context returned from webview_bind() above
    Perl_cb_context * ctx = (Perl_cb_context*) SvPV_nolen(_ctx);

    printf("Unbinding %s from %x\n", SvPV_nolen(ctx->js_name), ctx->w);

    webview_unbind(ctx->w, SvPV_nolen(ctx->js_name));
    SvREFCNT_dec(ctx->cb);
    SvREFCNT_dec(ctx->args);
    SvREFCNT_dec(ctx->js_name);
OUTPUT:
    RETVAL

void *
Webview_webview_return(IV w, const char *seq, int status, const char *result);
CODE:
    webview_return((webview_t) w, seq, status, result);
OUTPUT:
    RETVAL

HV *
Webview_webview_version();
PPCODE:
    const webview_version_info_t *ver;
    ver = webview_version();
    /* build an even-sized array from that struct */
    /* EXTEND(SP,3); */
    XPUSHs(sv_2mortal(newSViv(ver->version.major)));
    XPUSHs(sv_2mortal(newSViv(ver->version.minor)));
    XPUSHs(sv_2mortal(newSViv(ver->version.patch)));

INCLUDE: const-xs.inc
