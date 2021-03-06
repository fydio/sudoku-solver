--module Sudoku.Model.Fact
--  ( Fact(..)
--  , empty
--  , alsoNot
--  , mightBe
--  , known
--  , isA
--  ) where
--
--
--import Data.List ( (\\) )
--import qualified Data.Set as Set
--import qualified Sudoku.Model.Value as V
--
--
--data Fact = Is V.Value | IsNot (Set.Set V.Value) deriving ( Eq )
--
--empty :: Fact
--empty = IsNot Set.empty
--
--alsoNot :: Fact -> V.Value -> Maybe Fact
--alsoNot x@(Is a) excl =
--  if a == excl
--  then Nothing
--  else Just x
--alsoNot (IsNot xs) x =
--  let ys = x `Set.insert` xs
--  in
--    case (Set.size ys) of
--      9 -> Nothing
--      8 ->
--        let y = Set.lookupMin $ canBe $ IsNot ys
--        in fmap Is y
--      i -> Just (IsNot ys)
--
--mightBe :: V.Value -> Fact -> Fact
--mightBe v (Is x) = IsNot . Set.fromList $ V.allValues \\ [v, x]
--
--known :: Fact -> Bool
--known (Is _) = True
--known _ = False
--
--canBe :: Fact -> Set.Set V.Value
--canBe (Is _) = Set.empty
--canBe (IsNot xs) = (Set.difference (Set.fromList V.allValues) xs)
--
--isA :: Fact -> Maybe V.Value
--isA (Is v) = Just v
--isA _ = Nothing
--
--valueSet :: Set.Set V.Value
--valueSet = Set.fromList V.allValues
--
--instance Show Fact where
--  show (IsNot xs) =
--    let
--      a = if (Set.member V.V1 xs) then " " else "1"
--      b = if (Set.member V.V2 xs) then " " else "2"
--      c = if (Set.member V.V3 xs) then " " else "3"
--      d = if (Set.member V.V4 xs) then " " else "4"
--      e = if (Set.member V.V5 xs) then " " else "5"
--      f = if (Set.member V.V6 xs) then " " else "6"
--      g = if (Set.member V.V7 xs) then " " else "7"
--      h = if (Set.member V.V8 xs) then " " else "8"
--      i = if (Set.member V.V9 xs) then " " else "9"
--    in
--      unlines $
--      [ a ++ b ++ c
--      , d ++ e ++ f
--      , g ++ h ++ i
--      ]
--  show (Is x) = unlines $
--    [ "   "
--    , " " ++ (show x) ++ " "
--    , "   "
--    ]
