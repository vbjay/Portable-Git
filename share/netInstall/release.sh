#!/bin/sh

# Recreate PortableGit-netinstall.exe



MSYSGITBRANCH="$1"
test -z "$MSYSGITBRANCH" && MSYSGITBRANCH=master
FOURMSYSGITBRANCH="$2"

TARGET=/PortableGit-netinstall.exe
TMPDIR=/tmp/installer-tmp
OPTS7="-m0=lzma -mx=9 -md=64M"
TMPPACK=/tmp.7z
SHARE=/share/netInstall/

test ! -d "$TMPDIR" || rm -rf "$TMPDIR" || exit
mkdir "$TMPDIR" &&
cd "$TMPDIR" &&
(cd .. && test ! -f "$TMPPACK" || rm "$TMPPACK") &&
echo "Copying files" &&
sed 's/\r//g' "$SHARE"/fileList.txt |
	(cd / && tar -c --file=- --files-from=-; echo $? > /tmp/exitstatus) |
	tar xvf - &&
test 0 = "$(cat /tmp/exitstatus)" &&
sed 's/\r//g' "$SHARE"/fileList-mingw.txt |
	(cd / && tar -c -v --file=- --files-from=-;
	 echo $? > /tmp/exitstatus) |
	tar xvf - &&
test 0 = "$(cat /tmp/exitstatus)" &&
mkdir etc &&
cp "$SHARE"/gitconfig etc/ &&
if test -d /etc/profile.d
then
	cp -R /etc/profile.d ./
fi &&
sed -e "s|@@MSYSGITBRANCH@@|$MSYSGITBRANCH|g" \
    -e "s|@@FOURMSYSGITBRANCH@@|$FOURMSYSGITBRANCH|g" \
  < "$SHARE"/setup-msysgit.sh > setup-msysgit.sh &&
echo "Creating archive" &&
cd .. &&
/share/7-Zip/7za.exe a $OPTS7 "$TMPPACK" installer-tmp &&
(cat /share/7-Zip/7zSD.sfx &&
 echo ';!@Install@!UTF-8!' &&
 echo 'Title="msysGit-netinstall: MinGW Git + MSys DevEnv installation"' &&
 echo 'BeginPrompt="This archive contains the minimal system needed to\nbootstrap the latest PortableGit environment"' &&
 echo 'CancelPrompt="Do you want to cancel PortableGit installation?"' &&
 echo 'ExtractDialogText="Please, wait..."' &&
 echo 'ExtractPathText="Where do you want to install PortableGit?"' &&
 echo 'ExtractTitle="Extracting..."' &&
 echo 'GUIFlags="8+32+64+256+4096"' &&
 echo 'GUIMode="1"' &&
 echo 'InstallPath="C:\\"' &&
 echo 'OverwriteMode="2"' &&
 echo 'RunProgram="\"%%T\installer-tmp\bin\sh.exe\" /setup-msysgit.sh"' &&
 echo 'Delete="%%T\installer-tmp"' &&
 echo 'RunProgram="\"%%T\PortableGit\Git Bash.vbs"' &&
 echo ';!@InstallEnd@!' &&
 cat "$TMPPACK") > "$TARGET" &&
 echo "Success! You'll find the new installer at \"$TARGET\"." &&
 cd / &&
 git add "$TARGET" &&
 rm $TMPPACK
