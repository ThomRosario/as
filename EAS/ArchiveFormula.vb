If NumAttachments>500 then
   print("Skipping message with more than 500 attachments...")
   return noarchive
end
if OnDemandArchive then 
   return Archive
end
if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR  InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
   return NoStubNoDelete
end
if DateAge("dd", MsgDate) > 14 AND MsgSize >= 100000 then
   return Archive
end
if DateAge("dd", MsgDate) > 90 then
   return Archive
end

return NoStubNoDelete

'  "Default EX Users" ----------------------------------------------
if InStr(UCase(MessageClass), UCase("IPM.APPOINTMENT")) OR    InStr(UCase(MessageClass), UCase("IPM.CONTACT")) OR    InStr(UCase(MessageClass), UCase("IPM.DISTLIST")) OR     InStr(UCase(MessageClass), UCase("IPM.STICKYNOTE")) OR    InStr(UCase(MessageClass), UCase("IPM.ITEMS")) then
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

'Entries in Recipient Lists -1 --> 10