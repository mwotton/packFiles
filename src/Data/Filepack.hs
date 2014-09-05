{-# LANGUAGE TupleSections #-}
module Data.Filepack (evenPack) where
import           Control.Applicative ((<$>))
import           Data.BinPack
import           Data.Function       (on)
import           Data.List           (sortBy)
import           Data.Ord            (comparing)
import           System.Posix.Files  (fileSize, getFileStatus)

binSize = 10000000000000000
-- evenPack :: [FilePath] -> Int -> IO  [[FilePath]]
evenPack paths bins = do
  withSizes <- sortBy (compare `on` snd)  <$> mapM (\p -> (p,) . fileSize <$> getFileStatus p) paths
  return .  map  (\bin -> (binSize - gap bin, map fst $ items bin)) . fst $ binpack WorstFit Decreasing snd  (emptyBins binSize bins)  withSizes
