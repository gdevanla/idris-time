module Data.Time.Calendar.Private

import Data.Time.Clock.Internal.Fixed

export
data PadOption
    = Pad Int
          String
    | NoPad

export
showPadded: PadOption -> String -> String
showPadded (Pad i c) s =
  let
    ix = toNat $ i - cast (length s)
    padding = unlines $ replicate ix c
    y = padding ++ s
  in
    y
showPadded NoPad y = y

export
interface (Num t, Ord t, Show t) => ShowPadded t where
  showPaddedNum: PadOption -> t -> String

export
ShowPadded Integer where
  showPaddedNum NoPad i = show i
  showPaddedNum pad i = case (i < 0) of
                             True => "-" ++ (showPaddedNum pad (negate i))
                             False => showPadded pad $ show i
export
ShowPadded Int where
  showPaddedNum NoPad i = show i
  showPaddedNum pad i =
    case (i < 0) of
         True => "-" ++ (showPaddedNum pad (negate i))
         False => showPadded pad $ show i
export
show2: (ShowPadded t) => t -> String
show2 = showPaddedNum $ Pad 2 "0"

export
show3: (ShowPadded t) => t -> String
show3 = showPaddedNum $ Pad 3 "0"

export
show4: (ShowPadded t) => t -> String
show4 = showPaddedNum $ Pad 4 "0"

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



-- Forceful conversion from Integer to Int
export
integerToInt: Integer -> Int
integerToInt x = cast (the String (cast x))


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
