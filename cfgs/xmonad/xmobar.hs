-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config

Config {
    font = "xft:Roboto:size=10",
    additionalFonts = ["xft:FontAwesome:size=10"],
    alpha = 150,
    bgColor = "#212121",
    fgColor = "#e5e6e6",
    position = BottomSize C 100 24,
    lowerOnStart = True,
    commands = [
        Run CoreTemp [
        "--template" , "<fn=1>\xf06d</fn> <core0>°C"
        ] 10,
        Run Com "sh" [
            "-c", "awk '{ print \"<fn=1>\xf1fe</fn> \" $1 }' /proc/loadavg"
        ] "loadavg" 10,
        Run Date "<fn=1>\xf017</fn> %a %d %b %H:%M" "date" 10,
    --    Run StdinReader,
    Run UnsafeStdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "  %UnsafeStdinReader%  } { %coretemp%   %loadavg%   %date%   "
       }
