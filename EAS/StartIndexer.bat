:: --------------------------------------------------------------
:: This script restarts the EAS indexer and relies on the Windows
:: SysInternals tool, pskill.exe.
:: http://technet.microsoft.com/en-us/sysinternals/bb896683.aspx
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: --------------------------------------------------------------
echo - - = = S T A R T I N G   I N D E X E R = = - -
set srvc=EASIDOLIndexerService
sc.exe start %srvc%
echo Finished restarting EAS Indexer
