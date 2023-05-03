use 5.020;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

use Config;

my $DIR=".";
my $FLAGS="-Wall -Wextra -pedantic -I$DIR";
my $CFLAGS="-std=c99 $FLAGS -Wl,--gc-sections -fPIC -shared";

my $CXXFLAGS;
my $DEFINE;
#if [ "$(uname)" = "Darwin" ]; then
        #CXXFLAGS="-DWEBVIEW_COCOA -std=c++11 $FLAGS -framework WebKit"
#else
# XXX Linux only so far
$DEFINE='-DWEBVIEW_GTK -DWEBVIEW_API=extern';
my $PKG_DIRS = readpipe('pkg-config --cflags --libs gtk+-3.0 webkit2gtk-4.0');
my $PKG_LIBS = readpipe('pkg-config --libs gtk+-3.0 webkit2gtk-4.0');
$PKG_DIRS =~ s!\s*\z!!;
$CXXFLAGS="-std=c++11 $FLAGS $PKG_DIRS -lstdc++ -fPIC -Wl,--gc-sections -shared ";

# First, build the C++ part (instead of leaving that to the Makefile ...)
my $build_webview = "g++ -c $DEFINE $CXXFLAGS webview.cc -o ./webview.o";
say $build_webview;
chdir "vendor/";
system($build_webview) == 0
    or die "Couldn't build vendor/webview.o.";
chdir "..";

say "Building Perl extension";

WriteMakefile(
    NAME              => 'UI::Webview',
    VERSION_FROM      => 'lib/UI/Webview.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/UI/Webview.pm', # retrieve abstract from module
    AUTHOR            => 'Max Maischein <cpan@corion.net>',
    LIBS              => '-lm ' . $PKG_LIBS, # e.g., '-lm'
    DEFINE            => $DEFINE,
    INC               => "-I. -Ivendor/ $PKG_DIRS",
    CCFLAGS           => '-std=c99 ' . $Config{ccflags},
    LDFROM            => '$(OBJECT) vendor/webview.o',
	# Un-comment this if you add C files to link with later:
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw( WEBVIEW_HINT_FIXED
		 WEBVIEW_HINT_MAX WEBVIEW_HINT_MIN WEBVIEW_HINT_NONE
		 WEBVIEW_MSWEBVIEW2_BUILTIN_IMPL
		 WEBVIEW_MSWEBVIEW2_EXPLICIT_LINK WEBVIEW_VERSION_MAJOR
		 WEBVIEW_VERSION_MINOR WEBVIEW_VERSION_NUMBER
		 WEBVIEW_VERSION_PATCH),
              );
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'UI::Webview',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
