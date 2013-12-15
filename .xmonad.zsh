#!/usr/bin/zsh

# Basic configuration file
RESOLUTION='1680x1050'
KEYB='us'


trayer --edge bottom --align right --SetDockType true --transparent true --tint 0x000000 --height 22 --SetPartialStrut true --monitor primary --expand true &
diodon &
compton -c &
davmail &
nm-applet --disable-sm &
feh --randomize --bg-max ~/.config/*.png ~/.config/*.jpg &
# xrandr --output Virtual3 --off --output Virtual2 --off --output Virtual1 --mode ${RESOLUTION} --pos 0x0 --rotate normal --output Virtual7 --off --output Virtual6 --off --output Virtual5 --off --output Virtual4 --off --output Virtual8 --off

# Start up pydoc
killall pydoc
daemonize pydoc -p 9922

# startup linc
killall pidgin
daemonize pidgin.sh

setxkbmap -layout ${KEYB}

while true; do  
        find ~/.wallpapers -type f -name '*.jpg' -o -name '*.png'  |
        shuf | head -n1 | xargs -I '{}' -n1 feh --bg-max '{}'
        sleep 5m
done
