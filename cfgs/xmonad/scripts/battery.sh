#!/bin/sh
BATTERY_ICON_0="<fn=1></fn>"
BATTERY_ICON_1="<fn=1></fn>"
BATTERY_ICON_2="<fn=1></fn>"
BATTERY_ICON_3="<fn=1></fn>"
BATTERY_ICON_4="<fn=1></fn>"
BATTERY_CHARGING="<fn=1></fn>"

battery_status=$(cat '/sys/class/power_supply/BAT0/status')
capacity=$(cat '/sys/class/power_supply/BAT0/capacity')
if [ $capacity -gt 85 ]; then
    battery_icon=$BATTERY_ICON_4
elif [ $capacity -gt 60 ]; then
    battery_icon=$BATTERY_ICON_3
elif [ $capacity -gt 40 ]; then
    battery_icon=$BATTERY_ICON_2
elif [ $capacity -gt 20 ]; then
    battery_icon=$BATTERY_ICON_1
else
    battery_icon=$BATTERY_ICON_0
fi

if [ "$battery_status" = "Charging" ]; then
    battery_icon="${BATTERY_CHARGING} ${battery_icon}"
fi
echo "${battery_icon} $capacity%"



