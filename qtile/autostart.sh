#!/usr/bin/env bash

setxkbmap gb &
nitrogen --restore &
systemctl --user enable pulseaudio
picom &
# change the touchpad behaviour
xinput set-prop 12 "libinput Natural Scrolling Enabled" 1 
