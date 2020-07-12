module Data.Time.Calendar.Private

import Data.Time.Clock.Internal.Fixed

-- data PadOption
--     = Pad Int
--           Char
--     | NoPad

-- showPadded :: PadOption -> String -> String
-- showPadded NoPad s = s
-- showPadded (Pad i c) s = replicate (i - length s) c ++ s

-- class (Num t, Ord t, Show t) => ShowPadded t where
--     showPaddedNum :: PadOption -> t -> String

-- instance ShowPadded Integer where
--     showPaddedNum NoPad i = show i
--     showPaddedNum pad i
--         | i < 0 = '-' : (showPaddedNum pad (negate i))
--     showPaddedNum pad i = showPadded pad $ show i

-- instance ShowPadded Int where
--     showPaddedNum NoPad i = show i
--     showPaddedNum _pad i
--         | i == minBound = show i
--     showPaddedNum pad i
--         | i < 0 = '-' : (showPaddedNum pad (negate i))
--     showPaddedNum pad i = showPadded pad $ show i

-- show2Fixed :: Pico -> String
-- show2Fixed x
--     | x < 10 = '0' : (showFixed True x)
-- show2Fixed x = showFixed True x

-- show2 :: (ShowPadded t) => t -> String
-- show2 = showPaddedNum $ Pad 2 '0'

-- show3 :: (ShowPadded t) => t -> String
-- show3 = showPaddedNum $ Pad 3 '0'

-- show4 :: (ShowPadded t) => t -> String
-- show4 = showPaddedNum $ Pad 4 '0'

-- mod100 :: (Integral i) => i -> i
-- mod100 x = mod x 100

-- div100 :: (Integral i) => i -> i
-- div100 x = div x 100

export
clip : (Ord t) => t -> t -> t -> t
clip a b x = case x < a of
                  True => a
                  _ => case x > b of
                       True => b
                       _ => x

export
clipValid : (Ord t) => t -> t -> t -> Maybe t
clipValid a b x = case x < a of
                  True => Nothing
                  _ => case x > b of
                       True => Nothing
                       _ => Just x

-- quotBy :: (Real a, Integral b) => a -> a -> b
-- quotBy d n = truncate ((toRational n) / (toRational d))

-- remBy :: Real a => a -> a -> a
-- remBy d n = n - (fromInteger f) * d
--   where
--     f = quotBy d n

-- quotRemBy :: (Real a, Integral b) => a -> a -> (b, a)
-- quotRemBy d n = let
--     f = quotBy d n
--     in (f, n - (fromIntegral f) * d)
