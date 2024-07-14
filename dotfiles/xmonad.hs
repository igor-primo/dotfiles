-- default desktop configuration for Fedora

import XMonad

import XMonad.Util.EZConfig

import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.TwoPane

import XMonad.Actions.DynamicProjects
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
     xmonad $ dynamicProjects projects def
          { modMask = mod4Mask
          , terminal = "st"
          , workspaces = workspaceNames projects
          , borderWidth = 3
          , normalBorderColor = "#4f3928"
          , focusedBorderColor = "#ebe9e7"
          -- , workspaces = workspaceNames projects
          , layoutHook =
            spacingWithEdge 5 $  TwoPane (3/100) (1/2)
            ||| Full
            ||| ResizableTall 1 (3/100) (1/2) []
          , handleEventHook = handleEventHook def <> Hacks.windowedFullscreenFixEventHook
          }
          `additionalKeysP`
          [ ("M-x", spawn "xscreensaver-command -lock")
          , ("M-C-s", unGrab *> spawn "xfce4-screenshooter")
          , ("M-s", spawn "firefox")
          , ("M-e", spawn "emacsclient -c")
          , ("M-a", sendMessage MirrorShrink)
          , ("M-z", sendMessage MirrorExpand)
          , ("M-y", spawn "youtube.sh")
          , ("M-w", spawn "rofi -drun-use-desktop-cache -show combi")
          , ("M-p", spawn "pomo.sh")
          , ("M-o", spawn "pkill -f pomo.sh")
          , ("M-n", spawn "dunstctl history-pop")
          , ("M-m", spawn "dunstctl close")
          , ("M-/", switchProjectPrompt myXPConfig)
          , ("M-;", shiftToProjectPrompt myXPConfig)
          -- , ("M-/" , promptedGoto)
          -- , ("M-;" , promptedShift)
          ]
          -- ++
          -- -- The following does two things:
          -- --   1. Switch topics (no modifier)
          -- --   2. Move focused window to topic N (shift modifier)
          -- [ ("M-" ++ m ++ k, f i)
          -- | (i, k) <- zip (topicNames topicItems) (map show [1 .. 9 :: Int])
          -- , (f, m) <- [(goto, ""), (windows . W.shift, "S-")]
          -- ]

-- Dynamics Workspaces stuff

projects :: [Project]
projects =
  [ Project { projectName      = "1:livre"
            , projectDirectory = "~/"
            , projectStartHook = Just (spawn "firefox")
            }
  , Project { projectName      = "2:dotfiles"
            , projectDirectory = "~/.config/home-manager"
            , projectStartHook = Just (spawn "emacsclient -c ~/.config/home-manager")
            }
  , Project { projectName      = "3:journaling"
            , projectDirectory = "~/org"
            , projectStartHook = Just (spawn "emacsclient -c ~/org")
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
spawnTCC = spawn "st"
         *> spawn "firefox"
         *> spawn "emacsclient -c ~/repos/tcc-2024"

spawnBoilpage :: X ()
spawnBoilpage = spawn "st"
              *> spawn "firefox"
              *> spawn "emacsclient -c ~/repos/boilpage"

-- spawnEditorInTopic :: X ()
-- spawnEditorInTopic = proc $ inEditor >-$ currentTopicDir myTopicConfig

-- spawnTermInTopic :: X ()
-- spawnTermInTopic = proc inTerm

-- executeInTopic :: String -> X ()
-- executeInTopic p = proc $ (termInDir >-$ currentTopicDir myTopicConfig)
--                       >-> execute p

-- topicItems :: [TopicItem]
-- topicItems =
--   [ inHome "1:WEB" (spawn "firefox")
--   , TI "2:Boilpage" "repos/boilpage" spawnBoilpage
--   ]

-- myTopicConfig :: TopicConfig
-- myTopicConfig = def
--   { topicDirs          = tiDirs    topicItems
--   , topicActions       = tiActions topicItems
--   , defaultTopicAction = const (pure ())
--   , defaultTopic       = "1:WEB"         -- fallback
--   }

-- goto :: Topic -> X ()
-- goto = switchTopic myTopicConfig

-- promptedGoto :: X ()
-- promptedGoto = workspacePrompt def goto

-- promptedShift :: X ()
-- promptedShift = workspacePrompt def $ windows . W.shift
