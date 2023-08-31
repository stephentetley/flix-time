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

    ///
    /// A wrapper around java.time.YearMonth.
    ///
    pub enum YearMonth(##java.time.YearMonth)

    ///
    ///
    ///
    instance ToString[YearMonth] {
        pub def toString(x: YearMonth): String =
            import java.time.YearMonth.toString(): String \ {};
            let YearMonth(x1) = x;
            toString(x1)
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[YearMonth] {
        pub def fromString(s: String): Option[YearMonth] = 
            Result.tryCatch(_ -> {
                import static java.time.YearMonth.parse(##java.lang.CharSequence): ##java.time.YearMonth \ {};        
                let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
                YearMonth(parse(cs))
            }) |> Result.toOption
    }


    instance Eq[YearMonth] {
        pub def eq(x: YearMonth, y: YearMonth): Bool =
            import java.time.YearMonth.equals(##java.lang.Object): Bool \ {};
            let YearMonth(x1) = x;
            let YearMonth(y1) = y;
            equals(x1, checked_cast(y1))
    }

    instance Hash[YearMonth] {
        pub def hash(x: YearMonth): Int32 =
            import java.time.YearMonth.hashCode(): Int32 \ {};
            let YearMonth(x1) = x;
            hashCode(x1)

    }

    instance Order[YearMonth] {
        pub def compare(x: YearMonth, y: YearMonth): Comparison =
            import java.time.YearMonth.compareTo(##java.time.YearMonth): Int32 \ {};
            let YearMonth(x1) = x;
            let YearMonth(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
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


    /// ## Unwrap

    pub def getYearMonth(x: YearMonth): ##java.time.YearMonth = 
        let YearMonth(x1) = x;
        x1

    /// ## Constructors

    pub def yearMonth(r: {year = Int32, month = Int32}): YearMonth =
        import static java.time.YearMonth.of(Int32, Int32): ##java.time.YearMonth \ {};
        YearMonth(of(r.year, r.month))

    pub def yearMonthWithMonth(r: {year = Int32, month = Month}): YearMonth =
        import static java.time.YearMonth.of(Int32, ##java.time.Month): ##java.time.YearMonth \ {};
        let m1 = Time.Month.marshalMonth(r.month);
        YearMonth(of(r.year, m1))


    /// ## `now` and "abstract constructors" if any

    pub def now(): YearMonth \ IO =
        import static java.time.YearMonth.now(): ##java.time.YearMonth \ IO;
        YearMonth(now())

    /// ## `from` functions

    /// `fromTemporalAccessor` specialized

    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): YearMonth = 
        import static java.time.YearMonth.from(##java.time.temporal.TemporalAccessor): ##java.time.YearMonth \ {} as fromTA;
        try {
            YearMonth(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromLocalDate(x: LocalDate): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromLocalDateTime(x: LocalDateTime): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromOffsetDateTime(x: OffsetDateTime): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromZonedDateTime(x: ZonedDateTime): YearMonth = 
        fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))

    /// ## `parse` / `format` functions  

    ///
    /// Parse the string `s` as a YearMonth, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(_)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, YearMonth] =
        Result.tryCatch(_ -> {
            import static java.time.YearMonth.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.YearMonth \ {};
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            YearMonth(parse(cs, fmtr))
        })
    
    ///
    /// Returns YearMonth `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: YearMonth): String =
        import java.time.YearMonth.format(##java.time.format.DateTimeFormatter): String \ {};
        let YearMonth(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)


    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: YearMonth, y: YearMonth): Bool =
        import java.time.YearMonth.isBefore(##java.time.YearMonth): Bool \ {};
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: YearMonth, y: YearMonth): Bool =
        import java.time.YearMonth.isAfter(##java.time.YearMonth): Bool \ {};
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        isAfter(x1, y1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: YearMonth): Bool =
        import java.time.YearMonth.isLeapYear(): Bool \ {};
        let YearMonth(x1) = x;
        isLeapYear(x1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isValidDay(x: YearMonth, dayOfMonth: Int32): Bool =
        import java.time.YearMonth.isValidDay(Int32): Bool \ {};
        let YearMonth(x1) = x;
        isValidDay(x1, dayOfMonth)

    /// ## YearMonth functions

    ///
    /// Returns the length of the month.
    ///
    pub def lengthOfMonth(x: YearMonth): Int32 =
        import java.time.YearMonth.lengthOfMonth(): Int32 \ {};
        let YearMonth(x1) = x;
        lengthOfMonth(x1)

    ///
    /// Returns the length of the year.
    ///
    pub def lengthOfYear(x: YearMonth): Int32 =
        import java.time.YearMonth.lengthOfYear(): Int32 \ {};
        let YearMonth(x1) = x;
        lengthOfYear(x1)

    /// ## Getters and Setters

    pub def getMonth(x: YearMonth): Month =
        import java.time.YearMonth.getMonth(): ##java.time.Month \ {};
        let YearMonth(x1) = x;
        getMonth(x1) |> Time.Month.unmarshalMonth

    pub def withMonth(month: Month, x: YearMonth): YearMonth =
        yearMonthWithMonth({year = getYear(x), month = month})

    pub def getMonthValue(x: YearMonth): Int32 =
        import java.time.YearMonth.getMonthValue(): Int32 \ {};
        let YearMonth(x1) = x;
        getMonthValue(x1)

    pub def withMonthValue(month: Int32, x: YearMonth): YearMonth =
        import java.time.YearMonth.withMonth(Int32): ##java.time.YearMonth \ {};
        let YearMonth(x1) = x;
        YearMonth(withMonth(x1, month))

    pub def getYear(x: YearMonth): Int32 =
        import java.time.YearMonth.getYear(): Int32 \ {};
        let YearMonth(x1) = x;
        getYear(x1)

    pub def withYear(year: Int32, x: YearMonth): YearMonth =
        import java.time.YearMonth.withYear(Int32): ##java.time.YearMonth \ {};
        let YearMonth(x1) = x;
        YearMonth(withYear(x1, year))

    /// ## plus / minus functions

    pub def plusMonths(x: YearMonth, months: Int64): YearMonth =
        import java.time.YearMonth.plusMonths(Int64): ##java.time.YearMonth \ {};
        let YearMonth(x1) = x;
        YearMonth(plusMonths(x1, months))

    pub def minusMonths(x: YearMonth, months: Int64): YearMonth =
        import java.time.YearMonth.minusMonths(Int64): ##java.time.YearMonth \ {};
        let YearMonth(x1) = x;
        YearMonth(minusMonths(x1, months))

    pub def plusYears(x: YearMonth, years: Int64): YearMonth =
        import java.time.YearMonth.plusYears(Int64): ##java.time.YearMonth \ {};
        let YearMonth(x1) = x;
        YearMonth(plusYears(x1, years))

    pub def minusYears(x: YearMonth, years: Int64): YearMonth =
        import java.time.YearMonth.minusYears(Int64): ##java.time.YearMonth \ {};
        let YearMonth(x1) = x;
        YearMonth(minusYears(x1, years))



    /// ## between / until functions

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = YearMonth, end = YearMonth}): Int64 = 
        import java.time.YearMonth.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getYearMonth(r.start);
        let e1 = unchecked_cast(getYearMonth(r.end) as ##java.time.temporal.Temporal);
        until(b1, e1, u)


    pub def monthsUntil(r: {start = YearMonth, end = YearMonth}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
        untilHelper(unchecked_cast(get_MONTHS() as ##java.time.temporal.TemporalUnit), r)

    pub def yearsUntil(r: {start = YearMonth, end = YearMonth}): Int64 = 
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
        untilHelper(unchecked_cast(get_YEARS() as ##java.time.temporal.TemporalUnit), r)

}
