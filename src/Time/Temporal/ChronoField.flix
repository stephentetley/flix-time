/*
 * Copyright 2022 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



mod Time.Temporal {

    use Time.Temporal.ChronoField
    use Time.Temporal.ChronoField.{NanoOfSecond, NanoOfDay, MicroOfSecond, MicroOfDay, 
        MilliOfSecond, MilliOfDay, SecondOfMinute, SecondOfDay, MinuteOfHour, MinuteOfDay, 
        HourOfAmPm, ClockHourOfAmPm, HourOfDay, ClockHourOfDay, AmPmOfDay, DayOfWeek, 
        AlignedDayOfWeekInMonth, AlignedDayOfWeekInYear, DayOfMonth, DayOfYear, EpochDay, 
        AlignedWeekOfMonth, AlignedWeekOfYear, MonthOfYear, ProlepticMonth, YearOfEra, 
        Year, Era, InstantSeconds, OffsetSeconds}

    ///
    /// ChronoField
    ///
    pub enum ChronoField with Eq, Order, ToString, Hash {
        case NanoOfSecond
        case NanoOfDay
        case MicroOfSecond
        case MicroOfDay
        case MilliOfSecond
        case MilliOfDay
        case SecondOfMinute
        case SecondOfDay
        case MinuteOfHour
        case MinuteOfDay
        case HourOfAmPm
        case ClockHourOfAmPm
        case HourOfDay
        case ClockHourOfDay
        case AmPmOfDay
        case DayOfWeek
        case AlignedDayOfWeekInMonth
        case AlignedDayOfWeekInYear
        case DayOfMonth
        case DayOfYear
        case EpochDay
        case AlignedWeekOfMonth
        case AlignedWeekOfYear
        case MonthOfYear
        case ProlepticMonth
        case YearOfEra
        case Year
        case Era
        case InstantSeconds
        case OffsetSeconds
    }

    instance FromString[ChronoField] {
        pub def fromString(x: String): Option[ChronoField] = match x {
            case "NanoOfSecond"             => Some(NanoOfSecond)
            case "NanoOfDay"                => Some(NanoOfDay)
            case "MicroOfSecond"            => Some(MicroOfSecond)
            case "MicroOfDay"               => Some(MicroOfDay)
            case "MilliOfSecond"            => Some(MilliOfSecond)
            case "MilliOfDay"               => Some(MilliOfDay)
            case "SecondOfMinute"           => Some(SecondOfMinute)
            case "SecondOfDay"              => Some(SecondOfDay)
            case "MinuteOfHour"             => Some(MinuteOfHour)
            case "MinuteOfDay"              => Some(MinuteOfDay)
            case "HourOfAmPm"               => Some(HourOfAmPm)
            case "ClockHourOfAmPm"          => Some(ClockHourOfAmPm)
            case "HourOfDay"                => Some(HourOfDay)
            case "ClockHourOfDay"           => Some(ClockHourOfDay)
            case "AmPmOfDay"                => Some(AmPmOfDay)
            case "DayOfWeek"                => Some(DayOfWeek)
            case "AlignedDayOfWeekInMonth"  => Some(AlignedDayOfWeekInMonth)
            case "AlignedDayOfWeekInYear"   => Some(AlignedDayOfWeekInYear)
            case "DayOfMonth"               => Some(DayOfMonth)
            case "DayOfYear"                => Some(DayOfYear)
            case "EpochDay"                 => Some(EpochDay)
            case "AlignedWeekOfMonth"       => Some(AlignedWeekOfMonth)
            case "AlignedWeekOfYear"        => Some(AlignedWeekOfYear)
            case "MonthOfYear"              => Some(MonthOfYear)
            case "ProlepticMonth"           => Some(ProlepticMonth)
            case "YearOfEra"                => Some(YearOfEra)
            case "Year"                     => Some(Year)
            case "Era"                      => Some(Era)
            case "InstantSeconds"           => Some(InstantSeconds)
            case "OffsetSeconds"            => Some(OffsetSeconds)
            case _              => None
        }
    }


}

mod Time.Temporal.ChronoField {

    use Time.Temporal.ChronoField
    use Time.Temporal.ChronoField.{NanoOfSecond, NanoOfDay, MicroOfSecond, MicroOfDay, 
        MilliOfSecond, MilliOfDay, SecondOfMinute, SecondOfDay, MinuteOfHour, MinuteOfDay, 
        HourOfAmPm, ClockHourOfAmPm, HourOfDay, ClockHourOfDay, AmPmOfDay, DayOfWeek, 
        AlignedDayOfWeekInMonth, AlignedDayOfWeekInYear, DayOfMonth, DayOfYear, EpochDay, 
        AlignedWeekOfMonth, AlignedWeekOfYear, MonthOfYear, ProlepticMonth, YearOfEra, 
        Year, Era, InstantSeconds, OffsetSeconds}
    use Time.Temporal.TemporalField
    use Time.Temporal.TemporalField.{TemporalField}

    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{TemporalField => JTemporalField}
    import java.lang.{Enum => JEnum}

    /// Marshal enums

    pub def marshalChronoField(x: ChronoField): JChronoField =
        match x {
            case NanoOfSecond               => unsafe JChronoField.NANO_OF_SECOND
            case NanoOfDay                  => unsafe JChronoField.NANO_OF_DAY
            case MicroOfSecond              => unsafe JChronoField.MICRO_OF_SECOND
            case MicroOfDay                 => unsafe JChronoField.MICRO_OF_DAY
            case MilliOfSecond              => unsafe JChronoField.MILLI_OF_SECOND
            case MilliOfDay                 => unsafe JChronoField.MILLI_OF_DAY
            case SecondOfMinute             => unsafe JChronoField.SECOND_OF_MINUTE
            case SecondOfDay                => unsafe JChronoField.SECOND_OF_DAY
            case MinuteOfHour               => unsafe JChronoField.MINUTE_OF_HOUR
            case MinuteOfDay                => unsafe JChronoField.MINUTE_OF_DAY
            case HourOfAmPm                 => unsafe JChronoField.HOUR_OF_AMPM
            case ClockHourOfAmPm            => unsafe JChronoField.CLOCK_HOUR_OF_AMPM
            case HourOfDay                  => unsafe JChronoField.HOUR_OF_DAY
            case ClockHourOfDay             => unsafe JChronoField.CLOCK_HOUR_OF_DAY
            case AmPmOfDay                  => unsafe JChronoField.AMPM_OF_DAY
            case DayOfWeek                  => unsafe JChronoField.DAY_OF_WEEK
            case AlignedDayOfWeekInMonth    => unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH
            case AlignedDayOfWeekInYear     => unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR
            case DayOfMonth                 => unsafe JChronoField.DAY_OF_MONTH
            case DayOfYear                  => unsafe JChronoField.DAY_OF_YEAR
            case EpochDay                   => unsafe JChronoField.EPOCH_DAY
            case AlignedWeekOfMonth         => unsafe JChronoField.ALIGNED_WEEK_OF_MONTH
            case AlignedWeekOfYear          => unsafe JChronoField.ALIGNED_WEEK_OF_YEAR
            case MonthOfYear                => unsafe JChronoField.MONTH_OF_YEAR
            case ProlepticMonth             => unsafe JChronoField.PROLEPTIC_MONTH
            case YearOfEra                  => unsafe JChronoField.YEAR_OF_ERA
            case Year                       => unsafe JChronoField.YEAR
            case Era                        => unsafe JChronoField.ERA
            case InstantSeconds             => unsafe JChronoField.INSTANT_SECONDS
            case OffsetSeconds              => unsafe JChronoField.OFFSET_SECONDS
        }

    def primEquals(x: JChronoField, y: JChronoField): Bool =
        let x1 = (checked_cast(x) : JEnum);
        let y1 = (checked_cast(y) : JEnum);
        unsafe x1.equals(y1)


    pub def unmarshalChronoField(x: JChronoField): ChronoField =
        match x {
            case x1 if primEquals(x1, unsafe JChronoField.NANO_OF_SECOND)               => NanoOfSecond
            case x1 if primEquals(x1, unsafe JChronoField.NANO_OF_DAY)                  => NanoOfDay
            case x1 if primEquals(x1, unsafe JChronoField.MICRO_OF_SECOND)              => MicroOfSecond
            case x1 if primEquals(x1, unsafe JChronoField.MICRO_OF_DAY)                 => MicroOfDay
            case x1 if primEquals(x1, unsafe JChronoField.MILLI_OF_SECOND)              => MilliOfSecond
            case x1 if primEquals(x1, unsafe JChronoField.MILLI_OF_DAY)                 => MilliOfDay
            case x1 if primEquals(x1, unsafe JChronoField.SECOND_OF_MINUTE)             => SecondOfMinute
            case x1 if primEquals(x1, unsafe JChronoField.SECOND_OF_DAY)                => SecondOfDay
            case x1 if primEquals(x1, unsafe JChronoField.MINUTE_OF_HOUR)               => MinuteOfHour
            case x1 if primEquals(x1, unsafe JChronoField.MINUTE_OF_DAY)                => MinuteOfDay
            case x1 if primEquals(x1, unsafe JChronoField.HOUR_OF_AMPM)                 => HourOfAmPm
            case x1 if primEquals(x1, unsafe JChronoField.CLOCK_HOUR_OF_AMPM)           => ClockHourOfAmPm
            case x1 if primEquals(x1, unsafe JChronoField.HOUR_OF_DAY)                  => HourOfDay
            case x1 if primEquals(x1, unsafe JChronoField.CLOCK_HOUR_OF_DAY)            => ClockHourOfDay
            case x1 if primEquals(x1, unsafe JChronoField.AMPM_OF_DAY)                  => AmPmOfDay
            case x1 if primEquals(x1, unsafe JChronoField.DAY_OF_WEEK)                  => DayOfWeek
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH) => AlignedDayOfWeekInMonth
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR)  => AlignedDayOfWeekInYear
            case x1 if primEquals(x1, unsafe JChronoField.DAY_OF_MONTH)                 => DayOfMonth
            case x1 if primEquals(x1, unsafe JChronoField.DAY_OF_YEAR)                  => DayOfYear
            case x1 if primEquals(x1, unsafe JChronoField.EPOCH_DAY)                    => EpochDay
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_WEEK_OF_MONTH)        => AlignedWeekOfMonth
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_WEEK_OF_YEAR)         => AlignedWeekOfYear
            case x1 if primEquals(x1, unsafe JChronoField.MONTH_OF_YEAR)                => MonthOfYear
            case x1 if primEquals(x1, unsafe JChronoField.PROLEPTIC_MONTH)              => ProlepticMonth
            case x1 if primEquals(x1, unsafe JChronoField.YEAR_OF_ERA)                  => YearOfEra
            case x1 if primEquals(x1, unsafe JChronoField.YEAR)                         => Year
            case x1 if primEquals(x1, unsafe JChronoField.ERA)                          => Era
            case x1 if primEquals(x1, unsafe JChronoField.INSTANT_SECONDS)              => InstantSeconds
            case x1 if primEquals(x1, unsafe JChronoField.OFFSET_SECONDS)               => OffsetSeconds
            case _                                                          => bug!("unmarshalChronoField")
        }


    pub def asTemporalField(x: ChronoField): TemporalField = 
        let x1 = Time.Temporal.ChronoField.marshalChronoField(x);
        let cx1 = unchecked_cast(x1 as JTemporalField);
        TemporalField(cx1)

}
