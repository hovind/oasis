cflags{
	'-include $dir/config.h',
	'-I $srcdir',
	'-I $srcdir/compat/regex',
	'-I $outdir',
	'-I $builddir/pkg/curl/include',
	'-I $builddir/pkg/zlib/include',
}

rule('cmdlist', 'wd=$$PWD && cd $srcdir && ./generate-cmdlist.sh $$wd/$in >$$wd/$out.tmp && mv $$wd/$out.tmp $$wd/$out')
build('cmdlist', '$outdir/common-cmds.h', {
	'$srcdir/command-list.txt', '|', expand{'$srcdir/Documentation/', lines('commands.txt')},
})

pkg.deps = {'$outdir/common-cmds.h', 'pkg/curl/headers', 'pkg/zlib/headers'}

cc('exec_cmd.c', nil, {cflags=[[$cflags '-DPREFIX=""']]})
cc('common-main.c')
cc('http.c')
cc('compat/regex/regex.c', nil, {cflags='$cflags -DGAWK -DNO_MBSUPPORT'})

-- src/Makefile:/^LIB_OBJS.\+=
lib('libgit.a', [[
	abspath.c
	advice.c
	alias.c
	alloc.c
	apply.c
	archive-tar.c
	archive-zip.c
	archive.c
	argv-array.c
	attr.c
	base85.c
	bisect.c
	blame.c
	blob.c
	branch.c
	bulk-checkin.c
	bundle.c
	cache-tree.c
	color.c
	column.c
	combine-diff.c
	commit.c
	compat/obstack.c
	compat/regex/regex.c.o
	compat/terminal.c
	compat/qsort_s.c
	config.c
	connect.c
	connected.c
	convert.c
	copy.c
	credential.c
	csum-file.c
	ctype.c
	date.c
	decorate.c
	diff-delta.c
	diff-lib.c
	diff-no-index.c
	diff.c
	diffcore-break.c
	diffcore-delta.c
	diffcore-order.c
	diffcore-pickaxe.c
	diffcore-rename.c
	dir.c
	dir-iterator.c
	editor.c
	entry.c
	environment.c
	ewah/bitmap.c
	ewah/ewah_bitmap.c
	ewah/ewah_io.c
	ewah/ewah_rlw.c
	exec_cmd.c.o
	fetch-pack.c
	fsck.c
	gettext.c
	gpg-interface.c
	graph.c
	grep.c
	hashmap.c
	help.c
	hex.c
	ident.c
	kwset.c
	levenshtein.c
	line-log.c
	line-range.c
	list-objects.c
	ll-merge.c
	lockfile.c
	log-tree.c
	mailinfo.c
	mailmap.c
	match-trees.c
	merge-blobs.c
	merge-recursive.c
	merge.c
	mergesort.c
	mru.c
	name-hash.c
	notes-cache.c
	notes-merge.c
	notes-utils.c
	notes.c
	object.c
	oidset.c
	pack-bitmap-write.c
	pack-bitmap.c
	pack-check.c
	pack-objects.c
	pack-revindex.c
	pack-write.c
	pager.c
	parse-options-cb.c
	parse-options.c
	patch-delta.c
	patch-ids.c
	path.c
	pathspec.c
	pkt-line.c
	preload-index.c
	pretty.c
	prio-queue.c
	progress.c
	prompt.c
	quote.c
	reachable.c
	read-cache.c
	ref-filter.c
	reflog-walk.c
	refs.c
	refs/files-backend.c
	refs/iterator.c
	refs/ref-cache.c
	remote.c
	replace_object.c
	repository.c
	rerere.c
	resolve-undo.c
	revision.c
	run-command.c
	send-pack.c
	sequencer.c
	server-info.c
	setup.c
	sha1-array.c
	sha1-lookup.c
	sha1_file.c
	sha1_name.c
	shallow.c
	sideband.c
	sigchain.c
	split-index.c
	strbuf.c
	streaming.c
	string-list.c
	submodule-config.c
	submodule.c
	sub-process.c
	symlinks.c
	tag.c
	tempfile.c
	tmp-objdir.c
	trace.c
	trailer.c
	transport-helper.c
	transport.c
	tree-diff.c
	tree-walk.c
	tree.c
	unpack-trees.c
	url.c
	urlmatch.c
	usage.c
	userdiff.c
	utf8.c
	varint.c
	version.c
	versioncmp.c
	walker.c
	wildmatch.c
	worktree.c
	wrapper.c
	write_or_die.c
	ws.c
	wt-status.c
	xdiff-interface.c
	zlib.c

	sha1dc/sha1.c
	sha1dc/ubc_check.c

	thread-utils.c
	libxdiff.a
	$builddir/pkg/zlib/libz.a
]])

-- src/Makefile:/^XDIFF_OBJS.\+=
lib('libxdiff.a', [[xdiff/(
	xdiffi.c
	xprepare.c
	xutils.c
	xemit.c
	xmerge.c
	xpatience.c
	xhistogram.c
)]])

