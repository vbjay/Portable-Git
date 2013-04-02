#!/bin/sh

#This script converts this repo to allow the repo to be pushed to github.

echo "Configuring Portable Git repo push url with ssh url."
git remote set-url --push origin git@github.com:vbjay/Portable-Git.git

cd /share/GitExtensions/
echo "Configuring Git Extensions repo push url with ssh url."
git remote set-url --push origin git@github.com:vbjay/Git-Extensions.git

if [ -e "/share/src/GitExtensions/.git" ]; then
	cd /share/src/GitExtensions/
	echo "Configuring Git Extensions Src repo push url with ssh url."
	git remote set-url --push origin git@github.com:vbjay/gitextensions.git
fi