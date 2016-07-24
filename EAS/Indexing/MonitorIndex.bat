:: ----------------------------------------------------------------------------
:: This script runs a sql query via the bcp.exe program and sends an email to 
:: the messaging team if the number of messages in the indexing queue is 
:: greater than one day's worth of messages (held in the depth variable)
:: 
:: Thom Rosario
:: thom_rosario@email.com
:: 1.17.2014; v1.1 -- added check to send only once per day
:: 1.17.2014; v1.0
:: ----------------------------------------------------------------------------
@echo off
setlocal EnableDelayedExpansion
set tempDate=%DATE:/=-%
set tempDate=%tempDate: =-%
set today=%tempDate%.txt
set maxDepth=500000

:: Set some variables for use in sending the report
set to=-to messagingteam@someplace.net
set from=-f IndexStatus@someplace.net
set subj=-subject "EAS Index Queue Depth Greater than 1 Day"
set smtp=-server smtp.someplace.net
set body=EmailBody.txt
set blat="D:\Program Files\blat\blat.exe"

:: Perform the query
set tmp=tempIndexCount.txt
bcp "select count(*) from EAS.dbo.FT_NOTIFY"  queryout %tmp% -T -c -S pmhexcsql002y
set /p remaining=<%tmp%
del %tmp%

if %remaining% GEQ %maxDepth% (
	if NOT exist %today% (
		echo 1 > %today%
		echo Current EAS Indexer queue is greater than one day:  %remaining% >> %body%
		%blat% %body% %to% %smtp% %from% %subj%
		del %body%
	)
) 
