||| Module that provides fixed-point number to represent seconds in nanoseconds.
module Fixed

public export
data Fixed a = MkFixed Integer

public export
data E12
data E9
data E2

public export
Dec : Type
Dec = Fixed E2

public export
Pico : Type
Pico = Fixed E12

public export
Nano : Type
Nano = Fixed E9


public export
Show (Fixed a) where
  show (MkFixed x) = show x

export
Eq (Fixed a) where
  (MkFixed a) == (MkFixed b) = a == b

export
Ord (Fixed a) where
  compare (MkFixed a) (MkFixed b) = compare a b

export
interface HasResolution (a: Type) where
  resolution : (f : Type -> Type) -> f a -> Integer

export
HasResolution E12 where
  resolution _ _ =  1000000000000

export
HasResolution E2 where
  resolution _ _ =  100

public export
Enum (Fixed a) where
  pred (MkFixed x) = MkFixed (pred x)
  toNat (MkFixed x) = toNat x
  fromNat x = MkFixed (toIntegerNat x)

-- Currently unable to express `*` in terms of `div` due to totality checking
-- implementation (HasResolution a) => Num (Fixed a) where
--   (+) (MkFixed x) (MkFixed y) = MkFixed (x + y)
--   (*) fa@(MkFixed x) (MkFixed y)  = MkFixed (div (x * y) (resolution {a} Fixed fa))
--   fromInteger x = MkFixed x

export
add: Fixed a -> Fixed a -> Fixed a
add (MkFixed x) (MkFixed y) = MkFixed (x + y)

export
(+) : Fixed a -> Fixed a -> Fixed a
(+) = add

export
sub : Fixed a -> Fixed a -> Fixed a
sub (MkFixed x) (MkFixed y) = MkFixed (x - y)

export
(-) : Fixed a -> Fixed a -> Fixed a
(-) = sub

export
negate: Fixed a -> Fixed a
negate (MkFixed x) = MkFixed (negate x)

export
abs : Fixed a -> Fixed a
abs (MkFixed x) = MkFixed (abs x)

export
fromInteger : Integer -> Fixed a
fromInteger x = MkFixed x

export
toRational : (HasResolution a) => Fixed a -> Double
toRational {a} fa@(MkFixed x) = (cast x) / cast (resolution {a} Fixed fa)

export
multFixed : (HasResolution a) => Fixed a -> Fixed a -> Fixed a
multFixed {a} fa@(MkFixed x) (MkFixed y) =
  let
    result =  div (x * y) (resolution {a} Fixed fa)
  in
    MkFixed result

--MkFixed (x * y  * cast (1 / (resolution {a} Fixed fa)))

export
(*) : (HasResolution a) => Fixed a -> Fixed a -> Fixed a
(*) = multFixed


export
fracDiv : (HasResolution a) => Fixed a -> Fixed a -> Fixed a
fracDiv fa@(MkFixed x) (MkFixed y) = MkFixed (div (x * (resolution {a} Fixed fa)) y)

export
(/): (HasResolution a) => Fixed a -> Fixed a -> Fixed a
(/) = fracDiv

export
recip : (HasResolution a) => Fixed a -> Fixed a
recip {a} fa@(MkFixed x) = MkFixed (div ((resolution {a} Fixed fa) * (resolution {a} Fixed fa)) x)


-- TODO:
-- fromRationalFixed:

-- implementation (HasResolution a) => Num (Fixed a) where
--   (+) (MkFixed x) (MkFixed y) = addFixed
--   (*) fa@(MkFixed x) (MkFixed y)  = MkFixed (x * y * (resolution {a} Fixed fa))
--   fromInteger x = MkFixed x

--(HasResolution a) => Fractional (Fixed a) where
--  (/) = fraceDivFixed
--   --recip fa@(MkFixed x) =

--   -- MkFixed (div (res * res) x)
--   --                        where
--   --                        res = (resolution {a} Fixed fa)

-- partial
-- implementation (HasResolution a) => Integral (Fixed a) where
--   div (MkFixed x) (MkFixed y) = MkFixed (div x y)
--   mod (MkFixed x) (MkFixed y) = MkFixed (mod x y)


  --fromRational r = withResolution (\res -> MkFixed (floor (r * (toRational res))))

  -- (MkFixed a) + (MkFixed b) = MkFixed (a + b)
  -- (MkFixed a) - (MkFixed b) = MkFixed (a - b)
  -- fa@(MkFixed a) * (MkFixed b) = MkFixed (div (a * b) (resolution fa))
  -- negate (MkFixed a) = MkFixed (negate a)
  -- abs (MkFixed a) = MkFixed (abs a)
  -- signum (MkFixed a) = fromInteger (signum a)
  -- fromInteger i = withResolution (\res -> MkFixed (i * res))
