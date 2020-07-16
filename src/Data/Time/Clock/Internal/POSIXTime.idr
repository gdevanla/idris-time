module Data.Time.Clock.Internal.POSIXTime

import Data.Time.Clock.Internal.NominalDiffTime

||| 86400 nominal seconds in every day
posixDayLength: NominalDiffTime
posixDayLength = nominalDay


||| POSIX time = Nominal time since 1970-01-01 00:00 UTC

POSIXTime : Type
POSIXTime = NominalDiffTime
