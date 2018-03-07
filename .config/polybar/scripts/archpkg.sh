#!/bin/env bash
arch_updates=$(checkupdates 2> /dev/null | wc -l)
aur_updates=$(trizen -Qu --aur 2> /dev/null | wc -l)

if [ "$arch_updates" -gt 0 ] || [ "$aur_updates" -gt 0 ]; then
        echo $((arch_updates + aur_updates))
else
        echo "";
fi
