||| Module tries to implement all the friendly methods provided by the Haskell datatime library.
module Data.DateTime

import Data.Time.Clock.Internal.UTCTime
import Data.Time.Clock.System
import Data.Time.Clock.Internal.SystemTime
import Data.Time.Calendar.Gregorian
import Internal.CTimespec
import Data.Time.Calendar.Days
import Data.Time.Clock.Internal.DiffTime
import Data.Time.Calendar.Days
import Data.Time.LocalTime.Internal.TimeOfDay

import Data.Fin

||| A structure that stores MJD as Days and Diff time
DateTime: Type
DateTime = UTCTime

||| Return the Gregorian date based on the call to machine's getSystemTime
public export
today : IO Gregorian
today = do
  let (MkUTCTime x y) = systemToUTCTime !getSystemTime
  pure $ toGregorian x

||| Add days to Gregorian
public export
addDays: Gregorian -> Nat -> Gregorian
addDays gregorian n =
  let
    x = fromGregorian gregorian
    new_gregororian = addDays (cast n) x
  in
    toGregorian new_gregororian

||| Build the DateTime object based on machince getSystemTime
public export
getUTCTime: IO DateTime
getUTCTime = pure $ systemToUTCTime !getSystemTime

||| Return the current TimeOfDay based on machine's getSystemTime
public export
getCurrentUTCTimeOfDay : IO TimeOfDay
getCurrentUTCTimeOfDay = do
  utcTime <- getUTCTime
  pure $ timeToTimeOfDay (utctDayTime utcTime)
