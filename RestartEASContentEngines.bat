:: ---------------------------------------------------------------------------------
:: This script restarts the EAS indexers
:: 
:: Thom Rosario
:: 9.05.2013 -- v1.0
:: ---------------------------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set srvr=WODAEAS03
echo Restarting services on server:  %srvr%
call RestartService.bat AutonomyContent AutonomyContent.exe
call RestartService.bat AutonomyContent1 AutonomyContent1.exe
call RestartService.bat AutonomyContent2 AutonomyContent2.exe
call RestartService.bat AutonomyContent3 AutonomyContent3.exe
call RestartService.bat AutonomyContent4 AutonomyContent4.exe
call RestartService.bat AutonomyContent5 AutonomyContent5.exe
call RestartService.bat AutonomyContent6 AutonomyContent6.exe
call RestartService.bat AutonomyContent7 AutonomyContent7.exe
call RestartService.bat AutonomyContent8 AutonomyContent8.exe
call RestartService.bat AutonomyContent9 AutonomyContent9.exe

set srvr=PMHAEASINDX01
echo Restarting services on server:  %srvr%
call RestartService.bat AutonomyContent10 AutonomyContent10.exe
call RestartService.bat AutonomyContent11 AutonomyContent11.exe
call RestartService.bat AutonomyContent12 AutonomyContent12.exe
call RestartService.bat AutonomyContent13 AutonomyContent13.exe
call RestartService.bat AutonomyContent14 AutonomyContent14.exe
call RestartService.bat AutonomyContent15 AutonomyContent15.exe
call RestartService.bat AutonomyContent16 AutonomyContent16.exe
call RestartService.bat AutonomyContent17 AutonomyContent17.exe
call RestartService.bat AutonomyContent18 AutonomyContent18.exe
call RestartService.bat AutonomyContent19 AutonomyContent19.exe

set srvr=PMHAEASINDX02   
echo Restarting services on server:  %srvr%
call RestartService.bat AutonomyContent20 AutonomyContent20.exe
call RestartService.bat AutonomyContent21 AutonomyContent21.exe
call RestartService.bat AutonomyContent22 AutonomyContent22.exe
call RestartService.bat AutonomyContent23 AutonomyContent23.exe
call RestartService.bat AutonomyContent24 AutonomyContent24.exe
call RestartService.bat AutonomyContent25 AutonomyContent25.exe
call RestartService.bat AutonomyContent26 AutonomyContent26.exe
call RestartService.bat AutonomyContent27 AutonomyContent27.exe
call RestartService.bat AutonomyContent28 AutonomyContent28.exe
call RestartService.bat AutonomyContent29 AutonomyContent29.exe

echo Finished restarting EAS Indexers
