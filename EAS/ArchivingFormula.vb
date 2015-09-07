*** | Dec 06, 2011 @ 11:48:33 PST |  *** 

We've got a quota archiving rule established to prune out large messages, but it sometimes grabs calendar appointments.  After restoring an archived repeating appointment, the appointment doesn't work properly and has to be manually re-created.

The formula used was created for us by Autonomy when the system was installed years ago, and it seems to have a typo in it (no space before the STICKYNOTE line).

I don't know if the typo(?) is important or not, but I'd love some help on this.

if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR  
   InStr(UCase(MessageClass),UCase("IPM.STICKYNOTE")) OR 
   InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
   return NoStubNoDelete
end
if OnDemandArchive then 
   return Archive
end

if DateAge("dd", MsgDate) > 14 AND MsgSize >= 100000 then
   return Archive
end

if DateAge("dd", MsgDate) > 90 then
   return Archive
end

return NoStubNoDelete



================================================================================================

*** | Dec 06, 2011 @ 13:05:19 PST |  *** 

Are we using any kind of stub management rule for any groups or user archive rules?

Mark Strelecki
EAS Support


================================================================================================

*** | Dec 07, 2011 @ 07:01:02 PST |  *** 

Yes -- stubs over 1.5 years are deleted from mailboxes, and users are allowed to archive on demand.  Also, there's a nightly archive rule. 



================================================================================================

*** | Dec 08, 2011 @ 06:41:00 PST |  *** 

Any updates?

================================================================================================

*** | Dec 08, 2011 @ 07:45:33 PST |  *** 

Please attach the stub management rule to this ticket. Thank you!

================================================================================================

*** | Dec 08, 2011 @ 07:53:28 PST |  *** 

if DateAge("dd", MsgDate) > 548 then
   Return DeleteStub
end


================================================================================================

*** | Dec 08, 2011 @ 11:44:59 PST |  *** 

Can I get a phone call?  410.709.8466

================================================================================================

*** | Dec 08, 2011 @ 13:35:35 PST |  *** 

if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR  
   InStr(UCase(MessageClass),UCase("IPM.STICKYNOTE")) OR 
   InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
   return NoStubNoDelete
end
if OnDemandArchive then 
   return Archive
end

if DateAge("dd", MsgDate) > 14 AND MsgSize >= 100000 then
   return Archive
end

if DateAge("dd", MsgDate) > 90 then
   return Archive
end

If ArchiveDueToQuota then
If lcase(MessageClass)="ipm.appointment" Then
Return NoQuotaArchive
End

return NoStubNoDelete

================================================================================================

*** | Dec 08, 2011 @ 13:57:20 PST |  *** 

Thom,

Test this one out before just to confirm there are no syntax issues from cutting and pasting.   It should do exactly what you are looking for.

Thanks,
Kevin


if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR 
   InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR 
   InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
   return NoStubNoDelete
end

if OnDemandArchive then 
   return Archive
end

if DateAge("dd", MsgDate) > 14 AND MsgSize >= 100000 then
   return Archive
end

if DateAge("dd", MsgDate) > 90 then
   return Archive
end

If ArchiveDueToQuota then
if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR 
   InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR 
   InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
return NoQuotaArchive
End

return NoStubNoDelete

================================================================================================

*** | Dec 09, 2011 @ 06:43:38 PST | Status: Resolved *** 

Problem:

Repeating Calendar Tasks are stripped out of mailboxes; want help w/ archive formula

Solution:



if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR 
   InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR 
   InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
   return NoStubNoDelete
end

if OnDemandArchive then 
   return Archive
end

if DateAge("dd", MsgDate) > 14 AND MsgSize >= 100000 then
   return Archive
end

if DateAge("dd", MsgDate) > 90 then
   return Archive
end

If ArchiveDueToQuota then
if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR 
   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR 
   InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR 
   InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
return NoQuotaArchive
End

return NoStubNoDelete

================================================================================================

If NumAttachments>250 then
   print("Skipping message with more than 250 attachments...")
   return noarchive
end
if OnDemandArchive then 
   return Archive
end
if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR    InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR    InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR     InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR    InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
   return NoStubNoDelete
end

if DateAge("dd", MsgDate) > 14 AND MsgSize >= 100000 then
   return Archive
end

if DateAge("dd", MsgDate) > 90 then
   return Archive
end

return NoStubNoDelete