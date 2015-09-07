:: ---------------------------------------------------------------------------------
:: This script restarts the EAS indexers
:: 
:: Thom Rosario
:: thom_rosario@dell.com
:: 9.05.2013 -- v1.0
:: ---------------------------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set srvr=WODAEAS03
call StartService.bat AutonomyContent AutonomyContent
call StartService.bat AutonomyContent1 AutonomyContent1
call StartService.bat AutonomyContent2 AutonomyContent2
call StartService.bat AutonomyContent3 AutonomyContent3
call StartService.bat AutonomyContent4 AutonomyContent4
call StartService.bat AutonomyContent5 AutonomyContent5
call StartService.bat AutonomyContent6 AutonomyContent6
call StartService.bat AutonomyContent7 AutonomyContent7
call StartService.bat AutonomyContent8 AutonomyContent8
call StartService.bat AutonomyContent9 AutonomyContent9

set srvr=PMHAEASINDX01
call StartService.bat AutonomyContent10 AutonomyContent10
call StartService.bat AutonomyContent11 AutonomyContent11
call StartService.bat AutonomyContent12 AutonomyContent12
call StartService.bat AutonomyContent13 AutonomyContent13
call StartService.bat AutonomyContent14 AutonomyContent14
call StartService.bat AutonomyContent15 AutonomyContent15
call StartService.bat AutonomyContent16 AutonomyContent16
call StartService.bat AutonomyContent17 AutonomyContent17
call StartService.bat AutonomyContent18 AutonomyContent18
call StartService.bat AutonomyContent19 AutonomyContent19

set srvr=PMHAEASINDX02   
call StartService.bat AutonomyContent20 AutonomyContent20
call StartService.bat AutonomyContent21 AutonomyContent21
call StartService.bat AutonomyContent22 AutonomyContent22
call StartService.bat AutonomyContent23 AutonomyContent23
call StartService.bat AutonomyContent24 AutonomyContent24
call StartService.bat AutonomyContent25 AutonomyContent25
call StartService.bat AutonomyContent26 AutonomyContent26
call StartService.bat AutonomyContent27 AutonomyContent27
call StartService.bat AutonomyContent28 AutonomyContent28
call StartService.bat AutonomyContent29 AutonomyContent29

echo Finished restarting EAS Indexers
