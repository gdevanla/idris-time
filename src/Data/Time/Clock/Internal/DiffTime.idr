module Data.Time.Clock.Internal.DiffTime

--import Data.Data
--import Data.Fixed
--import Data.Ratio ((%))
--import Data.Typeable

||| This is a length of time, as measured by a clock.
||| Conversion functions will treat it as seconds.
||| It has a precision of 10^-12 s.
public export
data DiffTime = MkDiffTime Double -- We go with double here. Haskell uses Data.Fixed.Pico

-- -- necessary because H98 doesn't have "cunning newtype" derivation
-- instance Enum DiffTime where
--     succ (MkDiffTime a) = MkDiffTime (succ a)
--     pred (MkDiffTime a) = MkDiffTime (pred a)
--     toEnum = MkDiffTime . toEnum
--     fromEnum (MkDiffTime a) = fromEnum a
--     enumFrom (MkDiffTime a) = fmap MkDiffTime (enumFrom a)
--     enumFromThen (MkDiffTime a) (MkDiffTime b) = fmap MkDiffTime (enumFromThen a b)
--     enumFromTo (MkDiffTime a) (MkDiffTime b) = fmap MkDiffTime (enumFromTo a b)
--     enumFromThenTo (MkDiffTime a) (MkDiffTime b) (MkDiffTime c) = fmap MkDiffTime (enumFromThenTo a b c)

Show DiffTime where
    show (MkDiffTime t) = show t

-- -- necessary because H98 doesn't have "cunning newtype" derivation
-- instance Num DiffTime where
--     (MkDiffTime a) + (MkDiffTime b) = MkDiffTime (a + b)
--     (MkDiffTime a) - (MkDiffTime b) = MkDiffTime (a - b)
--     (MkDiffTime a) * (MkDiffTime b) = MkDiffTime (a * b)
--     negate (MkDiffTime a) = MkDiffTime (negate a)
--     abs (MkDiffTime a) = MkDiffTime (abs a)
--     signum (MkDiffTime a) = MkDiffTime (signum a)
--     fromInteger i = MkDiffTime (fromInteger i)

-- -- necessary because H98 doesn't have "cunning newtype" derivation
-- instance Real DiffTime where
--     toRational (MkDiffTime a) = toRational a

-- -- necessary because H98 doesn't have "cunning newtype" derivation
-- instance Fractional DiffTime where
--     (MkDiffTime a) / (MkDiffTime b) = MkDiffTime (a / b)
--     recip (MkDiffTime a) = MkDiffTime (recip a)
--     fromRational r = MkDiffTime (fromRational r)

-- -- necessary because H98 doesn't have "cunning newtype" derivation
-- instance RealFrac DiffTime where
--     properFraction (MkDiffTime a) = let
--         (b', a') = properFraction a
--         in (b', MkDiffTime a')
--     truncate (MkDiffTime a) = truncate a
--     round (MkDiffTime a) = round a
--     ceiling (MkDiffTime a) = ceiling a
--     floor (MkDiffTime a) = floor a

-- -- | Create a 'DiffTime' which represents an integral number of seconds.
-- export
-- secondsToDiffTime :: Integer -> DiffTime
-- secondsToDiffTime = fromInteger

-- -- | Create a 'DiffTime' from a number of picoseconds.
-- export
-- picosecondsToDiffTime :: Integer -> DiffTime
-- picosecondsToDiffTime x = MkDiffTime (MkFixed x)

-- -- | Get the number of picoseconds in a 'DiffTime'.
-- export
-- diffTimeToPicoseconds :: DiffTime -> Integer
-- diffTimeToPicoseconds (MkDiffTime (MkFixed x)) = x

-- {-# RULES
-- "realToFrac/DiffTime->Pico" realToFrac = \ (MkDiffTime ps) -> ps
-- "realToFrac/Pico->DiffTime" realToFrac = MkDiffTime
--  #-}
