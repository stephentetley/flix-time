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

    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}

    import java.time.{ZonedDateTime => JZonedDateTime}
    import java.time.chrono.{ChronoZonedDateTime}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around a Java ZonedDateTime.
    ///
    pub enum ZonedDateTime(JZonedDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[ZonedDateTime] {
        pub def toString(x: ZonedDateTime): String =
            let ZonedDateTime(x1) = x;
            unsafe IO { x1.toString() }
   }

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[ZonedDateTime] {
        pub def fromString(s: String): Option[ZonedDateTime] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let ans = unsafe IO { JZonedDateTime.parse(s1) };
                ZonedDateTime(ans)
           }) |> Result.toOption
   }

    instance Eq[ZonedDateTime] {
        pub def eq(x: ZonedDateTime, y: ZonedDateTime): Bool =
            let ZonedDateTime(x1) = x;
            let ZonedDateTime(y1) = y;
            unsafe IO { x1.equals(y1) }
   }

    instance Hash[ZonedDateTime] {
        pub def hash(x: ZonedDateTime): Int32 =
            let ZonedDateTime(x1) = x;
            unsafe IO { x1.hashCode() }
   }

    instance Order[ZonedDateTime] {
        pub def compare(x: ZonedDateTime, y: ZonedDateTime): Comparison =
            let ZonedDateTime(x1) = x;
            let ZonedDateTime(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
   }


}

