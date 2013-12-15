#!/usr/bin/zsh
if [[ -e /tmp/shitfile ]] { 
        echo "nan"
        exit;
} 

touch /tmp/shitfile 
pylint --rcfile=~/vimscripts/rcfile $1 2>/dev/null | grep "rated at" | sed "s/Your code .* at/score/" | sed 's/(.*\ //' | sed 's/)//' | awk '{if ($1 == "score") print $2}' 
rm /tmp/shitfile

