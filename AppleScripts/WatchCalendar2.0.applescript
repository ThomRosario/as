(* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
This script replicates one calendar to another.
It first copies all Exchange events to the iCloud calendar, and then deletes
any iCloud events that aren't in the Exchange calendar.  The first run will
likely take up to 30 mins, with later runs taking about 3 mins.  During the
run, the script checks to see if you're plugged in so that it doesn't kill your
battery.  Each add/delete event takes about 12 seconds to complete.

NOTE
------
Calendar.app fails to copy certain recurring events, times out and then 
crashes.  The script relaunches Calendar after a failed attempt, but the
avoidList property can be used to skip them alltogether for huge speed 
gains.

Once the target calendar syncs to iCloud, your  Watch should display the
events of your Exchange calendar.  This script relies upon having access to
an iCloud calendar whose name is stored in the iCloudCal property at the 
start of this script.

TODO:  
-- Clean up avoid list work to account for recurrence handling
-- Figure out how to hand a calendar event to a subroutine

Thom Rosario
v 1.3 -- added sqlite3 storage for recurrence handling
v 1.2.1 -- added Growl support
v 1.2 -- added rudimentary recurring meeting support
v 1.1 -- added the ability to avoid a list of events
v 1.0 -- initial functionality.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *)
P R E - F L I G H T
***************)
D E B U G   L O O P
*****************)
	*)
M A I N   C O D E
**************)
H A N D L E R S       
**************)
	This handler creates a SQLite3 database on the disk.  It's used to
	get around the slow performance of reading events directly from 
	calendars.  Storing the events in sql allows much faster replication.
	*****************************************************)
		set testResult to my setConfig "dbInited", "true"
		log testResult
	end tell*)
	This handler checks the row of sql data passed to it and compares 
	it to the date stamp of the current event we're processing & 
	returns that result.