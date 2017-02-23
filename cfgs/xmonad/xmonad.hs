-- xmonad config used by Vic Fryzel
-- Author: Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import Control.Arrow (second)
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.PhysicalScreens
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Fullscreen hiding (fullscreenEventHook)
import XMonad.Layout.PerScreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W
import XMonad.Util.Cursor
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)

------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "termite"

-- The command to lock the screen or show the screensaver.
myLogout = "xfce4-session-logout"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher = "rofi -show drun -config ~/.config/rofi/launcher"

myBrowser = "chromium"

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces =
  clickable $
  ["1 <fn=1>\xf268</fn> ", "2 <fn=1>\xf120</fn> ", "3 <fn=1>\xf121</fn> "] ++
--  map (\x -> show x ++ " <fn=1>\xf108</fn> ") [4 .. 8] ++
  map show [4..9] ++
  ["10 <fn=1>\xf001</fn> "]
  where
    clickable l =
      [ "<action=xdotool key super+" ++
      show i ++ " button=1>" ++ ws ++ "</action>"
      | (i, ws) <- zip ([1 .. 9] ++ [0]) l
      ]

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook =
  composeAll
    [ className =? "Chromium" --> doShift (myWorkspaces !! 0)
    , className =? "Emacs" --> doShift (myWorkspaces !! 2)
    , resource =? "desktop_window" --> doIgnore
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]

------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

myLayout = smartBorders $ avoidStruts $ ifWider 1920 widelayouts talllayouts
    where
        widelayouts = spacing 10 (ThreeColMid 1 (3 / 100) (1 / 2) ||| spiral (6 / 7) ||| Tall 1 (3 / 100) (1 / 2)) ||| noBorders Full
        talllayouts = spacing 10 (Mirror (Tall 1 (3 / 100) (1 / 2))) ||| noBorders Full

------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
--
myNormalBorderColor = "#D39A78"

myFocusedBorderColor = myNormalBorderColor


-- Color of current window title in xmobar.
xmobarTitleColor = "#b2b2b2"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#e5e6e6"
xmobarVisibleWorkspaceColor = "#b2b2b2"

xmobarUrgentWorkspaceColor = "#e32791"

xmobarInactiveWorkspaceColor = "#d9d9d9"

-- Width of the window border in pixels.
myBorderWidth = 0

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

myKeys conf@XConfig {XMonad.modMask = modMask} =
  M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --
  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
  -- Lock the screen using command specified by myLogout.
  , ((modMask .|. shiftMask, xK_q), spawn myLogout)
  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  , ((modMask, xK_d), spawn myLauncher)
  -- Start a browser. Browser to start is specified by myBrowser variable.
  , ((modMask .|. shiftMask, xK_c), spawn myBrowser)
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
  -- Restart xmonad.
  , ((modMask .|. shiftMask, xK_r), spawn "xmonad --recompile && xmonad --restart")
  ] ++
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [ ((m .|. modMask, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ] ++
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
   [((m .|. modMask, k), f sc)
   | (k, sc) <- zip [xK_w, xK_e, xK_r] [0..]
   , (f, m) <- [(viewScreen, 0), (sendToScreen, shiftMask)]
   ]

------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

button6 = 6 :: Button
button7 = 7 :: Button
button8 = 8 :: Button
button9 = 9 :: Button

myMouseBindings XConfig {XMonad.modMask = modMask} =
  M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
  [ ((modMask, button1), \ w -> focus w >> mouseMoveWindow w)
    -- mod-button2, Raise the window to the top of the stack
  , ((modMask, button2), \ w -> focus w >> windows W.swapMaster)
    -- mod-button3, Set the window to floating mode and resize by dragging
  , ((modMask, button3), \ w -> focus w >> mouseResizeWindow w)
    --  media controls
  , ((0, button9), \ w -> spawn "mpc next")
  , ((0, button8), \ w -> spawn "mpc prev")
  ]
  ++ map (second const) (prevNextWorkspaceBindings modMask button6 button7)

prevNextWorkspaceBindings modMask prev next =
    [ ((modMask, next), nextWS)
    , ((modMask, prev), prevWS)
    , ((modMask .|. shiftMask, next), shiftToNext)
    , ((modMask .|. shiftMask, prev), shiftToPrev)
    ]

------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $
    docks $ defaults
    { logHook =
        do fadeInactiveLogHook 0.8
           dynamicLogWithPP $
             xmobarPP
             { ppOutput = hPutStrLn xmproc
             , ppCurrent = xmobarColor "white" ""
             , ppVisible = xmobarColor xmobarVisibleWorkspaceColor ""
             , ppHidden = xmobarColor xmobarInactiveWorkspaceColor ""
             , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
             , ppUrgent = xmobarColor xmobarUrgentWorkspaceColor ""
             , ppSep = "   "
             }
    , manageHook = myManageHook
    , startupHook = myStartupHook
    , handleEventHook = fullscreenEventHook
    }

------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
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
    -- key bindings
  , keys = myKeys
  , mouseBindings = myMouseBindings
    -- hooks, layouts
  , layoutHook = myLayout
  , manageHook = myManageHook
  , startupHook = myStartupHook
  }
