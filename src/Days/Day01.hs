module Days.Day01 where

import Util.Util
import Util.Parsing ( Parser )
import qualified Util.Parsing as P

import qualified Program.RunDay as R (runDay, Day)

import Data.List ( sort )

runDay :: R.Day
runDay = R.runDay inputParser partA partB

type Input = [[Int]]
type OutputA = Int
type OutputB = Int

inputParser :: Parser Input
inputParser = flip (:) <$> P.lines (P.lines P.decimal) <*> P.lines P.decimal

partA :: Input -> OutputA
partA = map sum .> maximum

partB :: Input -> OutputB
partB = map sum .> sort .> reverse .> take 3 .> sum