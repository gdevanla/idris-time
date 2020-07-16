module Data.Time.Clock.Internal.NominalDiffTime

import Data.Time.Clock.Internal.Fixed as F

public export
data NominalDiffTime = MkNominalDiffTime Pico

export
Enum NominalDiffTime where
  pred (MkNominalDiffTime x) = MkNominalDiffTime (pred x)
  toNat (MkNominalDiffTime x) = toNat x
  fromNat x = MkNominalDiffTime (fromNat x)

export
Show NominalDiffTime where
    show (MkNominalDiffTime t) = show t

export
Eq NominalDiffTime where
  (MkNominalDiffTime a) == (MkNominalDiffTime b) = a == b

export
Ord NominalDiffTime where
  compare (MkNominalDiffTime a) (MkNominalDiffTime b) = compare a b

add: NominalDiffTime -> NominalDiffTime -> NominalDiffTime
add (MkNominalDiffTime x) (MkNominalDiffTime y) = MkNominalDiffTime (x + y)

(+) : NominalDiffTime -> NominalDiffTime -> NominalDiffTime
(+) = add

minus: NominalDiffTime -> NominalDiffTime -> NominalDiffTime
minus (MkNominalDiffTime x) (MkNominalDiffTime y) = MkNominalDiffTime (x - y)

negate: NominalDiffTime -> NominalDiffTime
negate (MkNominalDiffTime x) = MkNominalDiffTime (negate x)

abs : NominalDiffTime-> NominalDiffTime
abs (MkNominalDiffTime x) = MkNominalDiffTime (abs x)

fromInteger : Integer -> NominalDiffTime
fromInteger x = MkNominalDiffTime (MkFixed x)

mult: NominalDiffTime -> NominalDiffTime -> NominalDiffTime
mult (MkNominalDiffTime x) (MkNominalDiffTime y) = MkNominalDiffTime (x * y)

(*): NominalDiffTime -> NominalDiffTime -> NominalDiffTime
(*) = mult

toRational: NominalDiffTime -> Double
toRational (MkNominalDiffTime x) = (toRational x)

fracDiv: NominalDiffTime -> NominalDiffTime -> NominalDiffTime
fracDiv (MkNominalDiffTime x) (MkNominalDiffTime y) = MkNominalDiffTime (fracDiv x y)

(/): NominalDiffTime -> NominalDiffTime -> NominalDiffTime
(/) = fracDiv

recip : NominalDiffTime -> NominalDiffTime
recip (MkNominalDiffTime x) = MkNominalDiffTime (recip x)

secondsToNominalDiffTime: Integer -> NominalDiffTime
secondsToNominalDiffTime = fromInteger

picosecondsToNominalDiffTime: Integer -> NominalDiffTime
picosecondsToNominalDiffTime x = MkNominalDiffTime (MkFixed x)

diffTimeToPicoseconds : NominalDiffTime -> Integer
diffTimeToPicoseconds (MkNominalDiffTime (MkFixed x)) = x

-- | One day in 'NominalDiffTime'.
export
nominalDay: NominalDiffTime
nominalDay = 86400
