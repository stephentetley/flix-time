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



namespace Time/Temporal {

    use Time/Temporal.TemporalField
    use Time/Temporal.TemporalField.{TemporalField}

    ///
    /// ChronoField
    ///
    pub enum ChronoField with Eq, Order, ToString, Hash, Boxable {
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

    instance Interop/Flix.Marshal[ChronoField] {
        pub def toJavaObject(x: ChronoField): ##java.lang.Object =
            let x1 = Time/Temporal/ChronoField.marshal(x);
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): ChronoField = 
            let x1 = unsafe_cast o as ##java.time.temporal.ChronoField;
            Time/Temporal/ChronoField.unmarshal(x1)
    }

    instance Time/Temporal.ImplementsTemporalField[ChronoField] {
        pub def toTemporalField(x: ChronoField): TemporalField = 
            let x1 = Time/Temporal/ChronoField.marshal(x);
            TemporalField(unsafe_cast x1 as ##java.time.temporal.TemporalField)

        pub def fromTemporalField(x: TemporalField): ChronoField = 
            let TemporalField(x1) = x;
            Time/Temporal/ChronoField.unmarshal(unsafe_cast x1 as ##java.time.temporal.ChronoField)
    }


}

namespace Time/Temporal/ChronoField {

    use Time/Temporal.ChronoField
    use Time/Temporal.ChronoField.{NanoOfSecond, NanoOfDay, MicroOfSecond, MicroOfDay, 
        MilliOfSecond, MilliOfDay, SecondOfMinute, SecondOfDay, MinuteOfHour, MinuteOfDay, 
        HourOfAmPm, ClockHourOfAmPm, HourOfDay, ClockHourOfDay, AmPmOfDay, DayOfWeek, 
        AlignedDayOfWeekInMonth, AlignedDayOfWeekInYear, DayOfMonth, DayOfYear, EpochDay, 
        AlignedWeekOfMonth, AlignedWeekOfYear, MonthOfYear, ProlepticMonth, YearOfEra, 
        Year, Era, InstantSeconds, OffsetSeconds}

    use Time.DurationZ
    use Time.DurationZ.{DurationZ}

    /// ## Marshal enums

    pub def marshal(x: ChronoField): ##java.time.temporal.ChronoField =
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_SECOND;
        import static get java.time.temporal.ChronoField.NANO_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_DAY;
        import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_SECOND;
        import static get java.time.temporal.ChronoField.MICRO_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_DAY;
        import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_SECOND;
        import static get java.time.temporal.ChronoField.MILLI_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_DAY;
        import static get java.time.temporal.ChronoField.SECOND_OF_MINUTE: ##java.time.temporal.ChronoField \ {} as get_SECOND_OF_MINUTE;
        import static get java.time.temporal.ChronoField.SECOND_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_SECOND_OF_DAY;
        import static get java.time.temporal.ChronoField.MINUTE_OF_HOUR: ##java.time.temporal.ChronoField \ {} as get_MINUTE_OF_HOUR;
        import static get java.time.temporal.ChronoField.MINUTE_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_MINUTE_OF_DAY;
        import static get java.time.temporal.ChronoField.HOUR_OF_AMPM: ##java.time.temporal.ChronoField \ {} as get_HOUR_OF_AMPM;
        import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_AMPM: ##java.time.temporal.ChronoField \ {} as get_CLOCK_HOUR_OF_AMPM;
        import static get java.time.temporal.ChronoField.HOUR_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_HOUR_OF_DAY;
        import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_CLOCK_HOUR_OF_DAY;
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;
        import static get java.time.temporal.ChronoField.DAY_OF_WEEK: ##java.time.temporal.ChronoField \ {} as get_DAY_OF_WEEK;
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_DAY_OF_WEEK_IN_MONTH;
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_DAY_OF_WEEK_IN_YEAR;
        import static get java.time.temporal.ChronoField.DAY_OF_MONTH: ##java.time.temporal.ChronoField \ {} as get_DAY_OF_MONTH;
        import static get java.time.temporal.ChronoField.DAY_OF_YEAR: ##java.time.temporal.ChronoField \ {} as get_DAY_OF_YEAR;
        import static get java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField \ {} as get_EPOCH_DAY;
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_WEEK_OF_MONTH;
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_YEAR: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_WEEK_OF_YEAR;
        import static get java.time.temporal.ChronoField.MONTH_OF_YEAR: ##java.time.temporal.ChronoField \ {} as get_MONTH_OF_YEAR;
        import static get java.time.temporal.ChronoField.PROLEPTIC_MONTH: ##java.time.temporal.ChronoField \ {} as get_PROLEPTIC_MONTH;
        import static get java.time.temporal.ChronoField.YEAR_OF_ERA: ##java.time.temporal.ChronoField \ {} as get_YEAR_OF_ERA;
        import static get java.time.temporal.ChronoField.YEAR: ##java.time.temporal.ChronoField \ {} as get_YEAR;
        import static get java.time.temporal.ChronoField.ERA: ##java.time.temporal.ChronoField \ {} as get_ERA;
        import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField \ {} as get_INSTANT_SECONDS;
        import static get java.time.temporal.ChronoField.OFFSET_SECONDS: ##java.time.temporal.ChronoField \ {} as get_OFFSET_SECONDS;
        match x {
            case NanoOfSecond               => get_NANO_OF_SECOND()
            case NanoOfDay                  => get_NANO_OF_DAY()
            case MicroOfSecond              => get_MICRO_OF_SECOND()
            case MicroOfDay                 => get_MICRO_OF_DAY()
            case MilliOfSecond              => get_MILLI_OF_SECOND()
            case MilliOfDay                 => get_MILLI_OF_DAY()
            case SecondOfMinute             => get_SECOND_OF_MINUTE()
            case SecondOfDay                => get_SECOND_OF_DAY()
            case MinuteOfHour               => get_MINUTE_OF_HOUR()
            case MinuteOfDay                => get_MINUTE_OF_DAY()
            case HourOfAmPm                 => get_HOUR_OF_AMPM()
            case ClockHourOfAmPm            => get_CLOCK_HOUR_OF_AMPM()
            case HourOfDay                  => get_HOUR_OF_DAY()
            case ClockHourOfDay             => get_CLOCK_HOUR_OF_DAY()
            case AmPmOfDay                  => get_AMPM_OF_DAY()
            case DayOfWeek                  => get_DAY_OF_WEEK()
            case AlignedDayOfWeekInMonth    => get_ALIGNED_DAY_OF_WEEK_IN_MONTH()
            case AlignedDayOfWeekInYear     => get_ALIGNED_DAY_OF_WEEK_IN_YEAR()
            case DayOfMonth                 => get_DAY_OF_MONTH()
            case DayOfYear                  => get_DAY_OF_YEAR()
            case EpochDay                   => get_EPOCH_DAY()
            case AlignedWeekOfMonth         => get_ALIGNED_WEEK_OF_MONTH()
            case AlignedWeekOfYear          => get_ALIGNED_WEEK_OF_YEAR()
            case MonthOfYear                => get_MONTH_OF_YEAR()
            case ProlepticMonth             => get_PROLEPTIC_MONTH()
            case YearOfEra                  => get_YEAR_OF_ERA()
            case Year                       => get_YEAR()
            case Era                        => get_ERA()
            case InstantSeconds             => get_INSTANT_SECONDS()
            case OffsetSeconds              => get_OFFSET_SECONDS()
        }

    def primEquals(x: ##java.time.temporal.ChronoField, y: ##java.time.temporal.ChronoField): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unsafe_cast x as ##java.lang.Enum;
        let y1 = unsafe_cast y as ##java.lang.Object;
        equals(x1, y1)


    pub def unmarshal(x: ##java.time.temporal.ChronoField): ChronoField =
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_SECOND;
        import static get java.time.temporal.ChronoField.NANO_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_DAY;
        import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_SECOND;
        import static get java.time.temporal.ChronoField.MICRO_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_DAY;
        import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_SECOND;
        import static get java.time.temporal.ChronoField.MILLI_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_DAY;
        import static get java.time.temporal.ChronoField.SECOND_OF_MINUTE: ##java.time.temporal.ChronoField \ {} as get_SECOND_OF_MINUTE;
        import static get java.time.temporal.ChronoField.SECOND_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_SECOND_OF_DAY;
        import static get java.time.temporal.ChronoField.MINUTE_OF_HOUR: ##java.time.temporal.ChronoField \ {} as get_MINUTE_OF_HOUR;
        import static get java.time.temporal.ChronoField.MINUTE_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_MINUTE_OF_DAY;
        import static get java.time.temporal.ChronoField.HOUR_OF_AMPM: ##java.time.temporal.ChronoField \ {} as get_HOUR_OF_AMPM;
        import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_AMPM: ##java.time.temporal.ChronoField \ {} as get_CLOCK_HOUR_OF_AMPM;
        import static get java.time.temporal.ChronoField.HOUR_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_HOUR_OF_DAY;
        import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_CLOCK_HOUR_OF_DAY;
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;
        import static get java.time.temporal.ChronoField.DAY_OF_WEEK: ##java.time.temporal.ChronoField \ {} as get_DAY_OF_WEEK;
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_DAY_OF_WEEK_IN_MONTH;
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_DAY_OF_WEEK_IN_YEAR;
        import static get java.time.temporal.ChronoField.DAY_OF_MONTH: ##java.time.temporal.ChronoField \ {} as get_DAY_OF_MONTH;
        import static get java.time.temporal.ChronoField.DAY_OF_YEAR: ##java.time.temporal.ChronoField \ {} as get_DAY_OF_YEAR;
        import static get java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField \ {} as get_EPOCH_DAY;
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_WEEK_OF_MONTH;
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_YEAR: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_WEEK_OF_YEAR;
        import static get java.time.temporal.ChronoField.MONTH_OF_YEAR: ##java.time.temporal.ChronoField \ {} as get_MONTH_OF_YEAR;
        import static get java.time.temporal.ChronoField.PROLEPTIC_MONTH: ##java.time.temporal.ChronoField \ {} as get_PROLEPTIC_MONTH;
        import static get java.time.temporal.ChronoField.YEAR_OF_ERA: ##java.time.temporal.ChronoField \ {} as get_YEAR_OF_ERA;
        import static get java.time.temporal.ChronoField.YEAR: ##java.time.temporal.ChronoField \ {} as get_YEAR;
        import static get java.time.temporal.ChronoField.ERA: ##java.time.temporal.ChronoField \ {} as get_ERA;
        import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField \ {} as get_INSTANT_SECONDS;
        import static get java.time.temporal.ChronoField.OFFSET_SECONDS: ##java.time.temporal.ChronoField \ {} as get_OFFSET_SECONDS;
        match x {
            case x1 if primEquals(x1, get_NANO_OF_SECOND())                 => NanoOfSecond
            case x1 if primEquals(x1, get_NANO_OF_DAY())                    => NanoOfDay
            case x1 if primEquals(x1, get_MICRO_OF_SECOND())                => MicroOfSecond
            case x1 if primEquals(x1, get_MICRO_OF_DAY())                   => MicroOfDay
            case x1 if primEquals(x1, get_MILLI_OF_SECOND())                => MilliOfSecond
            case x1 if primEquals(x1, get_MILLI_OF_DAY())                   => MilliOfDay
            case x1 if primEquals(x1, get_SECOND_OF_MINUTE())               => SecondOfMinute
            case x1 if primEquals(x1, get_SECOND_OF_DAY())                  => SecondOfDay
            case x1 if primEquals(x1, get_MINUTE_OF_HOUR())                 => MinuteOfHour
            case x1 if primEquals(x1, get_MINUTE_OF_DAY())                  => MinuteOfDay
            case x1 if primEquals(x1, get_HOUR_OF_AMPM())                   => HourOfAmPm
            case x1 if primEquals(x1, get_CLOCK_HOUR_OF_AMPM())             => ClockHourOfAmPm
            case x1 if primEquals(x1, get_HOUR_OF_DAY())                    => HourOfDay
            case x1 if primEquals(x1, get_CLOCK_HOUR_OF_DAY())              => ClockHourOfDay
            case x1 if primEquals(x1, get_AMPM_OF_DAY())                    => AmPmOfDay
            case x1 if primEquals(x1, get_DAY_OF_WEEK())                    => DayOfWeek
            case x1 if primEquals(x1, get_ALIGNED_DAY_OF_WEEK_IN_MONTH())   => AlignedDayOfWeekInMonth
            case x1 if primEquals(x1, get_ALIGNED_DAY_OF_WEEK_IN_YEAR())    => AlignedDayOfWeekInYear
            case x1 if primEquals(x1, get_DAY_OF_MONTH())                   => DayOfMonth
            case x1 if primEquals(x1, get_DAY_OF_YEAR())                    => DayOfYear
            case x1 if primEquals(x1, get_EPOCH_DAY())                      => EpochDay
            case x1 if primEquals(x1, get_ALIGNED_WEEK_OF_MONTH())          => AlignedWeekOfMonth
            case x1 if primEquals(x1, get_ALIGNED_WEEK_OF_YEAR())           => AlignedWeekOfYear
            case x1 if primEquals(x1, get_MONTH_OF_YEAR())                  => MonthOfYear
            case x1 if primEquals(x1, get_PROLEPTIC_MONTH())                => ProlepticMonth
            case x1 if primEquals(x1, get_YEAR_OF_ERA())                    => YearOfEra
            case x1 if primEquals(x1, get_YEAR())                           => Year
            case x1 if primEquals(x1, get_ERA())                            => Era
            case x1 if primEquals(x1, get_INSTANT_SECONDS())                => InstantSeconds
            case x1 if primEquals(x1, get_OFFSET_SECONDS())                 => OffsetSeconds
        }


}
