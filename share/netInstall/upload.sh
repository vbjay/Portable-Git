#!/bin/sh

filename=$(basename "$1")
read -r -p "Please enter the username to login to vbjaysolutions.com." lname


scp "$1" $lname@vbjaysolutions.com:public_html/vbjaysolutions.com/git/$filename