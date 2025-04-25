#!/bin/bash

# Check if xidlehook or xautolock is running
# This is a simple implementation and might need adjustment based on your setup

INHIBIT_FILE="$HOME/.config/polybar/idle_inhibited"

if [ -f "$INHIBIT_FILE" ]; then
    echo "" # Inhibited icon
else
    echo "" # Not inhibited icon
fi
