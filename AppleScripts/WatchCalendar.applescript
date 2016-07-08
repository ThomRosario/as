(* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
This script copies calendar events from one calendar to another.  
It grabs any event between the specified min and max dates, and all recurring
events since it's just easier that way.  In the future, I may spend the time 
to learn how Calendar.app handles it's recurrences & refine this to abide by 
the min & max dates the same way normal events do.

Note that the iCloud calendar events aren't visible in Calendar.app, but they 
do actually sync to the  Watch as intended.  This script relies upon having
access to an iCloud calendar whose name is stored in the iCloudCal property 
at the start of this script.

TODO:  
-- Skip attachments
-- Figure out a cleaner recurrence check

Thom Rosario
v 1.5 -- 6.29.2016.  Added debug code
v 1.4 -- 1.25.2016.  Quit Calendar and CalendarAgent after execution & added
       delay to let Calendar.app finish launching before proceeding
v 1.3 -- Added a check to see if Mac's on AC power or not.  If plug is pulled,
            mid-routine, the script will exit gracefully.
v 1.2 -- Added a ⌘+H to the calendar activation to hide it when it launches
v 1.1 -- Adding try to duplication loop after 10.11 upgrade started crashing
v 1.0 -- Initial functionality.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *)


(* ************
V A R I A B L E S
**************)
logMsg("starting")
property debugScript : false
property iCloudCal : "APLExch" -- the name of your iCloud calendar
property exchCal : "Calendar" -- your Exchange calendar
global powerSource -- used to save battery if you're not plugged in
global eventStart, eventEnd -- used for holding calendar dates
global maxDate, minDate, inRange, recurrent -- date calculations variables

(*************
M A I N   C O D E
**************)
checkPowerState()
if powerSource is "AC" then
	-- Get the current date & set the earliest and latest dates we want to work on
	set now to current date
	if debugScript then
		set maxDate to now + (14 * days)
		set minDate to now - (14 * days)
	else
		set maxDate to now + (7 * days)
		set minDate to now - (1 * days)
	end if
	tell application "Calendar"
		activate
		if not debugScript then
			-- wait for the app to load and then hide it
			delay 17
			tell application "System Events"
				keystroke "h" using command down
			end tell
			delay 7 -- let the calendars finish loading
			
			--Give the user a choice of calendars to pick as the source
			--set listOfCalendars to name of calendars
			--choose from list listOfCalendars with title "Please select a source calendar" without empty selection allowed
			--set exchCal to result as string
		else
			delay 10
		end if
		
		if not debugScript then
			-- delete entries in specified time frame and all recurring
			repeat with anEvent in (get events of calendar iCloudCal)
				-- check to see if we lost AC power
				my checkPowerState()
				if powerSource is not "AC" then
					exit repeat
				end if
				
				-- check to see if it's in the date range
				set eventStart to (start date of anEvent)
				set inRange to ((eventStart > minDate) and (eventStart < maxDate))
				
				-- now check for recurring appt
				--				if exists recurrence of anEvent then
				try
					set recurText to (recurrence of anEvent)
					set recurrent to (recurText ≠ missing value)
				on error errMsg
					log "Not a recurring event:  " & errMsg
				end try
				--				end if
				
				(*if debugScript then
					if my apptOfInterest() then
						display dialog "It worked!"
					end if
				end if*)
				
				-- if this is one of the apppointments, delete it
				if inRange or recurrent then
					try
						set sumString to (summary of anEvent)
						log "Deleting:  " & sumString
						delete anEvent
					on error errMsg
						log "Error:  " & sumString & "; " & errMsg
					end try
				end if
			end repeat -- done deleting every event in range
		end if
		
		-- copy specific events from the source calendar to the destination
		repeat with anEvent in (get events of calendar exchCal)
			-- check to see if we lost AC power
			my checkPowerState()
			if powerSource is not "AC" then
				exit repeat
			end if
			
			set eventStart to (start date of anEvent)
			set eventEnd to (end date of anEvent)
			set recurText to (recurrence of anEvent)
			set inRange to ((eventStart > minDate) and (eventStart < maxDate))
			
			-- find out if it's a recurring meeting
			set recurrent to (recurText ≠ missing value)
			
			if inRange or recurrent then
				try
					set sumString to (summary of anEvent)
					log "Attempting:  " & sumString
					if debugScript then
						copy anEvent to the end of events of calendar iCloudCal
					else
						duplicate anEvent to the end of events of calendar iCloudCal
					end if
					log "Added:         " & sumString
				on error errMsg
					activate -- Calendar probably crashed; relaunch
					if not debugScript then
						delay 5 -- wait for the calendar to load
						tell application "System Events"
							keystroke "h" using command down
						end tell
						delay 5
					end if
					log "Error:          " & sumString & "; " & errMsg
				end try
			end if
		end repeat -- done copying events
	end tell
	
	-- Refresh calendars, then quit
	tell application "System Events"
		keystroke "r" using command down
	end tell
	delay 10
	quit
	delay 3
