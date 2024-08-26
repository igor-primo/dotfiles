-- default desktop configuration for Fedora

import XMonad

import XMonad.Util.EZConfig

import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.TwoPane
import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns

import XMonad.Actions.DynamicProjects
import XMonad.Util.NamedScratchpad
import XMonad.ManageHook

import qualified Data.Map.Strict as M
import qualified XMonad.StackSet as W

import XMonad.Actions.TopicSpace
import XMonad.Prompt
import XMonad.Prompt.Workspace
import XMonad.Prompt.FuzzyMatch

import qualified XMonad.Util.Hacks as Hacks

main :: IO ()
main = do
     -- xmonad $ dynamicProjects projects def
     xmonad $ def
          { modMask = mod4Mask
          , terminal = "st"
          , manageHook = namedScratchpadManageHook scratchpads
          , workspaces = [ "1" ]
          , borderWidth = 3
          , normalBorderColor = "#4f3928"
          , focusedBorderColor = "#ebe9e7"
          , layoutHook =
            gaps myGaps $  
            magnifier (TwoPane (3/100) (1/2))
            ||| magnifier (ResizableTall 1 (3/100) (1/2) [])
            ||| magnifier (ThreeColMid 1 (3/100) (1/2))
            ||| magnifier (ThreeCol 1 (3/100) (1/2))
            ||| Full
          , handleEventHook = handleEventHook def <> Hacks.windowedFullscreenFixEventHook
          }
          `additionalKeysP`
          [ ("M-x", spawn "xscreensaver-command -lock")
          , ("M-C-s", unGrab *> spawn "xfce4-screenshooter")
          , ("M-s", spawn "firefox")
          , ("M-a", sendMessage MirrorShrink)
          , ("M-z", sendMessage MirrorExpand)
          , ("M-y", spawn "bash youtube.sh")
          , ("M-w", spawn "rofi -drun-use-desktop-cache -show combi")
          , ("M-p", spawn "bash pomo.sh")
          , ("M-o", spawn "pkill -f pomo.sh")
          , ("M-n", spawn "dunstctl history-pop")
          , ("M-m", spawn "dunstctl close")
--          , ("M-/", switchProjectPrompt myXPConfig)
--          , ("M-;", shiftToProjectPrompt myXPConfig)
          , ("M-f", increaseGapHor)
          , ("M-g", diminishGapHor)
          , ("M-v", increaseGapVer)
          , ("M-b", diminishGapVer)
          , ("M-[", sendMessage MagnifyMore)
          , ("M-]", sendMessage MagnifyLess)
          , ("M-/", namedScratchpadAction scratchpads "processes")
          ]
          where 
          increaseGapHor = do
            _ <- sendMessage (IncGap 5 U)
            _ <- sendMessage (IncGap 5 D)
            pure () 
          diminishGapHor  = do
            _ <- sendMessage (DecGap 5 U)
            _ <- sendMessage (DecGap 5 D)
            pure () 
          increaseGapVer = do
            _ <- sendMessage (IncGap 5 R)
            _ <- sendMessage (IncGap 5 L)
            pure ()
          diminishGapVer = do
            _ <- sendMessage (DecGap 5 R)
            _ <- sendMessage (DecGap 5 L)
            pure ()

-- Dynamics Workspaces stuff

projects :: [Project]
projects =
  [ Project { projectName      = "1:livre"
            , projectDirectory = "~/"
            , projectStartHook = Just (spawn "firefox")
            }
  , Project { projectName      = "2:dotfiles"
            , projectDirectory = "~/.config/home-manager"
            , projectStartHook = Just (spawn "st")
            }
  , Project { projectName      = "3:journaling"
            , projectDirectory = "~/org"
            , projectStartHook = Just (spawn "st")
            }
  , Project { projectName      = "4:boilpage"
            , projectDirectory = "~/repos/boilpage"
            , projectStartHook = Just $ do spawnBoilpage
            }
  , Project { projectName      = "5:tcc"
            , projectDirectory = "~/repos/tcc-2024"
            , projectStartHook = Just $ do spawnTCC
            }
  ]

workspaceNames :: [Project] -> [String]
workspaceNames = map projectName

myXPConfig = def { searchPredicate = fuzzyMatch
                 , sorter          = fuzzySort
                 }

spawnTCC :: X ()
spawnTCC = spawn "st -e zsh -i -c 'tmuxinator start tcc -p tcc.yml'"
         *> spawn "st -e zsh -i -c nvim"
         *> spawn "firefox"

spawnBoilpage :: X ()
spawnBoilpage = spawn "st -e zsh -i -c 'tmuxinator start boilpage -p boilpage.yml'"
              *> spawn "st -e zsh -i -c nvim"

myGaps = [ (U, 10), (D, 10), (R, 10), (L, 10) ]              

scratchpads = [ NS "processes" "st -e zsh -i -c nvim ~/repos" (title =? "zsh") myFloat ]
  where myFloat = customFloating $ W.RationalRect sixth sixth third third
        sixth = 1 / 6
        third = 2 / 3
