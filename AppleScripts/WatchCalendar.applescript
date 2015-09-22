tell application "Calendar"
	activate
	-- delete everything from the destination calendar
	display dialog "Deleting old calendar data."
	repeat with anEvent in (get events of calendar "APLExch")
		delete anEvent
	end repeat
	
	-- copy all events from the source calendar to the destination
	display dialog "Starting calendar copy."
	repeat with anEvent in (get events of calendar "Calendar")
		duplicate anEvent to the end of events of calendar "APLExch"
	end repeat
end tell
display dialog "Calendar sync complete."

(*
tell application "System Events"
	set isRunning to (count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp")) > 0
end tell

if isRunning then
	tell application id "com.Growl.GrowlHelperApp"
		-- Make a list of all the notification types 
		-- that this script will ever send:
		set the allNotificationsList to ¬
			{"Calendar Sync"}
		
		-- Make a list of the notifications 
		-- that will be enabled by default.      
		-- Those not enabled by default can be enabled later 
		-- in the 'Applications' tab of the growl prefpane.
		set the enabledNotificationsList to ¬
			{"Calendar Sync"}
		
		-- Register our script with growl.
		-- You can optionally (as here) set a default icon 
		-- for this script's notifications.
		register as application ¬
			"Calendar Sync Script" all notifications allNotificationsList ¬
			default notifications enabledNotificationsList ¬
			icon of application "Script Editor"
		
		-- Send a Notification...
		notify with name ¬
			"Calendar Sync" title ¬
			"Calendar Sync notification" description ¬
			"The calendar sync is complete." application name "Calendar Sync Script"
	end tell
end if *)