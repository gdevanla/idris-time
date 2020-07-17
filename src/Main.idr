module Main

import Internal.CTimespec

main : IO ()
main = do
  putStrLn $ show !clock_gettime
  --putStrLn $ show !clock_getres
  pure ()
  -- mem <- alloc time_spec
  --   v <- get_time !ClockRealTime mem
  -- putStrLn $ show v
  -- let (CPt x1 y) = field time_spec 0 mem
  -- let (CPt x2 y) = field time_spec 1 mem
  --   putStrLn $ show $ prim__zextB64_BigInt !(peek I64 x1)
  -- putStrLn $ show !(peek I64 x2)
  -- pure ()

-- Local Variables:
-- idris-load-packages: ("contrib")
-- End:
