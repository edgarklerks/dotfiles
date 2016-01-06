{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}
module TopicDSL where

import Data.List
import TopicMachine
import TopicParser
import XMonad.Actions.TopicSpace
import qualified Language.Haskell.TH.Lift as L
import Language.Haskell.TH
import Language.Haskell.TH.Lib
import XMonad.Actions.ShowText
import Control.Monad.Trans
import qualified Data.Map        as M
import XMonad hiding ((|||), Tall)
-- import XMonad.Actions.Eval
data Level = L1 | L2 | L3
data TopicDSL where
     TopicName :: Topic -> TopicDSL
     TopicAction ::  TopicDSL -> (TopicConfig -> Dir -> Topic -> X ()) -> TopicDSL
     TopicDir ::  TopicDSL -> Dir -> TopicDSL
              deriving Show

newtype TopicDescription = TD [TopicDSL]
        deriving Show

type TopicAction = (TopicConfig -> Dir -> Topic -> X ())

instance Show (a->b) where
         show _ = "function"
fromDisk = do xs <- runIO $ loadTopicProgram
              [| xs |]

emptyDescription = TD []

topic :: Topic -> TopicDSL
topic = TopicName

(**>) :: TopicDSL -> (TopicConfig -> Dir -> Topic -> X ()) -> TopicDSL
(**>) = TopicAction

(*/*) :: TopicDSL -> Dir -> TopicDSL
(*/*) = TopicDir

(*+*) :: TopicDSL -> TopicDescription -> TopicDescription
(*+*) x (TD xs) = TD (x:xs)
infixr 3 */*
infixr 2 **>
infixr 1 *+*

loadTopicProgram :: IO [Line]
loadTopicProgram = do xs <- parseFromFile topicDescriptor "/home/eklerks/.xmonad/topic.tps"
                      case xs of
                        Left e -> error (show e)
                        Right a -> return a



programToTopicMachine :: TopicConfig -> LabelName -> FilePath -> Program -> MachineSate X
programToTopicMachine mt lbl fp = pushStack (String fp) . pushStack (String lbl) . programToMachineState [
                      ("spawn", spawnAction),
                      ("shell", shellAction),

                      ("shellIn", spawnShellInAction),
                      ("msg", message),
                      ("def", defaultSpawnAction)
           ]
      where spawnAction :: MachineSate X -> MachineContext X (MachineSate X)
            spawnAction ms = do ([s1], ms') <-  takeStack 1 ms
                                case s1 of
                                  String str -> lift ( spawn str) >> return ms'
                                  _ -> errorsignal ms "spawn expects s1 to be a string"
            spawnShellInAction :: MachineSate X -> MachineContext X (MachineSate X)
            spawnShellInAction ms = do ([s1,s2], ms') <- takeStack 2 ms
                                       case (s1,s2) of
                                          (String t, String d) -> lift (spawnShellIn t d) >> return ms'
                                          _ -> errorsignal ms "shellIn expects s1 and s2 to be a string"
            shellAction :: MachineSate X -> MachineContext X (MachineSate X)
            shellAction ms = do
                       ([s1], ms') <- takeStack 1 ms
                       case s1 of
                         String tit -> lift (spawnShell mt tit) *> return ms'
                         _ -> errorsignal ms "shell expects s1 to be a string"

            defaultSpawnAction :: MachineSate X -> MachineContext X (MachineSate X)
            defaultSpawnAction ms = do
                        ([s1,s2], ms') <- takeStack 2 ms
                        case (s1,s2) of
                             (String t, String d) -> lift (defaultAction undefined t d) *> return ms'
                             _ -> errorsignal ms "def expects s1 to be a double and s2 to be a string"

            message :: MachineSate X -> MachineContext X (MachineSate X)
            message ms = do ([s1,s2], ms') <- takeStack 2 ms
                            case (s1,s2) of
                              (Double n, String msg) -> lift ( flashText defaultSTConfig (toRational n) msg) >> return ms'
                              _ -> errorsignal ms "msg expects s1 to be a double and s2 to be a string"



runTopicMachine :: TopicConfig -> LabelName -> FilePath -> Program -> X ()
runTopicMachine mt lbl fp prog = do
              t <- bbq $ programToTopicMachine mt lbl fp prog
              case t of
                Left e -> flashText defaultSTConfig 5 e >> return ()
                Right a -> return ()

fillActions :: TopicConfig -> [Line] -> TopicDescription
fillActions tc [] = emptyDescription
fillActions tc (Line tn fp prg:xs) = topic tn */* maybe "~" id fp **> maybe (\_ _ _ -> return ()) (\prg -> (\t d _ -> runTopicMachine tc tn (maybe "~" id fp) prg) ) prg *+* fillActions tc xs

