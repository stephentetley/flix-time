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
                let cs  = (checked_cast(s1) : CharSequence);
                YearMonth(unsafe JYearMonth.parse(cs))
            }) |> Result.toOption
    }


    instance Eq[YearMonth] {
        pub def eq(x: YearMonth, y: YearMonth): Bool =
            let YearMonth(x1) = x;
            let YearMonth(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
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
    use Time.LocalDateTime
    use Time.Month
    use Time.OffsetDateTime
    use Time.Year
    use Time.ZonedDateTime

    import java.time.{YearMonth => JYearMonth}
    import java.lang.{Object, CharSequence}

    /// Unwrap

    pub def getYearMonth(x: YearMonth): JYearMonth = 
        let YearMonth(x1) = x;
        x1

    /// Constructors

    pub def yearMonth(r: {year = Int32, month = Int32}): YearMonth =
        YearMonth(unsafe JYearMonth.of(r#year, r#month))

    pub def yearMonthWithMonth(r: {year = Int32, month = Month}): YearMonth =
        let m1 = Time.Month.marshalMonth(r#month);
        YearMonth(unsafe JYearMonth.of(r#year, m1))


    /// `now` and "abstract constructors" if any

    pub def now(): YearMonth \ IO = YearMonth(JYearMonth.now())

    /// ## `from` functions

    /// `fromTemporalAccessor` specialized

    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): YearMonth = 
        import static java.time.YearMonth.from(##java.time.temporal.TemporalAccessor): ##java.time.YearMonth \ {} as fromTA;
        try {
            YearMonth(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(checked_cast(ex)))
        }

    pub def fromLocalDate(x: LocalDate): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromLocalDateTime(x: LocalDateTime): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromOffsetDateTime(x: OffsetDateTime): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromZonedDateTime(x: ZonedDateTime): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))

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
            let cs  = (checked_cast(s1) : CharSequence);
            YearMonth(unsafe JYearMonth.parse(cs, fmtr))
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
        unsafe x1.getMonth() |> Time.Month.unmarshalMonth

    pub def withMonth(month: Month, x: YearMonth): YearMonth =
        yearMonthWithMonth({year = getYear(x), month = month})

    pub def getMonthValue(x: YearMonth): Int32 =
        let YearMonth(x1) = x;
        unsafe x1.getMonthValue()

    pub def withMonthValue(month: Int32, x: YearMonth): YearMonth =
        let YearMonth(x1) = x;
        YearMonth(unsafe x1.withMonth(month))

    pub def getYear(x: YearMonth): Int32 =
        let YearMonth(x1) = x;
        unsafe x1.getYear()

    pub def withYear(year: Int32, x: YearMonth): YearMonth =
        let YearMonth(x1) = x;
        YearMonth(unsafe x1.withYear(year))

    /// plus / minus functions

    pub def plusMonths(x: YearMonth, months: Int64): YearMonth =
        let YearMonth(x1) = x;
        YearMonth(unsafe x1.plusMonths(months))

    pub def minusMonths(x: YearMonth, months: Int64): YearMonth =
        let YearMonth(x1) = x;
        YearMonth(unsafe x1.minusMonths(months))

    pub def plusYears(x: YearMonth, years: Int64): YearMonth =
        let YearMonth(x1) = x;
        YearMonth(unsafe x1.plusYears(years))

    pub def minusYears(x: YearMonth, years: Int64): YearMonth =
        let YearMonth(x1) = x;
        YearMonth(unsafe x1.minusYears(years))



    // between / until functions

    // def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = YearMonth, end = YearMonth}): Int64 = 
    //     import java.time.YearMonth.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
    //     let b1 = getYearMonth(r#start);
    //     let e1 = unchecked_cast(getYearMonth(r#end) as ##java.time.temporal.Temporal);
    //     until(b1, e1, u)


    // pub def monthsUntil(r: {start = YearMonth, end = YearMonth}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
    //     untilHelper(unchecked_cast(get_MONTHS() as ##java.time.temporal.TemporalUnit), r)

    // pub def yearsUntil(r: {start = YearMonth, end = YearMonth}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
    //     untilHelper(unchecked_cast(get_YEARS() as ##java.time.temporal.TemporalUnit), r)

}
