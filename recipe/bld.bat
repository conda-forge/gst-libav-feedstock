@ECHO ON

:: set pkg-config path so that host deps can be found
:: (set as env var so it's used by both meson and during build with g-ir-scanner)
set "PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig;%BUILD_PREFIX%\Library\lib\pkgconfig"

copy %LIBRARY_LIB%\libmp3lame.lib %LIBRARY_LIB%\mp3lame.lib
copy %LIBRARY_LIB%\libx265.lib %LIBRARY_LIB%\x265.lib
copy %LIBRARY_LIB%\libbz2.lib %LIBRARY_LIB%\bz2.lib
copy %LIBRARY_LIB%\libxml2.lib %LIBRARY_LIB%\xml2.lib

:: get mixed path (forward slash) form of prefix so host prefix replacement works
set "LIBRARY_PREFIX_M=%LIBRARY_PREFIX:\=/%"

%BUILD_PREFIX%\Scripts\meson.exe setup builddir --wrap-mode=nofallback --buildtype=release --prefix=%LIBRARY_PREFIX_M% --backend=ninja
if errorlevel 1 exit 1

ninja -v -C builddir -j %CPU_COUNT%
if errorlevel 1 exit 1

ninja -C builddir install -j %CPU_COUNT%
if errorlevel 1 exit 1

del %LIBRARY_PREFIX%\bin\*.pdb
del %LIBRARY_LIB%\mp3lame.lib
del %LIBRARY_LIB%\x265.lib
del %LIBRARY_LIB%\bz2.lib
del %LIBRARY_LIB%\xml2.lib
