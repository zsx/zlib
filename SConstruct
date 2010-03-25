# vim: ft=python expandtab

import os
from site_init import *

opts = Variables()
opts.Add(PathVariable('PREFIX', 'InstallDevation prefix', os.path.expanduser('~/FOSS'), PathVariable.PathIsDirCreate))
opts.Add(BoolVariable('DEBUG', 'Build with Debugging information', 0))
opts.Add(PathVariable('PERL', 'Path to the executable perl', r'C:\Perl\bin\perl.exe', PathVariable.PathIsFile))
opts.Add(BoolVariable('WITH_OSMSVCRT', 'Link with the os supplied msvcrt.dll instead of the one supplied by the compiler (msvcr90.dll, for instance)', 0))

env = Environment(variables = opts,
                  ENV=os.environ, tools = ['default', GBuilder], PDB = 'libz.pdb')

Initialize(env)

env.Append(CPPPATH=['#'])
env.Append(CFLAGS=env['DEBUG_CFLAGS'])
env.Append(CPPDEFINES=env['DEBUG_CPPDEFINES'])


if env['WITH_OSMSVCRT']:
    env['LIB_SUFFIX'] = '1'
    #env.Append(CPPDEFINES=['MSVCRT_COMPAT_STAT', 'MSVCRT_COMPAT_SPRINTF'])

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

dll_name = 'zlib' + env['LIB_SUFFIX']
dll_full_name=dll_name + env['SHLIBSUFFIX']
env.Append(CFLAGS = env['DEBUG_CFLAGS'])
env.RES('win32/zlib1.res', 'win32/zlib1.rc')
dll = env.SharedLibrary(target=[dll_name, 'z.lib'], source=OBJS + ['win32/zlib.def', 'win32/zlib1.res'])

env.AddPostAction(dll, 'mt.exe -nologo -manifest ${TARGET}.manifest -outputresource:$TARGET;2')

version='1.2.4'
env['DOT_IN_SUBS'] = {'@VERSION@': version,
					  '@prefix@': env['PREFIX'],
 					  '@exec_prefix@': '${prefix}/bin',
					  '@libdir@': '${prefix}/lib',
					  '@includedir@': '${prefix}/include'}

env.DotIn('zlib.pc', 'zlib.pc.in')

InstallRun('$PREFIX/bin', dll_full_name, env)
env['DOT_IN_SUBS']['@DLLS@'] = generate_file_element(dll_full_name, r'bin', env)
InstallDev('$PREFIX/lib/pkgconfig', 'zlib.pc', env)
env['DOT_IN_SUBS']['@PCS@'] = generate_file_element('zlib.pc', r'lib\\pkgconfig', env)
InstallDev('$PREFIX/include', ['zlib.h', 'zconf.h'], env)
env['DOT_IN_SUBS']['@HEADERS@'] = generate_file_element(['zlib.h', 'zconf.h'], r'include', env)
InstallDev('$PREFIX/lib', 'z.lib', env)
InstallDevAs('$PREFIX/lib/libz.lib', 'z.lib', env)
env['DOT_IN_SUBS']['@LIBS@'] = generate_file_element(['libz.lib', 'z.lib'], r'lib', env)

if env['DEBUG']:
    InstallDev('$PREFIX/pdb', env['PDB'], env)
    env['DOT_IN_SUBS']['@PDBS@'] = generate_file_element(env['PDB'], r'pdb', env)

env.DotIn('zlibdev.wxs', 'zlibdev.wxs.in')
env.DotIn('zlibrun.wxs', 'zlibrun.wxs.in')

env['PACKAGE_NAME'] = 'zlib'
env['PACKAGE_VERSION'] = version
DumpInstalledFiles(env)

InstallRun('$PREFIX/wxs', 'zlibrun.wxs', env)
InstallDev('$PREFIX/wxs', 'zlibdev.wxs', env)
#env.Tool('wixtool', '#..')
#env.WiX('zlibrun.msm', ['zlibrun.wxs'])
#env.WiX('zlibdev.msm', ['zlibdev.wxs'])
