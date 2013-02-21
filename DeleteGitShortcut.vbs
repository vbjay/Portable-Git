Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

Const TemporaryFolder = 2
linkfile = fso.BuildPath(fso.GetSpecialFolder(TemporaryFolder), "Git Bash.lnk")

set fl=fso.getfile(linkfile)
fl.delete(true)
