echo "Please enter your name."

read -r "NAME"
oldIFS=$IFS
IFS="$(printf '\n')" 
echo "Please enter your email address."
read -r "EMAIL"

echo Name:"$NAME"
echo "$NAME">name
echo Email:"$EMAIL"
echo "$EMAIL">email

NAME<name
EMAIL<email

echo Name:"$NAME"
echo Email:"$EMAIL"


git config --global user.name $NAME
git config --global user.email $EMAIL

git config -l | grep user

IFS=$oldIFS