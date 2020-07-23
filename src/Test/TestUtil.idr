module Test.TestUtil

public export
printSuccess: String -> IO ()
printSuccess s = putStrLn $ "\x1b[32m" ++ s

public export
printFail: String -> IO ()
printFail s = putStrLn $ "\x1b[31m" ++ s

public export
assertEq : Eq a => (name: String) -> (given : a) -> (expected : a) -> (message: String) -> IO ()
assertEq name g e mess = if g == e
  then printSuccess $ (show name) ++ ": Test Passed"
  else printFail $ (show name) ++ ": Test Failed = " ++ mess

public export
assertNotEq : Eq a => (name: String) -> (given : a) -> (expected : a) -> (message: String) -> IO ()
assertNotEq name g e mess = if not (g == e)
  then printSuccess $ (show name) ++ ": Test Passed"
  else printFail $ (show name) ++ ": Test Failed = " ++ mess


public export
assertGT : Ord a => (name: String) -> (given : a) -> (expected : a) -> (message: String) -> IO ()
assertGT name g e message = if (g > e)
  then printSuccess $ (show name) ++ ": Test Passed"
  else printFail $ (show name) ++ ": Test Failed = " ++ message
