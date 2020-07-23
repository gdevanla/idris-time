module Test.TestGregorian

import Data.Fin

import Test.TestUtil
import Data.Time.Calendar.Gregorian
import Data.Time.Calendar.Days

export
test_toGregorian: IO ()
test_toGregorian = do
  let result = toGregorian (MkModifiedJulianDay 59053)
  assertEq "test_toGregorian" result (MkGregorian 2020 7 23) ""

export
test_fromGregorian: IO ()
test_fromGregorian = do
  let result = fromGregorian (MkGregorian 2020 7 23)
  assertEq "test_fromGregorian" result (MkModifiedJulianDay 59053) ""

export
test_gregorianMonthLength: IO ()
test_gregorianMonthLength = do
  let result = gregorianMonthLength 2020 (FS 0)
  assertEq "test_gregorianMonthLength" result 29 (show result)

export
test_gregorianMonthLengthNonLeap: IO ()
test_gregorianMonthLengthNonLeap = do
  let result = gregorianMonthLength 2021 (FS 0)
  assertEq "test_gregorianMonthLengthNonLeap" result 28 (show result)

export
test_rolloverMonths: IO ()
test_rolloverMonths = do
  let result = rolloverMonths (2020, 11)
  assertEq "test_rolloverMonths" (2020, 11) result (show result)
  let result = rolloverMonths (2020, 13)
  assertEq "test_rolloverMonthsToNextYear" (2021, 1) result (show result)

export
test_addGregorianMonths: IO ()
test_addGregorianMonths = do
  let result = addGregorianMonths 5 (fromGregorian (MkGregorian 2020 2 15))
  assertEq "test_addGregorianMonths" result (MkGregorian 2020 7 15) (show result)
