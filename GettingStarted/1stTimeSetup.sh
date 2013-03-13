#!/bin/sh
echo "Please enter your name."
oldIFS=$IFS
IFS="$(printf '\n')" 

read -r "NAME"

echo "Please enter your email address."
read -r "EMAIL"

echo Name:"$NAME"
echo Email:"$EMAIL"

echo Running git config

git config --global user.name $NAME
git config --global user.email $EMAIL

echo Git user settings...
echo
git config -l | grep user
IFS=$oldIFS


if [ ! -f ~/.ssh/id_rsa ];
then
    ssh-keygen
fi