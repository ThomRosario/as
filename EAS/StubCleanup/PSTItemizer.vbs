Option Explicit
Dim objExplorer, objDocument

Const ForReading = 1
Const ForWriting = 2
Const olFolderInbox = 6

Dim objDictionary, keylist, cntlist
Dim fileDetails, fileSummary, filePSTList, sChoice
Dim fso, fdet, fin, fsum, pstfilename
Dim olApp, olNameSPace, rootStoreID, PSTName, openedPST, PSTCount
Dim i, temp, ErrNum, ErrDesc

Set objExplorer = WScript.CreateObject ("InternetExplorer.Application")
objExplorer.Navigate "about:blank"
objExplorer.ToolBar = 0
objExplorer.StatusBar = 0
objExplorer.Width = 600
objExplorer.Height = 240
objExplorer.Left = 0
objExplorer.Top = 0
objExplorer.Visible = 1
Set objDocument = objExplorer.Document
objDocument.Open
objDocument.Writeln "<html><title>PST Itemizer</title><body><table width=100%><tr><td>PST File List</td><td colspan=2><input type=textbox name=PSTLIST size=60 value=PSTFileList.txt /></td></tr><tr><td>PST Summary File</td><td colspan=2><input type=textbox name=SUMMARY size=60 value=PSTSummaryFile.txt /></td></tr><tr><td>PST Details</td><td><input type=radio name=CHOICE value=1 checked />No Details<br/><input type=radio name=CHOICE value=4 />All PST Items<br/></td><td><input type=radio name=CHOICE value=2 />Non Stubbed Items Only<br/><input type=radio name=CHOICE value=3 />Stubbed Items Only<br/></td></tr><tr><td>PST Details File</td><td colspan=2><input type=textbox name=DETAILS size=60 value=PSTDetailsFile.txt /></td></tr></table><br/><center><input type=checkbox name=CHK />Submit</center></body>"

Do While (NotDone)
    Wscript.Sleep 250
Loop 

filePSTList = objExplorer.Document.Body.All.PSTLIST.Value
fileSummary = objExplorer.Document.Body.All.SUMMARY.Value
fileDetails = objExplorer.Document.Body.All.DETAILS.Value
sChoice = ReadValue(objExplorer.Document.Body.All.CHOICE)

objExplorer.Quit
set ObjDocument = nothing
set ObjExplorer = nothing

set olApp = CreateObject("Outlook.Application")
set olNameSpace = olApp.GetNameSpace("MAPI")

'Get reference to mailbox.
rootStoreID = olNameSpace.GetDefaultFolder(olFolderInbox).parent.storeId

'Closing any opened .pst file to avoid conflict"

For i = olNameSpace.Folders.count To 1 Step -1
	temp = olNameSpace.Folders(i).storeID
	If Left(temp,75) <> Left(rootStoreID,75) Then
		'At least the first 75 digits of the rootStoreID
		'are the same for items that aren't Personal Folders.
		'Since they're not equal, this must be a 
		'Personal Folder. Close it.
		olNameSpace.RemoveStore olNameSpace.Folders(i)
	End If
Next
	

Set fso = CreateObject("Scripting.FileSystemObject")

Set fin = fso.OpenTextFile(filePSTList, ForReading, True)

if sChoice > 1 then
Set fdet = fso.OpenTextFile(fileDetails, ForWriting, True)	
fdet.Write "PSTFile" 
fdet.Write vbtab & "PSTName"
fdet.Write vbtab & "ItemNum"	
fdet.Write vbtab & "Folder"
fdet.Write vbtab & "SubItemNum"
fdet.Write vbtab & "MessageClass"
fdet.Write vbtab & "EntryID"
fdet.Write vbtab & "CreationTime"
fdet.Write vbtab & "LastModificationTime"
fdet.Write vbtab & "SentOn"
fdet.Write vbtab & "ReceivedTime"
fdet.Write vbtab & "Size"
fdet.Write vbtab & "Subject"
fdet.Write vbtab & "Unread"
fdet.Write vbtab & "Categories"
fdet.Write vbcrlf	
end if

Set fsum = fso.OpenTextFile(fileSummary, ForWriting, True)	

fsum.Writeline "Itemization script commenced at " & Now()
fsum.Writeline ""


do while fin.AtEndOfStream <> True

pstfilename = fin.Readline

if pstfilename <> "" then

	if fso.FileExists(pstfilename) then
	
		on Error Resume Next	
			olNameSpace.AddStore pstfilename
			ErrNum = Err.Number  
			ErrDesc = Err.Description
			Err.Clear
		on Error goto 0

		if ErrNum = 0 then

			fsum.WriteLine "PST File (" & pstfilename & ") opened at " & Now()
			fsum.Writeline ""

			For i = olNameSpace.Folders.count To 1 Step -1
				temp = olNameSpace.Folders(i).storeID
				If Left(temp,75) <> Left(rootStoreID,75) Then
					set openedPST = olNameSpace.Folders(i)
				End If
			Next

			'get the name of the PST.
			PSTName = openedPST.Name
			PSTCount = 0
			Set objDictionary = CreateObject("Scripting.Dictionary")
			'recurse folders!
			RecurseFolder openedPST, ""

fsum.writeline "Total Messages = " & cstr(pstcount)

