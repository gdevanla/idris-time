module Test.TestOrdinalDate

import Data.Fin

import Test.TestUtil
import Data.Time.Calendar.OrdinalDate
import Data.Time.Calendar.Days
import Data.Time.Calendar.Gregorian

export
test_toOrdinalDate: IO ()
test_toOrdinalDate = do
  let result = toOrdinalDate (MkModifiedJulianDay 59053)
  assertEq "test_toOrdinalDate" result (2020, 205) (show result)

export
test_fromOrdinalDate: IO ()
test_fromOrdinalDate = do
  let result = fromOrdinalDate 2020 205
  assertEq "test_toOrdinalDate" result (MkModifiedJulianDay 59053) (show result)

export
test_fromOrdinalDateWithJust: IO ()
test_fromOrdinalDateWithJust = do
  let result = fromOrdinalDateValid 2020 205
  assertEq "test_fromOrdinalDateWithJust_1" result (Just (MkModifiedJulianDay 59053)) (show result)
  let result = fromOrdinalDateValid 2020 366
  assertEq "test_fromOrdinalDataWithJust_2" result (Just (MkModifiedJulianDay 59214)) (show result)


export
test_fromOrdinalDateWithNothing: IO ()
test_fromOrdinalDateWithNothing = do
  let result = fromOrdinalDateValid 2020 368
  assertEq "test_toOrdinalDateWithNothing" result Nothing (show result)
