#!/bin/bash

# Path to obs-cli (make sure it's installed and available in your PATH)
OBS_CLI="obs-cli"

# Check if obs-cli is installed
if ! command -v "$OBS_CLI" &> /dev/null; then
    notify-send "Screen Recorder" "obs-cli not found. Please install obs-cli."  # Debugging notification
    exit 1
fi

# Argument passed to the script (action to be taken)
ACTION=$1

# Run the appropriate action based on the passed argument
case "$ACTION" in
    restart)
        # Start recording
        "$OBS_CLI" recording start
        notify-send "Screen Recorder" "Recording started"
        ;;
    stop)
        # Stop recording
        "$OBS_CLI" recording stop
        notify-send "Screen Recorder" "Recording stopped"
        ;;
    save)
        # Toggle pause/resume recording
        "$OBS_CLI" recording pause toggle  # Toggle between pause and resume
        notify-send "Screen Recorder" "Recording paused/resumed"
        ;;
    *)
        echo "Unknown action: $ACTION"
        exit 1
        ;;
esac
