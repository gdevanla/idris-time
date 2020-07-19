module Data.Time.Calendar.Gregorian

import Data.Vect

--import Data.Time.Calendar.CalendarDiffDays
import Data.Time.Calendar.Days
import Data.Time.Calendar.MonthDay
import Data.Time.Calendar.OrdinalDate
import Data.Time.Calendar.Private

-- TODO: It would be nice to bound `day` based on `month`. But, I do know how to do it yet.
public export
record Gregorian where
  constructor MkGregorian
  year: Integer
  month: Int
  day: Int


-- | Convert to proleptic Gregorian calendar. First element of result is year, second month number (1-12), third day (1-31).
export
toGregorian : Day -> Gregorian
toGregorian date =
  let
    (year, yd) = toOrdinalDate date
    (month, day) = dayOfYearToMonthAndDay (isLeapYear year) yd
  in
     MkGregorian year month day


-- ||| Convert from proleptic Gregorian calendar. First argument is year, second month number (1-12), third day (1-31).
-- -- Invalid values will be clipped to the correct range, month first, then day.
-- export
-- fromGregorian: Integer -> Fin 12 -> Int -> Maybe Day
-- fromGregorian year month day = do
--   let isLeap = (isLeapYear year)
--   bd <- boundedDay' day month isLeap
--   let day_of_year = monthAndDayToDayOfYear isLeap month bd
--   let day = fromOrdinalDate year day_of_year
--   pure day

export
fromGregorian: Gregorian -> Day
fromGregorian gregorian =
  let
    MkGregorian year month day = gregorian
    isLeap = (isLeapYear year)
    --bd = boundedDay' day month isLeap
    day_of_year = monthAndDayToDayOfYear isLeap month day
    day = fromOrdinalDate year day_of_year
  in
     day


||| Show in ISO 8601 format (yyyy-mm-dd)
-- export
-- showGregorianFromDay: Day -> String
-- showGregorian date =
--   let
-- (MkGregorian y m d) = toGregorian date
--   in
--     (show4 y) ++ "-" ++ (show2 m) ++ "-" ++ (show2 d)


export
showGregorian: Gregorian -> String
showGregorian (MkGregorian y m d) =
    (show4 y) ++ "-" ++ (show2 m) ++ "-" ++ (show2 d)




||| The number of days in a given month according to the proleptic Gregorian calendar. First argument is year, second is month.
gregorianMonthLength: Integer -> Fin 12 -> Nat
gregorianMonthLength year month = index month $ monthLengths (isLeapYear year)

rolloverMonths: (Integer, Integer) -> (Integer, Int)
rolloverMonths (y, m) = (y + (div (m - 1) 12), integerToInt ((mod (m - 1) 12) + 1))

addGregorianMonths: Integer -> Day -> Gregorian
addGregorianMonths n day =
  let
    MkGregorian y m d = toGregorian day
    (y', m') = rolloverMonths (y, cast m + n)
  in
    MkGregorian  y' m' d

-- -- | Add months, with days past the last day of the month clipped to the last day.
-- -- For instance, 2005-01-30 + 1 month = 2005-02-28.
-- addGregorianMonthsClip :: Integer -> Day -> Day
-- addGregorianMonthsClip n day = fromGregorian y m d
--   where
--     (y, m, d) = addGregorianMonths n day

-- -- | Add months, with days past the last day of the month rolling over to the next month.
-- -- For instance, 2005-01-30 + 1 month = 2005-03-02.
-- addGregorianMonthsRollOver :: Integer -> Day -> Day
-- addGregorianMonthsRollOver n day = addDays (fromIntegral d - 1) (fromGregorian y m 1)
--   where
--     (y, m, d) = addGregorianMonths n day

-- -- | Add years, matching month and day, with Feb 29th clipped to Feb 28th if necessary.
-- -- For instance, 2004-02-29 + 2 years = 2006-02-28.
-- addGregorianYearsClip :: Integer -> Day -> Day
-- addGregorianYearsClip n = addGregorianMonthsClip (n * 12)

-- -- | Add years, matching month and day, with Feb 29th rolled over to Mar 1st if necessary.
-- -- For instance, 2004-02-29 + 2 years = 2006-03-01.
-- addGregorianYearsRollOver :: Integer -> Day -> Day
-- addGregorianYearsRollOver n = addGregorianMonthsRollOver (n * 12)

-- -- | Add months (clipped to last day), then add days
-- addGregorianDurationClip :: CalendarDiffDays -> Day -> Day
-- addGregorianDurationClip (CalendarDiffDays m d) day = addDays d $ addGregorianMonthsClip m day

-- -- | Add months (rolling over to next month), then add days
-- addGregorianDurationRollOver :: CalendarDiffDays -> Day -> Day
-- addGregorianDurationRollOver (CalendarDiffDays m d) day = addDays d $ addGregorianMonthsRollOver m day

-- -- | Calendrical difference, with as many whole months as possible
-- diffGregorianDurationClip :: Day -> Day -> CalendarDiffDays
-- diffGregorianDurationClip day2 day1 = let
--     (y1, m1, d1) = toGregorian day1
--     (y2, m2, d2) = toGregorian day2
--     ym1 = y1 * 12 + toInteger m1
--     ym2 = y2 * 12 + toInteger m2
--     ymdiff = ym2 - ym1
--     ymAllowed =
--         if day2 >= day1
--             then if d2 >= d1
--                      then ymdiff
--                      else ymdiff - 1
--             else if d2 <= d1
--                      then ymdiff
--                      else ymdiff + 1
--     dayAllowed = addGregorianDurationClip (CalendarDiffDays ymAllowed 0) day1
--     in CalendarDiffDays ymAllowed $ diffDays day2 dayAllowed

-- -- | Calendrical difference, with as many whole months as possible.
-- -- Same as 'diffGregorianDurationClip' for positive durations.
-- diffGregorianDurationRollOver :: Day -> Day -> CalendarDiffDays
-- diffGregorianDurationRollOver day2 day1 = let
--     (y1, m1, d1) = toGregorian day1
--     (y2, m2, d2) = toGregorian day2
--     ym1 = y1 * 12 + toInteger m1
--     ym2 = y2 * 12 + toInteger m2
--     ymdiff = ym2 - ym1
--     ymAllowed =
--         if day2 >= day1
--             then if d2 >= d1
--                      then ymdiff
--                      else ymdiff - 1
--             else if d2 <= d1
--                      then ymdiff
--                      else ymdiff + 1
--     dayAllowed = addGregorianDurationRollOver (CalendarDiffDays ymAllowed 0) day1
--     in CalendarDiffDays ymAllowed $ diffDays day2 dayAllowed

-- -- orphan instance
public export
Show Day where
  show = showGregorian . toGregorian


public export
Show Gregorian where
  show = showGregorian
