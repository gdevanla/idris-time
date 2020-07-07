module Main

-- Local Variables:
-- idris-load-packages: ("contrib")
-- End:

import CFFI.Types
import CFFI.Memory

import Data.Bits

%include c "time.h"

  -- struct tm {
  -- int tm_sec;         /* seconds,  range 0 to 59          */
  -- int tm_min;         /* minutes, range 0 to 59           */
  -- int tm_hour;        /* hours, range 0 to 23             */
  -- int tm_mday;        /* day of the month, range 1 to 31  */
  -- int tm_mon;         /* month, range 0 to 11             */
  -- int tm_year;        /* The number of years since 1900   */
  -- int tm_wday;        /* day of the week, range 0 to 6    */
  -- int tm_yday;        /* day in the year, range 0 to 365  */
  -- int tm_isdst;       /* daylight saving time             */
  -- };

tm_spec : Composite
tm_spec = STRUCT [
          mkComposite I8, --sec
          mkComposite I8, --min
          mkComposite I8, --hour
          mkComposite I8, --mday
          mkComposite I8, --mon
          mkComposite I16, --year
          mkComposite I8, --wday
          mkComposite I8, --yday
          mkComposite I8  -- dst
        ]


-- struct timespec {
--   time_t   tv_sec;        /* seconds */
--   long     tv_nsec;       /* nanoseconds */
-- };

time_spec : Composite
time_spec = STRUCT [
  mkComposite I64, --
  mkComposite I64 --min
  ]

record CTimeSpec where
  constructor MkCTimeSpec
  sec : Integer
  nsec : Integer

Show CTimeSpec where
  show (MkCTimeSpec sec nsec) = show sec ++ "," ++ show nsec

get_time : Int -> Ptr -> IO Int
get_time clockId ptr = foreign FFI_C "clock_gettime" (Int -> Ptr -> IO Int) clockId ptr


ClockRealTime : IO Int
ClockRealTime = foreign FFI_C "#CLOCK_REALTIME" (IO Int)

clock_gettime : IO CTimeSpec
clock_gettime = do
  mem <- alloc time_spec
  result <- foreign FFI_C "clock_gettime" (Int -> Ptr -> IO Int) !ClockRealTime mem
  let (CPt x1 y) = field time_spec 0 mem
  let (CPt x2 y) = field time_spec 1 mem
  pure $ MkCTimeSpec (prim__zextB64_BigInt !(peek I64 x1)) (prim__zextB64_BigInt !(peek I64 x1))

clock_getres : IO CTimeSpec
clock_getres = do
  mem <- alloc time_spec
  result <- foreign FFI_C "clock_getres" (Int -> Ptr -> IO Int) !ClockRealTime mem
  let (CPt x1 y) = field time_spec 0 mem
  let (CPt x2 y) = field time_spec 1 mem
  pure $ MkCTimeSpec (prim__zextB64_BigInt !(peek I64 x1)) (prim__zextB64_BigInt !(peek I64 x1))

--hole : CPtr -> IO ()
--hole (CPt ptr y) = do
--  x <- ClockRealTime
--   let x = get_time x ptr
--   pure ptr


main : IO ()
main = do
  putStrLn $ show !clock_gettime
  putStrLn $ show !clock_getres
  pure ()
  -- mem <- alloc time_spec
  --   v <- get_time !ClockRealTime mem
  -- putStrLn $ show v
  -- let (CPt x1 y) = field time_spec 0 mem
  -- let (CPt x2 y) = field time_spec 1 mem
  --   putStrLn $ show $ prim__zextB64_BigInt !(peek I64 x1)
  -- putStrLn $ show !(peek I64 x2)
  -- pure ()
