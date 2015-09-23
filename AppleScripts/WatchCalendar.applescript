(* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
This script copies calendar events from one calendar to another.  
It grabs any event between the specified min and max dates, and all recurring
events since it's just easier that way.  In the future, I may spend the time 
to learn how Calendar.app handles it's recurrences & refine this to abide by 
the min & max dates the same way normal events do.

Thom Rosario
9.20.2015
v 1.0 -- Initial functionality.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *)
logMsg("starting")
property iCloudCal : "APLExch"
property exchCal : "Calendar"

-- Get the current date & set the earliest and latest dates we want to work on
set now to current date
set maxDate to now + (7 * days)
set minDate to now - (7 * days)

tell application "Calendar"
	activate
	-- delete entries in specified time frame
	repeat with anEvent in (get events of calendar iCloudCal)
		-- check to see if it's in the date range
		set eventStart to (start date of anEvent)
		set inRange to ((eventStart > minDate) and (eventStart < maxDate))
		
		-- now check for recurring appt
		set recurText to (recurrence of anEvent)
		set recurrent to (recurText ­ missing value)
		
		-- if this is one of the appts, delete it
		if inRange or recurrent then
			set sumString to (summary of anEvent)
			log "Deleting from destination:  " & sumString
			delete anEvent
		end if
	end repeat
	
	-- copy specific events from the source calendar to the destination
	repeat with anEvent in (get events of calendar exchCal)
		set eventStart to (start date of anEvent)
		set recurText to (recurrence of anEvent)
		if ((eventStart > minDate) and (eventStart < maxDate)) or Â
			(recurText ­ missing value) then
			set sumString to (summary of anEvent)
			log "Adding to destination:  " & sumString
			duplicate anEvent to the end of events of calendar iCloudCal
		end if
	end repeat
end tell
logMsg("completed")

on apptOfInterest()
end apptOfInterest

on logMsg(scriptStatus)
	set now to current date
	set nowString to now as string
	log nowString & ":  " & scriptStatus & " sync."
	display dialog "Calendar sync script " & scriptStatus
end logMsg