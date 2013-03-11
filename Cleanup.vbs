Set objNetwork = Wscript.CreateObject("Wscript.Network")
currUser = LCase(objNetwork.UserName)
Const strComputer = "." 
  Dim objWMIService, colProcessList
  Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
  Set colProcessList = objWMIService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'ssh-agent.exe'")
  For Each objProcess in colProcessList 
	If objProcess.GetOwner ( User, Domain ) = 0 Then
		If LCase(User) = currUser Then
			objProcess.Terminate() 
		end if
	end if
  Next  


'Delete Temp shortcut.
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

Const TemporaryFolder = 2
linkfile = fso.BuildPath(fso.GetSpecialFolder(TemporaryFolder), "Git Bash.lnk")

set fl=fso.getfile(linkfile)
fl.delete(true)
