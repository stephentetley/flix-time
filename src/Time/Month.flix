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
    use Time.LocalDateTime
    use Time.MonthDay
    use Time.OffsetDateTime
    use Time.YearMonth
    use Time.ZonedDateTime

    use Locale.{Locale}
    
    /// ## Marshal enums

    pub def marshalMonth(x: Month): ##java.time.Month =
        import static java_get_field java.time.Month.JANUARY: ##java.time.Month \ {} as get_JANUARY;
        import static java_get_field java.time.Month.FEBRUARY: ##java.time.Month \ {} as get_FEBRUARY;
        import static java_get_field java.time.Month.MARCH: ##java.time.Month \ {} as get_MARCH;
        import static java_get_field java.time.Month.APRIL: ##java.time.Month \ {} as get_APRIL;
        import static java_get_field java.time.Month.MAY: ##java.time.Month \ {} as get_MAY;
        import static java_get_field java.time.Month.JUNE: ##java.time.Month \ {} as get_JUNE;
        import static java_get_field java.time.Month.JULY: ##java.time.Month \ {} as get_JULY;
        import static java_get_field java.time.Month.AUGUST: ##java.time.Month \ {} as get_AUGUST;
        import static java_get_field java.time.Month.SEPTEMBER: ##java.time.Month \ {} as get_SEPTEMBER;
        import static java_get_field java.time.Month.OCTOBER: ##java.time.Month \ {} as get_OCTOBER;
        import static java_get_field java.time.Month.NOVEMBER: ##java.time.Month \ {} as get_NOVEMBER;
        import static java_get_field java.time.Month.DECEMBER: ##java.time.Month \ {} as get_DECEMBER;
        match x {
            case January    => get_JANUARY()
            case February   => get_FEBRUARY()
            case March      => get_MARCH()
            case April      => get_APRIL()
            case May        => get_MAY()
            case June       => get_JUNE()
            case July       => get_JULY()
            case August     => get_AUGUST()
            case September  => get_SEPTEMBER()
            case October    => get_OCTOBER()
            case November   => get_NOVEMBER()
            case December   => get_DECEMBER()
        }

    def primEquals(x: ##java.time.Month, y: ##java.time.Month): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)

    pub def unmarshalMonth(x: ##java.time.Month): Month =
        import static java_get_field java.time.Month.JANUARY: ##java.time.Month \ {} as get_JANUARY;
        import static java_get_field java.time.Month.FEBRUARY: ##java.time.Month \ {} as get_FEBRUARY;
        import static java_get_field java.time.Month.MARCH: ##java.time.Month \ {} as get_MARCH;
        import static java_get_field java.time.Month.APRIL: ##java.time.Month \ {} as get_APRIL;
        import static java_get_field java.time.Month.MAY: ##java.time.Month \ {} as get_MAY;
        import static java_get_field java.time.Month.JUNE: ##java.time.Month \ {} as get_JUNE;
        import static java_get_field java.time.Month.JULY: ##java.time.Month \ {} as get_JULY;
        import static java_get_field java.time.Month.AUGUST: ##java.time.Month \ {} as get_AUGUST;
        import static java_get_field java.time.Month.SEPTEMBER: ##java.time.Month \ {} as get_SEPTEMBER;
        import static java_get_field java.time.Month.OCTOBER: ##java.time.Month \ {} as get_OCTOBER;
        import static java_get_field java.time.Month.NOVEMBER: ##java.time.Month \ {} as get_NOVEMBER;
        import static java_get_field java.time.Month.DECEMBER: ##java.time.Month \ {} as get_DECEMBER;
        match x {
            case x1 if primEquals(x1, get_JANUARY())    => January
            case x1 if primEquals(x1, get_FEBRUARY())   => February
            case x1 if primEquals(x1, get_MARCH())      => March
            case x1 if primEquals(x1, get_APRIL())      => April
            case x1 if primEquals(x1, get_MAY())        => May
            case x1 if primEquals(x1, get_JUNE())       => June
            case x1 if primEquals(x1, get_JULY())       => July
            case x1 if primEquals(x1, get_AUGUST())     => August
            case x1 if primEquals(x1, get_SEPTEMBER())  => September
            case x1 if primEquals(x1, get_OCTOBER())    => October
            case x1 if primEquals(x1, get_NOVEMBER())   => November
            case x1 if primEquals(x1, get_DECEMBER())   => December
            case _                                      => bug!("unmarshalMonth")
        }

    /// ## `from` functions

    /// `fromTemporalAccessor` specialized
    def fromHelper(x: ##java.time.temporal.TemporalAccessor): Month = 
        import static java.time.Month.from(##java.time.temporal.TemporalAccessor): ##java.time.Month \ {} as fromTA;
        try {
            unmarshalMonth(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromLocalDate(x: LocalDate): Month = 
        fromHelper(unchecked_cast(Time.LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromLocalDateTime(x: LocalDateTime): Month = 
        fromHelper(unchecked_cast(Time.LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromMonthDay(x: MonthDay): Month = 
        fromHelper(unchecked_cast(Time.MonthDay.getMonthDay(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromOffsetDateTime(x: OffsetDateTime): Month = 
        fromHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromYearMonth(x: YearMonth): Month = 
        fromHelper(unchecked_cast(Time.YearMonth.getYearMonth(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromZonedDateTime(x: ZonedDateTime): Month = 
        fromHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))

    /// ## Month functions
    
    pub def getDisplayName(style: TextStyle, locale: Locale, x: Month): String =
        import java.time.Month.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let x1 = marshalMonth(x);
        let s1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, s1, locale1)

    pub def getValue(x: Month): Int32 =
        import java.time.Month.getValue(): Int32 \ {};
        let x1 = marshalMonth(x);
        getValue(x1)

    pub def firstDayOfYear(leap: Bool, x: Month): Int32 =
        import java.time.Month.firstDayOfYear(Bool): Int32 \ {};
        let x1 = marshalMonth(x);
        firstDayOfYear(x1, leap)

    pub def firstMonthOfQuarter(x: Month): Month =
        import java.time.Month.firstMonthOfQuarter(): ##java.time.Month \ {};
        let x1 = marshalMonth(x);
        unmarshalMonth(firstMonthOfQuarter(x1))

    pub def maxLength(x: Month): Int32 =
        import java.time.Month.maxLength(): Int32 \ {};
        let x1 = marshalMonth(x);
        maxLength(x1)

    pub def minLength(x: Month): Int32 =
        import java.time.Month.minLength(): Int32 \ {};
        let x1 = marshalMonth(x);
        minLength(x1)

    pub def length(leap: Bool, x: Month): Int32 =
        import java.time.Month.length(Bool): Int32 \ {};
        let x1 = marshalMonth(x);
        length(x1, leap)

    /// ## plus / minus functions

    pub def plus(x:Month, y: Int64): Month =
        import java.time.Month.plus(Int64): ##java.time.Month \ {};
        let x1 = marshalMonth(x);
        let x2 = plus(x1, y);
        unmarshalMonth(x2)

    pub def minus(x:Month, y: Int64): Month =
        import java.time.Month.minus(Int64): ##java.time.Month \ {};
        let x1 = marshalMonth(x);
        let x2 = minus(x1, y);
        unmarshalMonth(x2)



}
