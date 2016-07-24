:: ---------------------------------------------------------------------------------
:: This script calls the Notes crash tool (nsd.exe) to kill any open Notes tasks
:: so that the restart of EAS comes up clean
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: 8.07.2013 -- v1.0
:: ---------------------------------------------------------------------------------

d:
cd \"Program Files"\lotus\notes
nsd.exe -kill
cd \ZANTAZ
