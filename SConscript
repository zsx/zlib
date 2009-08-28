# vim: set ft=python

Import('env prefix')

env['PDB']='libz.pdb'
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

dll_name = 'libz' + env['LIB_SUFFIX']
dll_full_name=dll_name + env['SHLIBSUFFIX']
dll = env.SharedLibrary(target=[dll_name, 'libz.lib'], source=OBJS + ['win32/zlib.def',], CFLAGS='/LDd')

env['DOT_IN_SUBS'] = {'@VERSION@': '1.2.4beta1',
					  '@prefix@': prefix,
 					  '@exec_prefix@': '${prefix}/bin',
					  '@libdir@': '${prefix}/lib',
					  '@includedir@': '${prefix}/include'}

env.DotIn('zlib.pc', 'zlib.pc.in')

ipc = env.Install(prefix + '/lib/pkgconfig', 'zlib.pc')
ih = env.Install(prefix + '/include', ['zlib.h', 'zconf.h'])
idll = env.Install(prefix + '/bin', dll_full_name)
ilib = env.Install(prefix + '/lib', 'libz.lib')
ilist = [ipc, ih, idll, ilib]

if ARGUMENTS.get('debug', 0):
	ipdb = env.Install(prefix + '/pdb', env['PDB'])
	ilist += ipdb

Alias('install', ilist)

env.Depends('install', [dll, 'zconf.h', 'zlib.h', 'zlib.pc'])
