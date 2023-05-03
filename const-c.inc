#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant_21 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     WEBVIEW_VERSION_MAJOR WEBVIEW_VERSION_MINOR WEBVIEW_VERSION_PATCH */
  /* Offset 18 gives the best switch position.  */
  switch (name[18]) {
  case 'J':
    if (memEQ(name, "WEBVIEW_VERSION_MAJOR", 21)) {
    /*                                 ^         */
#ifdef WEBVIEW_VERSION_MAJOR
      *iv_return = WEBVIEW_VERSION_MAJOR;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'N':
    if (memEQ(name, "WEBVIEW_VERSION_MINOR", 21)) {
    /*                                 ^         */
#ifdef WEBVIEW_VERSION_MINOR
      *iv_return = WEBVIEW_VERSION_MINOR;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'T':
    if (memEQ(name, "WEBVIEW_VERSION_PATCH", 21)) {
    /*                                 ^         */
#ifdef WEBVIEW_VERSION_PATCH
      *iv_return = WEBVIEW_VERSION_PATCH;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!/usr/bin/perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV)};
my @names = (qw(WEBVIEW_HINT_FIXED WEBVIEW_HINT_MAX WEBVIEW_HINT_MIN
	       WEBVIEW_HINT_NONE WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL
	       WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK WEBVIEW_VERSION_MAJOR
	       WEBVIEW_VERSION_MINOR WEBVIEW_VERSION_NUMBER
	       WEBVIEW_VERSION_PATCH));

print constant_types(), "\n"; # macro defs
foreach (C_constant ("UI::Webview", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "\n#### XS Section:\n";
print XS_constant ("UI::Webview", $types);
__END__
   */

  switch (len) {
  case 16:
    /* Names all of length 16.  */
    /* WEBVIEW_HINT_MAX WEBVIEW_HINT_MIN */
    /* Offset 14 gives the best switch position.  */
    switch (name[14]) {
    case 'A':
      if (memEQ(name, "WEBVIEW_HINT_MAX", 16)) {
      /*                             ^        */
#ifdef WEBVIEW_HINT_MAX
        *iv_return = WEBVIEW_HINT_MAX;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'I':
      if (memEQ(name, "WEBVIEW_HINT_MIN", 16)) {
      /*                             ^        */
#ifdef WEBVIEW_HINT_MIN
        *iv_return = WEBVIEW_HINT_MIN;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 17:
    if (memEQ(name, "WEBVIEW_HINT_NONE", 17)) {
#ifdef WEBVIEW_HINT_NONE
      *iv_return = WEBVIEW_HINT_NONE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 18:
    if (memEQ(name, "WEBVIEW_HINT_FIXED", 18)) {
#ifdef WEBVIEW_HINT_FIXED
      *iv_return = WEBVIEW_HINT_FIXED;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 21:
    return constant_21 (aTHX_ name, iv_return);
    break;
  case 22:
    if (memEQ(name, "WEBVIEW_VERSION_NUMBER", 22)) {
#ifdef WEBVIEW_VERSION_NUMBER
      *iv_return = WEBVIEW_VERSION_NUMBER;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 31:
    if (memEQ(name, "WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL", 31)) {
#ifdef WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL
      *iv_return = WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 32:
    if (memEQ(name, "WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK", 32)) {
#ifdef WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK
      *iv_return = WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

