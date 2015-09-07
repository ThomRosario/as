:: --------------------------------------------------------------
:: This script stops the EAS indexer and relies on the Windows
:: SysInternals tool, pskill.exe.
:: http://technet.microsoft.com/en-us/sysinternals/bb896683.aspx
:: 
:: Thom Rosario
:: thom_rosario@dell.com
:: --------------------------------------------------------------
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set kill=d:\ZANTAZ\pskill.exe

set srvc=EASIDOLIndexerService
set proc=IdolIndexerService.exe
call KillService.bat EASIdolIndexerService
call KillProcess.bat IdolIndexerService.exe
call KillProcess.bat EASConverter.exe
call KillProcess.bat kvoop.exe

echo Removing any leftover temp files
rd /Q /S d:\temp\render
mkdir d:\temp\render
