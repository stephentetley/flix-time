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

    import java.time.{LocalDateTime => JLocalDateTime}
    import java.time.chrono.{ChronoLocalDateTime}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around a Java LocalDateTime.
    ///
    pub enum LocalDateTime(JLocalDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[LocalDateTime] {
        pub def toString(x: LocalDateTime): String =
            let LocalDateTime(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDateTime] {
        pub def fromString(s: String): Option[LocalDateTime] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs  = (checked_cast(s1) : CharSequence);
                LocalDateTime(unsafe JLocalDateTime.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[LocalDateTime] {
        pub def eq(x: LocalDateTime, y: LocalDateTime): Bool =
            let LocalDateTime(x1) = x;
            let LocalDateTime(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)

    }

    instance Hash[LocalDateTime] {
        pub def hash(x: LocalDateTime): Int32 =
            let LocalDateTime(x1) = x;
            unsafe x1.hashCode()

    }

    instance Order[LocalDateTime] {
        pub def compare(x: LocalDateTime, y: LocalDateTime): Comparison =
            let LocalDateTime(x1) = x;
            let LocalDateTime(y1) = y;
            let cy1 = (checked_cast(y1) : ChronoLocalDateTime);
            unsafe x1.compareTo(cy1) |> Comparison.fromInt32
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
    use Time.Period.{Period}
    use Time.OffsetDateTime
    use Time.YearMonth
    use Time.ZonedDateTime
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.{LocalDate => JLocalDate}
    import java.time.{LocalDateTime => JLocalDateTime}
    import java.time.chrono.{ChronoLocalDate}
    import java.time.chrono.{ChronoLocalDateTime}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{IsoFields => JIsoFields}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}

    /// Unwrap

    pub def getLocalDateTime(x: LocalDateTime): JLocalDateTime = 
        let LocalDateTime(x1) = x;
        x1


    pub def asTemporalAccessor(x: LocalDateTime): TemporalAccessor = 
        let LocalDateTime(x1) = x;
        let cx1 = checked_cast(x1);
        TemporalAccessor(cx1)

    /// Constructors

    pub def localDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, minute = Int32}): LocalDateTime =
        LocalDateTime(unsafe JLocalDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute))

    pub def localDateTimeWithSecond(r: {year = Int32, month = Int32, dayOfMonth = Int32,
                                hour = Int32, minute = Int32, second = Int32}): LocalDateTime =
        LocalDateTime(unsafe JLocalDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second))

    pub def localDateTimeWithSecondAndNano(r: {year = Int32, month = Int32, dayOfMonth = Int32,
                                        hour = Int32, minute = Int32, second = Int32, nanoSecond = Int32}): LocalDateTime =
        LocalDateTime(unsafe JLocalDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second, r#nanoSecond))


    /// `now` and "abstract constructors" if any

    ///
    /// Returns the current date-time from the system clock.
    ///
    pub def now(): LocalDateTime \ IO =
        LocalDateTime(JLocalDateTime.now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): LocalDateTime \ IO =
        let ZoneId(z) = zone;
        LocalDateTime(JLocalDateTime.now(z))


    /// `from` functions

    pub def fromLocalDateLocalTime(d: LocalDate, t: LocalTime): LocalDateTime =
        let LocalDate(d1) = d;
        let LocalTime(t1) = t;
        LocalDateTime(unsafe JLocalDateTime.of(d1, t1))

    pub def ofEpochSecond(offset: {offset = ZoneOffset}, epochSecond: Int64, nanoOfSecond: Int32): LocalDateTime =
        let ZoneOffset(o1) = offset#offset;
        LocalDateTime(unsafe JLocalDateTime.ofEpochSecond(epochSecond, nanoOfSecond, o1))

    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): LocalDateTime =
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone#zone;
        LocalDateTime(unsafe JLocalDateTime.ofInstant(x1, z1))

    // // `fromTemporalAccessor` specialized
    // def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): LocalDateTime = 
    //     import static java.time.LocalDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDateTime \ {} as fromTA;
    //     try {
    //         LocalDateTime(fromTA(x))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }

    // pub def fromOffsetDateTime(x: OffsetDateTime): LocalDateTime = 
    //     fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    // pub def fromZonedDateTime(x: ZonedDateTime): LocalDateTime = 
    //     fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))


    /// `to` functions

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        let LocalDateTime(x1) = x;
        let cx1 : ChronoLocalDateTime = (checked_cast(x1) : ChronoLocalDateTime);
        let ans : ChronoLocalDate = unsafe cx1.toLocalDate();
        let ans1 : JLocalDate = unchecked_cast(ans as JLocalDate);
        LocalDate(ans1)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        let LocalDateTime(x1) = x;
        LocalTime(unsafe x1.toLocalTime())

    /// `parse` / `format` functions

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Result[String, LocalDateTime] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            LocalDateTime(unsafe JLocalDateTime.parse(cs, fmtr))
        })

    ///
    /// Returns LocalDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: LocalDateTime): String =
        let LocalDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDateTime, y: LocalDateTime): Bool =
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDateTime, y: LocalDateTime): Bool =
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        unsafe x1.isAfter(y1)

    /// LocalDateTime functions

    pub def getMonthValue(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        let ans = unsafe x1.getMonth();
        unsafe ans.getValue()

    /// Getters and Setters

    pub def getYear(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe x1.getYear()

    pub def withYear(year: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withYear(year))

    pub def getMonth(x: LocalDateTime): Month =
        let LocalDateTime(x1) = x;
        Time.Month.unmarshalMonth(unsafe x1.getMonth())

    pub def withMonth(month: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withMonth(month))

    pub def getDayOfYear(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe x1.getDayOfYear()

    pub def withDayOfYear(dayOfYear: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withDayOfYear(dayOfYear))

    pub def getDayOfMonth(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe x1.getDayOfMonth()

    pub def withDayOfMonth(dayOfMonth: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withDayOfMonth(dayOfMonth))

    pub def getDayOfWeek(x: LocalDateTime): DayOfWeek =
        let LocalDateTime(x1) = x;
        Time.DayOfWeek.unmarshalDayOfWeek(unsafe x1.getDayOfWeek())

    pub def getHour(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe x1.getHour()

    pub def withHour(hour: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withHour(hour))

    pub def getMinute(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe x1.getMinute()

    pub def withMinute(minute: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withMinute(minute))

    pub def getSecond(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe x1.getSecond()

    pub def withSecond(second: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withSecond(second))

    pub def getNano(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe x1.getNano()

    pub def withNano(nano: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.withNano(nano))

    /// YearMonth methods

    // pub def adjustYearMonth(x: YearMonth, dt: LocalDateTime): LocalDateTime = 
    //     import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.YearMonth.getYearMonth(x);
    //     let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
    //     LocalDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.LocalDateTime))

    /// LocalDate methods

    // pub def adjustLocalDate(x: LocalDate, dt: LocalDateTime): LocalDateTime = 
    //     import java.time.LocalDate.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalDate.getLocalDate(x);
    //     let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
    //     LocalDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.LocalDateTime))

    /// LocalTime methods

    // pub def adjustLocalTime(x: LocalTime, dt: LocalDateTime): LocalDateTime = 
    //     import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalTime.getLocalTime(x);
    //     let dt1 = unchecked_cast(getLocalDateTime(dt) as ##java.time.temporal.Temporal);
        // LocalDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.LocalDateTime))

    /// DayOfWeek methods

    // pub def adjustDayOfWeek(x: DayOfWeek, d: LocalDateTime): LocalDateTime = 
    //     import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.DayOfWeek.marshalDayOfWeek(x);
    //     let d1 = unchecked_cast(getLocalDateTime(d) as ##java.time.temporal.Temporal);
    //     LocalDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.LocalDateTime))

    /// MonthDay methods

    // pub def adjustMonthDay(x: MonthDay, d: LocalDateTime): LocalDateTime = 
    //     import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.MonthDay.getMonthDay(x);
    //     let d1 = unchecked_cast(getLocalDateTime(d) as ##java.time.temporal.Temporal);
    //     LocalDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.LocalDateTime))


    // truncate functions

    // def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: LocalDateTime): LocalDateTime = 
    //     import java.time.LocalDateTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.LocalDateTime \ {};
    //     let LocalDateTime(x1) = x;
    //     LocalDateTime(truncatedTo(x1, u))

    // pub def truncatedToDays(x: LocalDateTime): LocalDateTime = 
    //     import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
    //     truncatedToHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), x)

    // plus / minus functions

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusYears(years))

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusYears(years))

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusMonths(months))

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusMonths(months))

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusWeeks( weeks))

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusWeeks(weeks))

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusDays(days))

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusDays(days))

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusHours(hours))

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusHours(hours))

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusMinutes(minutes))

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusMinutes(minutes))

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusSeconds(seconds))

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusSeconds(seconds))

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.plusNanos(nanos))

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        LocalDateTime(unsafe x1.minusNanos(nanos))


    pub def plusPeriod(x: LocalDateTime, p: Period): LocalDateTime =
        let LocalDateTime(x1) = x;
        let Period(p1) = p;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe p1.addTo(t1);
        let ans = unchecked_cast(t2 as JLocalDateTime);
        LocalDateTime(ans)
    
    pub def minusPeriod(x: LocalDateTime, p: Period): LocalDateTime =
        let LocalDateTime(x1) = x;
        let Period(p1) = p;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe p1.subtractFrom(t1);
        let ans = unchecked_cast(t2 as JLocalDateTime);
        LocalDateTime(ans)


    pub def plusDuration(x: LocalDateTime, d: DurationZ): LocalDateTime =
        let LocalDateTime(x1) = x;
        let DurationZ(d1) = d;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe d1.addTo(t1);
        let ans = unchecked_cast(t2 as JLocalDateTime);
        LocalDateTime(ans)
    
    pub def minusDuration(x: LocalDateTime, d: DurationZ): LocalDateTime =
        let LocalDateTime(x1) = x;
        let DurationZ(d1) = d;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe d1.subtractFrom(t1);
        let ans = unchecked_cast(t2 as JLocalDateTime);
        LocalDateTime(ans)


    // between / until functions

    pub def between(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): DurationZ =
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let tb1: JTemporal = checked_cast(b1);
        let te1: JTemporal = checked_cast(e1);
        let ans = unsafe JDuration.between(tb1, te1);
        DurationZ(ans)

    pub def secondsUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.SECONDS;
        unsafe b1.until(e1, cu1)

    pub def minutesUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.MINUTES;
        unsafe b1.until(e1, cu1)

    pub def hoursUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.HOURS;
        unsafe b1.until(e1, cu1)

    pub def halfDaysUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.HALF_DAYS;
        unsafe b1.until(e1, cu1)

    pub def daysUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.DAYS;
        unsafe b1.until(e1, cu1)

    pub def monthsUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.MONTHS;
        unsafe b1.until(e1, cu1)

    pub def yearsUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.YEARS;
        unsafe b1.until(e1, cu1)

    pub def quarterYearsUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe JIsoFields.QUARTER_YEARS;
        unsafe b1.until(e1, cu1)

}
