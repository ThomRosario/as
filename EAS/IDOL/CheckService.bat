:: ----------------------------------------------------------------------------
:: This script relies on the global variables of the script that called it.  It
:: checks to see if the passed process is running, and if it isn't sets a flag
:: and makes note of which engine isn't running.
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: 1.17.2014 -- v1.0
:: ----------------------------------------------------------------------------

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set srvc=%~1
set proc=%~2
tasklist /S %srvr% /FI "IMAGENAME eq %proc%" 2>NUL | find /I /N "%proc%">NUL
if "%ERRORLEVEL%"=="1" (
	echo %proc% not running; issuing start command now. >> %statusFile%
	sc.exe \\%srvr% start %srvc%
	set serviceDown=1
	echo %srvc% started
) 