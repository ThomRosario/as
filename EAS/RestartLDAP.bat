:: ---------------------------------------------------------------------------------
:: This script will restart LDAP on MSH00296.
:: 
:: Thom Rosario
:: thom_rosario@dell.com
:: 4.21.2014 -- v1.0
:: ---------------------------------------------------------------------------------

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set srvr=MSH00296
set srvc=idsslapd-db2admin
set proc=ibmslapd.exe

tasklist /S %srvr% /FI "IMAGENAME eq %proc%" 2>NUL | find /I /N "%proc%">NUL
if "%ERRORLEVEL%"=="0" (
	echo "Stopping LDAP"
	sc.exe \\%srvr% stop %srvc%
) 
echo "Starting LDAP"
sc.exe \\%srvr% start %srvc%