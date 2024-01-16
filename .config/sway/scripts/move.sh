#!/bin/bash

# Get the current focused window's ID
focused_window_id=$(swaymsg -t get_tree | jq -r '.. | objects | select(.focused == true).id')

# Get the workspace's edge windows' IDs
leftmost_window_id=$(swaymsg -t get_tree | jq -r ".. | objects | select(.type == \"con\" and .rect.x == 0) | .id" | head -n 1)
rightmost_window_id=$(swaymsg -t get_tree | jq -r ".. | objects | select(.type == \"con\" and (.rect.x + .rect.width) == 3840) | .id" | head -n 1)
topmost_window_id=$(swaymsg -t get_tree | jq -r ".. | objects | select(.type == \"con\" and .rect.y == 0) | .id" | head -n 1)
bottommost_window_id=$(swaymsg -t get_tree | jq -r ".. | objects | select(.type == \"con\" and (.rect.y + .rect.height) == 2160) | .id" | head -n 1)

# Determine the direction based on the script's argument
direction=$1

# Move the focused window based on the direction, if applicable
case $direction in
    left)
        if [ "$focused_window_id" != "$leftmost_window_id" ]; then
            swaymsg move left
        fi
        ;;
    right)
        if [ "$focused_window_id" != "$rightmost_window_id" ]; then
            swaymsg move right
        fi
        ;;
    up)
        if [ "$focused_window_id" != "$topmost_window_id" ]; then
            swaymsg move up
        fi
        ;;
    down)
        if [ "$focused_window_id" != "$bottommost_window_id" ]; then
            swaymsg move down
        fi
        ;;
esac
