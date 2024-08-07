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

    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}

    ///
    /// A wrapper around a Java LocalDateTime.
    ///
    pub enum LocalDateTime(##java.time.LocalDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[LocalDateTime] {
        pub def toString(x: LocalDateTime): String =
            import java.time.LocalDateTime.toString(): String \ {};
            let LocalDateTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDateTime] {
        pub def fromString(s: String): Option[LocalDateTime] =
            Result.tryCatch(_ -> {
                import static java.time.LocalDateTime.parse(##java.lang.CharSequence): ##java.time.LocalDateTime \ {};
                let cs:  ##java.lang.CharSequence = checked_cast(String.trim(s));
                LocalDateTime(parse(cs))
            }) |> Result.toOption
    }

    instance Eq[LocalDateTime] {
        pub def eq(x: LocalDateTime, y: LocalDateTime): Bool =
            import java.time.LocalDateTime.equals(##java.lang.Object): Bool \ {};
            let LocalDateTime(x1) = x;
            let LocalDateTime(y1) = y;
            equals(x1, checked_cast(y1))

    }

    instance Hash[LocalDateTime] {
        pub def hash(x: LocalDateTime): Int32 =
            import java.time.LocalDateTime.hashCode(): Int32 \ {};
            let LocalDateTime(x1) = x;
            hashCode(x1)

    }

    instance Order[LocalDateTime] {
        pub def compare(x: LocalDateTime, y: LocalDateTime): Comparison =
            import java.time.LocalDateTime.compareTo(##java.time.chrono.ChronoLocalDateTime): Int32 \ {};
            let LocalDateTime(x1) = x;
            let LocalDateTime(y1) = y;
            let cy1 = unchecked_cast(y1 as ##java.time.chrono.ChronoLocalDateTime);
            compareTo(x1, cy1) |> Comparison.fromInt32
    }

}

mod Time.LocalDateTime {

    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}    
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Format.DateTimeFormat
    use Time.DayOfWeek
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.Month
    use Time.MonthDay
    use Time.Period
    use Time.OffsetDateTime
    use Time.YearMonth
    use Time.ZonedDateTime
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    /// ## Unwrap

    pub def getLocalDateTime(x: LocalDateTime): ##java.time.LocalDateTime = 
        let LocalDateTime(x1) = x;
        x1


    pub def asTemporalAccessor(x: LocalDateTime): TemporalAccessor = 
        let LocalDateTime(x1) = x;
        TemporalAccessor(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor))

    /// ## Constructors

    pub def localDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, minute = Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime \ {};
        LocalDateTime(of(r#year, r#month, r#dayOfMonth, r#hour, r#minute))

    pub def localDateTimeWithSecond(r: {year = Int32, month = Int32, dayOfMonth = Int32,
                                hour = Int32, minute = Int32, second = Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime \ {};
        LocalDateTime(of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second))

    pub def localDateTimeWithSecondAndNano(r: {year = Int32, month = Int32, dayOfMonth = Int32,
                                        hour = Int32, minute = Int32, second = Int32, nanoSecond = Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime \ {};
        LocalDateTime(of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second, r#nanoSecond))


    /// ## `now` and "abstract constructors" if any

    ///
    /// Returns the current date-time from the system clock.
    ///
    pub def now(): LocalDateTime \ IO =
        import static java.time.LocalDateTime.now(): ##java.time.LocalDateTime \ IO;
        LocalDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): LocalDateTime \ IO =
        import static java.time.LocalDateTime.now(##java.time.ZoneId): ##java.time.LocalDateTime \ IO;
        let ZoneId(z) = zone;
        LocalDateTime(now(z))


    /// ## `from` functions

    pub def fromLocalDateLocalTime(d: LocalDate, t: LocalTime): LocalDateTime =
        import static java.time.LocalDateTime.of(##java.time.LocalDate, ##java.time.LocalTime): ##java.time.LocalDateTime \ {};
        let LocalDate(d1) = d;
        let LocalTime(t1) = t;
        LocalDateTime(of(d1, t1))

    pub def ofEpochSecond(offset: {offset = ZoneOffset}, epochSecond: Int64, nanoOfSecond: Int32): LocalDateTime =
        import static java.time.LocalDateTime.ofEpochSecond(Int64, Int32, ##java.time.ZoneOffset): ##java.time.LocalDateTime \ {};
        let ZoneOffset(o1) = offset#offset;
        LocalDateTime(ofEpochSecond(epochSecond, nanoOfSecond, o1))

    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): LocalDateTime =
        import static java.time.LocalDateTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalDateTime \ {};
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone#zone;
        LocalDateTime(ofInstant(x1, z1))

    /// # `fromTemporalAccessor` specialized
    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): LocalDateTime = 
        import static java.time.LocalDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDateTime \ {} as fromTA;
        try {
            LocalDateTime(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(checked_cast(ex)))
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): LocalDateTime = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromZonedDateTime(x: ZonedDateTime): LocalDateTime = 
        fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))


    /// ## `to` functions

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        import java.time.LocalDateTime.toLocalDate(): ##java.time.LocalDate \ {};
        let LocalDateTime(x1) = x;
        LocalDate(toLocalDate(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        import java.time.LocalDateTime.toLocalTime(): ##java.time.LocalTime \ {};
        let LocalDateTime(x1) = x;
        LocalTime(toLocalTime(x1))

    /// ## `parse` / `format` functions

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Result[String, LocalDateTime] =
        Result.tryCatch(_ -> {
            import static java.time.LocalDateTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalDateTime \ {};
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            LocalDateTime(parse(cs, fmtr))
        })

    ///
    /// Returns LocalDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: LocalDateTime): String =
        import java.time.LocalDateTime.format(##java.time.format.DateTimeFormatter): String \ {};
        let LocalDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)


    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isBefore(##java.time.chrono.ChronoLocalDateTime): Bool \ {};
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        isBefore(x1, unchecked_cast(y1 as ##java.time.chrono.ChronoLocalDateTime))

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isAfter(##java.time.chrono.ChronoLocalDateTime): Bool \ {};
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        isAfter(x1, unchecked_cast(y1 as ##java.time.chrono.ChronoLocalDateTime))

    /// ## LocalDateTime functions

    pub def getMonthValue(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMonth(): ##java.time.Month \ {};
        import java.time.Month.getValue(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getValue(getMonth(x1))

    /// ## Getters and Setters

    pub def getYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getYear(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getYear(x1)

    pub def withYear(year: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withYear(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withYear(x1, year))

    pub def getMonth(x: LocalDateTime): Month =
        import java.time.LocalDateTime.getMonth(): ##java.time.Month \ {};
        let LocalDateTime(x1) = x;
        Time.Month.unmarshalMonth(getMonth(x1))

    pub def withMonth(month: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withMonth(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withMonth(x1, month))

    pub def getDayOfYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfYear(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getDayOfYear(x1)

    pub def withDayOfYear(dayOfYear: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withDayOfYear(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withDayOfYear(x1, dayOfYear))

    pub def getDayOfMonth(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfMonth(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getDayOfMonth(x1)

    pub def withDayOfMonth(dayOfMonth: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withDayOfMonth(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfWeek(x: LocalDateTime): DayOfWeek =
        import java.time.LocalDateTime.getDayOfWeek(): ##java.time.DayOfWeek \ {};
        let LocalDateTime(x1) = x;
        Time.DayOfWeek.unmarshalDayOfWeek(getDayOfWeek(x1))

    pub def getHour(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getHour(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getHour(x1)

    pub def withHour(hour: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withHour(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withHour(x1, hour))

    pub def getMinute(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMinute(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getMinute(x1)

    pub def withMinute(minute: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withMinute(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withMinute(x1, minute))

    pub def getSecond(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getSecond(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getSecond(x1)

    pub def withSecond(second: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withSecond(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withSecond(x1, second))

    pub def getNano(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getNano(): Int32 \ {};
        let LocalDateTime(x1) = x;
        getNano(x1)

    pub def withNano(nano: Int32, x: LocalDateTime): LocalDateTime =
        import java.time.LocalDateTime.withNano(Int32): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(withNano(x1, nano))

    /// YearMonth methods

    pub def adjustYearMonth(x: YearMonth, dt: LocalDateTime): LocalDateTime = 
        import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.YearMonth.getYearMonth(x);
        let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.LocalDateTime))

    /// LocalDate methods

    pub def adjustLocalDate(x: LocalDate, dt: LocalDateTime): LocalDateTime = 
        import java.time.LocalDate.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.LocalDate.getLocalDate(x);
        let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.LocalDateTime))

    /// LocalTime methods

    pub def adjustLocalTime(x: LocalTime, dt: LocalDateTime): LocalDateTime = 
        import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.LocalTime.getLocalTime(x);
        let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.LocalDateTime))

    /// DayOfWeek methods

    pub def adjustDayOfWeek(x: DayOfWeek, d: LocalDateTime): LocalDateTime = 
        import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.DayOfWeek.marshalDayOfWeek(x);
        let d1 = unchecked_cast(getLocalDateTime(d) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.LocalDateTime))

    /// MonthDay methods

    pub def adjustMonthDay(x: MonthDay, d: LocalDateTime): LocalDateTime = 
        import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.MonthDay.getMonthDay(x);
        let d1 = unchecked_cast(getLocalDateTime(d) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.LocalDateTime))


    /// ## truncate functions

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: LocalDateTime): LocalDateTime = 
        import java.time.LocalDateTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(truncatedTo(x1, u))

    pub def truncatedToDays(x: LocalDateTime): LocalDateTime = 
        import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        truncatedToHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), x)

    /// ## plus / minus functions

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusYears(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusYears(x1, years))

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusYears(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusYears(x1, years))

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMonths(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusMonths(x1, months))

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMonths(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusMonths(x1, months))

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusWeeks(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusWeeks(x1, weeks))

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusWeeks(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusWeeks(x1, weeks))

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusDays(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusDays(x1, days))

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusDays(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusDays(x1, days))

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusHours(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusHours(x1, hours))

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusHours(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusHours(x1, hours))

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMinutes(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMinutes(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusSeconds(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusSeconds(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusNanos(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(plusNanos(x1, nanos))

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusNanos(Int64): ##java.time.LocalDateTime \ {};
        let LocalDateTime(x1) = x;
        LocalDateTime(minusNanos(x1, nanos))


    pub def plusPeriod(i: LocalDateTime, x: Period): LocalDateTime =
        import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.Period.getPeriod(x);
        let i1 = unchecked_cast(getLocalDateTime(i) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(addTo(x1, i1) as ##java.time.LocalDateTime))
    
    pub def minusPeriod(i: LocalDateTime, x: Period): LocalDateTime =
        import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.Period.getPeriod(x);
        let i1 = unchecked_cast(getLocalDateTime(i) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.LocalDateTime))



    pub def plusDuration(dt: LocalDateTime, x: DurationZ): LocalDateTime =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let DurationZ(x1) = x;
        let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(addTo(x1, dt1) as ##java.time.LocalDateTime))
    
    pub def minusDuration(dt: LocalDateTime, x: DurationZ): LocalDateTime =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let DurationZ(x1) = x;
        let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
        LocalDateTime(unchecked_cast(subtractFrom(x1, dt1) as ##java.time.LocalDateTime))


    /// ## between / until functions

    pub def between(r: {start = LocalDateTime, end = LocalDateTime}): DurationZ =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
        let s1 = unchecked_cast(getLocalDateTime(r#start) as ##java.time.temporal.Temporal);
        let e1 = unchecked_cast(getLocalDateTime(r#end) as ##java.time.temporal.Temporal);
        DurationZ(between(s1, e1)) 
                            


    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import java.time.LocalDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getLocalDateTime(r#start);
        let e1 = unchecked_cast(getLocalDateTime(r#end) as ##java.time.temporal.Temporal);
        until(b1, e1, u)


    pub def secondsUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    pub def minutesUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    pub def hoursUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)

    pub def halfDaysUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        untilHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), r)

    pub def daysUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        untilHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), r)

    pub def monthsUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
        untilHelper(unchecked_cast(get_MONTHS() as ##java.time.temporal.TemporalUnit), r)

    pub def yearsUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
        untilHelper(unchecked_cast(get_YEARS() as ##java.time.temporal.TemporalUnit), r)

    pub def quarterYearsUntil(r: {start = LocalDateTime, end = LocalDateTime}): Int64 = 
        import static java_get_field java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.TemporalUnit \ {} as get_QUARTER_YEARS;
        untilHelper(get_QUARTER_YEARS(), r)


}
