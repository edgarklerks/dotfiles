#!/usr/bin/zsh 

local REPOSDIR 
local BACKUPNAME 
local BACKUP_REPOS
local CURRENT_REPOS
local REPOS
local REPOSNAME
local LOCALS
local OLD_DIR 

# Configuration 
LOCALS=(".hg/hgrc" "src/content_library/config/localsettings.py")
REPOSNAME='content-library'
REPOS="https://e.klerks:ui8ulieBieli@hg.sanomaservices.nl/Webservices/Content-Library/$REPOSNAME"
REPOSDIR="$HOME/sanoma"
BACKUPNAME=$1
BACKUP_REPOS="$REPOSDIR/$BACKUPNAME"
CURRENT_REPOS="$REPOSDIR/$REPOSNAME"

OLD_DIR=`pwd`


if [[ -e $BACKUP_REPOS ]] {
    echo "old repos already exists"
    exit;
}

# Setting trap for rollback 
TRAPINT() {
    echo "rollback, this will clean $CURRENT_REPOS"
    if [[ -e $BACKUP_REPOS ]] {
        rm -vR $CURRENT_REPOS 
        mv $BACKUP_REPOS $CURRENT_REPOS 
    }
}



echo "moving current repos to backup repos"
mv -v $CURRENT_REPOS $BACKUP_REPOS 

echo "cd'ing into $REPOSDIR"
cd $REPOSDIR 

echo "cloning repository"
hg clone $REPOS   

echo "restoring local files"
for x in $LOCALS; {
        if [[ -e "$BACKUP_REPOS/$x" ]] {
                print "restoring $x"
                cp -v "$BACKUP_REPOS/$x" "$CURRENT_REPOS/$x";
        }
}
echo "cd'ing to $REPOSNAME"
cd $REPOSNAME 

echo "update develop"
hg update develop

echo "done"
cd $OLD_DIR