end if


(*************
H A N D L E R S       
**************)
if not debugScript then
	do shell script "killall CalendarAgent"
	if powerSource is "AC" then
		logMsg("completed")
	else
		logMsg("stopped to save battery.")
	end if
end if

-- Log and prompt subroutine
on logMsg(scriptStatus)
	set now to current date
	set nowString to now as string
	log nowString & ":  " & scriptStatus & " sync."
	if debugScript then
		display dialog "Calendar sync script " & scriptStatus
	end if
end logMsg

-- Determine if we need this appointment
on apptOfInterest(anEvent)
	-- local eventStart, eventEnd
	-- set eventStart to (start date of anEvent)
	-- set eventStart to test
	-- set eventEnd to (end date of anEvent)
	set inRange to ((eventStart > minDate) and (eventStart < maxDate))
	set recurrent to (recurText ≠ missing value)
	if inRange or recurrent then
		return true
	else
		return false
	end if
end apptOfInterest

-- Figure out if we're on battery power
on checkPowerState()
	if debugScript then
		set powerSource to "AC"
	else
		do shell script "pmset -g everything | grep Cycles"
		set powerState to the result
		set powerSource to word 1 of powerState
	end if
end checkPowerState

(****************************
R E C U R R E N C E   C H E C K E R
*****************************)
-- Check this script out to see if it works for recurrence checking
if debugScript then
	(*
to getRecurrenceTermination(startDate, recurrenceString)
set olddel to AppleScript's text item delimiters
set AppleScript's text item delimiters to ";"
set tItems to text items of recurrenceString
set AppleScript's text item delimiters to "="
set d to 0
set untl to missing value
repeat with anItem in tItems

    set parts to text items of anItem
    set sec to word 3 of anItem

    if (offset of "FREQ=" in anItem) > 0 then
        if (offset of "WEEKLY" in anItem) > 0 then
            set d to 7
        else if (offset of "DAILY" in anItem) > 0 then
            set d to 1
        else if (offset of "MONTHLY" in anItem) > 0 then
            set d to 31
        end if
    else if (offset of "INTERVAL=" in anItem) > 0 then
        set d to d * sec
    else if (offset of "COUNT=" in anItem) > 0 then
        set d to d * sec
    else if (offset of "UNTIL=" in anItem) > 0 then
        set untl to current date
        set untl's year to text 1 thru 4 of sec
        set untl's month to text 5 thru 6 of sec
        set untl's day to text 7 thru 8 of sec
        set untl's hours to text 10 thru 11 of sec
        set untl's minutes to text 12 thru 13 of sec
        set untl's seconds to text 13 thru 14 of sec
    end if
end repeat
set AppleScript's text item delimiters to olddel

if untl is missing value then
    if d is not 0 then
        set finalDate to startDate + (d * days)
    else
        set finalDate to startDate + (1000 * days)
    end if
else
    set finalDate to untl
end if
return finalDate
end getRecurrenceTermination

tell application "iCal"

set TheCalendars to name of calendars

set theSourceCalendar to ""
set theDestinationCalendar to ""

choose from list TheCalendars with title "Please select a source calendar" without empty selection allowed
set theSourceCalendar to result as string

if theSourceCalendar is "" then
    --do nothing
else

    set theOtherCals to {}
    repeat with anItem in TheCalendars
        if (anItem as string) is not (theSourceCalendar as string) then set theOtherCals to theOtherCals & anItem
    end repeat

    choose from list theOtherCals with title "Please select a destination calendar" without empty selection allowed
    set theDestinationCalendar to result as string


    if theDestinationCalendar is "" then
        --do nothing
    else

        display dialog "Copy calendar events from " & theSourceCalendar & " to " & theDestinationCalendar & "?" buttons {"OK", "Cancel"} default button 2
        if the button returned of the result is "OK" then
            set TheEvents to events of calendar theSourceCalendar
            set otherEvents to events of calendar theDestinationCalendar
            repeat with anEvent in TheEvents
                set curDate to current date
                set isNew to 1
                set startDate to start date of anEvent
                set endDate to end date of anEvent
                set eventStatus to status of anEvent
                set recuInfo to recurrence of anEvent
                set auid to uid of anEvent
                if recuInfo is not missing value then
                    set ed to my getRecurrenceTermination(startDate, recuInfo)
                end if
                if endDate ≥ curDate and eventStatus is not none then
                    --check that is not already existing using uid of events
                    repeat with oEvent in otherEvents
                        set ouid to uid of oEvent
                        if ouid is equal to auid then
                            set isNew to 0
                            exit repeat
                        end if
                    end repeat
                    if isNew is not 0 then
                        duplicate anEvent to end of calendar theDestinationCalendar
                    end if
                else
                    log "Event discarded: old"
                end if

            end repeat
        else
            --do nothing
        end if
    end if
end if
end tell
*)
end if
