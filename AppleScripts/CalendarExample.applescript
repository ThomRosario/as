--iCal Event Duplicator.scpt
--Writen by Mike Cramer
--January 10, 2011 ~ 4pm CST
--
--Assume GPL style license.

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
        
        repeat with anEvent in TheEvents
          
          tell anEvent
            set theProperties to properties
            
            set THEdescription to description
            if THEdescription = missing value then set THEdescription to ""
            set thestartdate to start date
            if thestartdate = missing value then set thestartdate to ""
            set THEenddate to end date
            if THEenddate = missing value then set THEenddate to ""
            set THEalldayevent to allday event
            if THEalldayevent = missing value then set THEalldayevent to ""
            set THErecurrence to recurrence
            if THErecurrence = missing value then set THErecurrence to ""
            set THEexcludeddates to excluded dates
            --      if THEexcludeddates = missing value then set THEexcludeddates to ""
            set THEstatus to status
            if THEstatus = missing value then set THEstatus to ""
            set THEsummary to summary
            if THEsummary = missing value then set THEsummary to ""
            set THElocation to location
            if THElocation = missing value then set THElocation to ""
            set THEurl to url
            if THEurl = missing value then set THEurl to ""
            
          end tell
          
          tell calendar theDestinationCalendar
            make new event at end with properties {description:THEdescription, start date:thestartdate, end date:THEenddate, allday event:THEalldayevent, summary:THEsummary, location:THElocation, url:THEurl}
          end tell
        end repeat
      else
        --do nothing
      end if
    end if
  end if
end tell