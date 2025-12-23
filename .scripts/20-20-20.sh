#!/bin/bash

# 20-20-20 Eye Rest Reminder for Hyprland
# Every 20 minutes, shows a full-screen blocking reminder for 20 seconds

INTERVAL=1200  # 20 minutes in seconds
DURATION=20    # 20 seconds break

while true; do
    sleep $INTERVAL
    
    # Show notification warning
    notify-send -u critical -t 3000 "👁️ 20-20-20 EYE BREAK" "Eye break starting in 3 seconds..."
    
    sleep 3
    
    # Create full-screen blocking overlay using yad
    # Install: sudo pacman -S yad
    yad --width=1920 --height=1080 \
        --center \
        --undecorated \
        --no-buttons \
        --timeout=$DURATION \
        --timeout-indicator=top \
        --skip-taskbar \
        --on-top \
        --sticky \
        --fixed \
        --title="Eye Break" \
        --text="<span font='64' weight='bold' foreground='#eb6f92'>👁️  EYE BREAK TIME  👁️</span>

<span font='32' foreground='#e0def4'>Look at something <b>20 FEET</b> away (6 meters)</span>

<span font='32' foreground='#e0def4'>For <b>20 SECONDS</b></span>

<span font='28' foreground='#9ccfd8'>🪑 Stand up and look away from the screen</span>

<span font='20' foreground='#6e6a86'>This window will close automatically...</span>" \
        --text-align=center \
        --back=1f1d2e \
        --borders=50 &
    
    YAD_PID=$!
    
    # Wait for the duration
    sleep $DURATION
    
    # Kill yad if still running
    kill $YAD_PID 2>/dev/null
    
    # Show completion notification
    notify-send -u normal -t 3000 "✅ Eye Break Complete" "Great job! Back to work 💪"
done
