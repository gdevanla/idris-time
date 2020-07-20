module Data.Time.LocalTime.Internal.TimeOfDay

import Data.Time.Clock.Internal.Fixed
import Data.Time.Clock.Internal.DiffTime

export
record TimeOfDay where
  constructor MkTimeOfDay
  todHour: Integer
  todMin: Integer
  todSec: Pico

export
Show TimeOfDay where
  show (MkTimeOfDay h m s) = show h ++ ":" ++ show m ++ ":" ++ show s

posixDayLength: Integer
posixDayLength = 86400

export
nonLeapTimeOfDay : Integer -> TimeOfDay
nonLeapTimeOfDay picoSeconds =
  let
    s = mod picoSeconds 60
    s' = div picoSeconds 60
    h = div s' 60
    m' = mod s' 60
  in
    MkTimeOfDay h m' (MkFixed s)

export
timeToTimeOfDay: DiffTime -> TimeOfDay
timeToTimeOfDay x =
  let
    picoSeconds = (diffTimeToPicoseconds x)
  in
    if picoSeconds >= posixDayLength then (MkTimeOfDay 23 59 (MkFixed (60 + (picoSeconds - posixDayLength))))
    else nonLeapTimeOfDay picoSeconds
