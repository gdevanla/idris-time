module Data.Time.Calendar

import Data.Time.Calendar.Days

export
data DayOfWeek
  = Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  | Sunday


export
Enum DayOfWeek where
  pred Monday = Tuesday
  pred Tuesday = Wednesday
  pred Wednesday = Thursday
  pred Thursday = Friday
  pred Friday = Saturday
  pred Saturday = Sunday
  pred Sunday = Monday
  toNat Monday = 1
  toNat Tuesday = 2
  toNat Wednesday = 3
  toNat Thursday = 4
  toNat Friday = 5
  toNat Saturday = 6
  toNat Sunday = 7

  -- this is really slow!! and unusable. I am not able to get a total function out of this using (fromNat : x -> Int)
  fromNat x = case x of
                   Z => Sunday
                   (S (S (S (S (S (S (S k))))))) => fromNat k
                   (S (S (S (S (S (S k)))))) => Saturday
                   (S (S (S (S (S k))))) => Friday
                   (S (S (S (S k)))) => Thursday
                   (S (S (S k))) => Wednesday
                   (S (S k)) => Tuesday
                   (S k) => Monday


dayOfWeek : Day -> DayOfWeek
dayOfWeek (MkModifiedJulianDay d) = let x = fromInteger (d + 3)
  in
    case mod x 7 of
         0 => Sunday
         1 => Monday
         2 => Tuesday
         3 => Wednesday
         4 => Thursday
         5 => Friday
         _ => Saturday




--dayOfWeek (MkModifiedJulianDay d)
