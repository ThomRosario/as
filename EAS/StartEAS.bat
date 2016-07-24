:: ---------------------------------------------------------------------------------
:: This script starts EAS 
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: ---------------------------------------------------------------------------------
echo - - = = S T A R T I N G   E A S = = - -
set srvc=EASService

sc.exe \\wodaeas01 start %srvc%
echo Waiting for EAS to start on the parent server
timeout /t 120
echo Starting EAS on WODAEAS02
sc.exe \\wodaeas02 start %srvc%
echo Starting EAS on WODAEAS06
sc.exe \\wodaeas06 start %srvc%
echo Starting EAS on WODAEAS07
sc.exe \\wodaeas07 start %srvc%
echo Starting EAS on WODAEAS08
sc.exe \\wodaeas08 start %srvc%
echo Starting EAS on PMHAEASARCH01
sc.exe \\pmhaeasarch01 start %srvc%
echo Starting EAS on PMHAEASARCH02
sc.exe \\pmhaeasarch02 start %srvc%
echo Starting EAS on PMHAEASARCH03
sc.exe \\pmhaeasarch03 start %srvc%
echo Starting EAS on PMHAEASARCH04
sc.exe \\pmhaeasarch04 start %srvc%
echo Starting EAS on PMHAEASARCH05
sc.exe \\pmhaeasarch05 start %srvc%

echo Starting EAS on PMHEXCEASTMP01
sc.exe \\PMHEXCEASTMP01 start %srvc%
echo Starting EAS on PMHEXCEASTMP02
sc.exe \\PMHEXCEASTMP02 start %srvc%
echo Starting EAS on PMHEXCEASTMP03
sc.exe \\PMHEXCEASTMP03 start %srvc%
echo Starting EAS on PMHEXCEASTMP04
sc.exe \\PMHEXCEASTMP04 start %srvc%
echo Starting EAS on PMHEXCEASTMP05
sc.exe \\PMHEXCEASTMP05 start %srvc%
echo Starting EAS on PMHEXCEASTMP06
sc.exe \\PMHEXCEASTMP06 start %srvc%
echo Starting EAS on PMHEXCEASTMP07
sc.exe \\PMHEXCEASTMP07 start %srvc%
echo Starting EAS on PMHEXCEASTMP08
sc.exe \\PMHEXCEASTMP08 start %srvc%
echo Starting EAS on PMHEXCEASTMP09
sc.exe \\PMHEXCEASTMP09 start %srvc%
echo Finished starting EAS

:: Add line here to remove \\wodaeas01\d$\EAS_Lock.txt