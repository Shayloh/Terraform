#!/bin/sh
echo *****************Start*****************
date
# commit id
sha1=`git rev-parse HEAD`
name=`git show $sha1 | grep 'Author:' | cut -d' ' -f2`
email=`git show $sha1 | grep 'Author:' | cut -d' ' -f3 | sed -e 's/<//g' | sed -e 's/>//g'`
echo 'list:'
echo $name 
echo $email 
git config --global user.name $name
git config --global user.email $email
echo '***************** git checkout develop & git pull:'
git checkout develop
git pull
echo '***************** git merge origin/master:'
conflict=`git merge origin/master`
echo $conflict | grep 'CONFLICT'
if [ $? -ne 0 ]; then
    echo '***************** git push origin HEAD:'
    git push origin HEAD
    echo '***************** git status:'
    git status
else
    git status
    echo 'Automatic merge failed...'
    echo 'Please fix conflicts and then commit the result...'
    exit 1
fi
echo *****************End*****************
