||| Module tries to implement all the friendly methods provided by the Haskell datatime library.
module Data.DateTime

import Data.Time.Clock.Internal.UTCTime
import Data.Time.Clock.System
import Data.Time.Clock.Internal.SystemTime
import Data.Time.Calendar.Gregorian
import Internal.CTimespec
import Data.Time.Calendar.Days
import Data.Time.Clock.Internal.DiffTime

import Data.Fin

DateTime: Type
DateTime = UTCTime

public export
today : IO (Integer, Int, Int)
today = do
  let (MkUTCTime x y) = systemToUTCTime !getSystemTime
  pure $ toGregorian x


addDays: (Integer, Int, Int) -> Integer -> (Integer, Int, Int)
addDays (y, m, d) n =
  let
    x = fromGregorian ?hole1
  in
    ?hole
