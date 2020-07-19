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

import Data.Fin

DateTime: Type
DateTime = UTCTime

public export
today : IO Gregorian
today = do
  let (MkUTCTime x y) = systemToUTCTime !getSystemTime
  pure $ toGregorian x

public export
addDays: Gregorian -> Integer -> Gregorian
addDays gregorian n =
  let
    x = fromGregorian gregorian
    new_gregororian = addDays n x
  in
    toGregorian new_gregororian
