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


namespace Time {

    use Time.Year
    use Time.Year.{Year}

    ///
    /// A wrapper around java.time.Year.
    ///
    pub enum Year(##java.time.Year)

    instance ToString[Year] {
        pub def toString(x: Year): String =
            import java.time.Year.toString(): String \ {};
            let Year(x1) = x;
            toString(x1)
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[Year] {
        pub def fromString(s: String): Option[Year] =
            Result.tryCatch(_ -> {
                import static java.time.Year.parse(##java.lang.CharSequence): ##java.time.Year \ {};
                let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
                Year(parse(cs))
            }) |> Result.toOption
    }

    instance Eq[Year] {
        pub def eq(x: Year, y: Year): Bool = 
            import java.time.Year.equals(##java.lang.Object): Bool \ {};
            let Year(x1) = x;
            let Year(y1) = y;
            equals(x1, checked_cast(y1))

    }

    instance Hash[Year] {
        pub def hash(x: Year): Int32 =
            import java.time.Year.hashCode(): Int32 \ {};
            let Year(x1) = x;
            hashCode(x1)
    }

    instance Order[Year] {
        pub def compare(x: Year, y: Year): Comparison =
            import java.time.Year.compareTo(##java.time.Year): Int32 \ {};
            let Year(x1) = x;
            let Year(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }

    instance Interop/Flix.Marshal[Year]{
        pub def toJavaObject(x: Year): ##java.lang.Object =
            let Year(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): Year = 
            Year(unchecked_cast(o as ##java.time.Year))
    }

}

namespace Time/Year {

    use Time.Year
    use Time.Year.{Year}

    use Time/Format.DateFormat
    use Time/Format.DateTimeFormatter
    use Time/Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Clock
    use Time.Clock.{Clock}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.Month
    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    use Time.OffsetDateTime
    use Time.YearMonth
    use Time.YearMonth.{YearMonth}
    use Time.ZonedDateTime
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    /// ## Unwrap

    pub def getYear(x: Year): ##java.time.Year = 
        let Year(x1) = x;
        x1

    /// ## Constructors

    pub def year(isoYear: {isoYear = Int32}): Year =
        import static java.time.Year.of(Int32): ##java.time.Year \ {};
        Year(of(isoYear.isoYear))


    /// ## `now` and "abstract constructors" if any

    pub def now(): Year \ IO =
        import static java.time.Year.now(): ##java.time.Year \ IO;
        Year(now())

    pub def nowWithClock(x: Clock): Year \ IO =
        import static java.time.Year.now(##java.time.Clock): ##java.time.Year \ IO;
        let Clock(x1) = x;
        Year(now(x1))

    pub def nowWithZoneId(x: ZoneId): Year \ IO =
        import static java.time.Year.now(##java.time.ZoneId): ##java.time.Year \ IO;
        let ZoneId(x1) = x;
        Year(now(x1))

    /// ## `at` functions

    pub def atDay(x: Year, dayOfYear: Int32): Option[LocalDate] =
        Result.tryCatch(_ -> {
            import java.time.Year.atDay(Int32): ##java.time.LocalDate \ {};
            let Year(x1) = x;
            LocalDate(atDay(x1, dayOfYear))
        }) |> Result.toOption

    pub def atMonth(x: Year, month: Int32): Option[YearMonth] =
        Result.tryCatch(_ -> {
            import java.time.Year.atMonth(Int32): ##java.time.YearMonth \ {};
            let Year(x1) = x;
            YearMonth(atMonth(x1, month))
        }) |> Result.toOption

    pub def atMonthWithMonth(x: Year, month: Month): Option[YearMonth] =
        Result.tryCatch(_ -> {
            import java.time.Year.atMonth(##java.time.Month): ##java.time.YearMonth \ {};
            let Year(x1) = x;
            let m1 = Time/Month.marshal(month);
            YearMonth(atMonth(x1, m1))
        }) |> Result.toOption

    pub def atMonthDay(x: Year, monthDay: MonthDay): LocalDate =
        import java.time.Year.atMonthDay(##java.time.MonthDay): ##java.time.LocalDate \ {};
        let Year(x1) = x;
        let MonthDay(m1) = monthDay;
        LocalDate(atMonthDay(x1, m1))


    /// ## `from` functions

    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): Year = 
        import static java.time.Year.from(##java.time.temporal.TemporalAccessor): ##java.time.Year \ {} as fromTA;
        try {
            Year(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromLocalDate(x: LocalDate): Year = 
        fromTemporalAccessorHelper(unchecked_cast(Time/LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromLocalDateTime(x: LocalDateTime): Year = 
        fromTemporalAccessorHelper(unchecked_cast(Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromOffsetDateTime(x: OffsetDateTime): Year = 
        fromTemporalAccessorHelper(unchecked_cast(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromYearMonth(x: YearMonth): Year = 
        fromTemporalAccessorHelper(unchecked_cast(Time/YearMonth.getYearMonth(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromZonedDateTime(x: ZonedDateTime): Year = 
        fromTemporalAccessorHelper(unchecked_cast(Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))


    /// ## `parse` / `format` functions  

    ///
    /// Parse the string `s` as a Year, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, Year] =
        Result.tryCatch(_ -> {
            import static java.time.Year.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.Year \ {};
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            Year(parse(cs, fmtr))
        })

    ///
    /// Returns the Year `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: Year): String =
        import java.time.Year.format(##java.time.format.DateTimeFormatter): String \ {};
        let Year(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)


    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: Year, y: Year): Bool =
        import java.time.Year.isBefore(##java.time.Year): Bool \ {};
        let Year(x1) = x;
        let Year(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: Year, y: Year): Bool =
        import java.time.Year.isAfter(##java.time.Year): Bool \ {};
        let Year(x1) = x;
        let Year(y1) = y;
        isAfter(x1, y1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeap(y: Year): Bool =
        import java.time.Year.isLeap(): Bool \ {};
        let Year(y1) = y;
        isLeap(y1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: Int64): Bool =
        import static java.time.Year.isLeap(Int64): Bool \ {};
        isLeap(x)

    ///
    /// Returns `true` if _.
    ///
    pub def isValidMonthDay(x: MonthDay, y: Year): Bool =
        import java.time.Year.isValidMonthDay(##java.time.MonthDay): Bool \ {};
        let x1 = Time/MonthDay.getMonthDay(x);
        let Year(y1) = y;
        isValidMonthDay(y1, x1)


    /// ## Year functions

    ///
    /// Returns _
    ///
    pub def length(x: Year): Int32 =
        import java.time.Year.length(): Int32 \ {};
        let Year(x1) = x;
        length(x1)

    /// ## plus / minus functions

    ///
    /// _
    ///
    pub def plusYears(x: Year, yearsToAdd: Int64): Year =
        import java.time.Year.plusYears(Int64): ##java.time.Year \ {};
        let Year(x1) = x;
        Year(plusYears(x1, yearsToAdd))

    ///
    /// _
    ///
    pub def minusYears(x: Year, yearsToSubtract: Int64): Year =
        import java.time.Year.minusYears(Int64): ##java.time.Year \ {};
        let Year(x1) = x;
        Year(minusYears(x1, yearsToSubtract))


    /// ## between / until functions

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = Year, end = Year}): Int64 = 
        import java.time.Year.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getYear(r.start);
        let e1 = unchecked_cast(getYear(r.end) as ##java.time.temporal.Temporal);
        until(b1, e1, u)


    pub def yearsUntil(r: {start = Year, end = Year}): Int64 = 
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
        untilHelper(unchecked_cast(get_YEARS() as ##java.time.temporal.TemporalUnit), r)

    pub def decadesUntil(r: {start = Year, end = Year}): Int64 = 
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit \ {} as get_DECADES;
        untilHelper(unchecked_cast(get_DECADES() as ##java.time.temporal.TemporalUnit), r)

    pub def centuriesUntil(r: {start = Year, end = Year}): Int64 = 
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit \ {} as get_CENTURIES;
        untilHelper(unchecked_cast(get_CENTURIES() as ##java.time.temporal.TemporalUnit), r)


}
