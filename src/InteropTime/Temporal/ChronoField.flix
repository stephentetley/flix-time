/*
 * Copyright 2024 Stephen Tetley
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


pub mod InteropTime.Temporal.ChronoField {

    use InteropTime.Temporal.ChronoField.ChronoField
    use InteropTime.Temporal.ChronoField.ChronoField.{NanoOfSecond, NanoOfDay,
        MicroOfSecond, MicroOfDay, MilliOfSecond, MilliOfDay, SecondOfMinute,
        SecondOfDay, MinuteOfHour, MinuteOfDay, HourOfAmPm, ClockHourOfAmPm,
        HourOfDay, ClockHourOfDay, AmPmOfDay, DayOfWeek, AlignedDayOfWeekInMonth,
        AlignedDayOfWeekInYear, DayOfMonth, DayOfYear, EpochDay, AlignedWeekOfMonth,
        AlignedWeekOfYear, MonthOfYear, ProlepticMonth, YearOfEra, Year, Era,
        InstantSeconds, OffsetSeconds }
    
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{TemporalField => JTemporalField}


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

    /// Marshal enums

    pub def marshalChronoField(x: ChronoField): JChronoField =
        match x {
            case NanoOfSecond               => JChronoField.NANO_OF_SECOND
            case NanoOfDay                  => JChronoField.NANO_OF_DAY
            case MicroOfSecond              => JChronoField.MICRO_OF_SECOND
            case MicroOfDay                 => JChronoField.MICRO_OF_DAY
            case MilliOfSecond              => JChronoField.MILLI_OF_SECOND
            case MilliOfDay                 => JChronoField.MILLI_OF_DAY
            case SecondOfMinute             => JChronoField.SECOND_OF_MINUTE
            case SecondOfDay                => JChronoField.SECOND_OF_DAY
            case MinuteOfHour               => JChronoField.MINUTE_OF_HOUR
            case MinuteOfDay                => JChronoField.MINUTE_OF_DAY
            case HourOfAmPm                 => JChronoField.HOUR_OF_AMPM
            case ClockHourOfAmPm            => JChronoField.CLOCK_HOUR_OF_AMPM
            case HourOfDay                  => JChronoField.HOUR_OF_DAY
            case ClockHourOfDay             => JChronoField.CLOCK_HOUR_OF_DAY
            case AmPmOfDay                  => JChronoField.AMPM_OF_DAY
            case DayOfWeek                  => JChronoField.DAY_OF_WEEK
            case AlignedDayOfWeekInMonth    => JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH
            case AlignedDayOfWeekInYear     => JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR
            case DayOfMonth                 => JChronoField.DAY_OF_MONTH
            case DayOfYear                  => JChronoField.DAY_OF_YEAR
            case EpochDay                   => JChronoField.EPOCH_DAY
            case AlignedWeekOfMonth         => JChronoField.ALIGNED_WEEK_OF_MONTH
            case AlignedWeekOfYear          => JChronoField.ALIGNED_WEEK_OF_YEAR
            case MonthOfYear                => JChronoField.MONTH_OF_YEAR
            case ProlepticMonth             => JChronoField.PROLEPTIC_MONTH
            case YearOfEra                  => JChronoField.YEAR_OF_ERA
            case Year                       => JChronoField.YEAR
            case Era                        => JChronoField.ERA
            case InstantSeconds             => JChronoField.INSTANT_SECONDS
            case OffsetSeconds              => JChronoField.OFFSET_SECONDS
        }

    def primEquals(x: JChronoField, y: JChronoField): Bool =
        unsafe IO { x.equals(y) }


    pub def unmarshalChronoField(x: JChronoField): ChronoField =
        match x {
            case x1 if primEquals(x1, JChronoField.NANO_OF_SECOND)               => NanoOfSecond
            case x1 if primEquals(x1, JChronoField.NANO_OF_DAY)                  => NanoOfDay
            case x1 if primEquals(x1, JChronoField.MICRO_OF_SECOND)              => MicroOfSecond
            case x1 if primEquals(x1, JChronoField.MICRO_OF_DAY)                 => MicroOfDay
            case x1 if primEquals(x1, JChronoField.MILLI_OF_SECOND)              => MilliOfSecond
            case x1 if primEquals(x1, JChronoField.MILLI_OF_DAY)                 => MilliOfDay
            case x1 if primEquals(x1, JChronoField.SECOND_OF_MINUTE)             => SecondOfMinute
            case x1 if primEquals(x1, JChronoField.SECOND_OF_DAY)                => SecondOfDay
            case x1 if primEquals(x1, JChronoField.MINUTE_OF_HOUR)               => MinuteOfHour
            case x1 if primEquals(x1, JChronoField.MINUTE_OF_DAY)                => MinuteOfDay
            case x1 if primEquals(x1, JChronoField.HOUR_OF_AMPM)                 => HourOfAmPm
            case x1 if primEquals(x1, JChronoField.CLOCK_HOUR_OF_AMPM)           => ClockHourOfAmPm
            case x1 if primEquals(x1, JChronoField.HOUR_OF_DAY)                  => HourOfDay
            case x1 if primEquals(x1, JChronoField.CLOCK_HOUR_OF_DAY)            => ClockHourOfDay
            case x1 if primEquals(x1, JChronoField.AMPM_OF_DAY)                  => AmPmOfDay
            case x1 if primEquals(x1, JChronoField.DAY_OF_WEEK)                  => DayOfWeek
            case x1 if primEquals(x1, JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH) => AlignedDayOfWeekInMonth
            case x1 if primEquals(x1, JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR)  => AlignedDayOfWeekInYear
            case x1 if primEquals(x1, JChronoField.DAY_OF_MONTH)                 => DayOfMonth
            case x1 if primEquals(x1, JChronoField.DAY_OF_YEAR)                  => DayOfYear
            case x1 if primEquals(x1, JChronoField.EPOCH_DAY)                    => EpochDay
            case x1 if primEquals(x1, JChronoField.ALIGNED_WEEK_OF_MONTH)        => AlignedWeekOfMonth
            case x1 if primEquals(x1, JChronoField.ALIGNED_WEEK_OF_YEAR)         => AlignedWeekOfYear
            case x1 if primEquals(x1, JChronoField.MONTH_OF_YEAR)                => MonthOfYear
            case x1 if primEquals(x1, JChronoField.PROLEPTIC_MONTH)              => ProlepticMonth
            case x1 if primEquals(x1, JChronoField.YEAR_OF_ERA)                  => YearOfEra
            case x1 if primEquals(x1, JChronoField.YEAR)                         => Year
            case x1 if primEquals(x1, JChronoField.ERA)                          => Era
            case x1 if primEquals(x1, JChronoField.INSTANT_SECONDS)              => InstantSeconds
            case x1 if primEquals(x1, JChronoField.OFFSET_SECONDS)               => OffsetSeconds
            case _                                                          => bug!("unmarshalChronoField")

        }


}
