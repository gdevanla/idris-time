module Fixed

public export
data Fixed a = MkFixed Integer

export
data E12
data E9

export
pico : Type
pico = Fixed E12

export
nano : Type
nano = Fixed E9

Eq (Fixed a) where
  (MkFixed a) == (MkFixed b) = a == b

Ord (Fixed a) where
  compare (MkFixed a) (MkFixed b) = compare a b

interface HasResolution (a: Type) where
  resolution : (f : Type -> Type) -> f a -> Integer

Enum (Fixed a) where
  pred (MkFixed x) = MkFixed (pred x)
  toNat (MkFixed x) = toNat x
  fromNat x = MkFixed (toIntegerNat x)

-- implementation (HasResolution a) => Num (Fixed a) where
--   (+) (MkFixed x) (MkFixed y) = MkFixed (x + y)
--   (*) fa@(MkFixed x) (MkFixed y)  = MkFixed (div (x * y) (resolution {a} Fixed fa))
--   fromInteger x = MkFixed x

addFixed : Fixed a -> Fixed a -> Fixed a
addFixed (MkFixed x) (MkFixed y) = MkFixed (x + y)

subFixed : Fixed a -> Fixed a -> Fixed a
subFixed (MkFixed x) (MkFixed y) = MkFixed (x - y)

negateFixed: Fixed a -> Fixed a
negateFixed (MkFixed x) = MkFixed (negate x)

absFixed : Fixed a -> Fixed a
absFixed (MkFixed x) = MkFixed (abs x)

fromIntegerFixed : Integer -> Fixed a
fromIntegerFixed x = MkFixed x

multFixed : (HasResolution a) => Fixed a -> Fixed a -> Fixed a
multFixed {a} fa@(MkFixed x) (MkFixed y) = MkFixed (x * y * (resolution {a} Fixed fa))

toRationalFromFixed : (HasResolution a) => Fixed a -> Double
toRationalFromFixed {a} fa@(MkFixed x) = (cast x) / cast (resolution {a} Fixed fa)

fraceDivFixed : (HasResolution a) => Fixed a -> Fixed a -> Fixed a
fraceDivFixed fa@(MkFixed x) (MkFixed y) = MkFixed (div (x * (resolution {a} Fixed fa)) y)

recipFixed : (HasResolution a) => Fixed a -> Fixed a
recipFixed {a} fa@(MkFixed x) = MkFixed (div ((resolution {a} Fixed fa) * (resolution {a} Fixed fa)) x)

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
