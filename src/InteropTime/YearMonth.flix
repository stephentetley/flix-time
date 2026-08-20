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


pub mod InteropTime.YearMonth {

    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TemporalFormat
    use InteropTime.Format.TemporalParse
    use InteropTime.Format.DateFormatter
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.Month.Month
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.Year
    use InteropTime.ZonedDateTime.ZonedDateTime
    
    import java.time.{YearMonth => JYearMonth}
    import java.time.{Year => JYear}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around java.time.YearMonth.
    ///
    pub enum YearMonth(JYearMonth)

    ///
    ///
    ///
    instance ToString[YearMonth] {
        pub def toString(x: YearMonth): String =
            let YearMonth.YearMonth(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[YearMonth] {
        pub def fromString(s: String): Option[YearMonth] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JYearMonth.parse(s1) };
                Some(YearMonth.YearMonth(ans))
            } catch {
                case _: JException => None
            }
    }


    instance Eq[YearMonth] {
        pub def eq(x: YearMonth, y: YearMonth): Bool =
            let YearMonth.YearMonth(x1) = x;
            let YearMonth.YearMonth(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[YearMonth] {
        pub def hash(x: YearMonth): Int32 =
            let YearMonth.YearMonth(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[YearMonth] {
        pub def compare(x: YearMonth, y: YearMonth): Comparison =
            let YearMonth.YearMonth(x1) = x;
            let YearMonth.YearMonth(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }


    instance ToJava[YearMonth] {
        type Out = JYearMonth
        pub def toJava(x: YearMonth): JYearMonth = 
            let YearMonth.YearMonth(x1) = x;
            x1
    }

    instance ToFlix[YearMonth] {
        type In = JYearMonth
        pub def toFlix(x: JYearMonth): YearMonth = 
            YearMonth.YearMonth(x)
    }

    
    instance TemporalFormat[YearMonth] {
        type Formatter = DateFormatter
        type Aef = {}
        pub def format(formatter: DateFormatter, x: YearMonth): String =
            let YearMonth.YearMonth(x1) = x;
            let formatter1 = ToJava.toJava(formatter);
            unsafe IO { x1.format(formatter1) }
    }

    instance TemporalParse[YearMonth] {
        type Formatter = DateFormatter
        type Aef = {}
        pub def parse(formatter: DateFormatter, s: String): Result[String, YearMonth] = 
            AdaptorExtras.opWithResult(formatter, formatter1 -> {
                let s1 = String.trim(s);
                unsafe IO { JYearMonth.parse(s1, formatter1) }
            })
    }

    /// Constructors

    pub def yearMonth(year: {year = Int32}, month: {month = Int32}): YearMonth =
        let ans = unsafe IO { JYearMonth.of(year#year, month#month) };
        YearMonth(ans)

    pub def yearMonthWithMonth(year: {year = Int32}, month: {month = Month}): YearMonth =
        AdaptorExtras.op(month#month, month1 -> unsafe IO { JYearMonth.of(year#year, month1) })


    /// `now` and "abstract constructors" if any

    pub def now(): YearMonth \ IO = YearMonth(JYearMonth.now())

    // `from` functions

    // `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYearMonth.$from(x1) })

    pub def fromLocalDateTime(x: LocalDateTime): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYearMonth.$from(x1) })

    pub def fromOffsetDateTime(x: OffsetDateTime): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYearMonth.$from(x1) })

    pub def fromZonedDateTime(x: ZonedDateTime): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYearMonth.$from(x1) })

    /// to functions
    
    pub def toYear(x: YearMonth): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })

    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: YearMonth, y: YearMonth): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: YearMonth, y: YearMonth): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: YearMonth): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isLeapYear() })

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isValidDay(x: YearMonth, dayOfMonth: Int32): Bool =
        AdaptorExtras.extract(x, x1 ->  unsafe IO { x1.isValidDay(dayOfMonth) })

    /// YearMonth functions

    ///
    /// Returns the length of the month.
    ///
    pub def lengthOfMonth(x: YearMonth): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.lengthOfMonth() })

    ///
    /// Returns the length of the year.
    ///
    pub def lengthOfYear(x: YearMonth): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.lengthOfYear() })

    /// Getters and Setters

    pub def getMonth(x: YearMonth): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getMonth() })

    pub def withMonth(month: Month, x: YearMonth): YearMonth =
        yearMonthWithMonth(year = getYear(x), month = month)

    pub def getMonthValue(x: YearMonth): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMonthValue() })

    pub def withMonthValue(month: Int32, x: YearMonth): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMonth(month) })

    pub def getYear(x: YearMonth): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getYear() })

    pub def withYear(year: Int32, x: YearMonth): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withYear(year) })

    /// plus / minus functions

    pub def plusMonths(x: YearMonth, months: Int64): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMonths(months) })

    pub def minusMonths(x: YearMonth, months: Int64): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMonths(months) })

    pub def plusYears(x: YearMonth, years: Int64): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusYears(years) })

    pub def minusYears(x: YearMonth, years: Int64): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusYears(years) })



    // between / until functions

    pub def monthsUntil(begin: {begin = YearMonth}, end: {end = YearMonth}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MONTHS) }
        )


    pub def yearsUntil(begin: {begin = YearMonth}, end: {end = YearMonth}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.YEARS) }
        )

}
