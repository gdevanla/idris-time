module Test.TestFixed

import Test.TestUtil
import Data.Time.Clock.Internal.Fixed


getDec : Integer -> Dec
getDec x = MkFixed x

getPico : Integer -> Pico
getPico x = MkFixed x


export
testAdd: IO ()
testAdd = do
  let a = getPico 1
  let b = getPico 1
  assertEq "testAdd" (a + b) 2 ""


export
testSub: IO ()
testSub = do
  let a = getPico 5
  let b = getPico 3
  assertEq "testSub" (a - b) 2 ""


export
testNegate: IO ()
testNegate = do
  let a = negate $ getPico 5
  assertEq "testNegate" a (-5) (show a)


export
testMultFixed: IO ()
testMultFixed = do
  let a = getDec 123
  let b = getDec 25
  let result = a * b
  assertEq "testMultFixed" result 30 (show result)


export
testFracDiv: IO ()
testFracDiv = do
  let a = getDec 3456
  let b = getDec 1234
  let result = a / b
  assertEq "testMultFixed" result 280 (show result)


export
testRecip: IO ()
testRecip = do
  let a = getDec 3456
  let result = recip a
  assertEq "testRecip" result 2 (show result)
