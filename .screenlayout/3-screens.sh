#!/bin/sh
#
## use with laptop side by side setup
# xrandr --output eDP --primary --mode 1920x1080 --rate 60.05 --pos 1920x0 --rotate normal \
# 	--output HDMI-A-0 --mode 1920x1080 --rate 120.00 --pos 3840x0 --rotate normal \
# 	--output DisplayPort-0 --mode 1920x1080  --pos 0x0 --rotate normal \
# 	--output DisplayPort-1 --off \
# 	&& ~/.fehbg

## use with laptop and portable monitor:
## laptop on the left, HDMI output on the right, Displayport-0 output under the laptop. 
xrandr --output eDP --primary --mode 1920x1080 --rate 60.05 --pos 0x0 --rotate normal \
	--output HDMI-A-0 --mode 1920x1080 --rate 120.00 --pos 1920x0 --rotate normal \
	--output DisplayPort-0 --mode 1920x1080 --rate 60.00 --pos 0x1080 --rotate normal \
	--output DisplayPort-1 --off
	&& ~/.fehbg

