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
    
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{TemporalField => JTemporalField}


    ///
    /// ChronoField
    ///
    pub enum ChronoField with Eq, Order, ToString {
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

    instance Hash[ChronoField] {
        pub def hash(x: ChronoField): Int32 = match x {
            case ChronoField.NanoOfSecond               => unsafe IO { let x1 = JChronoField.NANO_OF_SECOND; x1.hashCode() }
            case ChronoField.NanoOfDay                  => unsafe IO { let x1 = JChronoField.NANO_OF_DAY; x1.hashCode() }
            case ChronoField.MicroOfSecond              => unsafe IO { let x1 = JChronoField.MICRO_OF_SECOND; x1.hashCode() }
            case ChronoField.MicroOfDay                 => unsafe IO { let x1 = JChronoField.MICRO_OF_DAY; x1.hashCode() }
            case ChronoField.MilliOfSecond              => unsafe IO { let x1 = JChronoField.MILLI_OF_SECOND; x1.hashCode() }
            case ChronoField.MilliOfDay                 => unsafe IO { let x1 = JChronoField.MILLI_OF_DAY; x1.hashCode() }
            case ChronoField.SecondOfMinute             => unsafe IO { let x1 = JChronoField.SECOND_OF_MINUTE; x1.hashCode() }
            case ChronoField.SecondOfDay                => unsafe IO { let x1 = JChronoField.SECOND_OF_DAY; x1.hashCode() }
            case ChronoField.MinuteOfHour               => unsafe IO { let x1 = JChronoField.MINUTE_OF_HOUR; x1.hashCode() }
            case ChronoField.MinuteOfDay                => unsafe IO { let x1 = JChronoField.MINUTE_OF_DAY; x1.hashCode() }
            case ChronoField.HourOfAmPm                 => unsafe IO { let x1 = JChronoField.HOUR_OF_AMPM; x1.hashCode() }
            case ChronoField.ClockHourOfAmPm            => unsafe IO { let x1 = JChronoField.CLOCK_HOUR_OF_AMPM; x1.hashCode() }
            case ChronoField.HourOfDay                  => unsafe IO { let x1 = JChronoField.HOUR_OF_DAY; x1.hashCode() }
            case ChronoField.ClockHourOfDay             => unsafe IO { let x1 = JChronoField.CLOCK_HOUR_OF_DAY; x1.hashCode() }
            case ChronoField.AmPmOfDay                  => unsafe IO { let x1 = JChronoField.AMPM_OF_DAY; x1.hashCode() }
            case ChronoField.DayOfWeek                  => unsafe IO { let x1 = JChronoField.DAY_OF_WEEK; x1.hashCode() }
            case ChronoField.AlignedDayOfWeekInMonth    => unsafe IO { let x1 = JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH; x1.hashCode() }
            case ChronoField.AlignedDayOfWeekInYear     => unsafe IO { let x1 = JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR; x1.hashCode() }
            case ChronoField.DayOfMonth                 => unsafe IO { let x1 = JChronoField.DAY_OF_MONTH; x1.hashCode() }
            case ChronoField.DayOfYear                  => unsafe IO { let x1 = JChronoField.DAY_OF_YEAR; x1.hashCode() }
            case ChronoField.EpochDay                   => unsafe IO { let x1 = JChronoField.EPOCH_DAY; x1.hashCode() }
            case ChronoField.AlignedWeekOfMonth         => unsafe IO { let x1 = JChronoField.ALIGNED_WEEK_OF_MONTH; x1.hashCode() }
            case ChronoField.AlignedWeekOfYear          => unsafe IO { let x1 = JChronoField.ALIGNED_WEEK_OF_YEAR; x1.hashCode() }
            case ChronoField.MonthOfYear                => unsafe IO { let x1 = JChronoField.MONTH_OF_YEAR; x1.hashCode() }
            case ChronoField.ProlepticMonth             => unsafe IO { let x1 = JChronoField.PROLEPTIC_MONTH; x1.hashCode() }
            case ChronoField.YearOfEra                  => unsafe IO { let x1 = JChronoField.YEAR_OF_ERA; x1.hashCode() }
            case ChronoField.Year                       => unsafe IO { let x1 = JChronoField.YEAR; x1.hashCode() }
            case ChronoField.Era                        => unsafe IO { let x1 = JChronoField.ERA; x1.hashCode() }
            case ChronoField.InstantSeconds             => unsafe IO { let x1 = JChronoField.INSTANT_SECONDS; x1.hashCode() }
            case ChronoField.OffsetSeconds              => unsafe IO { let x1 = JChronoField.OFFSET_SECONDS; x1.hashCode() }
        }
    }


    instance ToJava[ChronoField] {
        type Out = JChronoField
        pub def toJava(x: ChronoField): JChronoField = match x {
            case ChronoField.NanoOfSecond               => unsafe IO { JChronoField.NANO_OF_SECOND }
            case ChronoField.NanoOfDay                  => unsafe IO { JChronoField.NANO_OF_DAY }
            case ChronoField.MicroOfSecond              => unsafe IO { JChronoField.MICRO_OF_SECOND }
            case ChronoField.MicroOfDay                 => unsafe IO { JChronoField.MICRO_OF_DAY }
            case ChronoField.MilliOfSecond              => unsafe IO { JChronoField.MILLI_OF_SECOND }
            case ChronoField.MilliOfDay                 => unsafe IO { JChronoField.MILLI_OF_DAY }
            case ChronoField.SecondOfMinute             => unsafe IO { JChronoField.SECOND_OF_MINUTE }
            case ChronoField.SecondOfDay                => unsafe IO { JChronoField.SECOND_OF_DAY }
            case ChronoField.MinuteOfHour               => unsafe IO { JChronoField.MINUTE_OF_HOUR }
            case ChronoField.MinuteOfDay                => unsafe IO { JChronoField.MINUTE_OF_DAY }
            case ChronoField.HourOfAmPm                 => unsafe IO { JChronoField.HOUR_OF_AMPM }
            case ChronoField.ClockHourOfAmPm            => unsafe IO { JChronoField.CLOCK_HOUR_OF_AMPM }
            case ChronoField.HourOfDay                  => unsafe IO { JChronoField.HOUR_OF_DAY }
            case ChronoField.ClockHourOfDay             => unsafe IO { JChronoField.CLOCK_HOUR_OF_DAY }
            case ChronoField.AmPmOfDay                  => unsafe IO { JChronoField.AMPM_OF_DAY }
            case ChronoField.DayOfWeek                  => unsafe IO { JChronoField.DAY_OF_WEEK }
            case ChronoField.AlignedDayOfWeekInMonth    => unsafe IO { JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH }
            case ChronoField.AlignedDayOfWeekInYear     => unsafe IO { JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR }
            case ChronoField.DayOfMonth                 => unsafe IO { JChronoField.DAY_OF_MONTH }
            case ChronoField.DayOfYear                  => unsafe IO { JChronoField.DAY_OF_YEAR }
            case ChronoField.EpochDay                   => unsafe IO { JChronoField.EPOCH_DAY }
            case ChronoField.AlignedWeekOfMonth         => unsafe IO { JChronoField.ALIGNED_WEEK_OF_MONTH }
            case ChronoField.AlignedWeekOfYear          => unsafe IO { JChronoField.ALIGNED_WEEK_OF_YEAR }
            case ChronoField.MonthOfYear                => unsafe IO { JChronoField.MONTH_OF_YEAR }
            case ChronoField.ProlepticMonth             => unsafe IO { JChronoField.PROLEPTIC_MONTH }
            case ChronoField.YearOfEra                  => unsafe IO { JChronoField.YEAR_OF_ERA }
            case ChronoField.Year                       => unsafe IO { JChronoField.YEAR }
            case ChronoField.Era                        => unsafe IO { JChronoField.ERA }
            case ChronoField.InstantSeconds             => unsafe IO { JChronoField.INSTANT_SECONDS }
            case ChronoField.OffsetSeconds              => unsafe IO { JChronoField.OFFSET_SECONDS }
        }
    }



    instance ToFlix[ChronoField] {
        type In = JChronoField
        pub def toFlix(x: JChronoField): ChronoField = unsafe IO {
            if (x.equals(JChronoField.NANO_OF_SECOND))                      ChronoField.NanoOfSecond
            else if (x.equals(JChronoField.NANO_OF_DAY))                    ChronoField.NanoOfDay
            else if (x.equals(JChronoField.MICRO_OF_SECOND))                ChronoField.MicroOfSecond
            else if (x.equals(JChronoField.MICRO_OF_DAY))                   ChronoField.MicroOfDay
            else if (x.equals(JChronoField.MILLI_OF_SECOND))                ChronoField.MilliOfSecond
            else if (x.equals(JChronoField.MILLI_OF_DAY))                   ChronoField.MilliOfDay
            else if (x.equals(JChronoField.SECOND_OF_MINUTE))               ChronoField.SecondOfMinute
            else if (x.equals(JChronoField.SECOND_OF_DAY))                  ChronoField.SecondOfDay
            else if (x.equals(JChronoField.MINUTE_OF_HOUR))                 ChronoField.MinuteOfHour
            else if (x.equals(JChronoField.MINUTE_OF_DAY))                  ChronoField.MinuteOfDay
            else if (x.equals(JChronoField.HOUR_OF_AMPM))                   ChronoField.HourOfAmPm
            else if (x.equals(JChronoField.CLOCK_HOUR_OF_AMPM))             ChronoField.ClockHourOfAmPm
            else if (x.equals(JChronoField.HOUR_OF_DAY))                    ChronoField.HourOfDay
            else if (x.equals(JChronoField.CLOCK_HOUR_OF_DAY))              ChronoField.ClockHourOfDay
            else if (x.equals(JChronoField.AMPM_OF_DAY))                    ChronoField.AmPmOfDay
            else if (x.equals(JChronoField.DAY_OF_WEEK))                    ChronoField.DayOfWeek
            else if (x.equals(JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH))   ChronoField.AlignedDayOfWeekInMonth
            else if (x.equals(JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR))    ChronoField.AlignedDayOfWeekInYear
            else if (x.equals(JChronoField.DAY_OF_MONTH))                   ChronoField.DayOfMonth
            else if (x.equals(JChronoField.DAY_OF_YEAR))                    ChronoField.DayOfYear
            else if (x.equals(JChronoField.EPOCH_DAY))                      ChronoField.EpochDay
            else if (x.equals(JChronoField.ALIGNED_WEEK_OF_MONTH))          ChronoField.AlignedWeekOfMonth
            else if (x.equals(JChronoField.ALIGNED_WEEK_OF_YEAR))           ChronoField.AlignedWeekOfYear
            else if (x.equals(JChronoField.MONTH_OF_YEAR))                  ChronoField.MonthOfYear
            else if (x.equals(JChronoField.PROLEPTIC_MONTH))                ChronoField.ProlepticMonth
            else if (x.equals(JChronoField.YEAR_OF_ERA))                    ChronoField.YearOfEra
            else if (x.equals(JChronoField.YEAR))                           ChronoField.Year
            else if (x.equals(JChronoField.ERA))                            ChronoField.Era
            else if (x.equals(JChronoField.INSTANT_SECONDS))                ChronoField.InstantSeconds
            else if (x.equals(JChronoField.OFFSET_SECONDS))                 ChronoField.OffsetSeconds
            else bug!("toFlix[ChronoField]")
        }
    }

}
