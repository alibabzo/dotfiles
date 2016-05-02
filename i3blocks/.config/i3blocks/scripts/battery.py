#!/usr/bin/env python3
#
# A battery indicator blocklet script for i3blocks

from subprocess import check_output

status = check_output(['acpi'], universal_newlines=True)
state = status.split(": ")[1].split(", ")[0]
commasplitstatus = status.split(", ")
percentleft = int(commasplitstatus[1].rstrip("%\n"))

FA_LIGHTNING = "<span font='FontAwesome'>\uf0e7</span>"
FA_BATTERY_FULL = "<span font='FontAwesome'>\uf240</span>"
FA_BATTERY_3_Q = "<span font='FontAwesome'>\uf241</span>"
FA_BATTERY_2_Q = "<span font='FontAwesome'>\uf242</span>"
FA_BATTERY_1_Q = "<span font='FontAwesome'>\uf243</span>"
FA_BATTERY_EMPTY = "<span font='FontAwesome'>\uf244</span>"
FA_PLUG = "<span font='FontAwesome'>\uf1e6</span>"


def color(percent):
    if percent < 10:
        return "#FF0000"
    if percent < 20:
        return "#FF3300"
    if percent < 30:
        return "#FF6600"
    if percent < 40:
        return "#FF9900"
    if percent < 50:
        return "#FFCC00"
    if percent < 60:
        return "#FFFF00"
    if percent < 70:
        return "#FFFF33"
    if percent < 80:
        return "#FFFF66"
    return "#FFFFFF"


def battery(percent):
    if percent <= 15:
        return FA_BATTERY_EMPTY
    if percent > 15 and percent <= 30:
        return FA_BATTERY_1_Q
    if percent > 30 and percent <= 70:
        return FA_BATTERY_2_Q
    if percent > 70 and percent <= 85:
        return FA_BATTERY_3_Q
    return FA_BATTERY_FULL

fulltext = "<span color='{}'>{}</span>".format(
    color(percentleft), battery(percentleft))
timeleft = ""

if state == "Discharging":
    time = commasplitstatus[-1].split()[0]
    time = ":".join(time.split(":")[0:2])
    timeleft = " ({})".format(time)
else:
    fulltext += " " + FA_PLUG


form = ' <span color="{}">{}%</span>'
fulltext += form.format(color(percentleft), percentleft)

print(fulltext)
print(fulltext)
