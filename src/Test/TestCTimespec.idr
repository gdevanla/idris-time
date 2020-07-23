module Test.TestCTimespec

import Internal.CTimespec
import Test.TestUtil

export
testClockGetTime : IO ()
testClockGetTime = do
  t <- clock_gettime
  assertGT "testCloclGetTime" (sec t) 1595330483  (show t) -- just a sanity check to make sure C api call works
