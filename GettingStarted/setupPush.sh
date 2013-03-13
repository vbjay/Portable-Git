#!/bin/sh

#This script converts this repo to allow the repo to be pushed to github.

git remote set-url --push origin git@github.com:vbjay/Portable-Git.git

cd /share/GitExtensions/

git remote set-url --push origin git@github.com:vbjay/Git-Extensions.git
