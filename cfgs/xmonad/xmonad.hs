------------------------------------------------------------------------
-- Imports
import qualified Data.Map as M (fromList, Map)

import GHC.IO.Encoding as GIO (setFileSystemEncoding, char8)
import Graphics.X11.ExtraTypes.XF86
       (xF86XK_AudioLowerVolume, xF86XK_AudioMute,
        xF86XK_AudioRaiseVolume)
import Network.HostName (getHostName)
import System.IO (hPutStrLn)

import XMonad

import XMonad.Actions.PhysicalScreens
       (getScreen, sendToScreen, viewScreen)
import XMonad.Actions.UpdatePointer (updatePointer)

import XMonad.Hooks.DynamicLog
       (dynamicLogWithPP, ppCurrent, ppVisible, ppUrgent, ppHidden,
        ppOutput, ppSep, ppTitle, shorten, xmobarColor)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.SetWMName (setWMName)

-- import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Hooks.ManageHelpers
       (doCenterFloat, isDialog)

import XMonad.Layout.Gaps (gaps, Direction2D(U, D, L, R))
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.PerScreen (ifWider)
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft))
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.Spiral (spiral)
import XMonad.Layout.ThreeColumns (ThreeCol(ThreeColMid))

import XMonad.Prompt
       (deleteConsecutive, Direction1D(Next), XPPosition(..),
        XPConfig(..))
import XMonad.Prompt.Shell (shellPrompt)

import qualified XMonad.StackSet as W
       (focusDown, focusMaster, focusUp, greedyView, view, shift, sink,
        swapDown, swapMaster, swapUp)

import XMonad.Util.Run (spawnPipe)

import XMobar (xmobar)

------------------------------------------------------------------------
-- Variables
myModMask = mod4Mask

-- Terminal
myTerminal = "termite"

-- Logout command
myLogout hostname =
  if hostname == "a-laptop"
    then "shutdown_menu"
    else "xfce4-session-logout"

-- Launcher
myLauncher = "rofi -show drun -config ~/.config/rofi/launcher"

-- Browser
myBrowser = "chromium"

-- Gap size (px)
myGaps = 5

-- Width of the window border in pixels.
myBorderWidth = 0

-- Colours
xmobarTitleColor = "#b2b2b2"

myNormalBorderColor = "#D39A78"

myFocusedBorderColor = myNormalBorderColor

xmobarVisibleWorkspaceColor = "#b2b2b2"

xmobarUrgentWorkspaceColor = "#e32791"

xmobarCurrentWorkspaceColor = xmobarFgColor

xmobarInactiveWorkspaceColor = "#d9d9d9"

xmobarFgColor = "#e5e6e6"

xmobarBgColor = "#212121"

xmobarFont = "xft:Roboto:size=10"

myXPConfig =
  def
  { position = Top
  , font = "xft:Roboto:size=14"
  , promptBorderWidth = 0
  , height = 30
  , historySize = 100
  , historyFilter = deleteConsecutive
  }

------------------------------------------------------------------------
-- Workspaces
myWorkspaces =
  clickable $
  ["1 <fn=1>\xf268</fn> ", "2 <fn=1>\xf120</fn> ", "3 <fn=1>\xf121</fn> "] ++
  map show [4 .. 9] ++ ["10 <fn=1>\xf001</fn> "]
  where
    clickable l =
      [ "<action=xdotool key super+" ++
      show i ++ " button=1>" ++ ws ++ "</action>"
      | (i, ws) <- zip ([1 .. 9] ++ [0]) l
      ]

------------------------------------------------------------------------
-- Window rules
myManageHook =
  composeAll
    [ className =? "Chromium-browser" --> doShift (myWorkspaces !! 0)
    , className =? "Emacs" --> doShift (myWorkspaces !! 2)
    , resource =? "desktop_window" --> doIgnore
    , isDialog --> doCenterFloat
    ]

------------------------------------------------------------------------
-- Layouts
myLayout = avoidStruts $
  renamed [CutWordsLeft 2] $ ifWider 1080 widelayouts talllayouts
  where
    widelayouts =
      gaps gs $
      spacing
        myGaps
        (ThreeColMid 1 (3 / 100) (1 / 2) |||
         spiral (6 / 7) ||| Tall 1 (3 / 100) (1 / 2)) |||
      noBorders Full
    talllayouts =
      gaps gs $
      spacing myGaps (Mirror (Tall 1 (3 / 100) (1 / 2))) ||| noBorders Full
    gs = [(U, myGaps), (D, myGaps), (L, myGaps), (R, myGaps)]

