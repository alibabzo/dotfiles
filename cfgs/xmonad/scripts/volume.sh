#!/bin/sh
MUTED_VOLUME_ICON="<fn=1></fn>"
LOW_VOLUME_ICON="<fn=1></fn>"
HIGH_VOLUME_ICON="<fn=1></fn>"
sink_name=$(pactl info | grep 'Default Sink' | cut -d ' ' -f 3)
sink_id=$(pactl list short sinks | grep "$sink_name" | cut -f 1)

mute=$(pactl list sinks | grep '^[[:space:]]Mute:' \
    | head -n $(($sink_id + 1)) | tail -n 1 | cut -d' ' -f2)
vol=$(pactl list sinks | grep '^[[:space:]]Volume:' \
    | head -n $(($sink_id + 1)) | tail -n 1 \
    | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

if [ "$mute" = 'yes' ]; then
    output="${MUTED_VOLUME_ICON} muted"
elif [ $vol -lt 50 ]; then
    output="${LOW_VOLUME_ICON} $vol%"
else
    output="${HIGH_VOLUME_ICON} $vol%"
fi
echo "$output"
