typedef struct {
/* Stuff that Webview cares about */
    webview_t w;
    char *seq;
    char *req;
/* Stuff that we care about to call Perl */
    SV * js_name;
    SV * cb;
    AV * args;
} Perl_cb_context;

void Webview_reflect(const char *seq, const char *req, void *arg ) {
    /* the args are the Perl SV we want to call and the Perl args stored */
    /* I'm unclear on what is in req */
    Perl_cb_context* ctx = (Perl_cb_context *) arg;
    /* Currently we ignore the other subroutine arguments or anything */
    /* that might be passed in in *req */
    /* The response needs to be sent via webview_return() */
    /* The callback from this is already on the UI thread spawned from Perl */

    dSP;
    ENTER;
    SAVETMPS;

    printf("Callback invoked on %x from javascript:%s to %x\n", ctx->w, SvPV_nolen(ctx->js_name), ctx->cb);
    PUSHMARK(SP);
    EXTEND(SP, 3);
    PUSHs(sv_2mortal(newSViv( (uint64_t) ctx->w )));
    PUSHs(sv_2mortal(newSVpv(seq, 0 )));
    PUSHs(sv_2mortal(newSVpv(req, 0 )));
    PUTBACK;
    call_sv( ctx->cb, G_VOID | G_DISCARD);
    FREETMPS;
    LEAVE;
    //printf("Callback done\n");
    return;
}