------------------------------------------------------------------------
-- Key bindings
myKeys hostname conf@XConfig {XMonad.modMask = modMask} =
  M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --
  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
  -- Lock the screen using command specified by myLogout.
  , ((modMask .|. shiftMask, xK_q), spawn (myLogout hostname))
  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  , ((modMask, xK_d), shellPrompt myXPConfig)
  -- Start a browser. Browser to start is specified by myBrowser variable.
  , ((modMask .|. shiftMask, xK_c), spawn myBrowser)
  -- Mute volume
  , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
  -- Decrease volume
  , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%")
  --Increase volume
  , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%")
  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --
  -- Close focused window.
  , ((modMask, xK_q), kill)
  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space), sendMessage NextLayout)
  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n), refresh)
  -- Move focus to the next window.
  , ((modMask, xK_Tab), windows W.focusDown)
  -- Move focus to the next window.
  , ((modMask, xK_j), windows W.focusDown)
  -- Move focus to the previous window.
  , ((modMask, xK_k), windows W.focusUp)
  -- Move focus to the master window.
  , ((modMask, xK_m), windows W.focusMaster)
  -- Swap the focused window and the master window.
  , ((modMask, xK_Return), windows W.swapMaster)
  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
  -- Shrink the master area.
  , ((modMask, xK_h), sendMessage Shrink)
  -- Expand the master area.
  , ((modMask, xK_l), sendMessage Expand)
  -- Push window back into tiling.
  , ((modMask, xK_t), withFocused $ windows . W.sink)
  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma), sendMessage (IncMasterN 1))
  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
  ] ++
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [ ((m .|. modMask, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ] ++
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [ ((m .|. modMask, k), f sc)
  | (k, sc) <- zip [xK_w, xK_e, xK_r] [0 ..]
  , (f, m) <- [(viewScreen, 0), (sendToScreen, shiftMask)]
  ]

------------------------------------------------------------------------
-- Mouse bindings
myFocusFollowsMouse = True

myMouseBindings XConfig {XMonad.modMask = modMask} =
  M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w)
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), \w -> focus w >> windows W.swapMaster)
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w)
    ]

------------------------------------------------------------------------
-- Status bars and logging
myLogHook h =
  dynamicLogWithPP
    (def
     { ppOutput = hPutStrLn h
     , ppCurrent = xmobarColor "white" ""
     , ppVisible = xmobarColor xmobarVisibleWorkspaceColor ""
     , ppHidden = xmobarColor xmobarInactiveWorkspaceColor ""
     , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
     , ppUrgent = xmobarColor xmobarUrgentWorkspaceColor ""
     , ppSep = "   "
     }) >>
  updatePointer (0.5, 0.5) (0, 0) >>
  setWMName "LG3D"

------------------------------------------------------------------------
-- Startup hook
myStartupHook = do
  Just s0 <- getScreen 0
  Just s1 <- getScreen 1
  screenWorkspace s1 >>= flip whenJust (windows . W.view)
  windows $ W.greedyView (myWorkspaces !! 1)
  screenWorkspace s0 >>= flip whenJust (windows . W.view)

------------------------------------------------------------------------
-- Run xmonad
main = do
  GIO.setFileSystemEncoding GIO.char8 -- workaround for xmonad #611
  host <- getHostName
  xmobarProc <- spawnPipe (XMobar.xmobar host)
  xmonad $
    docks $
    fullscreenSupport $
    ewmh
    defaults
    { keys = myKeys host
    , logHook = myLogHook xmobarProc
    }

------------------------------------------------------------------------
-- No need to modify this.
defaults =
  def
    -- simple stuff
  { terminal = myTerminal
  , focusFollowsMouse = myFocusFollowsMouse
  , borderWidth = myBorderWidth
  , modMask = myModMask
  , workspaces = myWorkspaces
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , mouseBindings = myMouseBindings
    -- hooks, layouts
  , layoutHook = myLayout
  , manageHook = myManageHook
  , startupHook = myStartupHook
  }
