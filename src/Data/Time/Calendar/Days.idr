module Data.Time.Calendar.Days

||| TODO: Should we use Nat and bound the values
||| The Modified Julian Day is a standard count of days, with zero being the day 1858-11-17.
export
data Day = MkModifiedJulianDay Integer

export
Eq Day where
  (MkModifiedJulianDay a) == (MkModifiedJulianDay b) = a == b

export
Ord Day where
  compare (MkModifiedJulianDay a) (MkModifiedJulianDay b) = compare a b

export
Enum Day where
  pred (MkModifiedJulianDay x) = MkModifiedJulianDay (pred x)
  toNat (MkModifiedJulianDay x) = toNat x
  fromNat x = MkModifiedJulianDay (fromNat x)

export
range: (Day, Day) -> List Day
range (MkModifiedJulianDay x, MkModifiedJulianDay y) = map (MkModifiedJulianDay) [x .. y]

export
index: (Day, Day) -> Nat -> Maybe Day
index (a, b) k =
  let (MkModifiedJulianDay a1) = a
      (MkModifiedJulianDay b1) = b
      range_a_b = range (a, b)
      inbounds = inBounds k range_a_b
  in
    case inbounds of
         Yes prf => Just (List.index k range_a_b)
         No  contra => Nothing

export
inRange: (Day, Day) -> Day -> Bool
inRange (a, b) k = elem k (range (a, b))

export
rangeSize: (Day, Day) -> Nat
rangeSize x = List.length (range x)

export
addDays: Integer -> Day -> Day
addDays x (MkModifiedJulianDay y) = MkModifiedJulianDay (x + y)

export
diffDays: Day -> Day -> Integer
diffDays (MkModifiedJulianDay x) (MkModifiedJulianDay y) = x - y
