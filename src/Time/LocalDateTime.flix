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
    use Time.LocalDateTime.{LocalDateTime }

    import java.time.{LocalDateTime => JLocalDateTime }
    import java.time.chrono.{ChronoLocalDateTime }
    import java.lang.{Object, CharSequence }

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
            unsafe IO { x1.toString() }
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
                let ans = unsafe IO { JLocalDateTime.parse(s1) };
                LocalDateTime(ans)
           }) |> Result.toOption
   }

    instance Eq[LocalDateTime] {
        pub def eq(x: LocalDateTime, y: LocalDateTime): Bool =
            let LocalDateTime(x1) = x;
            let LocalDateTime(y1) = y;
            unsafe IO { x1.equals(y1) }

   }

    instance Hash[LocalDateTime] {
        pub def hash(x: LocalDateTime): Int32 =
            let LocalDateTime(x1) = x;
            unsafe IO { x1.hashCode() }

   }

    instance Order[LocalDateTime] {
        pub def compare(x: LocalDateTime, y: LocalDateTime): Comparison =
            let LocalDateTime(x1) = x;
            let LocalDateTime(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
   }

}

mod Time.LocalDateTime {

    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime }
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter }
    use Time.Format.DateTimeFormat
    use Time.DayOfWeek
    use Time.DurationZ
    use Time.DurationZ.{DurationZ }
    use Time.InstantZ
    use Time.InstantZ.{InstantZ }
    use Time.LocalDate
    use Time.LocalDate.{LocalDate }
    use Time.LocalTime
    use Time.LocalTime.{LocalTime }
    use Time.Month
    use Time.MonthDay
    use Time.MonthDay.{MonthDay }
    use Time.Period
    use Time.Period.{Period }
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime }
    use Time.YearMonth
    use Time.YearMonth.{YearMonth }
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime }
    use Time.ZoneId
    use Time.ZoneId.{ZoneId }
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset }

    import java.lang.{Object, CharSequence }
    import java.time.{Duration => JDuration }
    import java.time.{LocalDate => JLocalDate }
    import java.time.{LocalDateTime => JLocalDateTime }
    import java.time.chrono.{ChronoLocalDate }
    import java.time.chrono.{ChronoLocalDateTime }
    import java.time.temporal.{ChronoUnit => JChronoUnit }
    import java.time.temporal.{IsoFields => JIsoFields }
    import java.time.temporal.{Temporal => JTemporal }
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor }

    /// Unwrap

    pub def getLocalDateTime(x: LocalDateTime): JLocalDateTime = 
        let LocalDateTime(x1) = x;
        x1



    /// Constructors

    pub def localDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, minute = Int32 }): LocalDateTime =
        LocalDateTime(unsafe IO { JLocalDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute)}) 

    pub def localDateTimeWithSecond(r: {year = Int32, month = Int32, dayOfMonth = Int32,
                                hour = Int32, minute = Int32, second = Int32 }): LocalDateTime =
        LocalDateTime(unsafe IO { JLocalDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second) })

    pub def localDateTimeWithSecondAndNano(r: {year = Int32, month = Int32, dayOfMonth = Int32,
                                        hour = Int32, minute = Int32, second = Int32, nanoSecond = Int32 }): LocalDateTime =
        LocalDateTime(unsafe IO { JLocalDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second, r#nanoSecond)}) 


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
        let ans = JLocalDateTime.now(z);
        LocalDateTime(ans)


    /// `from` functions

    pub def fromLocalDateLocalTime(d: LocalDate, t: LocalTime): LocalDateTime =
        let LocalDate(d1) = d;
        let LocalTime(t1) = t;
        let ans = unsafe IO { JLocalDateTime.of(d1, t1) };
        LocalDateTime(ans)

    pub def ofEpochSecond(offset: {offset = ZoneOffset }, epochSecond: Int64, nanoOfSecond: Int32): LocalDateTime =
        let ZoneOffset(o1) = offset#offset;
        let ans = unsafe IO { JLocalDateTime.ofEpochSecond(epochSecond, nanoOfSecond, o1) };
        LocalDateTime(ans)

    pub def ofInstant(zone: {zone = ZoneId }, x: InstantZ): LocalDateTime =
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone#zone;
        let ans = unsafe IO { JLocalDateTime.ofInstant(x1, z1) };
        LocalDateTime(ans)

    // `fromTemporalAccessor` specialized

    pub def fromOffsetDateTime(x: OffsetDateTime): LocalDateTime = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe IO { JLocalDateTime.$from(x1) };
        LocalDateTime(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): LocalDateTime = 
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { JLocalDateTime.$from(x1) };
        LocalDateTime(ans)



    /// `to` functions

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.toLocalDate() };
        LocalDate(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.toLocalTime() };
        LocalTime(ans)

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
            let ans = unsafe IO { JLocalDateTime.parse(s1, fmtr) };
            LocalDateTime(ans)
       })

    ///
    /// Returns LocalDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: LocalDateTime): String =
        let LocalDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe IO { x1.format(fmtr) }


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDateTime, y: LocalDateTime): Bool =
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        unsafe IO { x1.isBefore(y1) }

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDateTime, y: LocalDateTime): Bool =
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        unsafe IO { x1.isAfter(y1) }

    /// LocalDateTime functions

    pub def getMonthValue(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        let m1 = unsafe IO { x1.getMonth() };
        unsafe IO { m1.getValue() }

    /// Getters and Setters

    pub def getYear(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe IO { x1.getYear() }

    pub def withYear(year: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withYear(year) };
        LocalDateTime(ans)

    pub def getMonth(x: LocalDateTime): Month =
        let LocalDateTime(x1) = x;
        Time.Month.unmarshalMonth(unsafe IO { x1.getMonth() })

    pub def withMonth(month: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withMonth(month) };
        LocalDateTime(ans)

    pub def getDayOfYear(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe IO { x1.getDayOfYear() }

    pub def withDayOfYear(dayOfYear: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withDayOfYear(dayOfYear) };
        LocalDateTime(ans)

    pub def getDayOfMonth(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe IO { x1.getDayOfMonth() }

    pub def withDayOfMonth(dayOfMonth: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withDayOfMonth(dayOfMonth) };
        LocalDateTime(ans)

    pub def getDayOfWeek(x: LocalDateTime): DayOfWeek =
        let LocalDateTime(x1) = x;
        Time.DayOfWeek.unmarshalDayOfWeek(unsafe IO { x1.getDayOfWeek() })

    pub def getHour(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe IO { x1.getHour() }

    pub def withHour(hour: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withHour(hour) };
        LocalDateTime(ans)

    pub def getMinute(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe IO { x1.getMinute() }

    pub def withMinute(minute: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withMinute(minute) };
        LocalDateTime(ans)

    pub def getSecond(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe IO { x1.getSecond() }

    pub def withSecond(second: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withSecond(second) };
        LocalDateTime(ans)

    pub def getNano(x: LocalDateTime): Int32 =
        let LocalDateTime(x1) = x;
        unsafe IO { x1.getNano() }

    pub def withNano(nano: Int32, x: LocalDateTime): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.$withNano(nano) };
        LocalDateTime(ans)

    /// YearMonth methods

    pub def adjustYearMonth(ym: YearMonth, x: LocalDateTime): LocalDateTime = 
        let LocalDateTime(x1) = x;
        let YearMonth(ym1) = ym;
        let t1 = unsafe IO { ym1.adjustInto(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)

    /// LocalDate methods

    pub def adjustLocalDate(d: LocalDate, x: LocalDateTime): LocalDateTime = 
        let LocalDateTime(x1) = x;
        let LocalDate(d1) = d;
        let t1 = unsafe IO { d1.adjustInto(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)

    /// LocalTime methods

    pub def adjustLocalTime(lt: LocalTime, x: LocalDateTime): LocalDateTime = 
        let LocalDateTime(x1) = x;
        let LocalTime(lt1) = lt;
        let t1 = unsafe IO { lt1.adjustInto(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)

    /// DayOfWeek methods

    pub def adjustDayOfWeek(d: DayOfWeek, x: LocalDateTime): LocalDateTime = 
        let LocalDateTime(x1) = x;
        let d1 = Time.DayOfWeek.marshalDayOfWeek(d);
        let t1 = unsafe IO { d1.adjustInto(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)

    /// MonthDay methods

    pub def adjustMonthDay(md: MonthDay, x: LocalDateTime): LocalDateTime = 
        let LocalDateTime(x1) = x;
        let MonthDay(md1) = md;
        let t1 = unsafe IO { md1.adjustInto(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)
        


    // truncate functions

    pub def truncatedToDays(x: LocalDateTime): LocalDateTime = 
        let LocalDateTime(x1) = x;
        let u1 = unsafe IO { JChronoUnit.DAYS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        LocalDateTime(ans)

    // plus / minus functions

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusYears(years) };
        LocalDateTime(ans)

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusYears(years) };
        LocalDateTime(ans)

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusMonths(months) };
        LocalDateTime(ans)

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusMonths(months) };
        LocalDateTime(ans)

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusWeeks( weeks) };
        LocalDateTime(ans)

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusWeeks(weeks) };
        LocalDateTime(ans)

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusDays(days) };
        LocalDateTime(ans)

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusDays(days) };
        LocalDateTime(ans)

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusHours(hours) };
        LocalDateTime(ans)

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusHours(hours) };
        LocalDateTime(ans)

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusMinutes(minutes) };
        LocalDateTime(ans)

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusMinutes(minutes) };
        LocalDateTime(ans)

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusSeconds(seconds) };
        LocalDateTime(ans)

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusSeconds(seconds) };
        LocalDateTime(ans)

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.plusNanos(nanos) };
        LocalDateTime(ans)

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { x1.minusNanos(nanos) };
        LocalDateTime(ans)


    pub def plusPeriod(x: LocalDateTime, p: Period): LocalDateTime =
        let LocalDateTime(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe IO { p1.addTo(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)
    
    pub def minusPeriod(x: LocalDateTime, p: Period): LocalDateTime =
        let LocalDateTime(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe IO { p1.subtractFrom(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)


    pub def plusDuration(x: LocalDateTime, d: DurationZ): LocalDateTime =
        let LocalDateTime(x1) = x;
        let DurationZ(d1) = d;
        let t1 = unsafe IO { d1.addTo(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)
    
    pub def minusDuration(x: LocalDateTime, d: DurationZ): LocalDateTime =
        let LocalDateTime(x1) = x;
        let DurationZ(d1) = d;
        let t1 = unsafe IO { d1.subtractFrom(x1) };
        let ans = unchecked_cast(t1 as JLocalDateTime);
        LocalDateTime(ans)


    // between / until functions

    pub def between(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): DurationZ =
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let ans = unsafe IO { JDuration.between(b1, e1) };
        DurationZ(ans)

    pub def secondsUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.SECONDS };
        unsafe IO { b1.until(e1, cu1) }

    pub def minutesUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.MINUTES };
        unsafe IO { b1.until(e1, cu1) }

    pub def hoursUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.HOURS };
        unsafe IO { b1.until(e1, cu1) }

    pub def halfDaysUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.HALF_DAYS };
        unsafe IO { b1.until(e1, cu1) }

    pub def daysUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.DAYS };
        unsafe IO { b1.until(e1, cu1) }

    pub def monthsUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.MONTHS };
        unsafe IO { b1.until(e1, cu1) }

    pub def yearsUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.YEARS };
        unsafe IO { b1.until(e1, cu1) }

    pub def quarterYearsUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        let LocalDateTime(b1) = begin#begin;
        let LocalDateTime(e1) = end#end;
        let cu1 = unsafe IO { JIsoFields.QUARTER_YEARS };
        unsafe IO { b1.until(e1, cu1) }

}
