local data = [[
	compat/(
		accessx basic caps complete
		iso9995
		japan ledcaps
		lednum ledscroll level5
		misc mousekeys
		olpc pc pc98 xfree86
		xtest README
	)
	geometry/(
		digital_vndr/(lk pc unix)
		sgi_vndr/(indigo indy O2)
		amiga ataritt chicony
		dell everex fujitsu
		hhk hp keytronic kinesis
		macintosh microsoft nec nokia
		northgate pc sanwa sony thinkpad
		sun teck steelseries typematrix winbook README
	)
	keycodes/(
		digital_vndr/(lk pc)
		sgi_vndr/(indigo indy iris)
		aliases
		amiga
		ataritt
		empty
		evdev
		fujitsu
		hp
		ibm
		jolla
		macintosh
		olpc
		sony
		sun
		xfree86
		xfree98
		README
	)
	rules/(
		xfree98
		xkb.dtd
		README
	)
	symbols/(
		digital_vndr/(lk pc us vt)
		fujitsu_vndr/(jp us)
		hp_vndr/(us)
		jolla_vndr/(sbj)
		macintosh_vndr/(
			apple ch de dk
			fi fr
			gb is it jp
			latam nl no pt
			se us
		)
		nec_vndr/(jp)
		nokia_vndr/(rx-44 rx-51 su-8w)
		sgi_vndr/(jp)
		sharp_vndr/(sl-c3x00 ws003sh ws007sh ws011sh ws020sh)
		sony_vndr/(us)
		sun_vndr/(
			ara be br ca ch
			cz de dk ee es
			fi fr gb gr it
			jp kr lt lv nl
			no pl pt ro ru
			se sk solaris tr
			tw ua us
		)
		xfree68_vndr/(amiga ataritt)
		af al am apl
		ara at au az
		ba bd be
		bg br brai
		bt bw by
		ca cd ch
		cm cn cz
		de dk dz
		ee es et epo eu
		fi fo fr
		gb ge gh gn
		gr hr hu
		id ie il
		in iq
		ir is it
		jp
		ke kg kh
		kr kz
		la latam latin
		lk lt lv
		ma mao md me
		mk ml mm
		mn mt mv my
		ng nl no np
		parens pc ph pk pl pt
		ro rs ru
		se si sk sn
		sy th
		terminate tg
		tj tm tr tw tz
		ua us uz vn
		za
		altwin capslock compose ctrl empty eurosign rupeesign group inet
		keypad kpdl level3 level5 nbsp olpc shift srvr_ctrl typo
	)
	types/(
		basic cancel caps
		complete default extra
		iso9995 level5 mousekeys nokia numpad
		pc README
	)
]]
for f in iterpaths(data) do
	file('share/xkb/'..f, '644', '$srcdir/'..f)
end

rule('merge', 'HDR=$srcdir/rules/HDR ./$srcdir/rules/merge.sh $out.tmp $in && mv $out.tmp $out')
function merge(out, srcs)
	build('merge', '$outdir/'..out, {
		expand{'$srcdir/rules/', paths(srcs)},
		'|', '$srcdir/rules/HDR', '$srcdir/rules/merge.sh',
	})
	file('share/xkb/rules/'..out, '644', '$outdir/'..out)
end

merge('base', [[
	base.hdr.part base.lists.part
	base.lists.base.part
	HDR base.m_k.part
	HDR base.l1_k.part
	HDR base.l_k.part
	HDR
	HDR base.ml_g.part
	HDR base.m_g.part
	HDR base.mlv_s.part
	HDR base.ml_s.part
	HDR base.ml1_s.part
	HDR
	HDR base.ml2_s.part
	HDR base.ml3_s.part
	HDR base.ml4_s.part
	HDR
	HDR
	HDR
	HDR base.m_s.part
	HDR base.ml_s1.part
	HDR
	HDR
	HDR
	HDR
	HDR
	HDR base.ml_c.part
	HDR base.ml1_c.part
	HDR base.m_t.part
	HDR
	HDR base.l1o_s.part
	HDR base.l2o_s.part
	HDR base.l3o_s.part
	HDR base.l4o_s.part
	HDR base.o_s.part
	HDR base.o_c.part
	HDR base.o_t.part
]])
merge('evdev', [[
	base.hdr.part base.lists.part
	evdev.lists.part
	HDR evdev.m_k.part
	HDR base.l1_k.part
	HDR base.l_k.part
	HDR
	HDR base.ml_g.part
	HDR base.m_g.part
	HDR base.mlv_s.part
	HDR base.ml_s.part
	HDR base.ml1_s.part
	HDR
	HDR base.ml2_s.part
	HDR base.ml3_s.part
	HDR base.ml4_s.part
	HDR
	HDR
	HDR
	HDR evdev.m_s.part
	HDR
	HDR
	HDR
	HDR
	HDR
	HDR
	HDR base.ml_c.part
	HDR base.ml1_c.part
	HDR base.m_t.part
	HDR
	HDR base.l1o_s.part
	HDR base.l2o_s.part
	HDR base.l3o_s.part
	HDR base.l4o_s.part
	HDR base.o_s.part
	HDR base.o_c.part
	HDR base.o_t.part
]])

fetch 'git'
