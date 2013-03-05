Set shell = CreateObject("WScript.Shell")

Set fso = CreateObject("Scripting.FileSystemObject")

Const TemporaryFolder = 2
linkfile = fso.BuildPath(fso.GetSpecialFolder(TemporaryFolder), "Git Bash.lnk")
gitdir = fso.GetParentFolderName(WScript.ScriptFullName)
' Dynamically create a shortcut with the current directory as the working directory.
Set link = shell.CreateShortcut(linkfile)

If not (fso.FileExists(linkfile)) Then
	link.TargetPath = fso.BuildPath(gitdir, "bin\sh.exe")
	link.Arguments = "--login -i"
	link.IconLocation = fso.BuildPath(gitdir, "etc\git.ico")
	link.Save
end if
If WScript.Arguments.Length > 0 Then link.WorkingDirectory = WScript.Arguments(0)
Set wshSystemEnv = shell.Environment( "VOLATILE" )

homeDir=fso.buildpath(fso.GetParentFolderName(link.TargetPath),"..\home\")
wshSystemEnv("HOME")=homeDir


Set app = CreateObject("Shell.Application")
app.ShellExecute linkfile
