#!/usr/bin/env bash

#set the keyboard layout
setxkbmap gb &
# set background
# nitrogen --restore &
# set the audio settings
systemctl --user enable pulseaudio
#set compositor settigs
picom &
# change the touchpad behaviour
#xinput set-prop 12 "libinput Natural Scrolling Enabled" 1 
