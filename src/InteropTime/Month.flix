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
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.MonthDay.MonthDay
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.YearMonth.YearMonth
    use InteropTime.ZonedDateTime.ZonedDateTime
    
    use InteropLocale.Locale.Locale
    
    import java.time.{Month => JMonth}
    import java.lang.{Enum => JEnum}

    pub enum Month with Eq, Order, ToString, Hash {
        case January
        case February
        case March
        case April
        case May
        case June
        case July
        case August
        case September
        case October
        case November
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

    instance ToJava[Month] {
        type Out = JMonth
        pub def toJava(x: Month): JMonth = match x {
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
    }

    
    instance ToFlix[Month] {
        type In = JMonth
        pub def toFlix(x: JMonth): Month = unsafe IO {
            if (x.equals(JMonth.JANUARY))           Month.January
            else if (x.equals(JMonth.FEBRUARY))     Month.February
            else if (x.equals(JMonth.MARCH))        Month.March
            else if (x.equals(JMonth.APRIL))        Month.April
            else if (x.equals(JMonth.MAY))          Month.May
            else if (x.equals(JMonth.JUNE))         Month.June
            else if (x.equals(JMonth.JULY))         Month.July
            else if (x.equals(JMonth.AUGUST))       Month.August
            else if (x.equals(JMonth.SEPTEMBER))    Month.September
            else if (x.equals(JMonth.OCTOBER))      Month.October
            else if (x.equals(JMonth.NOVEMBER))     Month.November
            else if (x.equals(JMonth.DECEMBER))     Month.December
            else bug!("toFlix[Month]")
        }
    }
    // `from` functions

    /// `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): Month =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonth.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromLocalDateTime(x: LocalDateTime): Month =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonth.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromMonthDay(x: MonthDay): Month =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonth.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): Month =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonth.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromYearMonth(x: YearMonth): Month =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonth.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): Month =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonth.$from(x1) };
        ToFlix.toFlix(ans)

    /// Month functions
    
    pub def getDisplayName(style: TextStyle, locale: Locale, x: Month): String =
        let x1 = ToJava.toJava(x);
        let s1 = ToJava.toJava(style);
        let locale1 = ToJava.toJava(locale);
        unsafe IO { x1.getDisplayName(s1, locale1) }

    pub def getValue(x: Month): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getValue() }

    pub def firstDayOfYear(leap: Bool, x: Month): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.firstDayOfYear(leap) }

    pub def firstMonthOfQuarter(x: Month): Month =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.firstMonthOfQuarter() };
        ToFlix.toFlix(ans)

    pub def maxLength(x: Month): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.maxLength() }

    pub def minLength(x: Month): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.minLength() }

    pub def length(leap: Bool, x: Month): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.length(leap) }

    // plus / minus functions

    pub def plus(x:Month, y: Int64): Month =
        let x1 = ToJava.toJava(x);
        let x2 = unsafe IO { x1.plus(y) };
        ToFlix.toFlix(x2)

    pub def minus(x:Month, y: Int64): Month =
        let x1 = ToJava.toJava(x);
        let x2 = unsafe IO { x1.minus(y) };
        ToFlix.toFlix(x2)

}

