#!/bin/bash

# Battery status path
BAT_PATH="/sys/class/power_supply/BAT0"
LOCK_FILE="/tmp/.battery"

# Read capacity and status
CAPACITY=$(cat "$BAT_PATH/capacity")
STATYS=$(cat "$BAT_PATH/status")

# Notification logic
if [ "$CAPACITY" -lt 25 ]; then
		if [ ! -f "$LOCK_FILE" ]; then
				notify-send -u critical "󰂃 Low Battery" "Battery is at ${CAPACITY}%\nPlease plug into power immediately."
				touch "$LOCK_FILE"
		fi
else
		# Remove lockfile
		[ -f "$LOCK_FILE" ] && rm "$LOCK_FILE"
fi
