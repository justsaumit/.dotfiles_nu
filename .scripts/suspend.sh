#!/bin/bash 
swayidle -w \
      timeout 600 'swaylock -f' \
      timeout 900 ' hyprctl dispatch dpms off' \
              resume ' hyprctl dispatch dpms on'  \
      before-sleep 'loginctl lock-session $XDG_SESSION_ID' \
      lock 'playerctl -a pause && swaylock -f' 
