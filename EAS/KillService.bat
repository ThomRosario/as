:: ---------------------------------------------------------------------------------
:: This script relies on the global variables of the script that called it.  It
:: issues a polite "stop" command to the service and returns control to the calling
:: script.
:: 
:: Thom Rosario
:: thom_rosario@dell.com
:: 7.31.2013 -- v1.0
:: ---------------------------------------------------------------------------------

@echo off
::SETLOCAL ENABLEDELAYEDEXPANSION
set srvc=%~1

echo - - = = STOPPING %srvr% = = - -
sc.exe \\%srvr% stop %srvc%
timeout /t 3
echo %srvc% stopped on %srvr%
goto :EOF
