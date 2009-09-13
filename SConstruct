# vim: ft=python expandtab

import os
from site_init import GBuilder, Initialize

opts = Variables()
opts.Add(PathVariable('PREFIX', 'Installation prefix', os.path.expanduser('~/FOSS'), PathVariable.PathIsDirCreate))
opts.Add(BoolVariable('DEBUG', 'Build with Debugging information', 0))
opts.Add(PathVariable('PERL', 'Path to the executable perl', r'C:\Perl\bin\perl.exe', PathVariable.PathIsFile))

env = Environment(variables = opts,
                  ENV=os.environ, tools = ['default', GBuilder], PDB = 'libz.pdb')

Initialize(env)

Initialize(env)
env.Append(CPPPATH=['#'])
env.Append(CFLAGS=env['DEBUG_CFLAGS'])
env.Append(CPPDEFINES=env['DEBUG_CPPDEFINES'])


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
env.Append(CFLAGS = env['DEBUG_CFLAGS'])
env.RES('win32/zlib1.res', 'win32/zlib1.rc')
dll = env.SharedLibrary(target=[dll_name, 'z.lib'], source=OBJS + ['win32/zlib.def', 'win32/zlib1.res'])

env.AddPostAction(dll, 'mt.exe -nologo -manifest ${TARGET}.manifest -outputresource:$TARGET;2')

env['DOT_IN_SUBS'] = {'@VERSION@': '1.2.4beta1',
					  '@prefix@': env['PREFIX'],
 					  '@exec_prefix@': '${prefix}/bin',
					  '@libdir@': '${prefix}/lib',
					  '@includedir@': '${prefix}/include'}

env.DotIn('zlib.pc', 'zlib.pc.in')

env.Alias('install', env.Install('$PREFIX/lib/pkgconfig', 'zlib.pc'))
env.Alias('install', env.Install('$PREFIX/include', ['zlib.h', 'zconf.h']))
env.Alias('install', env.Install('$PREFIX/bin', dll_full_name))
env.Alias('install', env.Install('$PREFIX/lib', 'z.lib'))

if env['DEBUG']:
	env.Alias('install', env.Install('$PREFIX/pdb', env['PDB']))
