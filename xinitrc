# Author:       Rafael Schreiber
# Date:         28-03-2019
 
setxkbmap -layout de
xmodmap ~/.Xmodmap
xrandr --output HDMI-1 --mode 1920x1080 --rate 60 --pos 2560x184 --rotate normal --output DP-2 --primary --mode 2560x1440 --rate 165 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-2 --off
exec i3