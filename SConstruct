# vim: set ft=python

import os

env = Environment()

comps = "adler32 compress crc32 gzio uncompr deflate trees zutil inflate infback inftrees inffast".split()

OBJS=[x + env['OBJSUFFIX'] for x in comps]

env.Depends("adler32" + env['OBJSUFFIX'], "zlib.h zconf.h".split())
env.Depends("compress" + env['OBJSUFFIX'], "zlib.h zconf.h".split())
env.Depends("crc32" + env['OBJSUFFIX'], "crc32.h zlib.h zconf.h".split())
env.Depends("deflate" + env['OBJSUFFIX'], "deflate.h zutil.h zlib.h zconf.h".split())
env.Depends("example" + env['OBJSUFFIX'], "zlib.h zconf.h".split())
env.Depends("gzio" + env['OBJSUFFIX'], "zutil.h zlib.h zconf.h".split())
env.Depends("inffast" + env['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h inflate.h inffast.h".split())
env.Depends("inflate" + env['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h inflate.h inffast.h".split())
env.Depends("infback" + env['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h inflate.h inffast.h".split())
env.Depends("inftrees" + env['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h".split())
env.Depends("minigzip" + env['OBJSUFFIX'], "zlib.h zconf.h".split())
env.Depends("trees" + env['OBJSUFFIX'], "deflate.h zutil.h zlib.h zconf.h trees.h".split())
env.Depends("uncompr" + env['OBJSUFFIX'], "zlib.h zconf.h".split())
env.Depends("zutil" + env['OBJSUFFIX'], "zutil.h zlib.h zconf.h".split())

for o in comps:
	env.SharedObject(o + env['OBJSUFFIX'], o + ".c") 

dll_name = 'libz-msvcrt90'
dll_full_name=dll_name + env['SHLIBSUFFIX']
dll = env.SharedLibrary(target=[dll_name, 'libz.lib'], source=OBJS + ['win32/zlib.def',])

def dot_in_fun(target, source, env):
	if not env.has_key('DOT_IN_SUBS'):
		raise Exception("DOT_IN_SUBS is not set in env")
	t = file(target[0].rstr(), 'w')
	s = file(source[0].rstr(), 'r')
	for l in s.readlines():
		for k, v in env['DOT_IN_SUBS'].items():
			l = l.replace(k, v)
		t.write(l)
	t.close()
	s.close()

dot_in_processor = Builder(action= dot_in_fun, src_suffix = '.in')
prefix=os.path.expanduser(r'~\FOSS\Debug')
env['DOT_IN_SUBS'] = {'@VERSION@': '1.2.4beta1',
					  '@prefix@': prefix,
 					  '@exec_prefix@': '${prefix}/bin',
					  '@libdir@': '${prefix}/lib',
					  '@includedir@': '${prefix}/include'}
env.Append(BUILDERS={'DotIn': dot_in_processor})

env.DotIn('zlib.pc', 'zlib.pc.in')

ip = env.Install(prefix + '/lib/pkgconfig', 'zlib.pc')
ih = env.Install(prefix + '/include', ['zlib.h', 'zconf.h'])
idll = env.Install(prefix + '/bin', dll_full_name)
ilib = env.Install(prefix + '/lib', 'libz.lib')

Alias('install', [ip, ih, idll, ilib])

env.Depends('install', [dll, 'zconf.h', 'zlib.h', 'zlib.pc'])