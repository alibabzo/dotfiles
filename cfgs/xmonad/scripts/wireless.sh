#!/bin/sh
WIRELESS_ICON="<fn=1></fn>"
WIRED_ICON="<fn=1></fn>"
NOT_CONNECTED_ICON="<fn=1></fn>"
eth=$(nmcli c show --active | grep 'enp0s25')
wifi=$(iwgetid | cut -d \" -f 2)
output=''
if [[ "$eth" = '' && "$wifi" = '' ]]; then
    output="$NOT_CONNECTED_ICON disconnected"
else
    if [[ "$wifi" != '' ]]; then
        quality_calc=$(iwconfig wlp2s0 | grep Quality \
            | cut -d = -f 2 | cut -d ' ' -f 1 | bc -l)
        quality=${quality_calc:1:2}
        output="$WIRELESS_ICON $wifi $quality%"
    fi
    if [[ "$eth" != '' ]]; then
        output="$output $WIRED_ICON"
    fi
fi
echo $output
