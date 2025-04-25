#!/bin/bash

INHIBIT_FILE="$HOME/.config/polybar/idle_inhibited"

if [ -f "$INHIBIT_FILE" ]; then
    # If currently inhibited, remove inhibition
    rm "$INHIBIT_FILE"
    
    # Re-enable your screensaver/idle system
    # Adjust these commands based on your setup
    if command -v xautolock &> /dev/null; then
        xautolock -enable
    elif command -v xidlehook &> /dev/null; then
        pkill -USR1 xidlehook # This assumes xidlehook is set up to toggle on USR1
    fi
else
    # If not inhibited, create inhibition
    touch "$INHIBIT_FILE"
    
    # Disable your screensaver/idle system
    # Adjust these commands based on your setup
    if command -v xautolock &> /dev/null; then
        xautolock -disable
    elif command -v xidlehook &> /dev/null; then
        pkill -USR1 xidlehook # This assumes xidlehook is set up to toggle on USR1
    fi
fi

# Force polybar to update this module
pkill -RTMIN+1 polybar
