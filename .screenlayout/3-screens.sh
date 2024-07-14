#!/bin/sh
xrandr --output eDP --primary --mode 1920x1080 --rate 59.93 --pos 1920x0 --rotate normal \
	--output HDMI-A-0 --mode 1920x1080 --rate 129.88 --pos 3840x0 --rotate normal \
	--output DisplayPOrt-0 --mode 1920x1080  --pos 0x0 --rotate normal \
	--output DisplayPort-1 --off \
	&& ~/.fehbg