-- src/Makefile:/^BUILTIN_OBJS.\+=
local builtins = {
	'add',
	'am',
	'annotate',
	'apply',
	'archive',
	'bisect--helper',
	'blame',
	'branch',
	'bundle',
	'cat-file',
	'check-attr',
	'check-ignore',
	'check-mailmap',
	'check-ref-format',
	'checkout-index',
	'checkout',
	'clean',
	'clone',
	'column',
	'commit-tree',
	'commit',
	'config',
	'count-objects',
	'credential',
	'describe',
	'diff-files',
	'diff-index',
	'diff-tree',
	'diff',
	'difftool',
	'fast-export',
	'fetch-pack',
	'fetch',
	'fmt-merge-msg',
	'for-each-ref',
	'fsck',
	'gc',
	'get-tar-commit-id',
	'grep',
	'hash-object',
	'help',
	'index-pack',
	'init-db',
	'interpret-trailers',
	'log',
	'ls-files',
	'ls-remote',
	'ls-tree',
	'mailinfo',
	'mailsplit',
	'merge',
	'merge-base',
	'merge-file',
	'merge-index',
	'merge-ours',
	'merge-recursive',
	'merge-tree',
	'mktag',
	'mktree',
	'mv',
	'name-rev',
	'notes',
	'pack-objects',
	'pack-redundant',
	'pack-refs',
	'patch-id',
	'prune-packed',
	'prune',
	'pull',
	'push',
	'read-tree',
	'rebase--helper',
	'receive-pack',
	'reflog',
	'remote',
	'remote-ext',
	'remote-fd',
	'repack',
	'replace',
	'rerere',
	'reset',
	'rev-list',
	'rev-parse',
	'revert',
	'rm',
	'send-pack',
	'shortlog',
	'show-branch',
	'show-ref',
	'stripspace',
	'submodule--helper',
	'symbolic-ref',
	'tag',
	'unpack-file',
	'unpack-objects',
	'update-index',
	'update-ref',
	'update-server-info',
	'upload-archive',
	'var',
	'verify-commit',
	'verify-pack',
	'verify-tag',
	'worktree',
	'write-tree',
}
exe('git', {'git.c', 'common-main.c.o', expand{'builtin/', builtins, '.c'}, 'libgit.a.d'})
file('bin/git', '755', '$outdir/git')
local syms = {
	builtins,
	'cherry',
	'cherry-pick',
	'format-patch',
	'fsck-objects',
	'init',
	'merge-subtree',
	'show',
	'stage',
	'status',
	'whatchanged',
}
for name in iterstrings(syms) do
	sym('libexec/git-core/git-'..name, '../../bin/git')
end

local function x(name, srcs)
	exe('git-'..name, {srcs or name..'.c', 'common-main.c.o', 'libgit.a.d'})
	file('libexec/git-core/git-'..name, '755', '$outdir/git-'..name)
end

-- src/Makefile:/^PROGRAM_OBJS./+=
x('credential-store')
x('daemon')
x('fast-import')
x('http-backend')
x('imap-send', {'imap-send.c', 'http.c.o', '$builddir/pkg/curl/libcurl.a.d'})
x('sh-i18n--envsubst')
x('shell')
x('show-index')
x('upload-pack')
-- git-remote-testsvn is intentionally omitted.

x('remote-http', {'remote-curl.c', 'http.c.o', 'http-walker.c', '$builddir/pkg/curl/libcurl.a.d'})
for _, remote in ipairs{'https', 'ftp', 'ftps'} do
	sym('libexec/git-core/git-remote-'..remote, 'git-remote-http')
end

rule('sh_gen', 'sed -f $dir/sh_gen.sed $in >$out.tmp && mv $out.tmp $out')
local function x(name, mode)
	build('sh_gen', '$outdir/git-'..name, {'$srcdir/git-'..name..'.sh', '|', '$dir/sh_gen.sed'})
	file('libexec/git-core/git-'..name, mode, '$outdir/git-'..name)
end

-- src/Makefile:/^SCRIPT_SH.\+=
x('bisect', '755')
x('difftool--helper', '755')
x('filter-branch', '755')
x('merge-octopus', '755')
x('merge-one-file', '755')
x('merge-resolve', '755')
x('mergetool', '755')
x('quiltimport', '755')
x('rebase', '755')
x('remote-testgit', '755')
x('request-pull', '755')
x('stash', '755')
x('submodule', '755')
x('web--browse', '755')

-- src/Makefile:/^SCRIPT_LIB.\+=
x('mergetool--lib', '644')
x('parse-remote', '644')
x('rebase--am', '644')
x('rebase--interactive', '644')
x('rebase--merge', '644')
x('sh-setup', '644')
x('sh-i18n', '644')

for _, name in ipairs{'git-shell', 'git-upload-pack'} do
	sym('bin/'..name, '../libexec/git-core/'..name)
end
for _, name in ipairs{'git-receive-pack', 'git-upload-archive'} do
	sym('bin/'..name, 'git')
end

-- templates
dir('share/git-core/templates/branches', '755')
file('share/git-core/templates/description', '644', '$srcdir/templates/this--description')
file('share/git-core/templates/info/exclude', '644', '$srcdir/templates/info--exclude')
-- Skip the sample hooks and install an empty directory instead.
dir('share/git-core/templates/hooks', '755')

man(expand{'man/', lines('man.txt')})

fetch 'local'
