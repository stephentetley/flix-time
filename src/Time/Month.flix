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



mod Time {


    use Time.Month
    use Time.Month.{
        January, February, March, 
        April, May, June, 
        July, August, September, 
        October, November, December
    }
    
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
            case  "January" => Some(January)
            case  "February" => Some(February)
            case  "March" => Some(March)
            case  "April" => Some(April)
            case  "May" => Some(May)
            case  "June" => Some(June)
            case  "July" => Some(July)
            case  "August" => Some(August)
            case  "September" => Some(September)
            case  "October" => Some(October)
            case  "November" => Some(November)
            case  "December" => Some(December)
            case _ => None
        }
    }


}

mod Time.Month {

    use Time.Month
    use Time.Month.{
        January, February, March, 
        April, May, June, 
        July, August, September, 
        October, November, December
    }

    use Time.Format.TextStyle
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.YearMonth
    use Time.YearMonth.{YearMonth}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}

    use Locale.{Locale}
    import java.time.{Month => JMonth}
    import java.lang.{Enum => JEnum}
    
    /// # Marshal enums

    pub def marshalMonth(x: Month): JMonth =
        match x {
            case January    => unsafe JMonth.JANUARY
            case February   => unsafe JMonth.FEBRUARY
            case March      => unsafe JMonth.MARCH
            case April      => unsafe JMonth.APRIL
            case May        => unsafe JMonth.MAY
            case June       => unsafe JMonth.JUNE
            case July       => unsafe JMonth.JULY
            case August     => unsafe JMonth.AUGUST
            case September  => unsafe JMonth.SEPTEMBER
            case October    => unsafe JMonth.OCTOBER
            case November   => unsafe JMonth.NOVEMBER
            case December   => unsafe JMonth.DECEMBER
        }

    def primEquals(x: JMonth, y: JMonth): Bool =
        unsafe x.equals(y)

    pub def unmarshalMonth(x: JMonth): Month =
        match x {
            case x1 if primEquals(x1, unsafe JMonth.JANUARY)    => January
            case x1 if primEquals(x1, unsafe JMonth.FEBRUARY)   => February
            case x1 if primEquals(x1, unsafe JMonth.MARCH)      => March
            case x1 if primEquals(x1, unsafe JMonth.APRIL)      => April
            case x1 if primEquals(x1, unsafe JMonth.MAY)        => May
            case x1 if primEquals(x1, unsafe JMonth.JUNE)       => June
            case x1 if primEquals(x1, unsafe JMonth.JULY)       => July
            case x1 if primEquals(x1, unsafe JMonth.AUGUST)     => August
            case x1 if primEquals(x1, unsafe JMonth.SEPTEMBER)  => September
            case x1 if primEquals(x1, unsafe JMonth.OCTOBER)    => October
            case x1 if primEquals(x1, unsafe JMonth.NOVEMBER)   => November
            case x1 if primEquals(x1, unsafe JMonth.DECEMBER)   => December
            case _                                      => bug!("unmarshalMonth")
        }

    // `from` functions

    /// `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): Month =  
        let LocalDate(x1) = x;
        let ans = unsafe JMonth.from(x1);
        unmarshalMonth(ans)

    pub def fromLocalDateTime(x: LocalDateTime): Month = 
        let LocalDateTime(x1) = x;
        let ans = unsafe JMonth.from(x1);
        unmarshalMonth(ans)

    pub def fromMonthDay(x: MonthDay): Month = 
        let MonthDay(x1) = x;
        let ans = unsafe JMonth.from(x1);
        unmarshalMonth(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): Month =
        let OffsetDateTime(x1) = x;
        let ans = unsafe JMonth.from(x1);
        unmarshalMonth(ans)

    pub def fromYearMonth(x: YearMonth): Month = 
        let YearMonth(x1) = x;
        let ans = unsafe JMonth.from(x1);
        unmarshalMonth(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): Month = 
        let ZonedDateTime(x1) = x;
        let ans = unsafe JMonth.from(x1);
        unmarshalMonth(ans)

    /// Month functions
    
    pub def getDisplayName(style: TextStyle, locale: Locale, x: Month): String =
        let x1 = marshalMonth(x);
        let s1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe x1.getDisplayName(s1, locale1)

    pub def getValue(x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe x1.getValue()

    pub def firstDayOfYear(leap: Bool, x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe x1.firstDayOfYear(leap)

    pub def firstMonthOfQuarter(x: Month): Month =
        let x1 = marshalMonth(x);
        let ans = unsafe x1.firstMonthOfQuarter();
        unmarshalMonth(ans)

    pub def maxLength(x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe x1.maxLength()

    pub def minLength(x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe x1.minLength()

    pub def length(leap: Bool, x: Month): Int32 =
        let x1 = marshalMonth(x);
        unsafe x1.length(leap)

    // plus / minus functions

    pub def plus(x:Month, y: Int64): Month =
        let x1 = marshalMonth(x);
        let x2 = unsafe x1.plus(y);
        unmarshalMonth(x2)

    pub def minus(x:Month, y: Int64): Month =
        let x1 = marshalMonth(x);
        let x2 = unsafe x1.minus(y);
        unmarshalMonth(x2)



}
