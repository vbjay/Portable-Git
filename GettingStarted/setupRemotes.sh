#!/bin/sh

#This script converts this repo to allow the repo to be pushed to github.

echo "Configuring Portable Git repo urls."
git remote set-url origin git://github.com/vbjay/Portable-Git.git
git remote set-url --push origin git@github.com:vbjay/Portable-Git.git

cd /share/GitExtensions/
echo "Configuring Git Extensions repo urls."
git remote set-url origin git://github.com/vbjay/Git-Extensions.git
git remote set-url --push origin git@github.com:vbjay/Git-Extensions.git

if [ -e "/share/src/GitExtensions/.git" ]; then
	cd /share/src/GitExtensions/
	echo "Configuring Git Extensions Src repo urls."
	echo "Removing remotes"
	git remote remove origin
	git remote remove upstream
	echo "Adding remotes"
	git remote add origin git://github.com/vbjay/gitextensions.git
	git remote set-url --push origin git@github.com:vbjay/gitextensions.git
	git remote add upstream	git://github.com/gitextensions/gitextensions.git 
	git remote set-url --push upstream	git://github.com/gitextensions/gitextensions.git
	
	
	if [ -e "/share/src/GitExtensions/GitExtensionsDoc/.git" ]; then
		echo "Configuring Git Extensions Doc repo urls."
		cd /share/src/GitExtensions/GitExtensionsDoc/
		echo "Removing remotes"
		git remote remove origin
		git remote remove upstream
		echo "Adding remotes"
		git remote add origin	git://github.com/vbjay/GitExtensionsDoc.git 
		git remote set-url --push origin	git@github.com:vbjay/GitExtensionsDoc.git 
		git remote add upstream	git://github.com/gitextensions/GitExtensionsDoc.git 
		git remote set-url --push upstream	git://github.com/gitextensions/GitExtensionsDoc.git 
	fi
	if [ -e "/share/src/GitExtensions/GitExtensionsTest/.git" ]; then
		echo "Configuring Git Extensions Test repo urls."
		cd /share/src/GitExtensions/GitExtensionsTest/
		echo "Removing remotes"
		git remote remove origin
		git remote remove upstream
		echo "Adding remotes"
		git remote add origin	git://github.com/vbjay/gitextensionstest.git 
		git remote set-url --push origin	git@github.com:vbjay/gitextensionstest.git 
		git remote add upstream	git://github.com/gitextensions/gitextensionstest.git 
		git remote set-url --push upstream	git://github.com/gitextensions/gitextensionstest.git 
	fi
fi
cd /
git submodule foreach --recursive git remote -v update