mod Time.ZonedDateTime {

    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime }
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter }
    use Time.Format.DateTimeFormat
    use Time.DayOfWeek
    use Time.DurationZ
    use Time.DurationZ.{DurationZ }
    use Time.LocalDate
    use Time.LocalDate.{LocalDate }
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime }
    use Time.LocalTime
    use Time.LocalTime.{LocalTime }
    use Time.Month
    use Time.MonthDay
    use Time.MonthDay.{MonthDay }
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime }
    use Time.Period
    use Time.Period.{Period }
    use Time.YearMonth
    use Time.YearMonth.{YearMonth }
    use Time.ZoneId
    use Time.ZoneId.{ZoneId }
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset }

    import java.lang.{CharSequence }
    import java.time.{Duration => JDuration }
    import java.time.{ZonedDateTime => JZonedDateTime }
    import java.time.{LocalDateTime => JLocalDateTime, LocalDate => JLocalDate }
    import java.time.chrono.{ChronoZonedDateTime, ChronoLocalDate, ChronoLocalDateTime }
    import java.time.temporal.{ChronoUnit => JChronoUnit }
    import java.time.temporal.{IsoFields => JIsoFields } 
    import java.time.temporal.{Temporal => JTemporal }
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor }

    /// Unwrap

    pub def getZonedDateTime(x: ZonedDateTime): JZonedDateTime = 
        let ZonedDateTime(x1) = x;
        x1


    /// Constructors

    pub def zonedDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, 
                            minute = Int32, second = Int32, nanoSecond = Int32, zoneId = ZoneId }): ZonedDateTime =
        ZonedDateTime(unsafe IO { JZonedDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second, r#nanoSecond, Time.ZoneId.getZoneId(r#zoneId)) }) 


    /// `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): ZonedDateTime \ IO = ZonedDateTime(JZonedDateTime.now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): ZonedDateTime \ IO =
        let ZoneId(z1) = zone;
        let ans = JZonedDateTime.now(z1);
        ZonedDateTime(ans)

    /// `from` functions

    pub def fromLocalDateTime(zone: {zone = ZoneId }, dateTime: LocalDateTime): ZonedDateTime =
        let LocalDateTime(dt1) = dateTime;
        let ZoneId(z1) = zone#zone;
        let ans = unsafe IO { JZonedDateTime.of(dt1, z1) };
        ZonedDateTime(ans)


    pub def fromLocalDateLocalTime(zone: {zone = ZoneId }, date: LocalDate, time: LocalTime): ZonedDateTime =
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneId(z1) = zone#zone;
        let ans = unsafe IO { JZonedDateTime.of(d1, t1, z1) };
        ZonedDateTime(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): ZonedDateTime = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe IO { JZonedDateTime.$from(x1) };
        ZonedDateTime(ans)


    /// `to` functions

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: ZonedDateTime): LocalDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.toLocalDateTime() };
        LocalDateTime(ans)
        


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: ZonedDateTime): LocalDate =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.toLocalDate() };
        LocalDate(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: ZonedDateTime): LocalTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.toLocalTime() };
        LocalTime(ans)

    /// `parse` / `format` functions

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(_)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Result[String, ZonedDateTime] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let ans = unsafe IO { JZonedDateTime.parse(s1, fmtr) };
            ZonedDateTime(ans)
       })

    ///
    /// Returns ZonedDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: ZonedDateTime): String =
        let ZonedDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe IO { x1.format(fmtr) }

    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: ZonedDateTime, y: ZonedDateTime): Bool =
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        unsafe IO { x1.isBefore(y1) }

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: ZonedDateTime, y: ZonedDateTime): Bool =
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        unsafe IO { x1.isAfter(y1) }

    /// Getters and Setters

    pub def getYear(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe IO { x1.getYear() }

    pub def withYear(year: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withYear(year) };
        ZonedDateTime(ans)

    pub def getMonth(x: ZonedDateTime): Month =
        let ZonedDateTime(x1) = x;
        let m1 = unsafe IO { x1.getMonth() };
        Time.Month.unmarshalMonth(m1)

    pub def withMonth(month: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withMonth(month) };
        ZonedDateTime(ans)


    pub def getMonthValue(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        let m1 = unsafe IO { x1.getMonth() };
        unsafe IO { m1.getValue() }


    pub def getDayOfYear(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe IO { x1.getDayOfYear() }

    pub def withDayOfYear(dayOfYear: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withDayOfYear(dayOfYear) };
        ZonedDateTime(ans)

    pub def getDayOfMonth(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe IO { x1.getDayOfMonth() }

    pub def withDayOfMonth(dayOfMonth: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withDayOfMonth(dayOfMonth) };
        ZonedDateTime(ans)

    pub def getDayOfWeek(x: ZonedDateTime): DayOfWeek =
        let ZonedDateTime(x1) = x;
        let d1 = unsafe IO { x1.getDayOfWeek() };
        Time.DayOfWeek.unmarshalDayOfWeek(d1)

    // no setDayOfWeek

    pub def getHour(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe IO { x1.getHour() }

    pub def withHour(hour: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withHour(hour) };
        ZonedDateTime(ans)

    pub def getMinute(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe IO { x1.getMinute() }

    pub def withMinute(minute: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withMinute(minute) };
        ZonedDateTime(ans)

    pub def getSecond(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe IO { x1.getSecond() }

    pub def withSecond(second: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withSecond(second) };
        ZonedDateTime(ans)

    pub def getNano(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe IO { x1.getNano() }

    pub def withNano(nano: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withNano(nano) };
        ZonedDateTime(ans)

    pub def withZoneSameInstant(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ZoneId(zone1) = zone;
        let dt1 = unsafe IO { x1.$withZoneSameInstant(zone1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    pub def withZoneSameLocal(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ZoneId(zone1) = zone;
        let dt1 = unsafe IO { x1.$withZoneSameLocal(zone1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)


    pub def withFixedOffsetZone(x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.$withFixedOffsetZone() };
        ZonedDateTime(ans)

    pub def withEarlierOffsetAtOverlap(x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let dt1 = unsafe IO { x1.$withEarlierOffsetAtOverlap() };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    pub def withLaterOffsetAtOverlap(x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let dt1 = unsafe IO { x1.$withLaterOffsetAtOverlap() };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // DayOfWeek methods

    pub def adjustDayOfWeek(d: DayOfWeek, x: ZonedDateTime): ZonedDateTime =  
        let ZonedDateTime(x1) = x;
        let d1 = Time.DayOfWeek.marshalDayOfWeek(d);
        let dt1 = unsafe IO { d1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // MonthDay methods

    pub def adjustMonthDay(md: MonthDay, x: ZonedDateTime): ZonedDateTime =  
        let ZonedDateTime(x1) = x;
        let MonthDay(md1) = md;
        let dt1 = unsafe IO { md1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // ZoneOffset methods

    pub def adjustZoneOffset(zo: ZoneOffset, x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let ZoneOffset(zo1) = zo;
        let dt1 = unsafe IO { zo1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)


    // YearMonth methods

    pub def adjustYearMonth(ym: YearMonth, x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let YearMonth(ym1) = ym;
        let dt1 = unsafe IO { ym1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // LocalDate methods

    pub def adjustLocalDate(ld: LocalDate, x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let LocalDate(ld1) = ld;
        let dt1 = unsafe IO { ld1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // LocalDateTime methods

    pub def adjustLocalDateTime(ldt: LocalDateTime, x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let LocalDateTime(ldt1) = ldt;
        let dt1 = unsafe IO { ldt1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // LocalTime methods

    pub def adjustLocalTime(lt: LocalTime, x: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        let LocalTime(lt1) = lt;
        let dt1 = unsafe IO { lt1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // plus / minus functions

    pub def plusYears(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusYears(i) };
        ZonedDateTime(ans)

    pub def minusYears(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusYears(i) };
        ZonedDateTime(ans)

    pub def plusMonths(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusMonths(i) };
        ZonedDateTime(ans)

    pub def minusMonths(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusMonths(i) };
        ZonedDateTime(ans)

    pub def plusWeeks(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusWeeks(i) };
        ZonedDateTime(ans)

    pub def minusWeeks(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusWeeks(i) };
        ZonedDateTime(ans)

    pub def plusDays(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusDays(i) };
        ZonedDateTime(ans)

    pub def minusDays(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusDays(i) };
        ZonedDateTime(ans)

    pub def plusHours(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusHours(i) };
        ZonedDateTime(ans)

    pub def minusHours(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusHours(i) };
        ZonedDateTime(ans)

    pub def plusMinutes(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusMinutes(i) };
        ZonedDateTime(ans)

    pub def minusMinutes(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusMinutes(i) };
        ZonedDateTime(ans)

    pub def plusSeconds(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusSeconds(i) };
        ZonedDateTime(ans)

    pub def minusSeconds(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusSeconds(i) };
        ZonedDateTime(ans)

    pub def plusNanos(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.plusNanos(i) };
        ZonedDateTime(ans)

    pub def minusNanos(x: ZonedDateTime, i: Int64): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.minusNanos(i) };
        ZonedDateTime(ans)

    pub def plusDuration(x: ZonedDateTime, d: DurationZ): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let DurationZ(d1) = d;
        let dt1 = unsafe IO { d1.addTo(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)
    
    pub def minusDuration(x: ZonedDateTime, d: DurationZ): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let DurationZ(d1) = d;
        let dt1 = unsafe IO { d1.subtractFrom(x1) };
        let ans = unchecked_cast(dt1 as JZonedDateTime);
        ZonedDateTime(ans)

    // Period methods

    pub def plusPeriod(x: ZonedDateTime, p: Period): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe IO { p1.addTo(x1) };
        let ans = unchecked_cast(t1 as JZonedDateTime);
        ZonedDateTime(ans)
    
    pub def minusPeriod(x: ZonedDateTime, p: Period): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe IO { p1.subtractFrom(x1) };
        let ans = unchecked_cast(t1 as JZonedDateTime);
        ZonedDateTime(ans)



    // between / until functions 


    pub def between(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): DurationZ =
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let ans = unsafe IO { JDuration.between(b1, e1) };
        DurationZ(ans)


    // `until` specialized

    pub def secondsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.SECONDS };
        unsafe IO { b1.until(e1, cu1) }

    pub def minutesUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.MINUTES };
        unsafe IO { b1.until(e1, cu1) }

    pub def hoursUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.HOURS };
        unsafe IO { b1.until(e1, cu1) }

    pub def halfDaysUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.HALF_DAYS };
        unsafe IO { b1.until(e1, cu1) }

    pub def daysUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.DAYS };
        unsafe IO { b1.until(e1, cu1) }

    pub def monthsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.MONTHS };
        unsafe IO { b1.until(e1, cu1) }

    pub def yearsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JChronoUnit.YEARS };
        unsafe IO { b1.until(e1, cu1) }

    pub def quarterYearsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        let ZonedDateTime(b1) = begin#begin;
        let ZonedDateTime(e1) = end#end;
        let cu1 = unsafe IO { JIsoFields.QUARTER_YEARS };
        unsafe IO { b1.until(e1, cu1) }

}
