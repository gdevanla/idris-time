module Data.Time.LocalTime.Internal.TimeZone


export
record TimeZone where
  constructor MkTimeZone
  timeZoneMinutes: Int
  timeZoneSummaryOnly: Bool
  timeZoneName: String

-- TODO: Implement TimeZone conversion functions
