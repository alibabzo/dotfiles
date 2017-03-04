#!/usr/bin/env sh
awk '{ print "<fn=1></fn> " $1 }' /proc/loadavg
