@echo off
set RELEASE_PATH=%~dp0\..\oah\Win32\Release
pkg-config --modversion %RELEASE_PATH%\lib\pkgconfig\zlib.pc > libver.tmp || goto error
set /P LIBVER= < libver.tmp
del libver.tmp

nmake /nologo version=%LIBVER% release_path=%RELEASE_PATH% %*

goto:eof
:error
echo Couldn't start build process... are pkg-config in your PATH and/or have you compiled z.sln with OAH_BUILD_OUTPUT cleared!??