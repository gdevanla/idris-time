module Data.Time.Clock.System


import Data.Time.Clock.Internal.SystemTime
import Data.Time.Clock.Internal.UTCTime
import Data.Time.Clock.Internal.DiffTime
import Data.Time.Calendar.Days


-- | The day of the epoch of 'SystemTime', 1970-01-01
export
systemEpochDay: Day
systemEpochDay = MkModifiedJulianDay 40587

export
get_nano_res: Integer
get_nano_res = 1000000000

export
systemToUTCTime: SystemTime -> UTCTime
systemToUTCTime (MkSystemTime seconds nanoseconds) =
  let
    days = seconds `div` 86400
    day = addDays days systemEpochDay
    timeSeconds = seconds `mod` 86400
    -- TODO: Add nanoseconds
    --timeNanoseconds = timeSeconds * get_nano_res -- TODO: add nanoseconds + ()
    time = picosecondsToDiffTime (timeSeconds) -- * 1000)
  in
    MkUTCTime day time


-- TODO: Currently we do no capture nanoseconds, therefore coversion to System time looses precision
-- utcToSystemTime: UTCTime -> SystemTime
-- utcToSystemTime (MkUTCTime day diffTime) =
--   let
--     days = diffDays day systemEpochDay
--     timePicoSeconds = diffTimeToPicoseconds diffTime
--     timeNanoseconds = timePicoSeconds `div` 1000
--     timeSeconds = if timeNanoseconds >= 86400000000000 then 86399 else timeNanoseconds `div` get_nano_res
--     seconds = days * 86400 + timeSeconds
--   in
--     MkSystemTime seconds 0
