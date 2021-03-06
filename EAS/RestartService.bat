:: ---------------------------------------------------------------------------------
:: This script relies on the global variables of the script that called it.  It
:: issues a polite "stop" command to the service if it's running, and then issues
:: a "start" command.
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: 9.05.2013 -- v1.0
:: ---------------------------------------------------------------------------------

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set srvc=%~1
set proc=%~2

tasklist /S %srvr% /FI "IMAGENAME eq %proc%" 2>NUL | find /I /N "%proc%">NUL
if "%ERRORLEVEL%"=="0" (
	sc.exe \\%srvr% stop %srvc%
) 
sc.exe \\%srvr% start %srvc%
