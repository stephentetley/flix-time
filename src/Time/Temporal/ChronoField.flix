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



mod Time.Temporal {


    ///
    /// ChronoField
    ///
    pub restrictable enum ChronoField[i] with Eq, Order, ToString, Hash {
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


}

mod Time.Temporal.ChronoField {

    use Time.Temporal.ChronoField

    
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{TemporalField => JTemporalField}


    /// Marshal enums

    pub def marshalChronoField(x: ChronoField[s]): JChronoField =
        choose x {
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
        unsafe x.equals(y)


    pub def unmarshalChronoField(x: JChronoField): ChronoField[<NanoOfSecond, NanoOfDay, MicroOfSecond, MicroOfDay, 
                                        MilliOfSecond, MilliOfDay, SecondOfMinute, SecondOfDay, MinuteOfHour, MinuteOfDay, 
                                        HourOfAmPm, ClockHourOfAmPm, HourOfDay, ClockHourOfDay, AmPmOfDay, DayOfWeek, 
                                        AlignedDayOfWeekInMonth, AlignedDayOfWeekInYear, DayOfMonth, DayOfYear, EpochDay, 
                                        AlignedWeekOfMonth, AlignedWeekOfYear, MonthOfYear, ProlepticMonth, YearOfEra, 
                                        Year, Era, InstantSeconds, OffsetSeconds>] =
        match x {
            case x1 if primEquals(x1, unsafe JChronoField.NANO_OF_SECOND)               => open_variant NanoOfSecond
            case x1 if primEquals(x1, unsafe JChronoField.NANO_OF_DAY)                  => open_variant NanoOfDay
            case x1 if primEquals(x1, unsafe JChronoField.MICRO_OF_SECOND)              => open_variant MicroOfSecond
            case x1 if primEquals(x1, unsafe JChronoField.MICRO_OF_DAY)                 => open_variant MicroOfDay
            case x1 if primEquals(x1, unsafe JChronoField.MILLI_OF_SECOND)              => open_variant MilliOfSecond
            case x1 if primEquals(x1, unsafe JChronoField.MILLI_OF_DAY)                 => open_variant MilliOfDay
            case x1 if primEquals(x1, unsafe JChronoField.SECOND_OF_MINUTE)             => open_variant SecondOfMinute
            case x1 if primEquals(x1, unsafe JChronoField.SECOND_OF_DAY)                => open_variant SecondOfDay
            case x1 if primEquals(x1, unsafe JChronoField.MINUTE_OF_HOUR)               => open_variant MinuteOfHour
            case x1 if primEquals(x1, unsafe JChronoField.MINUTE_OF_DAY)                => open_variant MinuteOfDay
            case x1 if primEquals(x1, unsafe JChronoField.HOUR_OF_AMPM)                 => open_variant HourOfAmPm
            case x1 if primEquals(x1, unsafe JChronoField.CLOCK_HOUR_OF_AMPM)           => open_variant ClockHourOfAmPm
            case x1 if primEquals(x1, unsafe JChronoField.HOUR_OF_DAY)                  => open_variant HourOfDay
            case x1 if primEquals(x1, unsafe JChronoField.CLOCK_HOUR_OF_DAY)            => open_variant ClockHourOfDay
            case x1 if primEquals(x1, unsafe JChronoField.AMPM_OF_DAY)                  => open_variant AmPmOfDay
            case x1 if primEquals(x1, unsafe JChronoField.DAY_OF_WEEK)                  => open_variant DayOfWeek
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH) => open_variant AlignedDayOfWeekInMonth
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR)  => open_variant AlignedDayOfWeekInYear
            case x1 if primEquals(x1, unsafe JChronoField.DAY_OF_MONTH)                 => open_variant DayOfMonth
            case x1 if primEquals(x1, unsafe JChronoField.DAY_OF_YEAR)                  => open_variant DayOfYear
            case x1 if primEquals(x1, unsafe JChronoField.EPOCH_DAY)                    => open_variant EpochDay
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_WEEK_OF_MONTH)        => open_variant AlignedWeekOfMonth
            case x1 if primEquals(x1, unsafe JChronoField.ALIGNED_WEEK_OF_YEAR)         => open_variant AlignedWeekOfYear
            case x1 if primEquals(x1, unsafe JChronoField.MONTH_OF_YEAR)                => open_variant MonthOfYear
            case x1 if primEquals(x1, unsafe JChronoField.PROLEPTIC_MONTH)              => open_variant ProlepticMonth
            case x1 if primEquals(x1, unsafe JChronoField.YEAR_OF_ERA)                  => open_variant YearOfEra
            case x1 if primEquals(x1, unsafe JChronoField.YEAR)                         => open_variant Year
            case x1 if primEquals(x1, unsafe JChronoField.ERA)                          => open_variant Era
            case x1 if primEquals(x1, unsafe JChronoField.INSTANT_SECONDS)              => open_variant InstantSeconds
            case x1 if primEquals(x1, unsafe JChronoField.OFFSET_SECONDS)               => open_variant OffsetSeconds
            case _                                                          => bug!("unmarshalChronoField")

        }


}
