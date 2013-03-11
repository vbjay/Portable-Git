Set objNetwork = Wscript.CreateObject("Wscript.Network")
Set fso = CreateObject("Scripting.FileSystemObject")

currUser = LCase(objNetwork.UserName)
Const strComputer = "." 
  Dim objWMIService, colProcessList
  Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
  Set colProcessList = objWMIService.ExecQuery("SELECT * FROM Win32_Process")
  For Each objProcess in colProcessList 
	If objProcess.GetOwner ( User, Domain ) = 0 Then
		If LCase(User) = currUser Then
			If InStr(objProcess.ExecutablePath,fso.GetParentFolderName(WScript.ScriptFullName)) Then
				Wscript.echo(objProcess.ExecutablePath & vbcrlf)
			end if

		end if
	end if
  Next  


