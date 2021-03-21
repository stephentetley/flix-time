/*
 * Copyright 2020 Stephen Tetley
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

    pub enum ChronoField {
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

    instance ToString[ChronoField] {
        pub def toString(x: ChronoField): String = match x {
            case NanoOfSecond => "NanoOfSecond"
            case NanoOfDay => "NanoOfDay"
            case MicroOfSecond => "MicroOfSecond"
            case MicroOfDay => "MicroOfDay"
            case MilliOfSecond => "MilliOfSecond"
            case MilliOfDay => "MilliOfDay"
            case SecondOfMinute => "SecondOfMinute"
            case SecondOfDay => "SecondOfDay"
            case MinuteOfHour => "MinuteOfHour"
            case MinuteOfDay => "MinuteOfDay"
            case HourOfAmPm => "HourOfAmPm"
            case ClockHourOfAmPm => "ClockHourOfAmPm"
            case HourOfDay => "HourOfDay"
            case ClockHourOfDay => "ClockHourOfDay"
            case AmPmOfDay => "AmPmOfDay"
            case DayOfWeek => "DayOfWeek"
            case AlignedDayOfWeekInMonth => "AlignedDayOfWeekInMonth"
            case AlignedDayOfWeekInYear => "AlignedDayOfWeekInYear"
            case DayOfMonth => "DayOfMonth"
            case DayOfYear => "DayOfYear"
            case EpochDay => "EpochDay"
            case AlignedWeekOfMonth => "AlignedWeekOfMonth"
            case AlignedWeekOfYear => "AlignedWeekOfYear"
            case MonthOfYear => "MonthOfYear"
            case ProlepticMonth => "ProlepticMonth"
            case YearOfEra => "YearOfEra"
            case Year => "Year"
            case Era => "Era"
            case InstantSeconds => "InstantSeconds"
            case OffsetSeconds => "OffsetSeconds"
        }
    }

    instance FromString[ChronoField] {
        pub def fromString(x: String): Option[ChronoField] = match x {
            case "NanoOfSecond" => Some(NanoOfSecond)
            case "NanoOfDay" => Some(NanoOfDay)
            case "MicroOfSecond" => Some(MicroOfSecond)
            case "MicroOfDay" => Some(MicroOfDay)
            case "MilliOfSecond" => Some(MilliOfSecond)
            case "MilliOfDay" => Some(MilliOfDay)
            case "SecondOfMinute" => Some(SecondOfMinute)
            case "SecondOfDay" => Some(SecondOfDay)
            case "MinuteOfHour" => Some(MinuteOfHour)
            case "MinuteOfDay" => Some(MinuteOfDay)
            case "HourOfAmPm" => Some(HourOfAmPm)
            case "ClockHourOfAmPm" => Some(ClockHourOfAmPm)
            case "HourOfDay" => Some(HourOfDay)
            case "ClockHourOfDay" => Some(ClockHourOfDay)
            case "AmPmOfDay" => Some(AmPmOfDay)
            case "DayOfWeek" => Some(DayOfWeek)
            case "AlignedDayOfWeekInMonth" => Some(AlignedDayOfWeekInMonth)
            case "AlignedDayOfWeekInYear" => Some(AlignedDayOfWeekInYear)
            case "DayOfMonth" => Some(DayOfMonth)
            case "DayOfYear" => Some(DayOfYear)
            case "EpochDay" => Some(EpochDay)
            case "AlignedWeekOfMonth" => Some(AlignedWeekOfMonth)
            case "AlignedWeekOfYear" => Some(AlignedWeekOfYear)
            case "MonthOfYear" => Some(MonthOfYear)
            case "ProlepticMonth" => Some(ProlepticMonth)
            case "YearOfEra" => Some(YearOfEra)
            case "Year" => Some(Year)
            case "Era" => Some(Era)
            case "InstantSeconds" => Some(InstantSeconds)
            case "OffsetSeconds" => Some(OffsetSeconds)
            case _ => None
        }
    }

    instance Eq[ChronoField] {
        pub def eq(x: ChronoField, y: ChronoField): Bool = match (x,y) {
            case (NanoOfSecond, NanoOfSecond) => true
            case (NanoOfDay, NanoOfDay) => true
            case (MicroOfSecond, MicroOfSecond) => true
            case (MicroOfDay, MicroOfDay) => true
            case (MilliOfSecond, MilliOfSecond) => true
            case (MilliOfDay, MilliOfDay) => true
            case (SecondOfMinute, SecondOfMinute) => true
            case (SecondOfDay, SecondOfDay) => true
            case (MinuteOfHour, MinuteOfHour) => true
            case (MinuteOfDay, MinuteOfDay) => true
            case (HourOfAmPm, HourOfAmPm) => true
            case (ClockHourOfAmPm, ClockHourOfAmPm) => true
            case (HourOfDay, HourOfDay) => true
            case (ClockHourOfDay, ClockHourOfDay) => true
            case (AmPmOfDay, AmPmOfDay) => true
            case (DayOfWeek, DayOfWeek) => true
            case (AlignedDayOfWeekInMonth, AlignedDayOfWeekInMonth) => true
            case (AlignedDayOfWeekInYear, AlignedDayOfWeekInYear) => true
            case (DayOfMonth, DayOfMonth) => true
            case (DayOfYear, DayOfYear) => true
            case (EpochDay, EpochDay) => true
            case (AlignedWeekOfMonth, AlignedWeekOfMonth) => true
            case (AlignedWeekOfYear, AlignedWeekOfYear) => true
            case (MonthOfYear, MonthOfYear) => true
            case (ProlepticMonth, ProlepticMonth) => true
            case (YearOfEra, YearOfEra) => true
            case (Year, Year) => true
            case (Era, Era) => true
            case (InstantSeconds, InstantSeconds) => true
            case (OffsetSeconds, OffsetSeconds) => true
            case (_,_) => false
        }
    }

    instance Hash[ChronoField] {
        pub def hash(x: ChronoField): Int = Time/Temporal/ChronoField.hashCode(x)
    }

    instance Order[ChronoField] {
        pub def compare(x: ChronoField, y: ChronoField): Comparison = match Time/Temporal/ChronoField.compareTo(x,y) {
            case n if n < 0 => LessThan
            case n if n == 0 => EqualTo
            case _ => GreaterThan
        }
    }
}

namespace Time/Temporal/ChronoField {

    use Time/Temporal.ChronoField;
    use Time/Temporal.ChronoField.{NanoOfSecond, NanoOfDay, MicroOfSecond, MicroOfDay, 
            MilliOfSecond, MilliOfDay, SecondOfMinute, SecondOfDay, MinuteOfHour, 
            MinuteOfDay, HourOfAmPm, ClockHourOfAmPm, HourOfDay, ClockHourOfDay, 
            AmPmOfDay, DayOfWeek, AlignedDayOfWeekInMonth, AlignedDayOfWeekInYear, 
            DayOfMonth, DayOfYear, EpochDay, AlignedWeekOfMonth, AlignedWeekOfYear, 
            MonthOfYear, ProlepticMonth, YearOfEra, Year, Era, InstantSeconds, 
            OffsetSeconds};
    
    pub def fromEnum(x: ChronoField): Int32 = match x {
        case NanoOfSecond => 0
        case NanoOfDay => 1
        case MicroOfSecond => 2
        case MicroOfDay => 3
        case MilliOfSecond => 4
        case MilliOfDay => 5
        case SecondOfMinute => 6
        case SecondOfDay => 7
        case MinuteOfHour => 8
        case MinuteOfDay => 9
        case HourOfAmPm => 10
        case ClockHourOfAmPm => 11
        case HourOfDay => 12
        case ClockHourOfDay => 13
        case AmPmOfDay => 14
        case DayOfWeek => 15
        case AlignedDayOfWeekInMonth => 16
        case AlignedDayOfWeekInYear => 17
        case DayOfMonth => 18
        case DayOfYear => 19
        case EpochDay => 20
        case AlignedWeekOfMonth => 21
        case AlignedWeekOfYear => 22
        case MonthOfYear => 23
        case ProlepticMonth => 24
        case YearOfEra => 25
        case Year => 26
        case Era => 27
        case InstantSeconds => 28
        case OffsetSeconds => 29
    }

    pub def toEnum(x: Int32): Option[ChronoField] = match x {
        case 0 => Some(NanoOfSecond)
        case 1 => Some(NanoOfDay)
        case 2 => Some(MicroOfSecond)
        case 3 => Some(MicroOfDay)
        case 4 => Some(MilliOfSecond)
        case 5 => Some(MilliOfDay)
        case 6 => Some(SecondOfMinute)
        case 7 => Some(SecondOfDay)
        case 8 => Some(MinuteOfHour)
        case 9 => Some(MinuteOfDay)
        case 10 => Some(HourOfAmPm)
        case 11 => Some(ClockHourOfAmPm)
        case 12 => Some(HourOfDay)
        case 13 => Some(ClockHourOfDay)
        case 14 => Some(AmPmOfDay)
        case 15 => Some(DayOfWeek)
        case 16 => Some(AlignedDayOfWeekInMonth)
        case 17 => Some(AlignedDayOfWeekInYear)
        case 18 => Some(DayOfMonth)
        case 19 => Some(DayOfYear)
        case 20 => Some(EpochDay)
        case 21 => Some(AlignedWeekOfMonth)
        case 22 => Some(AlignedWeekOfYear)
        case 23 => Some(MonthOfYear)
        case 24 => Some(ProlepticMonth)
        case 25 => Some(YearOfEra)
        case 26 => Some(Year)
        case 27 => Some(Era)
        case 28 => Some(InstantSeconds)
        case 29 => Some(OffsetSeconds)
        case _ =>   None
    }

    pub def marshal(x: ChronoField): ##java.time.temporal.ChronoField = 
        import get java.time.temporal.ChronoField:NANO_OF_SECOND                as getNANO_OF_SECOND;
        import get java.time.temporal.ChronoField:NANO_OF_DAY                   as getNANO_OF_DAY;
        import get java.time.temporal.ChronoField:MICRO_OF_SECOND               as getMICRO_OF_SECOND;
        import get java.time.temporal.ChronoField:MICRO_OF_DAY                  as getMICRO_OF_DAY;
        import get java.time.temporal.ChronoField:MILLI_OF_SECOND               as getMILLI_OF_SECOND;
        import get java.time.temporal.ChronoField:MILLI_OF_DAY                  as getMILLI_OF_DAY;
        import get java.time.temporal.ChronoField:SECOND_OF_MINUTE              as getSECOND_OF_MINUTE;
        import get java.time.temporal.ChronoField:SECOND_OF_DAY                 as getSECOND_OF_DAY;
        import get java.time.temporal.ChronoField:MINUTE_OF_HOUR                as getMINUTE_OF_HOUR;        
        import get java.time.temporal.ChronoField:MINUTE_OF_DAY                 as getMINUTE_OF_DAY;
        import get java.time.temporal.ChronoField:HOUR_OF_AMPM                  as getHOUR_OF_AMPM;
        import get java.time.temporal.ChronoField:CLOCK_HOUR_OF_AMPM            as getCLOCK_HOUR_OF_AMPM;
        import get java.time.temporal.ChronoField:HOUR_OF_DAY                   as getHOUR_OF_DAY;
        import get java.time.temporal.ChronoField:CLOCK_HOUR_OF_DAY             as getCLOCK_HOUR_OF_DAY;
        import get java.time.temporal.ChronoField:AMPM_OF_DAY                   as getAMPM_OF_DAY;
        import get java.time.temporal.ChronoField:DAY_OF_WEEK                   as getDAY_OF_WEEK;
        import get java.time.temporal.ChronoField:ALIGNED_DAY_OF_WEEK_IN_MONTH  as getALIGNED_DAY_OF_WEEK_IN_MONTH;
        import get java.time.temporal.ChronoField:ALIGNED_DAY_OF_WEEK_IN_YEAR   as getALIGNED_DAY_OF_WEEK_IN_YEAR;
        import get java.time.temporal.ChronoField:DAY_OF_MONTH                  as getDAY_OF_MONTH;
        import get java.time.temporal.ChronoField:DAY_OF_YEAR                   as getDAY_OF_YEAR;
        import get java.time.temporal.ChronoField:EPOCH_DAY                     as getEPOCH_DAY;
        import get java.time.temporal.ChronoField:ALIGNED_WEEK_OF_MONTH         as getALIGNED_WEEK_OF_MONTH;
        import get java.time.temporal.ChronoField:ALIGNED_WEEK_OF_YEAR          as getALIGNED_WEEK_OF_YEAR;
        import get java.time.temporal.ChronoField:MONTH_OF_YEAR                 as getMONTH_OF_YEAR;
        import get java.time.temporal.ChronoField:PROLEPTIC_MONTH               as getPROLEPTIC_MONTH;
        import get java.time.temporal.ChronoField:YEAR_OF_ERA                   as getYEAR_OF_ERA;
        import get java.time.temporal.ChronoField:YEAR                          as getYEAR;
        import get java.time.temporal.ChronoField:ERA                           as getERA;
        import get java.time.temporal.ChronoField:INSTANT_SECONDS               as getINSTANT_SECONDS;
        import get java.time.temporal.ChronoField:OFFSET_SECONDS                as getOFFSET_SECONDS;
        match x {
            case NanoOfSecond               => getNANO_OF_SECOND()
            case NanoOfDay                  => getNANO_OF_DAY()
            case MicroOfSecond              => getMICRO_OF_SECOND()
            case MicroOfDay                 => getMICRO_OF_DAY()
            case MilliOfSecond              => getMILLI_OF_SECOND()
            case MilliOfDay                 => getMILLI_OF_DAY()
            case SecondOfMinute             => getSECOND_OF_MINUTE()
            case SecondOfDay                => getSECOND_OF_DAY()
            case MinuteOfHour               => getMINUTE_OF_HOUR()
            case MinuteOfDay                => getMINUTE_OF_DAY()
            case HourOfAmPm                 => getHOUR_OF_AMPM()
            case ClockHourOfAmPm            => getCLOCK_HOUR_OF_AMPM()
            case HourOfDay                  => getHOUR_OF_DAY()
            case ClockHourOfDay             => getCLOCK_HOUR_OF_DAY()
            case AmPmOfDay                  => getAMPM_OF_DAY()
            case DayOfWeek                  => getDAY_OF_WEEK()
            case AlignedDayOfWeekInMonth    => getALIGNED_DAY_OF_WEEK_IN_MONTH()
            case AlignedDayOfWeekInYear     => getALIGNED_DAY_OF_WEEK_IN_YEAR()
            case DayOfMonth                 => getDAY_OF_MONTH()
            case DayOfYear                  => getDAY_OF_YEAR()
            case EpochDay                   => getEPOCH_DAY()
            case AlignedWeekOfMonth         => getALIGNED_WEEK_OF_MONTH()
            case AlignedWeekOfYear          => getALIGNED_WEEK_OF_YEAR()
            case MonthOfYear                => getMONTH_OF_YEAR()
            case ProlepticMonth             => getPROLEPTIC_MONTH()
            case YearOfEra                  => getYEAR_OF_ERA()
            case Year                       => getYEAR()
            case Era                        => getERA()
            case InstantSeconds             => getINSTANT_SECONDS()
            case OffsetSeconds              => getOFFSET_SECONDS()
        } as & Pure

    def primEquals(x: ##java.time.temporal.ChronoField, y: ##java.time.temporal.ChronoField): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def unmarshal(x: ##java.time.temporal.ChronoField): ChronoField = 
        import get java.time.temporal.ChronoField:NANO_OF_SECOND                as getNANO_OF_SECOND;
        import get java.time.temporal.ChronoField:NANO_OF_DAY                   as getNANO_OF_DAY;
        import get java.time.temporal.ChronoField:MICRO_OF_SECOND               as getMICRO_OF_SECOND;
        import get java.time.temporal.ChronoField:MICRO_OF_DAY                  as getMICRO_OF_DAY;
        import get java.time.temporal.ChronoField:MILLI_OF_SECOND               as getMILLI_OF_SECOND;
        import get java.time.temporal.ChronoField:MILLI_OF_DAY                  as getMILLI_OF_DAY;
        import get java.time.temporal.ChronoField:SECOND_OF_MINUTE              as getSECOND_OF_MINUTE;
        import get java.time.temporal.ChronoField:SECOND_OF_DAY                 as getSECOND_OF_DAY;
        import get java.time.temporal.ChronoField:MINUTE_OF_HOUR                as getMINUTE_OF_HOUR;        
        import get java.time.temporal.ChronoField:MINUTE_OF_DAY                 as getMINUTE_OF_DAY;
        import get java.time.temporal.ChronoField:HOUR_OF_AMPM                  as getHOUR_OF_AMPM;
        import get java.time.temporal.ChronoField:CLOCK_HOUR_OF_AMPM            as getCLOCK_HOUR_OF_AMPM;
        import get java.time.temporal.ChronoField:HOUR_OF_DAY                   as getHOUR_OF_DAY;
        import get java.time.temporal.ChronoField:CLOCK_HOUR_OF_DAY             as getCLOCK_HOUR_OF_DAY;
        import get java.time.temporal.ChronoField:AMPM_OF_DAY                   as getAMPM_OF_DAY;
        import get java.time.temporal.ChronoField:DAY_OF_WEEK                   as getDAY_OF_WEEK;
        import get java.time.temporal.ChronoField:ALIGNED_DAY_OF_WEEK_IN_MONTH  as getALIGNED_DAY_OF_WEEK_IN_MONTH;
        import get java.time.temporal.ChronoField:ALIGNED_DAY_OF_WEEK_IN_YEAR   as getALIGNED_DAY_OF_WEEK_IN_YEAR;
        import get java.time.temporal.ChronoField:DAY_OF_MONTH                  as getDAY_OF_MONTH;
        import get java.time.temporal.ChronoField:DAY_OF_YEAR                   as getDAY_OF_YEAR;
        import get java.time.temporal.ChronoField:EPOCH_DAY                     as getEPOCH_DAY;
        import get java.time.temporal.ChronoField:ALIGNED_WEEK_OF_MONTH         as getALIGNED_WEEK_OF_MONTH;
        import get java.time.temporal.ChronoField:ALIGNED_WEEK_OF_YEAR          as getALIGNED_WEEK_OF_YEAR;
        import get java.time.temporal.ChronoField:MONTH_OF_YEAR                 as getMONTH_OF_YEAR;
        import get java.time.temporal.ChronoField:PROLEPTIC_MONTH               as getPROLEPTIC_MONTH;
        import get java.time.temporal.ChronoField:YEAR_OF_ERA                   as getYEAR_OF_ERA;
        import get java.time.temporal.ChronoField:YEAR                          as getYEAR;
        import get java.time.temporal.ChronoField:ERA                           as getERA;
        import get java.time.temporal.ChronoField:INSTANT_SECONDS               as getINSTANT_SECONDS;
        import get java.time.temporal.ChronoField:OFFSET_SECONDS                as getOFFSET_SECONDS;
        match x {
            case x1 if primEquals(x1, getNANO_OF_SECOND())                  => NanoOfSecond
            case x1 if primEquals(x1, getNANO_OF_DAY())                     => NanoOfDay
            case x1 if primEquals(x1, getMICRO_OF_SECOND())                 => MicroOfSecond
            case x1 if primEquals(x1, getMICRO_OF_DAY())                    => MicroOfDay
            case x1 if primEquals(x1, getMILLI_OF_SECOND())                 => MilliOfSecond
            case x1 if primEquals(x1, getMILLI_OF_DAY())                    => MilliOfDay
            case x1 if primEquals(x1, getSECOND_OF_MINUTE())                => SecondOfMinute
            case x1 if primEquals(x1, getSECOND_OF_DAY())                   => SecondOfDay
            case x1 if primEquals(x1, getMINUTE_OF_HOUR())                  => MinuteOfHour
            case x1 if primEquals(x1, getMINUTE_OF_DAY())                   => MinuteOfDay
            case x1 if primEquals(x1, getHOUR_OF_AMPM())                    => HourOfAmPm
            case x1 if primEquals(x1, getCLOCK_HOUR_OF_AMPM())              => ClockHourOfAmPm
            case x1 if primEquals(x1, getHOUR_OF_DAY())                     => HourOfDay
            case x1 if primEquals(x1, getCLOCK_HOUR_OF_DAY())               => ClockHourOfDay
            case x1 if primEquals(x1, getAMPM_OF_DAY())                     => AmPmOfDay
            case x1 if primEquals(x1, getDAY_OF_WEEK())                     => DayOfWeek
            case x1 if primEquals(x1, getALIGNED_DAY_OF_WEEK_IN_MONTH())    => AlignedDayOfWeekInMonth
            case x1 if primEquals(x1, getALIGNED_DAY_OF_WEEK_IN_YEAR())     => AlignedDayOfWeekInYear
            case x1 if primEquals(x1, getDAY_OF_MONTH())                    => DayOfMonth
            case x1 if primEquals(x1, getDAY_OF_YEAR())                     => DayOfYear
            case x1 if primEquals(x1, getEPOCH_DAY())                       => EpochDay
            case x1 if primEquals(x1, getALIGNED_WEEK_OF_MONTH())           => AlignedWeekOfMonth
            case x1 if primEquals(x1, getALIGNED_WEEK_OF_YEAR())            => AlignedWeekOfYear
            case x1 if primEquals(x1, getMONTH_OF_YEAR())                   => MonthOfYear
            case x1 if primEquals(x1, getPROLEPTIC_MONTH())                 => ProlepticMonth
            case x1 if primEquals(x1, getYEAR_OF_ERA())                     => YearOfEra
            case x1 if primEquals(x1, getYEAR())                            => Year
            case x1 if primEquals(x1, getERA())                             => Era
            case x1 if primEquals(x1, getINSTANT_SECONDS())                 => InstantSeconds
            case x1 if primEquals(x1, getOFFSET_SECONDS())                  => OffsetSeconds
        } as & Pure

    

 
    pub def hashCode(x: ChronoField): Int32 =
        import java.lang.Enum.hashCode();
        let en1 = marshal(x) as ##java.lang.Enum;
        hashCode(en1) as & Pure

    pub def compareTo(x: ChronoField, y: ChronoField): Int32 = 
        import java.lang.Enum.compareTo(##java.lang.Enum);
        let x1 = marshal(x) as ##java.lang.Enum;
        let y1 = marshal(y) as ##java.lang.Enum;
        compareTo(x1, y1) as & Pure
}