-- default desktop configuration for Fedora

import qualified Data.Map.Strict as M
import XMonad
import XMonad.Actions.TopicSpace
import XMonad.Config.Kde
import XMonad.Layout.Gaps
import XMonad.Layout.Magnifier
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

main :: IO ()
main = do
  xmonad $
    def
      { modMask = mod4Mask,
        terminal = "ghostty --theme=GitHub-Light-High-Contrast",
        manageHook = namedScratchpadManageHook scratchpads,
        startupHook = myStartupHook,
        borderWidth = 4,
        normalBorderColor = "#435274",
        focusedBorderColor = "#6f9460",
        layoutHook =
          gaps myGaps $
            Full
              ||| magnifier (TwoPane (3 / 100) (1 / 2))
              ||| magnifier (ResizableTall 1 (3 / 100) (1 / 2) []),
        handleEventHook = handleEventHook def <> Hacks.windowedFullscreenFixEventHook
      }
      `removeKeysP` ["M-<Tab>", "M-S-<Tab>"]
      `additionalKeysP` [ ("M-x", spawn "xscreensaver-command -lock"),
                          ("M-d", unGrab *> spawn "/home/igor/.nix-profile/bin/flameshot gui"),
                          ("M-s", spawn "firefox"),
                          ("M-a", sendMessage MirrorShrink),
                          ("M-z", sendMessage MirrorExpand),
                          ("M-y", spawn "bash youtube.sh"),
                          ("M-w", spawn "rofi -drun-use-desktop-cache -show combi"),
                          ("M-p", spawn "bash pomo.sh"),
                          ("M-o", spawn "pkill -f pomo.sh"),
                          ("M-n", spawn "dunstctl history-pop"),
                          ("M-m", spawn "dunstctl close"),
                          ("M-f", increaseGapHor),
                          ("M-g", diminishGapHor),
                          ("M-v", increaseGapVer),
                          ("M-b", diminishGapVer),
                          ("M-[", sendMessage MagnifyMore),
                          ("M-]", sendMessage MagnifyLess),
                          ("M-/", namedScratchpadAction scratchpads "business journal"),
                          ("M-;", namedScratchpadAction scratchpads "hoogle"),
                          ("M-.", namedScratchpadAction scratchpads "general terminal"),
                          ("M1-<Tab>", windows W.focusDown),
                          ("M1-S-<Tab>", windows W.focusUp),
                          ("M-<Return>", spawn "ghostty --theme=GitHub-Dark-High-Contrast")
                        ]
  where
    increaseGapHor =
      sendMessage (IncGap 5 U)
      >> sendMessage (IncGap 5 D)
      >> pure ()
    diminishGapHor =
      sendMessage (DecGap 5 U)
      >> sendMessage (DecGap 5 D)
      >> pure ()
    increaseGapVer =
      sendMessage (IncGap 5 R)
      >> sendMessage (IncGap 5 L)
      >> pure ()
    diminishGapVer =
      sendMessage (DecGap 5 R)
      >> sendMessage (DecGap 5 L)
      >> pure ()

myXPConfig =
  def
    { searchPredicate = fuzzyMatch,
      sorter = fuzzySort
    }

myGaps = [(U, 10), (D, 10), (R, 10), (L, 10)]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "redshift -l -15.78:-47.93 -t 5700:4000 -b 1.0:0.9 -g 0.8 -m randr -v"
  spawnOnce "dunst"
  spawnOnce "sleep 2 && /usr/bin/xset r rate 250 60"
  spawnOnce "sleep 2 && /home/igor/.nix-profile/bin/feh --bg-fill /home/igor/repos/walls-catppuccin-mocha/beach-path.jpg"
  spawnOnce "sleep 2 && /home/igor/.nix-profile/bin/flameshot"
  spawnOnce "sleep 2 && /home/igor/.nix-profile/bin/picom --config=/home/igor/.picom.conf"
  spawnOnce "sleep 2 && /home/igor/.nix-profile/bin/xbanish"

scratchpads =
  [ NS "business journal" "ghostty --class='com.igor.journal' -e '/home/igor/.nix-profile/bin/jrnl business'" (className =? "com.igor.journal") myFloat
  , NS "hoogle" "firefox --class='hoogle' localhost:8080" (className =? "hoogle") myFloat
  , NS "general terminal" "ghostty --class='com.igor.terminal'" (className =? "com.igor.terminal") myFloat
  ]
  where
    myFloat = customFloating $ W.RationalRect sixth sixth third third
    sixth = 1 / 6
    third = 2 / 3
