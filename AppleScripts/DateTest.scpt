set now to current date
current date --> date "Saturday, April 15, 2006 4:29:04 PM"
(date ("1/1/2001" as string)) - (date ("1/1/2000" as string)) --> Returns 31622400

-- Get the current date as a string a display it
set nowString to now as string
--display dialog nowString

set maxDate to now + (14 * days)
set maxDateString to maxDate as string
display dialog maxDateString

set {year:y, month:m, day:d} to (current date)
y --> 2006
m --> April 
d --> 15

--display dialog m + 1 --> 10 

if (now < maxDate) then
	display dialog "It worked."
end if