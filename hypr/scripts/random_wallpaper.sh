#!/bin/bash

WALLPAPER_DIR="$HOME/Documents/Images/Wallpapers"
MONITOR_NAME="HDMI-A-2"                     # Change this to your monitor's name if different
LAST_WALLPAPER_FILE="$HOME/.last_wallpaper" # File to store the last wallpaper path

# Function to check if hyprpaper is running
check_hyprpaper_running() {
  pgrep -x "hyprpaper" >/dev/null
}

# Keep checking if hyprpaper is running
while true; do
  if check_hyprpaper_running; then
    echo "hyprpaper is running, proceeding to set the wallpaper."
    break
  fi
  echo "Waiting for hyprpaper to start..."
  sleep 2 # Wait for 2 seconds before checking again
done

# Get a list of all potential wallpapers (adjust the -name patterns as needed)
ALL_WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -name "1.png" -o -name "2.png" -o -name "3.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" \) | sort)

if [ -z "$ALL_WALLPAPERS" ]; then
  echo "No wallpapers found in $WALLPAPER_DIR"
  exit 1
fi

# Read the last chosen wallpaper from the file
LAST_CHOSEN_WALLPAPER=""
if [ -f "$LAST_WALLPAPER_FILE" ]; then
  LAST_CHOSEN_WALLPAPER=$(cat "$LAST_WALLPAPER_FILE")
fi

# Convert the list of wallpapers into an array
readarray -t WALLPAPER_ARRAY <<<"$ALL_WALLPAPERS"

# Find a new wallpaper that is not the same as the last chosen one
NEW_WALLPAPER=""
while true; do
  RANDOM_INDEX=$((RANDOM % ${#WALLPAPER_ARRAY[@]}))
  SELECTED_WALLPAPER="${WALLPAPER_ARRAY[$RANDOM_INDEX]}"
  if [ "$SELECTED_WALLPAPER" != "$LAST_CHOSEN_WALLPAPER" ]; then
    NEW_WALLPAPER="$SELECTED_WALLPAPER"
    break
  fi
done

if [ -z "$NEW_WALLPAPER" ]; then
  echo "Could not select a new wallpaper. This might happen if there's only one wallpaper or an issue with selection logic."
  exit 1
fi

# Apply the selected wallpaper using hyprctl hyprpaper
hyprctl hyprpaper wallpaper "$MONITOR_NAME,$NEW_WALLPAPER"

# Save the newly chosen wallpaper to the file for the next run
echo "$NEW_WALLPAPER" >"$LAST_WALLPAPER_FILE"
echo "Set wallpaper on $MONITOR_NAME to: $NEW_WALLPAPER"
