@echo off
:: this is the launcher executed when someone types:
:: bitsadmin /transfer t http://triplecheck.de/launch %temp%\x.bat&%temp%\x.bat

:: Copyright TripleCheck (c) 2014
:: Author: Nuno Brito
:: Date: 2014-04-06
:: License terms: Careware License ( http://jaclaz.altervista.org/Projects/careware.html )

set drive=c:
set name=triplecheck
set folder=%drive%\%name%
set cabfile=triplecheck-recent.cab
set wget=%folder%\wget.exe
set shortcut=TripleCheck.lnk
set url=http://triplecheck.de/archive

:: first step, create the folder
mkdir %folder%

:: change to the related drive and folder
%drive%
cd\%name%

:: get our downloader in place
bitsadmin /transfer TripleCheck %url%/wget.exe %wget%


:: now get our triplecheck runtime
%wget% %url%/%cabfile%.zip %cabfile%.zip
ren %cabfile%.zip %cabfile%
expand %cabfile% -F:* %folder%
del %cabfile%

:: install the shortcut
%wget% -q %url%/misc/%shortcut%.zip %shortcut%.zip
ren %shortcut%.zip %shortcut%
copy %shortcut% "%UserProfile%\Desktop"\%shortcut%
del %shortcut%


:: do we have java installed?
:: test if we have java installed or not
"%JAVA_HOME%"\bin\java -version > nul 2>&1
if %ERRORLEVEL% == 0 goto end

:: no java found, let's download our own java version
wget %url%/java.zip java.cab
:: rename from .zip to .cab
ren java.zip java.cab
expand java.cab -F:* %folder%
del java.cab


:end
:: launch our software
echo opening explorer
explorer .

echo launching triplecheck
%folder%\triplecheck.exe

:: delete our temporary files
del %wget%
del %temp%\x.bat

