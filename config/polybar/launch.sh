#!/usr/bin/env sh

# Author:       Rafael Schreiber
# Date:         28-03-2019 

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar -r main -c /home/rafael/.config/polybar/config &
polybar -r main2 -c /home/rafael/.config/polybar/config & # remove this line if you're just using one display output
