-- default desktop configuration for Fedora

import XMonad

import XMonad.Util.EZConfig
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.TwoPane
import qualified XMonad.Util.Hacks as Hacks

main :: IO ()
main = do
     xmonad $ def
          { modMask = mod4Mask
          , terminal = "st"
          , borderWidth = 3
          , normalBorderColor = "#4f3928"
          , focusedBorderColor = "#ebe9e7"
          , layoutHook = spacingWithEdge 5 $ TwoPane (3/100) (1/2) ||| Full ||| ResizableTall 1 (3/100) (1/2) []
          , handleEventHook = handleEventHook def <> Hacks.windowedFullscreenFixEventHook
          }
          `additionalKeysP`
          [ ("M-x", spawn "xscreensaver-command -lock")
          , ("M-C-s", unGrab *> spawn "xfce4-screenshooter")
          , ("M-s", spawn "chromium-browser")
          , ("M-e", spawn "emacsclient -c")
          , ("M-a", sendMessage MirrorShrink)
          , ("M-z", sendMessage MirrorExpand)
          , ("M-y", spawn "youtube.sh")
          , ("M-w", spawn "rofi -drun-use-desktop-cache -show combi")
          ]
   
