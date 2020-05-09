@echo off

set cwd=%~dp0

set USERPROFILE=%cwd%etc
set COMSPEC=%SystemRoot%\system32\cmd.exe
set PATH=%cwd%bin;%cwd%bin\dxgettext;%cwd%bin\gnugettext;%PATH%

busybox bash %cwd%etc\update.sh %cwd%

cd %cwd%

pause