defaultAction _ d t = spawnShellIn t d >*> 2 >> spawn ( "/home/eklerks/scripts/emacs.vim " ++ d)
-- termAction _ d t =  spawnShellIn t d
-- topicDescription = topic "home" */* "~" **> defaultAction
--                  *+* topic "hardware" */* "~/hardware" **> defaultAction
--                  *+* topic "sources" */* "~/sources" **> defaultAction
--                  *+* topic "sanoma" */* "~/sources/sanoma" **> defaultAction
--                  *+* topic "sanoma/dcp-core" */* "~/sources/sanoma/dcp-core" **> defaultAction
--                  *+* topic "sanoma/dcp-content-hub" */* "~/sources/sanoma/dcp-content-hub" **> defaultAction
--                  *+* topic "sanoma/dcp-analysis" */* "~/sources/sanoma/dcp-analysis" **> defaultAction
--                  *+* topic "zsh-scripts" */* "~/scripts" **> defaultAction
--                  *+* topic "conf" */* "~/sources/vim-zsh-vimperator-xmonad-configuration" **> defaultAction
--                  *+* topic "xmonad" */* "~/.xmonad" **> defaultAction
--                  *+* topic "books" */* "~/Dropbox/Sanoma Shared Stuff/Boeken" **> (\_ d t -> spawn "recoll" >> spawnShell t)
--                  *+* topic "mathematics" */* "~/Dropbox/Sanoma Shared Stuff/Boeken/Mathematics" **> (\_ d t -> spawn "recoll" >> spawnShell t)
--                  *+* topic "browser" */* "~" **> (\_ _ _ -> spawn "firefox")
--                  *+* topic "chat" */* "~" **> (\_ _ _ -> spawn "jitsy")
--                  *+* emptyDescription


getTriple :: TopicDSL -> (Topic, Dir, TopicAction)
getTriple (TopicName nm) = (nm, "~", (\_ _ _ -> return ()))
getTriple (TopicDir td dir) = case getTriple td of
                                (x,y,z) -> (x, dir, z)
getTriple (TopicAction td ad) = case getTriple td of
                                  (x,y,z) -> (x, y, ad)
type Topics = [Topic]
spawnShell :: TopicConfig -> String -> X ()
spawnShell myTopicConfig title = currentTopicDir myTopicConfig >>= spawnShellIn title

spawnShellIn :: Topic -> Dir -> X ()
spawnShellIn topic dir = spawn $ myShell [("-cd", dir)] topic ""
-- | Like query

spawnShellInWith :: Topic -> Dir -> String -> X ()
spawnShellInWith topic dir cmd = spawn $ myShell [("-cd", dir)] topic cmd

myShell :: [(String,String)] -> String -> String -> String
myShell opts title cmd = "urxvt " ++ (unwords $ jointuples (nubBy (\a b -> fst a == fst b) $ defaultopts ++ opts)) ++ (case cmd of
                                                                                                             [] -> ""
                                                                                                             x -> " -e " ++ cmd
                                                                                                             )
                where defaultopts = [
                                    ("-fade", "20"),
                                    ("+sb", ""),
                                    ("-bc", ""),
                                    ("-title", title)
                          ]
                      jointuples ((x,y):xs) = (x ++ " " ++ y) : jointuples xs
                      jointuples [] = []
