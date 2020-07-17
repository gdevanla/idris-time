module Data.Time.Clock.Internal.SystemTime
    -- ( SystemTime(..)
    -- , getSystemTime
    -- , getTime_resolution
    -- , getTAISystemTime
    -- ) where

--import Data.Bits32

--import Data.Data
--import Control.DeepSeq
--import Data.Int (Int64)
import Data.Time.Clock.Internal.DiffTime
--import Data.Word
--#include "HsTimeConfig.h"

import Internal.CTimespec
import Data.Time.Clock.Internal.Fixed

--------------------------------------------------------------------------------

-- | 'SystemTime' is time returned by system clock functions.
-- Its semantics depends on the clock function, but the epoch is typically the beginning of 1970.
-- Note that 'systemNanoseconds' of 1E9 to 2E9-1 can be used to represent leap seconds.
public export
record SystemTime where
  constructor MkSystemTime
  systemSeconds: Integer
  systemNanoseconds: Integer

-- | Get the system time, epoch start of 1970 UTC, leap-seconds ignored.
-- 'getSystemTime' is typically much faster than 'getCurrentTime'.
getSystemTime: IO SystemTime
getSystemTime = do
  (MkCTimeSpec x y) <- clock_gettime
  pure $ MkSystemTime x y

-- | The resolution of 'getSystemTime', 'getCurrentTime', 'getPOSIXTime'
-- | TODO: Fix this.
--getTime_resolution: DiffTime
-- getTime_resolution = 100E-9 -- 100ns

timespecToSystemTime: CTimeSpec -> SystemTime
timespecToSystemTime (MkCTimeSpec s ns) = (MkSystemTime s ns)

-- TODO: Currently nano second resolution does not work
timespecToDiffTime: CTimeSpec -> DiffTime
timespecToDiffTime (MkCTimeSpec s ns) = MkDiffTime (MkFixed (s)) -- + (ns  * 1E-9)))

--clockGetSystemTime :: ClockID -> IO SystemTime
--clockGetSystemTime clock = fmap timespecToSystemTime $ clockGetTime clock

--getSystemTime = clockGetSystemTime clock_REALTIME

--getTime_resolution = timespecToDiffTime realtimeRes

-- Use gettimeofday
-- getTime_resolution = 1E-6 -- microsecond
