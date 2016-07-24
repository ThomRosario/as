:: ---------------------------------------------------------------------------------
:: This script restarts the EAS indexers
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: 9.05.2013 -- v1.0
:: ---------------------------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set srvr=WODAEAS03
echo Processing server:  %srvr%
call StartService.bat AutonomyContent AutonomyContent.exe
call StartService.bat AutonomyContent1 AutonomyContent1.exe
call StartService.bat AutonomyContent2 AutonomyContent2.exe
call StartService.bat AutonomyContent3 AutonomyContent3.exe
call StartService.bat AutonomyContent4 AutonomyContent4.exe
call StartService.bat AutonomyContent5 AutonomyContent5.exe
call StartService.bat AutonomyContent6 AutonomyContent6.exe
call StartService.bat AutonomyContent7 AutonomyContent7.exe
call StartService.bat AutonomyContent8 AutonomyContent8.exe
call StartService.bat AutonomyContent9 AutonomyContent9.exe
call StartService.bat AutonomyDIH AutonomyDIH.exe
call StartService.bat AutonomyDAH AutonomyDAH.exe
call StartService.bat AutonomyDISH AutonomyDISH.exe

set srvr=PMHAEASINDX01
echo Processing server:  %srvr%
call StartService.bat AutonomyContent10 AutonomyContent10.exe
call StartService.bat AutonomyContent11 AutonomyContent11.exe
call StartService.bat AutonomyContent12 AutonomyContent12.exe
call StartService.bat AutonomyContent13 AutonomyContent13.exe
call StartService.bat AutonomyContent14 AutonomyContent14.exe
call StartService.bat AutonomyContent15 AutonomyContent15.exe
call StartService.bat AutonomyContent16 AutonomyContent16.exe
call StartService.bat AutonomyContent17 AutonomyContent17.exe
call StartService.bat AutonomyContent18 AutonomyContent18.exe
call StartService.bat AutonomyContent19 AutonomyContent19.exe

set srvr=PMHAEASINDX02   
echo Processing server:  %srvr%
call StartService.bat AutonomyContent20 AutonomyContent20.exe
call StartService.bat AutonomyContent21 AutonomyContent21.exe
call StartService.bat AutonomyContent22 AutonomyContent22.exe
call StartService.bat AutonomyContent23 AutonomyContent23.exe
call StartService.bat AutonomyContent24 AutonomyContent24.exe
call StartService.bat AutonomyContent25 AutonomyContent25.exe
call StartService.bat AutonomyContent26 AutonomyContent26.exe
call StartService.bat AutonomyContent27 AutonomyContent27.exe
call StartService.bat AutonomyContent28 AutonomyContent28.exe
call StartService.bat AutonomyContent29 AutonomyContent29.exe

echo Finished restarting EAS Indexers
