:: ---------------------------------------------------------------------------------
:: This script restarts EAS and relies on the Windows
:: SysInternals tool, d:\ZANTAZ\pskill.exe.
:: http://technet.microsoft.com/en-us/sysinternals/bb896683.aspx
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: 8.07.2013 -- added KillNotes.bat to get a clean restart on Domino Journaling
:: 7.31.2013 -- created killprocess.bat and killservice.bat subroutines for cleaner,
::              more maintainable code
:: 7.30.2013 -- added variables for better maintainability
::           -- added comments to explain the process
:: 7.29.2013 -- v1.0
:: ---------------------------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set kill=d:\ZANTAZ\pskill.exe

set srvr=WODAEAS02
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe
call KillNotes.bat

set srvr=WODAEAS06
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=WODAEAS07   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=WODAEAS08
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHAEASARCH01   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHAEASARCH02
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHAEASARCH03
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHAEASARCH04   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHAEASARCH05   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=WODAEAS01   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

echo - - = = S T A R T I N G   E A S = = - -
sc.exe \\wodaeas01 start %srvc%
echo Waiting for EAS to start on the parent server
timeout /t 120
echo Starting EAS on WODAEAS02
sc.exe \\wodaeas02 start %srvc%
echo Starting EAS on WODAEAS06
sc.exe \\wodaeas06 start %srvc%
echo Starting EAS on WODAEAS07
sc.exe \\wodaeas07 start %srvc%
echo Starting EAS on WODAEAS08
sc.exe \\wodaeas08 start %srvc%
echo Starting EAS on PMHAEASARCH01
sc.exe \\pmhaeasarch01 start %srvc%
echo Starting EAS on PMHAEASARCH02
sc.exe \\pmhaeasarch02 start %srvc%
echo Starting EAS on PMHAEASARCH03
sc.exe \\pmhaeasarch03 start %srvc%
echo Starting EAS on PMHAEASARCH04
sc.exe \\pmhaeasarch04 start %srvc%
echo Starting EAS on PMHAEASARCH05
sc.exe \\pmhaeasarch05 start %srvc%
echo Finished restarting EAS