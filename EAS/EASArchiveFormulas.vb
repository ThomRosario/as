If NumAttachments>250 then
   print("Skipping message with more than 250 attachments...")
   return noarchive
end

if OnDemandArchive then 
   return Archive
end

If ArchiveDueToQuota AND 
   (
	   InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR 
	   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR 
	   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR 
	   InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR 
	   InStr(UCase(MessageClass), UCase("IPM.ITEMS"))
	) then
return NoQuotaArchive
end

if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR
   InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR
   InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR     
   InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR    
   InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
   return NoStubNoDelete
end

if DateAge("dd", MsgDate) > 14 AND MsgSize >= 100000 then
   return Archive
end

if DateAge("dd", MsgDate) > 90 then
   return Archive
end

return NoStubNoDelete

if DateAge("dd", MsgDate) > 365 AND 
	NOT InStr(UCase(MessageClass), UCase("IPM.CONTACT")) then
   	Return DeleteStub
end
Return KeepStub