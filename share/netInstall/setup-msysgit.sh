#!/bin/sh

# We're already in the install directory
INSTALL_PATH="$(pwd)"
export PATH="$INSTALL_PATH/installer-tmp/bin:$PATH"
export PATH="$INSTALL_PATH/PotableGit/bin::$PATH"


error () {
    echo "* error: $*"
    echo INSTALLATION ABORTED
    read -e IGNORED_INPUT
    trap - exit
    exit 1
}

echo -------------------------------------------------------
echo Checking environment
echo -------------------------------------------------------
type cygpath >/dev/null 2>/dev/null && {
    echo "Cygwin seems to be in your system path. This was detected"
    echo "by trying to run cygpath, which was found by this shell."
    echo ""
    echo "Cygwin may cause severe problems, like crashes, if used in"
    echo "combination with msysgit. Please remove Cygwin from you system"
    echo "PATH environment variable."
    echo ""
    echo "For assistance on how to control your environment variables"
    echo "you should consult Microsoft's knowlege base:"
    echo "   Windows XP: http://support.microsoft.com/kb/310519"
    echo "   Windows NT: http://support.microsoft.com/kb/100843"
    echo ""
    error "Can not install msysgit when Cygwin is in PATH."
}
echo "Environment is clean. Can pull down latest Portable Git."

echo
echo -------------------------------------------------------
echo Fetching the latest Portable Git environment
echo -------------------------------------------------------
MSYSGIT_REPO_GIT=git://github.com/vbjay/Portable-Git.git
MSYSGIT_REPO_HTTP=https://github.com/vbjay/Portable-Git.git

# Multiply git.exe

for builtin in init unpack-objects update-ref fetch ls-remote clone checkout
do
	ln "$INSTALL_PATH/installer-tmp/bin/git.exe" \
		"$INSTALL_PATH/installer-tmp/bin/git-$builtin.exe"
done

git clone git://github.com/vbjay/Portable-Git.git PortableGit --recursive && 
cd ./PortableGit/share/GitExtensions/ &&
git checkout master

read -p "Copy any needed files to the home directory and press [Enter] key to close the insatall and run the Git shell..."
