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
call RestartService.bat AutonomyContent AutonomyContent
call RestartService.bat AutonomyContent1 AutonomyContent1
call RestartService.bat AutonomyContent2 AutonomyContent2
call RestartService.bat AutonomyContent3 AutonomyContent3
call RestartService.bat AutonomyContent4 AutonomyContent4
call RestartService.bat AutonomyContent5 AutonomyContent5
call RestartService.bat AutonomyContent6 AutonomyContent6
call RestartService.bat AutonomyContent7 AutonomyContent7
call RestartService.bat AutonomyContent8 AutonomyContent8
call RestartService.bat AutonomyContent9 AutonomyContent9

set srvr=PMHAEASINDX01
call RestartService.bat AutonomyContent10 AutonomyContent10
call RestartService.bat AutonomyContent11 AutonomyContent11
call RestartService.bat AutonomyContent12 AutonomyContent12
call RestartService.bat AutonomyContent13 AutonomyContent13
call RestartService.bat AutonomyContent14 AutonomyContent14
call RestartService.bat AutonomyContent15 AutonomyContent15
call RestartService.bat AutonomyContent16 AutonomyContent16
call RestartService.bat AutonomyContent17 AutonomyContent17
call RestartService.bat AutonomyContent18 AutonomyContent18
call RestartService.bat AutonomyContent19 AutonomyContent19

set srvr=PMHAEASINDX02   
call RestartService.bat AutonomyContent20 AutonomyContent20
call RestartService.bat AutonomyContent21 AutonomyContent21
call RestartService.bat AutonomyContent22 AutonomyContent22
call RestartService.bat AutonomyContent23 AutonomyContent23
call RestartService.bat AutonomyContent24 AutonomyContent24
call RestartService.bat AutonomyContent25 AutonomyContent25
call RestartService.bat AutonomyContent26 AutonomyContent26
call RestartService.bat AutonomyContent27 AutonomyContent27
call RestartService.bat AutonomyContent28 AutonomyContent28
call RestartService.bat AutonomyContent29 AutonomyContent29

echo Finished restarting EAS Indexers
