cflags{
	'-D HAVE_EXPAT_CONFIG_H',
	'-I include',
	'-I $dir',
	'-I pkg/openbsd/include',
}

lib('libexpat.a', [[
	expat/lib/(loadlibrary.c xmlparse.c xmltok.c xmlrole.c)
	$builddir/pkg/openbsd/libbsd.a.d
]])

pkg.hdrs = copy('$outdir/include', '$srcdir/expat/lib', {
	'expat.h',
	'expat_external.h',
})

fetch 'git'
