module Data.Time.Clock.Internal.DiffTime

import Data.Time.Clock.Internal.Fixed as F

--import Data.Data
--import Data.Fixed
--import Data.Ratio ((%))
--import Data.Typeable

||| This is a length of time, as measured by a clock.
||| Conversion functions will treat it as seconds.
||| It has a precision of 10^-12 s.
public export
data DiffTime = MkDiffTime Pico

Enum DiffTime where
  pred (MkDiffTime x) = MkDiffTime (pred x)
  toNat (MkDiffTime x) = toNat x
  fromNat x = MkDiffTime (fromNat x)

Show DiffTime where
    show (MkDiffTime t) = show t

add: DiffTime -> DiffTime -> DiffTime
add (MkDiffTime x) (MkDiffTime y) = MkDiffTime (x + y)

(+) : DiffTime -> DiffTime -> DiffTime
(+) = add

minus: DiffTime -> DiffTime -> DiffTime
minus (MkDiffTime x) (MkDiffTime y) = MkDiffTime (x - y)

negate: DiffTime -> DiffTime
negate (MkDiffTime x) = MkDiffTime (negate x)

abs : DiffTime-> DiffTime
abs (MkDiffTime x) = MkDiffTime (abs x)

fromInteger : Integer -> DiffTime
fromInteger x = MkDiffTime (MkFixed x)

mult: DiffTime -> DiffTime -> DiffTime
mult (MkDiffTime x) (MkDiffTime y) = MkDiffTime (x * y)

(*): DiffTime -> DiffTime -> DiffTime
(*) = mult

toRational: DiffTime -> Double
toRational (MkDiffTime x) = (toRational x)

fracDiv: DiffTime -> DiffTime -> DiffTime
fracDiv (MkDiffTime x) (MkDiffTime y) = MkDiffTime (fracDiv x y)

(/): DiffTime -> DiffTime -> DiffTime
(/) = fracDiv

recip : DiffTime -> DiffTime
recip (MkDiffTime x) = MkDiffTime (recip x)

secondsToDiffTime: Integer -> DiffTime
secondsToDiffTime = fromInteger

picosecondsToDiffTime: Integer -> DiffTime
picosecondsToDiffTime x = MkDiffTime (MkFixed x)

diffTimeToPicoseconds : DiffTime -> Integer
diffTimeToPicoseconds (MkDiffTime (MkFixed x)) = x
