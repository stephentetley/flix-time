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

    use Time.Year
    use Time.Year.{Year}

    import java.time.{Year => JYear}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around java.time.Year.
    ///
    pub enum Year(JYear)

    instance ToString[Year] {
        pub def toString(x: Year): String =
            let Year(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[Year] {
        pub def fromString(s: String): Option[Year] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs  = (checked_cast(s1) : CharSequence);
                Year(unsafe JYear.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[Year] {
        pub def eq(x: Year, y: Year): Bool = 
            let Year(x1) = x;
            let Year(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)

    }

    instance Hash[Year] {
        pub def hash(x: Year): Int32 =
            let Year(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[Year] {
        pub def compare(x: Year, y: Year): Comparison =
            let Year(x1) = x;
            let Year(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }

}

mod Time.Year {

    use Time.Year
    use Time.Year.{Year}

    use Time.Format.DateFormat
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Clock
    use Time.Clock.{Clock}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.Month
    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.YearMonth
    use Time.YearMonth.{YearMonth}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}


    import java.lang.{Object, CharSequence}
    import java.time.{Year => JYear}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}

    /// Unwrap

    pub def getYear(x: Year): JYear = 
        let Year(x1) = x;
        x1

    /// Constructors

    pub def year(isoYear: {isoYear = Int32}): Year = Year(unsafe JYear.of(isoYear#isoYear))


    /// `now` and "abstract constructors" if any

    pub def now(): Year \ IO = Year(JYear.now())

    pub def nowWithClock(x: Clock): Year \ IO =
        let Clock(x1) = x;
        Year(JYear.now(x1))

    pub def nowWithZoneId(x: ZoneId): Year \ IO =
        let ZoneId(x1) = x;
        Year(JYear.now(x1))

    /// `at` functions

    pub def atDay(x: Year, dayOfYear: Int32): Option[LocalDate] =
        Result.tryCatch(_ -> {
            let Year(x1) = x;
            LocalDate(unsafe x1.atDay(dayOfYear))
        }) |> Result.toOption

    pub def atMonth(x: Year, month: Int32): Option[YearMonth] =
        Result.tryCatch(_ -> {
            let Year(x1) = x;
            YearMonth(unsafe x1.atMonth(month))
        }) |> Result.toOption

    pub def atMonthWithMonth(x: Year, month: Month): Option[YearMonth] =
        Result.tryCatch(_ -> {
            let Year(x1) = x;
            let m1 = Time.Month.marshalMonth(month);
            YearMonth(unsafe x1.atMonth(m1))
        }) |> Result.toOption

    pub def atMonthDay(x: Year, monthDay: MonthDay): LocalDate =
        let Year(x1) = x;
        let MonthDay(m1) = monthDay;
        LocalDate(unsafe x1.atMonthDay(m1))


    // `from` functions

    pub def fromLocalDate(x: LocalDate): Year = 
        let LocalDate(x1) = x;
        let t1: JTemporalAccessor = checked_cast(x1);
        let ans = unsafe JYear.from(t1);
        Year(ans)

    pub def fromLocalDateTime(x: LocalDateTime): Year = 
        let LocalDateTime(x1) = x;
        let t1: JTemporalAccessor = checked_cast(x1);
        let ans = unsafe JYear.from(t1);
        Year(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): Year = 
        let OffsetDateTime(x1) = x;
        let t1: JTemporalAccessor = checked_cast(x1);
        let ans = unsafe JYear.from(t1);
        Year(ans)

    pub def fromYearMonth(x: YearMonth): Year = 
        let YearMonth(x1) = x;
        let t1: JTemporalAccessor = checked_cast(x1);
        let ans = unsafe JYear.from(t1);
        Year(ans)
    pub def fromZonedDateTime(x: ZonedDateTime): Year = 
        let ZonedDateTime(x1) = x;
        let t1: JTemporalAccessor = checked_cast(x1);
        let ans = unsafe JYear.from(t1);
        Year(ans)

    /// `parse` / `format` functions  

    ///
    /// Parse the string `s` as a Year, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, Year] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            Year(unsafe JYear.parse(cs, fmtr))
        })

    ///
    /// Returns the Year `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: Year): String =
        let Year(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: Year, y: Year): Bool =
        let Year(x1) = x;
        let Year(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: Year, y: Year): Bool =
        let Year(x1) = x;
        let Year(y1) = y;
        unsafe x1.isAfter(y1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeap(x: Year): Bool =
        let Year(x1) = x;
        unsafe x1.isLeap()

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: Int64): Bool =
        unsafe JYear.isLeap(x)

    ///
    /// Returns `true` if _.
    ///
    pub def isValidMonthDay(md: MonthDay, x: Year): Bool =
        let md1 = Time.MonthDay.getMonthDay(md);
        let Year(x1) = x;
        unsafe x1.isValidMonthDay(md1)


    /// Year functions

    ///
    /// Returns _
    ///
    pub def length(x: Year): Int32 =
        let Year(x1) = x;
        unsafe x1.length()

    /// plus / minus functions

    ///
    /// _
    ///
    pub def plusYears(x: Year, yearsToAdd: Int64): Year =
        let Year(x1) = x;
        let ans = unsafe x1.plusYears(yearsToAdd);
        Year(ans)

    ///
    /// _
    ///
    pub def minusYears(x: Year, yearsToSubtract: Int64): Year =
        let Year(x1) = x;
        let ans = unsafe x1.minusYears(yearsToSubtract);
        Year(ans)


    // between / until functions

    pub def yearsUntil(begin: {begin = Year}, end: {end = Year}): Int64 = 
        let Year(b1) = begin#begin;
        let Year(e1) = end#end;
        let cu1 = unsafe JChronoUnit.YEARS;
        unsafe b1.until(e1, cu1)

    pub def decadesUntil(begin: {begin = Year}, end: {end = Year}): Int64 = 
        let Year(b1) = begin#begin;
        let Year(e1) = end#end;
        let cu1 = unsafe JChronoUnit.DECADES;
        unsafe b1.until(e1, cu1)

    pub def centuriesUntil(begin: {begin = Year}, end: {end = Year}): Int64 = 
        let Year(b1) = begin#begin;
        let Year(e1) = end#end;
        let cu1 = unsafe JChronoUnit.CENTURIES;
        unsafe b1.until(e1, cu1)


}
