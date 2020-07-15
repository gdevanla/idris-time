module Data.Time.Calendar.MonthDay

import Data.Vect

import Data.Time.Calendar.Private

export
monthLengths: Bool -> Vect 12 Nat
monthLengths False = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
monthLengths True = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

export
dayLengthBounds : Fin 12  -> Vect 12 Nat -> Type
dayLengthBounds x xs  = Fin $ succ $ index x xs

export
DayBounds : Fin 12 -> Bool -> Type
DayBounds n isLeap =  (dayLengthBounds n (monthLengths isLeap))


-- defDayLengthBounds : (n: Fin 12) ->  (dayLengthBounds n (monthLengths isLeap))
-- defDayLengthBounds x = Vect.index x (monthLengths True)

-- hole : (n : Integer) -> ((n1 : Nat) -> Maybe (Fin n1)) -> Fin 32
-- hole n f = ?hole_rhs

||| Used to clip the days value to a typed bounded value based on the provided month and isLeap value
export
boundedDay: (n: Int) -> (month: Fin 12) -> (isLeap: Bool) -> Maybe (DayBounds month isLeap)
boundedDay x m isLeap = integerToFin (cast x) (S (Vect.index m (monthLengths isLeap)))


-- construct_prf : (n: Nat) -> (xs: List a) -> (prf: NonEmpty xs) ->  InBounds n xs
-- construct_prf _ [] IsNonEmpty impossible
-- construct_prf Z (x :: xs) prf = InFirst
-- construct_prf (S k) (x :: y :: xs) prf = InLater (construct_prf k (y::xs) prf)


-- -- construct_prf Z [] = ?construct_prf_rhs_4
-- -- construct_prf Z (x :: xs) = InFirst
-- -- construct_prf (S k) (x::xs) = InLater (construct_prf k xs)

-- | The length of a given month in the Gregorian or Julian calendars.
-- First arg is leap year flag.
export
monthLength: Bool -> Fin 12 -> Nat
monthLength isLeap month' =
  let
    --inBounds = InBounds (cast (month' - 1)) (monthLengths isLeap)
    monthLengths' = (monthLengths isLeap)
  in
    index month' monthLengths'

--   --Prelude.List.index (cast (month' - 1)) (monthLengths isLeap) {inBounds}

-- ||| Convert month and day in the Gregorian or Julian calendars to day of year.
-- ||| First arg is leap year flag.
export
monthAndDayToDayOfYear : (isLeap: Bool) -> (n: Fin 12) -> DayBounds n isLeap -> Integer
monthAndDayToDayOfYear isLeap month day' =
  let
    day' = day'
    k =
      if month <= 2
        then 0
        else if isLeap
                then -1
                else -2
    res = (div (367 * finToInteger month - 362) 12) + k + cast day'
  in
    res

--||| Convert month and day in the Gregorian or Julian calendars to day of year.
--||| First arg is leap year flag.
-- monthAndDayToDayOfYearValid :: Bool -> Int -> Int -> Maybe Int
-- monthAndDayToDayOfYearValid isLeap month day = do
--     month' <- clipValid 1 12 month
--     day' <- clipValid 1 (monthLength' isLeap month') day
--     let
--         day'' = fromIntegral day'
--         month'' = fromIntegral month'
--         k =
--             if month' <= 2
--                 then 0
--                 else if isLeap
--                          then -1
--                          else -2
--     return ((div (367 * month'' - 362) 12) + k + day'')
export
findMonthDay: Vect n Nat -> Int -> (Int, Int)
findMonthDay (y :: xs) yd =
  if yd > cast y
  then (\(m, d) => (m + 1, d)) (findMonthDay xs (yd - cast y))
  else (1, yd)

-- findMonthDay (n::ns) yd =
--   ()if yd > cast n then ((\(m, d) => (m + 1, d)) (findMonthDay ns (yd - n))) else (1, yd)


||| Convert day of year in the Gregorian or Julian calendars to month and day.
||| First arg is leap year flag.
export
dayOfYearToMonthAndDay : Bool -> Int -> (Int, Int)
dayOfYearToMonthAndDay isLeap yd =
  let
    clipped = (clip 1 (if isLeap then 366 else 365)  yd)
  in
    findMonthDay (monthLengths isLeap) clipped
