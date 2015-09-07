:: ---------------------------------------------------------------------------------
:: This script restarts the FootPrints web server's service, Tomcat7.
:: It's scheduled to run as a Windows Scheduled Task at 1am every morning.
::  
:: Thom Rosario
:: thom.rosario@jhuapl.edu
:: 8.05.2015 -- v1.0
:: ---------------------------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set proc=Tomcat7.exe
set kill=c:\Scripts\pskill.exe
set tcbin="C:\Program Files\Apache Software Foundation\Tomcat 7.0\bin"
c: 
cd %tcbin%
echo "Stopping Tomcat" via //SS//
Tomcat7.exe //SS//
echo Now trying net stop Tomcat7
net stop Tomcat7
timeout 30

:KillLoop
   tasklist /FI "IMAGENAME eq %proc%" 2>NUL | find /I /N "%proc%">NUL
   if "%ERRORLEVEL%"=="0" (
      echo %proc% found running
      %kill% %proc%
      timeout /t 1
      goto :KillLoop
   )
echo All %proc% processes stopped

:StartTomcat
echo Starting Tomcat
net start Tomcat7
