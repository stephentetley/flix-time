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


pub mod InteropTime.Month {

    use InteropTime.Month.Month
    use InteropTime.Month.Month.{January, February, March,
        April, May, June, July, August, September, October,
        November, December}

    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDate.LocalDate.{LocalDate}
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalDateTime.LocalDateTime.{LocalDateTime}
    use InteropTime.MonthDay.MonthDay
    use InteropTime.MonthDay.MonthDay.{MonthDay}
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetDateTime.OffsetDateTime.{OffsetDateTime}
    use InteropTime.YearMonth.YearMonth
    use InteropTime.YearMonth.YearMonth.{YearMonth}
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZonedDateTime.ZonedDateTime.{ZonedDateTime}

    use InteropLocale.Locale.Locale
    use InteropLocale.Locale.Locale.{Locale}

    import java.time.{Month => JMonth}
    import java.lang.{Enum => JEnum}

    pub enum Month with Eq, Order, ToString, Hash {
        case January,
        case February,
        case March,
        case April,
        case May,
        case June,
        case July,
        case August,
        case September,
        case October,
        case November,
        case December
    }


    instance FromString[Month] {
        pub def fromString(x: String): Option[Month] = match x {
            case  "January"     => Some(Month.January)
            case  "February"    => Some(Month.February)
            case  "March"       => Some(Month.March)
            case  "April"       => Some(Month.April)
            case  "May"         => Some(Month.May)
            case  "June"        => Some(Month.June)
            case  "July"        => Some(Month.July)
            case  "August"      => Some(Month.August)
            case  "September"   => Some(Month.September)
            case  "October"     => Some(Month.October)
            case  "November"    => Some(Month.November)
            case  "December"    => Some(Month.December)
            case _ => None
        }
    }

    /// # Marshal enums

    pub def marshalMonth(x: Month): JMonth =
        match x {
            case Month.January      => unsafe IO { JMonth.JANUARY }
            case Month.February     => unsafe IO { JMonth.FEBRUARY }
            case Month.March        => unsafe IO { JMonth.MARCH }
            case Month.April        => unsafe IO { JMonth.APRIL }
            case Month.May          => unsafe IO { JMonth.MAY }
            case Month.June         => unsafe IO { JMonth.JUNE }
            case Month.July         => unsafe IO { JMonth.JULY }
            case Month.August       => unsafe IO { JMonth.AUGUST }
            case Month.September    => unsafe IO { JMonth.SEPTEMBER }
            case Month.October      => unsafe IO { JMonth.OCTOBER }
            case Month.November     => unsafe IO { JMonth.NOVEMBER }
            case Month.December     => unsafe IO { JMonth.DECEMBER }
        }

    def primEquals(x: JMonth, y: JMonth): Bool =
        unsafe IO { x.equals(y) }

    pub def unmarshalMonth(x: JMonth): Month =
        match x {
            case x1 if primEquals(x1, unsafe IO { JMonth.JANUARY })    => January
            case x1 if primEquals(x1, unsafe IO { JMonth.FEBRUARY })   => February
            case x1 if primEquals(x1, unsafe IO { JMonth.MARCH })      => March
            case x1 if primEquals(x1, unsafe IO { JMonth.APRIL })      => April
            case x1 if primEquals(x1, unsafe IO { JMonth.MAY })        => May
            case x1 if primEquals(x1, unsafe IO { JMonth.JUNE })       => June
            case x1 if primEquals(x1, unsafe IO { JMonth.JULY })       => July
            case x1 if primEquals(x1, unsafe IO { JMonth.AUGUST })     => August
            case x1 if primEquals(x1, unsafe IO { JMonth.SEPTEMBER })  => September
            case x1 if primEquals(x1, unsafe IO { JMonth.OCTOBER })    => October
            case x1 if primEquals(x1, unsafe IO { JMonth.NOVEMBER })   => November
            case x1 if primEquals(x1, unsafe IO { JMonth.DECEMBER })   => December
            case _                                      => bug!("unmarshalMonth")
        }

    // `from` functions

    /// `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): Month =
        let LocalDate(x1) = x;
        let ans = unsafe IO { JMonth.$from(x1) };
        unmarshalMonth(ans)

    pub def fromLocalDateTime(x: LocalDateTime): Month =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { JMonth.$from(x1) };
        unmarshalMonth(ans)

    pub def fromMonthDay(x: MonthDay): Month =
        let MonthDay(x1) = x;
        let ans = unsafe IO { JMonth.$from(x1) };
        unmarshalMonth(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): Month =
        let OffsetDateTime(x1) = x;
        let ans = unsafe IO { JMonth.$from(x1) };
        unmarshalMonth(ans)

    pub def fromYearMonth(x: YearMonth): Month =
        let YearMonth(x1) = x;
        let ans = unsafe IO { JMonth.$from(x1) };
        unmarshalMonth(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): Month =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { JMonth.$from(x1) };
        unmarshalMonth(ans)

    /// Month functions
    
    pub def getDisplayName(style: TextStyle, locale: Locale, x: Month): String =
        let x1 = marshalMonth(x);
        let s1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe IO { x1.getDisplayName(s1, locale1) }

    pub def getValue(x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe IO { x1.getValue() }

    pub def firstDayOfYear(leap: Bool, x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe IO { x1.firstDayOfYear(leap) }

    pub def firstMonthOfQuarter(x: Month): Month =
        let x1 = marshalMonth(x);
        let ans = unsafe IO { x1.firstMonthOfQuarter() };
        unmarshalMonth(ans)

    pub def maxLength(x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe IO { x1.maxLength() }

    pub def minLength(x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe IO { x1.minLength() }

    pub def length(leap: Bool, x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe IO { x1.length(leap) }

    // plus / minus functions

    pub def plus(x:Month, y: Int64): Month =
        let x1 = marshalMonth(x);
        let x2 = unsafe IO { x1.plus(y) };
        unmarshalMonth(x2)

    pub def minus(x:Month, y: Int64): Month =
        let x1 = marshalMonth(x);
        let x2 = unsafe IO { x1.minus(y) };
        unmarshalMonth(x2)



}
