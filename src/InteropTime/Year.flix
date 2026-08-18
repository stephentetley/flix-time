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


pub mod InteropTime.Year {

    
    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.DateFormatter
    use InteropTime.ClockZ.ClockZ
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.Month.Month
    use InteropTime.MonthDay.MonthDay
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.YearMonth.YearMonth
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId


    import java.lang.{Object, CharSequence}
    import java.time.{Year => JYear}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around java.time.Year
    ///
    pub enum Year(JYear)

    instance ToString[Year] {
        pub def toString(x: Year): String =
            let Year.Year(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[Year] {
        pub def fromString(s: String): Option[Year] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JYear.parse(s1) };
                Some(Year.Year(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[Year] {
        pub def eq(x: Year, y: Year): Bool =
            let Year.Year(x1) = x;
            let Year.Year(y1) = y;
            unsafe IO { x1.equals(y1) }

    }

    instance Hash[Year] {
        pub def hash(x: Year): Int32 =
            let Year.Year(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[Year] {
        pub def compare(x: Year, y: Year): Comparison =
            let Year.Year(x1) = x;
            let Year.Year(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance ToJava[Year] {
        type Out = JYear
        pub def toJava(x: Year): JYear = 
            let Year.Year(x1) = x;
            x1
    }

    instance ToFlix[Year] {
        type In = JYear
        pub def toFlix(x: JYear): Year = 
            Year.Year(x)
    }

    /// Constructors

    pub def year(isoYear: {isoYear = Int32}): Year =
        let ans = unsafe IO { JYear.of(isoYear#isoYear) };
        Year(ans)


    /// `now` and "abstract constructors" if any

    pub def now(): Year \ IO = Year(JYear.now())

    pub def nowWithClock(x: ClockZ): Year \ IO =
        AdaptorExtras.op(x, x1 -> JYear.now(x1))

    pub def nowWithZoneId(x: ZoneId): Year \ IO =
        AdaptorExtras.op(x, x1 -> JYear.now(x1))

    /// `at` functions

    pub def atDay(x: Year, dayOfYear: Int32): Option[LocalDate] =
        AdaptorExtras.opWithOption(x, x1 -> unsafe IO { x1.atDay(dayOfYear) })

    pub def atMonth(x: Year, month: Int32): Option[YearMonth] =
        AdaptorExtras.opWithOption(x, x1 -> unsafe IO { x1.atMonth(month) })

    pub def atMonthWithMonth(x: Year, month: Month): YearMonth =
        AdaptorExtras.op2(x, month, (x1, month1) -> unsafe IO { x1.atMonth(month1) })

    pub def atMonthDay(x: Year, md: MonthDay): LocalDate =
        AdaptorExtras.op2(x, md, (x1, md1) -> unsafe IO { x1.atMonthDay(md1) })


    // `from` functions

    pub def fromLocalDate(x: LocalDate): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })

    pub def fromLocalDateTime(x: LocalDateTime): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })

    pub def fromOffsetDateTime(x: OffsetDateTime): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })

    pub def fromYearMonth(x: YearMonth): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })
    
    pub def fromZonedDateTime(x: ZonedDateTime): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })

    /// `parse` / `format` functions  

    ///
    /// Parse the string `s` as a Year, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateFormatter, s: String): Result[String, Year] =
        AdaptorExtras.opWithResult(formatter, formatter1 -> {
            let s1 = String.trim(s);
            unsafe IO { JYear.parse(s1, formatter1) }
        })

    ///
    /// Returns the Year `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateFormatter, x: Year): String =
        AdaptorExtras.extract2(formatter, x, (formatter1, x1) ->
            unsafe IO { x1.format(formatter1) }
        )


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: Year, y: Year): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: Year, y: Year): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeap(x: Year): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isLeap() })

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: Int64): Bool =
        unsafe IO { JYear.isLeap(x) }

    ///
    /// Returns `true` if _.
    ///
    pub def isValidMonthDay(md: MonthDay, x: Year): Bool =
        AdaptorExtras.extract2(md, x, (md1, x1) -> unsafe IO { x1.isValidMonthDay(md1) })


    /// Year functions

    ///
    /// Returns _
    ///
    pub def length(x: Year): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.length() })
        

    /// plus / minus functions

    ///
    /// _
    ///
    pub def plusYears(x: Year, n: Int64): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusYears(n) })

    ///
    /// _
    ///
    pub def minusYears(x: Year, n: Int64): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusYears(n) })


    // between / until functions
    
    // TODO inlining the (Java) ChronoUnit looks fine, should we do it everywhere?

    pub def yearsUntil(begin: {begin = Year}, end: {end = Year}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.YEARS) }
        )

    pub def decadesUntil(begin: {begin = Year}, end: {end = Year}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.DECADES) }
        )

    pub def centuriesUntil(begin: {begin = Year}, end: {end = Year}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.CENTURIES) }
        )


}
