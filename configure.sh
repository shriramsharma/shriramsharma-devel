#!/bin/bash

fileArray=(.alias .bashrc .git-completion.bash .gitconfig .netrc .screenrc .vimrc .vim)
len=${#fileArray[*]}

echo "Beginning copying config file"

i=0
while [ $i -lt $len ] 
do
echo "Copying ${fileArray[$i]}"
cp -R ${fileArray[$i]} ~/
let i++
done

echo "Done copying configuration files"

echo "Now start coding"
