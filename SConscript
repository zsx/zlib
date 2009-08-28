# vim: set ft=python

Import('env prefix')

env_libz = env.Clone(PDB='libz.pdb')
comps = "adler32 compress crc32 gzio uncompr deflate trees zutil inflate infback inftrees inffast".split()

OBJS=[x + env_libz['OBJSUFFIX'] for x in comps]

env_libz.Depends("adler32" + env_libz['OBJSUFFIX'], "zlib.h zconf.h".split())
env_libz.Depends("compress" + env_libz['OBJSUFFIX'], "zlib.h zconf.h".split())
env_libz.Depends("crc32" + env_libz['OBJSUFFIX'], "crc32.h zlib.h zconf.h".split())
env_libz.Depends("deflate" + env_libz['OBJSUFFIX'], "deflate.h zutil.h zlib.h zconf.h".split())
env_libz.Depends("example" + env_libz['OBJSUFFIX'], "zlib.h zconf.h".split())
env_libz.Depends("gzio" + env_libz['OBJSUFFIX'], "zutil.h zlib.h zconf.h".split())
env_libz.Depends("inffast" + env_libz['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h inflate.h inffast.h".split())
env_libz.Depends("inflate" + env_libz['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h inflate.h inffast.h".split())
env_libz.Depends("infback" + env_libz['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h inflate.h inffast.h".split())
env_libz.Depends("inftrees" + env_libz['OBJSUFFIX'], "zutil.h zlib.h zconf.h inftrees.h".split())
env_libz.Depends("minigzip" + env_libz['OBJSUFFIX'], "zlib.h zconf.h".split())
env_libz.Depends("trees" + env_libz['OBJSUFFIX'], "deflate.h zutil.h zlib.h zconf.h trees.h".split())
env_libz.Depends("uncompr" + env_libz['OBJSUFFIX'], "zlib.h zconf.h".split())
env_libz.Depends("zutil" + env_libz['OBJSUFFIX'], "zutil.h zlib.h zconf.h".split())

for o in comps:
	env_libz.SharedObject(o + env_libz['OBJSUFFIX'], o + ".c") 

dll_name = 'libz' + env_libz['LIB_SUFFIX']
dll_full_name=dll_name + env_libz['SHLIBSUFFIX']
dll = env_libz.SharedLibrary(target=[dll_name, 'libz.lib'], source=OBJS + ['win32/zlib.def',], CFLAGS='/LDd')

env_libz['DOT_IN_SUBS'] = {'@VERSION@': '1.2.4beta1',
					  '@prefix@': prefix,
 					  '@exec_prefix@': '${prefix}/bin',
					  '@libdir@': '${prefix}/lib',
					  '@includedir@': '${prefix}/include'}

env_libz.DotIn('zlib.pc', 'zlib.pc.in')

ipc = env_libz.Install(prefix + '/lib/pkgconfig', 'zlib.pc')
ih = env_libz.Install(prefix + '/include', ['zlib.h', 'zconf.h'])
idll = env_libz.Install(prefix + '/bin', dll_full_name)
ilib = env_libz.Install(prefix + '/lib', 'libz.lib')
ilist = [ipc, ih, idll, ilib]

if ARGUMENTS.get('debug', 0):
	ipdb = env_libz.Install(prefix + '/pdb', env_libz['PDB'])
	ilist += ipdb

Alias('install', ilist)

env_libz.Depends('install', [dll, 'zconf.h', 'zlib.h', 'zlib.pc'])
