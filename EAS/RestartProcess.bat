:: ---------------------------------------------------------------------------------
:: This script receives a process name passed as a parameter, and then kills all
:: instances of that process on the target server
:: 
:: Thom Rosario
:: thom_rosario@dell.com
:: 7.31.2013 -- v1.0
:: ---------------------------------------------------------------------------------

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set proc=%~1
:: this is how we grab the passed parameter

:: tasklist lists all the processes running
:: /FI filters for just the process we're looking for
:: find sets errorlevel to 0 if it finds what you're looking for
:: the loop keeps running until it doesn't find the process

:KillLoop
   tasklist /S %srvr% /FI "IMAGENAME eq %proc%" 2>NUL | find /I /N "%proc%">NUL
   if "%ERRORLEVEL%"=="0" (
      echo %proc% found running
      %kill% \\%srvr% %proc%
      timeout /t 1
      goto :KillLoop
   )
echo All %proc% processes stopped
goto :EOF
