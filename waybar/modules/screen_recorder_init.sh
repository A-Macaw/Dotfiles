#!/bin/bash

# Path to obs-cli (make sure it's installed and available in your PATH)
OBS_CLI="obs-cli"

# Check if obs-cli is available
if ! command -v "$OBS_CLI" &> /dev/null; then
    echo '{"text": "  Error", "tooltip": "obs-cli not found", "class": "error"}'
    exit 0
fi

# Get OBS recording status
status=$("$OBS_CLI" recording status)

# Check if recording is active (look for 'Recording' in the output)
if echo "$status" | grep -q "Recording"; then
    if echo "$status" | grep -q "Paused"; then
        echo '{"text": " Paused", "tooltip": "OBS recording is paused", "class": "paused"}'
    else
        echo '{"text": " Recording", "tooltip": "OBS is recording", "class": "recording"}'
    fi
else
    echo '{"text": " Not Recording", "tooltip": "OBS is not recording", "class": "not-recording"}'
fi
