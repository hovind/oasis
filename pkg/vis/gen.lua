set('version', 'v0.4')
cflags{
	'-std=c99',
	'-D CONFIG_HELP=1',
	'-D CONFIG_CURSES=1',
	'-D CONFIG_LUA=1',
	'-D CONFIG_LPEG=1',
	'-D CONFIG_TRE=0',
	'-D CONFIG_SELINUX=0',
	'-D CONFIG_ACL=0',
	'-D HAVE_MEMRCHR=1',
	'-D _POSIX_C_SOURCE=200809L',
	'-D _XOPEN_SOURCE=700',
	[[-D 'VERSION="$version"']],
	[[-D 'VIS_PATH="/share/vis"']],
	'-D NDEBUG',
	'-I $outdir',
	'-I pkg/libtermkey/src',
	'-I pkg/lua/src/src',
	'-I $builddir/pkg/ncurses/include',
}

build('copy', '$outdir/config.h', '$srcdir/config.def.h')

pkg.deps = {
	'$outdir/config.h',
	'pkg/libtermkey/fetch',
	'pkg/lua/fetch',
	'pkg/ncurses/headers',
}

exe('vis', [[
	array.c buffer.c libutf.c main.c map.c
	sam.c text.c text-motions.c text-objects.c text-util.c
	ui-terminal.c view.c vis.c vis-lua.c vis-modes.c vis-motions.c
	vis-operators.c vis-registers.c vis-marks.c vis-prompt.c vis-text-objects.c text-regex.c
	$builddir/pkg/(
		libtermkey/libtermkey.a.d
		lpeg/liblpeg.a
		lua/liblua.a
		ncurses/libncurses.a
	)
]])
file('bin/vis', '755', '$outdir/vis')

exe('vis-digraph', {'vis-digraph.c'})
file('bin/vis-digraph', '755', '$outdir/vis-digraph')

exe('vis-menu', {'vis-menu.c'})
file('bin/vis-menu', '755', '$outdir/vis-menu')

file('bin/vis-open', '755', '$srcdir/vis-open')

for _, f in ipairs{'vis.1', 'vis-digraph.1', 'vis-menu.1', 'vis-open.1'} do
	build('sed', '$outdir/'..f, '$srcdir/man/'..f, {expr='s,VERSION,$version,'})
	man{'$outdir/'..f}
end

for f in iterlines('lua.txt') do
	file('share/vis/'..f, '644', '$srcdir/lua/'..f)
end
sym('share/vis/lexer.lua', 'lexers/lexer.lua')
sym('share/vis/themes/default-16.lua', 'dark-16.lua')
sym('share/vis/themes/default-256.lua', 'dark-16.lua')

fetch 'git'
