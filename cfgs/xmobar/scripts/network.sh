#!/usr/bin/env sh
ETHERNET_INTERFACE=$1
WIRELESS_INTERFACE=$2
WIRELESS_ICON="<fn=1></fn>"
WIRED_ICON="<fn=1></fn>"
NOT_CONNECTED_ICON="<fn=1></fn>"
eth=$(nmcli c show --active | grep "$ETHERNET_INTERFACE")
wifi=$(iwgetid | cut -d \" -f 2)
output=''
if [ "$eth" = '' ] && [ "$wifi" = '' ]; then
    output="$NOT_CONNECTED_ICON disconnected"
else
    if [ "$wifi" != '' ]; then
        quality=$(iwconfig "$WIRELESS_INTERFACE" | grep Quality \
            | cut -d = -f 2 | cut -d ' ' -f 1 | bc -l \
            | head -c 3 | tail -c 2)
        output="$WIRELESS_ICON $wifi $quality%"
    fi
    if [ "$eth" != '' ]; then
        output="$output $WIRED_ICON"
    fi
fi
echo "$output"
