#!/bin/env bash
void_updates=$(xbps-install -Sun 2> /dev/null | wc -l)

if [ "$void_updates" -gt 0 ]; then
        echo $void_updates
else
        echo "";
fi
