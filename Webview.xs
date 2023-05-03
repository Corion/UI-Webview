#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <vendor/webview.h>

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

void *
Webview_webview_bind(IV w, const char *name, SV *callback, AV *arg);
CODE:
    /* Wrap the callback in a C function */
    webview_bind((webview_t) w, name, 0, 0);
OUTPUT:
    RETVAL

void *
Webview_webview_unbind(IV w, const char *name);
CODE:
    webview_unbind((webview_t) w, name);
OUTPUT:
    RETVAL

void *
Webview_webview_return(IV w, const char *seq, int status, const char *result);
CODE:
    /* Wrap the callback in a C function */
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
