module Main where

import           Data.Filepack
import           System.Environment (getArgs)

main = do
  let bins = 16
  files <- getArgs
  f <- evenPack files bins
  mapM (putStrLn . unwords . snd) f
