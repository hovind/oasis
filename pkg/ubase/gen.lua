cflags{
	'-std=c99', '-pedantic',
	'-Wall', '-Wno-maybe-uninitialized', '-Wno-overflow',
	'-D _GNU_SOURCE',
	'-D _XOPEN_SOURCE=700',
	'-I $dir',
}

lib('libutil.a', [[libutil/(
	agetcwd.c
	agetline.c
	apathmax.c
	concat.c
	ealloc.c
	eprintf.c
	estrtol.c
	estrtoul.c
	explicit_bzero.c
	passwd.c
	proc.c
	putword.c
	recurse.c
	strlcat.c
	strlcpy.c
	strtonum.c
	tty.c
)]])

function x(cmd, section, mode)
	if not mode then
		mode = '755'
	end
	file('bin/'..cmd, mode, exe(cmd, {cmd..'.c', 'libutil.a'}))
	if section then
		man{cmd..'.'..section}
	end
end

x('chvt', 1)
x('clear', 1)
x('ctrlaltdel', 8)
x('dd', 1)
x('df', 1)
x('dmesg', 1)
x('eject', 1)
x('fallocate', 1)
x('free', 1)
x('freeramdisk', 8)
x('fsfreeze', 8)
x('getty', 8)
x('halt', 8)
x('hwclock', 8)
x('id', 1)
x('insmod', 8)
x('killall5', 8)
x('last')
x('lastlog', 8)
x('login', 1)
x('lsmod', 8)
x('lsusb', 8)
x('mesg', 1)
x('mknod', 1)
x('mkswap', 8)
x('mount', 8)
x('mountpoint', 1)
x('nologin', 8)
x('pagesize', 1)
x('passwd', 1, '4755')
x('pidof', 1)
x('pivot_root', 8)
x('ps', 1)
x('pwdx', 1)
x('readahead', 8)
x('respawn', 1)
x('rmmod', 8)
x('stat', 1)
x('stty')
x('swaplabel', 8)
x('swapoff', 8)
x('swapon', 8)
x('switch_root', 8)
x('sysctl', 8)
x('truncate', 1)
x('umount', 8)
x('unshare', 1)
x('uptime', 1)
x('vtallow', 1)
x('watch', 1)
x('who', 1)

fetch 'git'
