#!/bin/sh

xrandr --output LVDS --mode 1920x1080
killall trayer
trayer --edge bottom --align right --SetDockType true --transparent true --tint 0x000000 --height 22 --SetPartialStrut true --monitor primary --expand true &

sudo mouseemu -right 29 272
