module XMobar (xmobar) where

import Data.List
import Text.Printf

xmobar :: String -> String
xmobar hostname = unwords ["xmobar", xmobarLook, xmobarTemplate hostname]

xmobarFont :: String
xmobarFont = "xft:Roboto:size=10"

xmobarBgColour :: String
xmobarBgColour = "#212121"

xmobarFgColour :: String
xmobarFgColour = "#e5e6e6"

xmobarLook :: String
xmobarLook = unwords
    [ printf "--font='%s'" xmobarFont
    , printf "--bgcolor='%s'" xmobarBgColour
    , printf "--fgcolor='%s'" xmobarFgColour
    ]

xmobarComParameters :: [String] -> String
xmobarComParameters [] = "[]"
xmobarComParameters c = printf "[\"%s\"]" (intercalate "\", \"" c)

xmobarStdin :: String
xmobarStdin = "Run UnsafeStdinReader"

xmobarCommands :: [String] -> String
xmobarCommands c = printf "--commands='[%s]'" (intercalate ", " c)

xmobarScript :: String -> [String] -> String -> Integer -> String
xmobarScript c p = printf "Run Com \"%s\" %s \"%s\" %d" c (xmobarComParameters p)

xmobarBattery :: String -> Integer -> String
xmobarBattery = xmobarScript "sh" [ "-c", "~/.config/xmobar/scripts/battery.sh" ]

xmobarLoad :: String -> Integer -> String
xmobarLoad = xmobarScript "sh" [ "-c", "~/.config/xmobar/scripts/load.sh" ]

xmobarNetwork :: String -> String -> String -> Integer -> String
xmobarNetwork lan wlan = xmobarScript "sh" [ "-c", "~/.config/xmobar/scripts/network.sh", lan, wlan ]

xmobarVolume :: String -> Integer -> String
xmobarVolume = xmobarScript "sh" [ "-c", "~/.config/xmobar/scripts/volume.sh" ]

xmobarCoreTemp :: Integer -> String
xmobarCoreTemp rr = concat
    [ "Run CoreTemp"
    , xmobarComParameters [ "--template", "<fn=1>\xf06d</fn> <core0>°C" ]
    , show rr
    ]

xmobarDate :: Integer -> String
xmobarDate rr = "Run Date \"<fn=1>\xf017</fn> %a %d %b %H:%M\" \"date\" "
    ++ show rr

xmobarSep :: String
xmobarSep = "   "

templateParameter :: [String] -> String
templateParameter template = printf " -t '%s'" (intercalate xmobarSep template)

xmobarTemplate :: String -> String
xmobarTemplate "a-desktop" = xmobarCommands
    [ xmobarStdin
    , xmobarLoad "load" 100
    , xmobarCoreTemp 100
    , xmobarDate 100
    ] ++ templateParameter
    [ "   %UnsafeStdinReader%}{"
    , "%coretemp%"
    , "%load%"
    , "%date%   "
    ]
xmobarTemplate "a-laptop" = xmobarCommands
    [ xmobarStdin
    , xmobarLoad "load" 100
    , xmobarCoreTemp 100
    , xmobarNetwork "enp0s25" "wlp3s0" "network" 600
    , xmobarVolume "volume" 30
    , xmobarBattery "battery" 600
    , xmobarDate 100
    ] ++ templateParameter
    [ "   %UnsafeStdinReader%}{"
    , "%coretemp%"
    , "%volume%"
    , "%network%"
    , "%battery%"
    , "%load%"
    , "%date%   "
    ]
xmobarTemplate _ = ""
