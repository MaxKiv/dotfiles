#!/bin/bash

# Simple power menu using rofi or dmenu
# Install rofi or dmenu first

# Detect which dialog tool is available
if command -v rofi &> /dev/null; then
    DIALOG="rofi -dmenu -i -p Power"
elif command -v dmenu &> /dev/null; then
    DIALOG="dmenu -p Power:"
else
    echo "Neither rofi nor dmenu is installed. Please install one of them."
    exit 1
fi

# Define menu options
OPTIONS="Shutdown\nReboot\nSuspend\nHibernate"

# Show menu and get user choice
CHOICE=$(echo -e "$OPTIONS" | $DIALOG)

# Execute based on choice
case "$CHOICE" in
    "Shutdown")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Hibernate")
        systemctl hibernate
        ;;
    *)
        # Do nothing if no valid option selected
        ;;
esac
