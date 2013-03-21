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
echo "Please enter a password for your new ssh keys.  If you don't want a password just press enter."
echo "Each time you load your ssh key, you will have to enter this password."
    ssh-keygen
fi