'####
'Deletes the temp shortcut that allows the shell to be run from any directory 
'and kills all processes that were started by the current user and are from this folder and sub folders.
'####

Set objNetwork = Wscript.CreateObject("Wscript.Network")
Set fso = CreateObject("Scripting.FileSystemObject")

currUser = LCase(objNetwork.UserName)
Const strComputer = "." 
  Dim objWMIService, colProcessList
  Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
  Set colProcessList = objWMIService.ExecQuery("SELECT * FROM Win32_Process")
  spath=fso.GetParentFolderName(WScript.ScriptFullName)
  For Each objProcess in colProcessList 
	If InStr(objProcess.ExecutablePath,spath)>0 Then
		If objProcess.GetOwner ( User, Domain ) = 0 Then
			If LCase(User) = currUser Then
				'Wscript.echo(objProcess.ExecutablePath & vbcrlf)
				if MsgBox("Do you want to stop " & vbcrlf & objProcess.name,VBYesNo)=vbyes Then
					objProcess.Terminate() 
				end if
			end if
		end if
	end if
  Next  

'Delete Temp shortcut.
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

Const TemporaryFolder = 2
linkfile = fso.BuildPath(fso.GetSpecialFolder(TemporaryFolder), "Git Bash.lnk")
if fso.FileExists(linkfile) Then
	set fl=fso.getfile(linkfile)
	fl.delete(true)
end if
