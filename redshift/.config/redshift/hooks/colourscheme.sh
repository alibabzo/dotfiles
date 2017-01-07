#!/bin/sh
event=$1
case $event in
    period-changed)
        period=$3
        case $period in
            night)
                colour-scheme dark
                ;;
            day)
                colour-scheme light
                ;;
        esac
        ;;
esac
