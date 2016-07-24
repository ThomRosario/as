:: ----------------------------------------------------------------------------
:: This script alerts the messaging team if any of the content engines are down
:: 
:: Thom Rosario
:: 1.17.2014; v1.1 -- added check to send only once/day
:: 1.17.2014; v1.0
:: ----------------------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set tempDate=%DATE:/=-%
set tempDate=%tempDate: =-%
set today=%tempDate%.txt

:: Set some variables for use in sending the report
set to=-to thom_rosario@email.com
set from=-f IDOLStatus@someplace.net
set subj=-subject "IDOL Indexer Content Engine Down"
set smtp=-server smtp.someplace.net
set blat="D:\Program Files\blat\blat.exe"
set statusFile="D:\Program Files\Monitoring\IDOL\status.txt"
set serviceDown=0

echo Current IDOL Engine status: > %statusFile%

set srvr=WODAEAS03
echo Checking content engines on:  %srvr%
call CheckService.bat AutonomyContent AutonomyContent.exe
call CheckService.bat AutonomyContent1 AutonomyContent1.exe
call CheckService.bat AutonomyContent2 AutonomyContent2.exe
call CheckService.bat AutonomyContent3 AutonomyContent3.exe
call CheckService.bat AutonomyContent4 AutonomyContent4.exe
call CheckService.bat AutonomyContent5 AutonomyContent5.exe
call CheckService.bat AutonomyContent6 AutonomyContent6.exe
call CheckService.bat AutonomyContent7 AutonomyContent7.exe
call CheckService.bat AutonomyContent8 AutonomyContent8.exe
call CheckService.bat AutonomyContent9 AutonomyContent9.exe
call CheckService.bat AutonomyDIH AutonomyDIH.exe
call CheckService.bat AutonomyDAH AutonomyDAH.exe
call CheckService.bat AutonomyDISH AutonomyDISH.exe

set srvr=PMHAEASINDX01
echo Checking content engines on:  %srvr%
call CheckService.bat AutonomyContent10 AutonomyContent10.exe
call CheckService.bat AutonomyContent11 AutonomyContent11.exe
call CheckService.bat AutonomyContent12 AutonomyContent12.exe
call CheckService.bat AutonomyContent13 AutonomyContent13.exe
call CheckService.bat AutonomyContent14 AutonomyContent14.exe
call CheckService.bat AutonomyContent15 AutonomyContent15.exe
call CheckService.bat AutonomyContent16 AutonomyContent16.exe
call CheckService.bat AutonomyContent17 AutonomyContent17.exe
call CheckService.bat AutonomyContent18 AutonomyContent18.exe
call CheckService.bat AutonomyContent19 AutonomyContent19.exe

set srvr=PMHAEASINDX02   
echo Checking content engines on:  %srvr%
call CheckService.bat AutonomyContent20 AutonomyContent20.exe
call CheckService.bat AutonomyContent21 AutonomyContent21.exe
call CheckService.bat AutonomyContent22 AutonomyContent22.exe
call CheckService.bat AutonomyContent23 AutonomyContent23.exe
call CheckService.bat AutonomyContent24 AutonomyContent24.exe
call CheckService.bat AutonomyContent25 AutonomyContent25.exe
call CheckService.bat AutonomyContent26 AutonomyContent26.exe
call CheckService.bat AutonomyContent27 AutonomyContent27.exe
call CheckService.bat AutonomyContent28 AutonomyContent28.exe
call CheckService.bat AutonomyContent29 AutonomyContent29.exe

echo Finished checking all content engines

if "%serviceDown%"=="1" (
	if NOT exist %today% (
		echo 1 > %today%
		%blat% %statusFile% %to% %smtp% %from% %subj%
	)
)
del %statusFile%