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


    use InteropTime.Internal.AdaptorExtras

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

    pub enum Month with Eq, Order, ToString {
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

    instance Hash[Month] {
        pub def hash(x: Month): Int32 = match x {
            case Month.January      => unsafe IO { let x1 = JMonth.JANUARY; x1.hashCode() }
            case Month.February     => unsafe IO { let x1 = JMonth.FEBRUARY; x1.hashCode() }
            case Month.March        => unsafe IO { let x1 = JMonth.MARCH; x1.hashCode() }
            case Month.April        => unsafe IO { let x1 = JMonth.APRIL; x1.hashCode() }
            case Month.May          => unsafe IO { let x1 = JMonth.MAY; x1.hashCode() }
            case Month.June         => unsafe IO { let x1 = JMonth.JUNE; x1.hashCode() }
            case Month.July         => unsafe IO { let x1 = JMonth.JULY; x1.hashCode() }
            case Month.August       => unsafe IO { let x1 = JMonth.AUGUST; x1.hashCode() }
            case Month.September    => unsafe IO { let x1 = JMonth.SEPTEMBER; x1.hashCode() }
            case Month.October      => unsafe IO { let x1 = JMonth.OCTOBER; x1.hashCode() }
            case Month.November     => unsafe IO { let x1 = JMonth.NOVEMBER; x1.hashCode() }
            case Month.December     => unsafe IO { let x1 = JMonth.DECEMBER; x1.hashCode() }
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
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    pub def fromLocalDateTime(x: LocalDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    pub def fromMonthDay(x: MonthDay): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    pub def fromOffsetDateTime(x: OffsetDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    pub def fromYearMonth(x: YearMonth): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    pub def fromZonedDateTime(x: ZonedDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    /// Month functions
    
    pub def getDisplayName(style: TextStyle, locale: Locale, x: Month): String =
        AdaptorExtras.extract3(style, locale, x, (style1, locale1, x1) -> 
            unsafe IO { x1.getDisplayName(style1, locale1) }
        )

    pub def getValue(x: Month): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getValue() })

    pub def firstDayOfYear(leap: Bool, x: Month): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.firstDayOfYear(leap) })

    pub def firstMonthOfQuarter(x: Month): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.firstMonthOfQuarter() })

    pub def maxLength(x: Month): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.maxLength() })

    pub def minLength(x: Month): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.minLength() })

    pub def length(leap: Bool, x: Month): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.length(leap) })

    // plus / minus functions

    pub def plus(x:Month, y: Int64): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plus(y) })

    pub def minus(x:Month, y: Int64): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minus(y) })

}