'print dictionary
keylist = objDictionary.Keys   ' Get the keys.
cntlist = objDictionary.Items   
For i = 0 To objDictionary.Count -1 ' Iterate the array.
fsum.writeline keylist(i) & vbtab & cntlist(i)
Next
fsum.writeline ""




			olNameSpace.RemoveStore openedPST
			set openedPST = nothing
			Set objDictionary = nothing
			fsum.WriteLine "PST File (" & pstfilename & ") closed at " & Now()
			fsum.Writeline ""

			
		else
			fsum.Writeline "PST File (" & pstfilename & ") could not be opened!"
			fsum.Writeline "Error # " & cstr(ErrNum)
			fsum.Writeline ErrDesc
			fsum.Writeline ""

		end if
	
	else	
		fsum.Writeline "PST File (" & pstfilename & ") could not be found!"
		fsum.Writeline ""
	end if		

end if

loop 'while fin.AtEndOfStream <> True


Set olNameSpace = Nothing
Set olApp = Nothing		


fsum.Writeline "Itemization script completed at " & Now()
fsum.Writeline ""


fin.Close
fsum.Close
if sChoice > 1 then
fdet.Close
Set fdet = nothing
end if
set fsum = nothing
Set fso = nothing	


if sChoice > 1 then

Wscript.Echo "Advanced PST Itemizer Completed.  Check " & fileSummary & " for summary info, and " & fileDetails & " for details info."

else

Wscript.Echo "Advanced PST Itemizer Completed.  Check " & fileSummary & " for summary info."

end if


Sub RecurseFolder(CurrentFolder,ParentFolder)
	Dim SubFolder
		

	if CurrentFolder.Folders.Count > 0 then 
		'this Folder has Subfolders.
		'deal with them first.
		
		for each SubFolder in CurrentFolder.Folders 		
			Call RecurseFolder(SubFolder,ParentFolder & "\" & CurrentFolder.Name)			
		next				
		
	end if
	
	' now process Files
	ProcessFiles CurrentFolder, ParentFolder & "\" & CurrentFolder.Name
						
End Sub


Sub ProcessFiles(CurrentFolder,FolderName)
	Dim Item , i, ErrNum, ErrDesc, mc

		
	For i = 1 To CurrentFolder.Items.Count

		PSTCount = PSTCount+1

		On Error Resume Next

		Set Item = CurrentFolder.Items(i)
		
		ErrNum = Err.Number  
		ErrDesc = Err.Description
		Err.Clear

		On Error Goto 0
		
		if ErrNum = 0 then				
		
			mc = Item.MessageClass
			addMsgClass mc
			
			if ( (sChoice=2 and Right(mc,4)<>".EAS") or (sChoice=3 and Right(mc,4)=".EAS") or (sChoice=4) )  then

			On Error Resume Next
			fdet.Write pstfilename
			fdet.Write vbtab 
			fdet.Write PSTName
			fdet.Write vbtab 
			fdet.Write cstr(PSTCount)
			fdet.Write vbtab 
			fdet.Write Mid(FolderName,Len(PSTName)+2)
			fdet.Write vbtab 
			fdet.Write cstr(i)
			fdet.Write vbtab 
			fdet.Write mc
			fdet.Write vbtab 
			fdet.Write Item.EntryID
			fdet.Write vbtab 
			fdet.Write Item.CreationTime
			fdet.Write vbtab 
			fdet.Write Item.LastModificationTime
			fdet.Write vbtab 
			fdet.Write Item.SentOn
			fdet.Write vbtab 
			fdet.Write Item.ReceivedTime
			fdet.Write vbtab 
			fdet.Write Item.Size
			fdet.Write vbtab 
			fdet.Write Process(Item.Subject)
			fdet.Write vbtab 
			fdet.Write Item.Unread
			fdet.Write vbtab 
			fdet.Write Item.Categories
			fdet.Write vbcrlf	
			On Error Goto 0
			
			end if

		else
			fsum.Writeline "PST File (" & pstfilename & ") , folder (" & FolderName & "), item #" & cstr(i) & " could not be referenced."
			fsum.Writeline "Error # " & cstr(ErrNum)
			fsum.Writeline ErrDesc
			fsum.Writeline ""

		end if
	Next
	
	Set Item = Nothing
						
End Sub



Function Process(textstring)
	Dim a
	a = Replace (textstring,vbcrlf," ")
	a = Replace (a,vbcr," ")
	a = Replace (a,vblf," ")
	a = Replace (a,vbtab," ")
	Process = Mid(a,1,255)
End Function


Sub AddMsgClass(msgclass)

if objDictionary.Exists(msgclass) then
	objDictionary.Item(msgclass) = objDictionary.Item(msgclass) + 1
else
	objDictionary.Add msgclass,1
end if

end sub



function NotDone
dim x,errno
  NotDone = true
  on Error resume next
  x = objExplorer.Document.Body.All.PSTLIST.Value
  errno = err.number
  err.clear
  on error goto 0
  if errno <> 0 then
     wscript.quit
  end if

  if objExplorer.Document.Body.All.CHK.checked then
    NotDone=false
  else
    NotDone = true
  end if

end function

function ReadValue(x)
dim y
for each y in x
if y.checked then
   readvalue=y.value
end if
next
end function

Sub IE_onQuit()
 Wscript.Quit
End Sub


'fdet.Write Item.SenderName <- restricted
'fdet.Write Process(Item.Body) <- restricted