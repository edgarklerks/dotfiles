{-# LANGUAGE FlexibleContexts #-}
module Main where
--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad hiding ((|||), Tall)
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Util.Cursor 
import XMonad.Layout.Mosaic
import XMonad.Layout.Circle
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog
import XMonad.Prompt
import XMonad.Prompt.XMonad
-- import XMonad.Prompt.Eval
import XMonad.Actions.UpdatePointer
import XMonad.Prompt.Man
import XMonad.Layout.LayoutModifier
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen as F
import XMonad.Layout.Spiral
import XMonad.Layout.HintedTile
import XMonad.Actions.WindowBringer
import XMonad.Actions.CycleWS
import XMonad.Actions.Search
import XMonad.Actions.Warp
import System.Cmd
import XMonad.Actions.Promote
import XMonad.Hooks.EwmhDesktops as E
import Data.List
import XMonad.Layout.Renamed
import XMonad.Layout.LayoutHints
import Text.Regex.TDFA ((=~~))
-- import XMonad.Actions.Eval

-- | Like query

like :: XMonad.Query String -> String -> XMonad.Query Bool
like q x = isInfixOf x `fmap` q

-- | Regex query

regex :: XMonad.Query String -> String -> XMonad.Query Bool
regex q x = ( =~~ x) =<< q
-- Dzen config
--


toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b )

dzenC :: LayoutClass l Window
     => XConfig l -> IO (XConfig (ModifiedLayout AvoidStruts l))
dzenC conf = statusBar ("dzen2 " ++ flags) dzenPP toggleStrutsKey conf
 where
    fg      = "'#a8a3f7'" -- n.b quoting
    bg      = "'#3f3c6d'"
    flags   = "-e 'onstart=lower' -w 400 -ta r -fg " ++ fg ++ " -bg " ++ bg

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "xterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 0

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["programming","browser", "servers","acceptatie"] ++ fmap show [4..9]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#00ff00"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [
      ((modm, xK_a), sendMessage Taller)
    , ((modm, xK_z), sendMessage Wider)
    , ((modm, xK_r), sendMessage Reset)
    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- Switch between layouts
    , ((modm .|. controlMask, xK_1), sendMessage $ JumpToLayout "Tall")
    , ((modm .|. controlMask, xK_2), sendMessage $ JumpToLayout "Wide")
    , ((modm .|. controlMask, xK_3), sendMessage $ JumpToLayout "Full")
    , ((modm .|. controlMask, xK_4), sendMessage $ JumpToLayout "Mirror")
    , ((modm .|. controlMask, xK_u), spawn "ruby /home/edgar/remote.rb nsfw")
    , ((modm .|. controlMask, xK_r), spawn "ruby /home/edgar/remote.rb sfw")
    , ((modm .|. controlMask, xK_n), spawn "ruby /home/edgar/remote.rb")
    , ((modm .|. controlMask, xK_p), spawn "zsh /home/eklerks/scripts/switch-screen.sh")
    -- xmonadPrompt
    , ((modm .|. controlMask, xK_x), xmonadPrompt defaultXPConfig)
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")
    -- navigate screens
    , ((modm, xK_Left), prevWS)
    , ((modm, xK_Right), nextWS)
    , ((modm, xK_Down), shiftToPrev)
    , ((modm, xK_Up), shiftToNext)
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
    , ((modm .|. shiftMask, xK_m ), manPrompt defaultXPConfig)
    , ((modm .|. shiftMask, xK_g), gotoMenu)-- windowPromptGoto defaultXPConfig)
    , ((modm .|. shiftMask, xK_b), bringMenu)-- windowPromptBring defaultXPConfig)
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm, xK_s), setDefaultCursor xC_spider)
    , ((modm, xK_y), setDefaultCursor xC_pirate)
    

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), promote)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- eval prompt
  --  , ((modm .|. controlMask              ,xK_e), evalPrompt  defaultEvalConfig defaultXPConfig)
    , ((modm           , xK_KP_Add), spawn "amixer -c 0 set Master 2dB+")
    , ((modm           , xK_KP_Subtract), spawn "amixer -c 0 set Master 2dB-")
    , ((modm .|. shiftMask, xK_l), spawn "xtrlock")
    , ((modm .|. shiftMask, xK_j), spawn "zsh /home/eklerks/scripts/jt.sh")

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f) >> warpToScreen sc (1/2) (1/2))
        | (key, sc) <- [xK_w, xK_e, xK_r] `zip` [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
--
-- take Fibonacci as AZZ
mosaicLayout = mosaic 5 fib
    where
     fib = reverse $ take 5 $ fib'
        where fib' = 1 : 2 : zipWith (+) fib' (tail fib')

myLayout = avoidStruts $ layoutHints $ fullscreenFull $ spacing 2 $ tiled Tall ||| tiled Wide ||| renamed [Replace "Mirror"] (Mirror (tiled Tall)) ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = HintedTile nmaster delta ratio Center

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

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
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , (className `like` "XMathematica") <||> (appName  `like` "Wolfram") <||> (appName `like` "Drawing Tools")  --> doFloat
    , appName =? "desktop_window" --> doIgnore
    , appName =? "kdesktop"       --> doIgnore
    , className =? "Firefox" <||> className =? "firefox"  --> doShift "browser"
    , className =? "logging" --> doShift "servers"
    , className =? "pidgin" <||> className =? "Pidgin" --> doShift "6"
    ] <+> manageDocks <+> fullscreenManageHook
------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = hintsEventHook <+> F.fullscreenEventHook <+> E.fullscreenEventHook <+> docksEventHook -- promoteWarp

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = dynamicLogWithPP xmobarPP

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
        liftIO $ system "zsh /home/eklerks/.xmonad.zsh &"
        setDefaultCursor xC_spider
        return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
--    system("setxkbmap -layout us")
    xconfig <- xmobar defaults
    xmonad $ ewmh xconfig

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--


defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }



-- Search function
--

mySearchEngine = intelligent (wikipedia !> alpha !> mathworld !> hoogle !> hackage !> scholar !> prefixAware google)
