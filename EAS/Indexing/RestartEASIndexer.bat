:: --------------------------------------------------------------
:: This script restarts the EAS indexer and relies on the Windows
:: SysInternals tool, pskill.exe.
:: http://technet.microsoft.com/en-us/sysinternals/bb896683.aspx
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: 8.07.2013 -- added cache cleanup
:: 7.31.2013 -- added two subroutines for easier maintainability
:: 7.30.2013 -- v1.0
:: --------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set kill=d:\ZANTAZ\pskill.exe

set srvc=EASIDOLIndexerService
set proc=IdolIndexerService.exe
call KillService.bat EASidolindexerService
call KillProcess.bat IdolIndexerService.exe
call KillProcess.bat kvoop.exe
call KillProcess.bat EASConverter.exe

echo Removing any leftover temp files
rd /Q /S d:\temp\render
mkdir d:\temp\render

echo - - = = S T A R T I N G   I N D E X E R = = - -
sc.exe start %srvc%
echo Finished restarting EAS Indexer
