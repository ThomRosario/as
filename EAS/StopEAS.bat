:: ---------------------------------------------------------------------------------
:: This script stops EAS and relies on the Windows
:: SysInternals tool, d:\ZANTAZ\pskill.exe.
:: http://technet.microsoft.com/en-us/sysinternals/bb896683.aspx
:: 
:: Thom Rosario
:: thom_rosario@email.com
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

set srvr=PMHEXCEASTMP01   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP02   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP03   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP04   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP05   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP06   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP07   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP08   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=PMHEXCEASTMP09   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

set srvr=WODAEAS01   
call KillService.bat EASService
call KillProcess.bat eassrvr.exe
call KillProcess.bat easviews.exe

:: Add text here to write \\wodaeas01\d$\EAS_Lock.txt
echo. 2>\\wodaeas01\d$\EAS_Lock.txt