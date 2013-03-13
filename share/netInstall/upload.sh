#!/bin/sh

filename=$(basename "$1")
scp "$1" vbjay@vbjaysolutions.com:public_html/vbjaysolutions.com/git/$filename