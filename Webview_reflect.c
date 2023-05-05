typedef struct {
/* Stuff that Webview cares about */
    webview_t w;
    char *seq;
    char *req;
/* Stuff that we care about to call Perl */
    SV * cb;
    AV * args;
} Perl_cb_context;

void Webview_reflect(const char *seq, const char *req, void *arg ) {
    /* the args are the Perl SV we want to call and the Perl args stored */
}
