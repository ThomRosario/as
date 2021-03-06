:: ---------------------------------------------------------------------------------
:: This script relies on the global variables of the script that called it.  It
:: issues a polite "stop" command to the service if it's running, and then issues
:: a "start" command.
:: 
:: Thom Rosario
:: 9.05.2013 -- v1.0
:: ---------------------------------------------------------------------------------

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set srvc=%~1
set proc=%~2
tasklist /S %srvr% /FI "IMAGENAME eq %proc%" 2>NUL | find /I /N "%proc%">NUL
if "%ERRORLEVEL%"=="1" (
	echo %proc% not running; starting now
	sc.exe \\%srvr% start %srvc%
	echo %srvc% started
) 
