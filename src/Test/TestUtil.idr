module Test.TestUtil

public export
assertEq : Eq a => (name: String) -> (given : a) -> (expected : a) -> (message: String) -> IO ()
assertEq name g e mess = if g == e
  then putStrLn $ (show name) ++ ": Test Passed"
  else putStrLn $ (show name) ++ ": Test Failed = " ++ mess

public export
assertNotEq : Eq a => (name: String) -> (given : a) -> (expected : a) -> (message: String) -> IO ()
assertNotEq name g e mess = if not (g == e)
  then putStrLn $ (show name) ++ ": Test Passed"
  else putStrLn $ (show name) ++ ": Test Failed = " ++ mess


public export
assertGT : Ord a => (name: String) -> (given : a) -> (expected : a) -> (message: String) -> IO ()
assertGT name g e message = if (g > e)
  then putStrLn $ (show name) ++ ": Test Passed"
  else putStrLn $ (show name) ++ ": Test Failed = " ++ message
