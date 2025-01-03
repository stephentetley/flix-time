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

    use Time.YearMonth
    use Time.YearMonth.{YearMonth}

    import java.time.{YearMonth => JYearMonth}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around java.time.YearMonth.
    ///
    pub enum YearMonth(JYearMonth)

    ///
    ///
    ///
    instance ToString[YearMonth] {
        pub def toString(x: YearMonth): String =
            let YearMonth(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[YearMonth] {
        pub def fromString(s: String): Option[YearMonth] = 
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let ans = unsafe JYearMonth.parse(s1);
                YearMonth(ans)
            }) |> Result.toOption
    }


    instance Eq[YearMonth] {
        pub def eq(x: YearMonth, y: YearMonth): Bool =
            let YearMonth(x1) = x;
            let YearMonth(y1) = y;
            unsafe x1.equals(y1)
    }

    instance Hash[YearMonth] {
        pub def hash(x: YearMonth): Int32 =
            let YearMonth(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[YearMonth] {
        pub def compare(x: YearMonth, y: YearMonth): Comparison =
            let YearMonth(x1) = x;
            let YearMonth(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }


}

mod Time.YearMonth {

    use Time.YearMonth
    use Time.YearMonth.{YearMonth}

    use Time.Format.DateFormat
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.Month
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.Year
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}

    import java.lang.{Object, CharSequence}
    import java.time.{YearMonth => JYearMonth}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}

    /// Unwrap

    pub def getYearMonth(x: YearMonth): JYearMonth = 
        let YearMonth(x1) = x;
        x1

    /// Constructors

    pub def yearMonth(r: {year = Int32, month = Int32}): YearMonth =
        let ans = unsafe JYearMonth.of(r#year, r#month);
        YearMonth(ans)

    pub def yearMonthWithMonth(r: {year = Int32, month = Month}): YearMonth =
        let m1 = Time.Month.marshalMonth(r#month);
        let ans = unsafe JYearMonth.of(r#year, m1);
        YearMonth(ans)


    /// `now` and "abstract constructors" if any

    pub def now(): YearMonth \ IO = YearMonth(JYearMonth.now())

    // `from` functions

    // `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): YearMonth = 
        let LocalDate(x1) = x;
        let ans = unsafe JYearMonth.from(x1);
        YearMonth(ans)

    pub def fromLocalDateTime(x: LocalDateTime): YearMonth = 
        let LocalDateTime(x1) = x;
        let ans = unsafe JYearMonth.from(x1);
        YearMonth(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): YearMonth = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JYearMonth.from(x1);
        YearMonth(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): YearMonth = 
        let ZonedDateTime(x1) = x;
        let ans = unsafe JYearMonth.from(x1);
        YearMonth(ans)

    /// `parse` / `format` functions  

    ///
    /// Parse the string `s` as a YearMonth, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(_)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, YearMonth] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let ans = unsafe JYearMonth.parse(s1, fmtr);
            YearMonth(ans)
        })
    
    ///
    /// Returns YearMonth `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: YearMonth): String =
        let YearMonth(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: YearMonth, y: YearMonth): Bool =
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: YearMonth, y: YearMonth): Bool =
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        unsafe x1.isAfter(y1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: YearMonth): Bool =
        let YearMonth(x1) = x;
        unsafe x1.isLeapYear()

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isValidDay(x: YearMonth, dayOfMonth: Int32): Bool =
        let YearMonth(x1) = x;
        unsafe x1.isValidDay(dayOfMonth)

    /// YearMonth functions

    ///
    /// Returns the length of the month.
    ///
    pub def lengthOfMonth(x: YearMonth): Int32 =
        let YearMonth(x1) = x;
        unsafe x1.lengthOfMonth()

    ///
    /// Returns the length of the year.
    ///
    pub def lengthOfYear(x: YearMonth): Int32 =
        let YearMonth(x1) = x;
        unsafe x1.lengthOfYear()

    /// Getters and Setters

    pub def getMonth(x: YearMonth): Month =
        let YearMonth(x1) = x;
        let m1 = unsafe x1.getMonth();
        Time.Month.unmarshalMonth(m1)

    pub def withMonth(month: Month, x: YearMonth): YearMonth =
        yearMonthWithMonth({year = getYear(x), month = month})

    pub def getMonthValue(x: YearMonth): Int32 =
        let YearMonth(x1) = x;
        unsafe x1.getMonthValue()

    pub def withMonthValue(month: Int32, x: YearMonth): YearMonth =
        let YearMonth(x1) = x;
        let ans = unsafe x1.withMonth(month);
        YearMonth(ans)

    pub def getYear(x: YearMonth): Int32 =
        let YearMonth(x1) = x;
        unsafe x1.getYear()

    pub def withYear(year: Int32, x: YearMonth): YearMonth =
        let YearMonth(x1) = x;
        let ans = unsafe x1.withYear(year);
        YearMonth(ans)

    /// plus / minus functions

    pub def plusMonths(x: YearMonth, months: Int64): YearMonth =
        let YearMonth(x1) = x;
        let ans = unsafe x1.plusMonths(months);
        YearMonth(ans)

    pub def minusMonths(x: YearMonth, months: Int64): YearMonth =
        let YearMonth(x1) = x;
        let ans = unsafe x1.minusMonths(months);
        YearMonth(ans)

    pub def plusYears(x: YearMonth, years: Int64): YearMonth =
        let YearMonth(x1) = x;
        let ans = unsafe x1.plusYears(years);
        YearMonth(ans)

    pub def minusYears(x: YearMonth, years: Int64): YearMonth =
        let YearMonth(x1) = x;
        let ans = unsafe x1.minusYears(years);
        YearMonth(ans)



    // between / until functions

    pub def monthsUntil(begin: {begin = YearMonth}, end: {end = YearMonth}): Int64 = 
        let YearMonth(b1) = begin#begin;
        let YearMonth(e1) = end#end;
        let cu1 = unsafe JChronoUnit.MONTHS;
        unsafe b1.until(e1, cu1)


    pub def yearsUntil(begin: {begin = YearMonth}, end: {end = YearMonth}): Int64 = 
        let YearMonth(b1) = begin#begin;
        let YearMonth(e1) = end#end;
        let cu1 = unsafe JChronoUnit.YEARS;
        unsafe b1.until(e1, cu1)

}
