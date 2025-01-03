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
    
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}

    import java.time.{OffsetDateTime => JOffsetDateTime}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around a Java OffsetDateTime.
    ///
    pub enum OffsetDateTime(JOffsetDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[OffsetDateTime] {
        pub def toString(x: OffsetDateTime): String =
            let OffsetDateTime(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetDateTime] {
        pub def fromString(s: String): Option[OffsetDateTime] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let ans = unsafe JOffsetDateTime.parse(s1);
                OffsetDateTime(ans)
            }) |> Result.toOption
    }

    instance Eq[OffsetDateTime] {
        pub def eq(x: OffsetDateTime, y: OffsetDateTime): Bool =
            let OffsetDateTime(x1) = x;
            let OffsetDateTime(y1) = y;
            unsafe x1.equals(y1)

    }

    instance Hash[OffsetDateTime] {
        pub def hash(x: OffsetDateTime): Int32 =
            let OffsetDateTime(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[OffsetDateTime] {
        pub def compare(x: OffsetDateTime, y: OffsetDateTime): Comparison =
            let OffsetDateTime(x1) = x;
            let OffsetDateTime(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }

}

mod Time.OffsetDateTime {

    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.Format.DateTimeFormat
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.DayOfWeek
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.Month
    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time.Period
    use Time.Period.{Period}
    use Time.YearMonth
    use Time.YearMonth.{YearMonth}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.{LocalDate => JLocalDate}
    import java.time.{LocalDateTime => JLocalDateTime}
    import java.time.{LocalTime => JLocalTime}
    import java.time.{MonthDay => JMonthDay}
    import java.time.{OffsetDateTime => JOffsetDateTime}
    import java.time.{YearMonth => JYearMonth}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{IsoFields => JIsoFields}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}

    /// Unwrap

    pub def getOffsetDateTime(x: OffsetDateTime): JOffsetDateTime = 
        let OffsetDateTime(x1) = x;
        x1


    /// Constructors

    pub def offsetDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, minute = Int32,
                    second = Int32, nanoSecond = Int32, offset = ZoneOffset}): OffsetDateTime =
        let ZoneOffset(o1) = r#offset;
        let ans = unsafe JOffsetDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second, r#nanoSecond, o1);
        OffsetDateTime(ans)


    /// `now` functions

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): OffsetDateTime \ IO = OffsetDateTime(JOffsetDateTime.now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetDateTime \ IO =
        let ZoneId(z1) = zone;
        let ans = JOffsetDateTime.now(z1);
        OffsetDateTime(ans)

    /// `at` functions

    pub def atZoneSameInstant(zone: {zone = ZoneId}, x: OffsetDateTime): ZonedDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone#zone;
        let ans = unsafe x1.atZoneSameInstant(z1);
        ZonedDateTime(ans)

    pub def atZoneSimilarLocal(zone: {zone = ZoneId}, x: OffsetDateTime): ZonedDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone#zone;
        let ans = unsafe x1.atZoneSimilarLocal(z1);
        ZonedDateTime(ans)


    pub def fromLocalDateTime(offset: {offset = ZoneOffset}, dateTime: LocalDateTime): OffsetDateTime =
        let LocalDateTime(dt1) = dateTime;
        let ZoneOffset(o1) = offset#offset;
        let ans = unsafe JOffsetDateTime.of(dt1, o1);
        OffsetDateTime(ans)


    /// `from` functions

    pub def fromLocalDateLocalTime(offset: {offset = ZoneOffset}, date: LocalDate, time: LocalTime): OffsetDateTime =
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneOffset(o1) = offset#offset;
        let ans = unsafe JOffsetDateTime.of(d1, t1, o1);
        OffsetDateTime(ans)

    /// `fromTemporalAccessor` specialized

    pub def fromZonedDateTime(x: ZonedDateTime): OffsetDateTime = 
        let ZonedDateTime(x1) = x;
        let ans = unsafe JOffsetDateTime.from(x1);
        OffsetDateTime(ans)

    /// `to` functions


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.toLocalDate();
        LocalDate(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.toLocalTime();
        LocalTime(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.toLocalDateTime();
        LocalDateTime(ans)


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.toOffsetTime();
        OffsetTime(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.toZonedDateTime();
        ZonedDateTime(ans)


    pub def toInstant(x: OffsetDateTime): InstantZ =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.toInstant();
        InstantZ(ans)

    pub def toEpochSecond(x: OffsetDateTime): Int64 =
        let OffsetDateTime(x1) = x;
        unsafe x1.toEpochSecond()

    /// `parse` / `format` functions
    
    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Result[String, OffsetDateTime] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let ans = unsafe JOffsetDateTime.parse(s1, fmtr);
            OffsetDateTime(ans)
        })


    ///
    /// Returns OffsetDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: OffsetDateTime): String =
        let OffsetDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)

    // predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetDateTime, y: OffsetDateTime): Bool =
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetDateTime, y: OffsetDateTime): Bool =
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        unsafe x1.isAfter(y1)


    pub def isInstantEqual(x: OffsetDateTime, y: OffsetDateTime): Bool =
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        unsafe x1.isEqual(y1)


    pub def isAmOfDay(x: OffsetDateTime): Bool = 
        let OffsetDateTime(x1) = x;
        let tf1 = unsafe JChronoField.AMPM_OF_DAY;
        unsafe x1.get(tf1) == 0


    pub def isPmOfDay(x: OffsetDateTime): Bool = 
        let OffsetDateTime(x1) = x;
        let tf1 = unsafe JChronoField.AMPM_OF_DAY;
        unsafe x1.get(tf1) == 1


    /// OffsetDateTime functions

    // pub def timeLineOrder(x: OffsetDateTime, y: OffsetDateTime): Comparison =
    //     import static java.time.OffsetDateTime.timeLineOrder(): ##java.util.Comparator \ {};
    //     import java.util.Comparator.compare(##java.lang.Object, ##java.lang.Object): Int32 \ {};
    //     let OffsetDateTime(x1) = x;
    //     let OffsetDateTime(y1) = y;
    //     let cmp = timeLineOrder();
    //     compare(cmp, checked_cast(x1), checked_cast(y1)) |> Comparison.fromInt32

    /// Getters and Setters
    /// Get / Set...

    pub def getOffset(x: OffsetDateTime): ZoneOffset =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.getOffset();
        ZoneOffset(ans)

    pub def withOffsetSameInstant(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        let ans = unsafe x1.withOffsetSameInstant(o1);
        OffsetDateTime(ans)

    pub def withOffsetSameLocal(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        let ans = unsafe x1.withOffsetSameLocal(o1);
        OffsetDateTime(ans)


    pub def getNano(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getNano()

    pub def withNano(nano: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withNano(nano);
        OffsetDateTime(ans)

    pub def getSecond(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getSecond()

    pub def withSecond(second: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withSecond(second);
        OffsetDateTime(ans)


    pub def getMinute(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getMinute()

    pub def withMinute(minute: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withMinute(minute);
        OffsetDateTime(ans)


    pub def getHour(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getHour()

    pub def withHour(hour: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withHour(hour);
        OffsetDateTime(ans)


    pub def getDayOfWeek(x: OffsetDateTime): DayOfWeek =
        let OffsetDateTime(x1) = x;
        let d1 = unsafe x1.getDayOfWeek();
        Time.DayOfWeek.unmarshalDayOfWeek(d1)


    pub def adjustDayOfWeek(d: DayOfWeek, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let d1 = Time.DayOfWeek.marshalDayOfWeek(d);
        let t1 = unsafe d1.adjustInto(x1);
        let ans = unchecked_cast(t1 as JOffsetDateTime);
        OffsetDateTime(ans)


    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getDayOfMonth()

    pub def withDayOfMonth(dayOfMonth: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withDayOfMonth(dayOfMonth);
        OffsetDateTime(ans)


    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getDayOfYear()

    pub def withDayOfYear(dayOfYear: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withDayOfYear(dayOfYear);
        OffsetDateTime(ans)

    pub def getMonth(x: OffsetDateTime): Month =
        let OffsetDateTime(x1) = x;
        let m1 = unsafe x1.getMonth();
        Time.Month.unmarshalMonth(m1)

    pub def getMonthValue(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        let m1 = unsafe x1.getMonth();
        unsafe m1.getValue()

    pub def withMonth(month: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withMonth(month);
        OffsetDateTime(ans)

    pub def getYear(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getYear()

    pub def withYear(year: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.withYear(year);
        OffsetDateTime(ans)

    // MonthDay methods

    pub def getMonthDay(x: OffsetDateTime): MonthDay = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JMonthDay.from(x1);
        MonthDay(ans)

    pub def adjustMonthDay(md: MonthDay, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let MonthDay(md1) = md;
        let dt1 = unsafe md1.adjustInto(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)

    // YearMonth methods

    pub def getYearMonth(x: OffsetDateTime): YearMonth = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JYearMonth.from(x1);
        YearMonth(ans)


    pub def adjustYearMonth(ym: YearMonth, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let YearMonth(ym1) = ym;
        let dt1 = unsafe ym1.adjustInto(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)


    // LocalDate methods

    pub def getLocalDate(x: OffsetDateTime): LocalDate = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JLocalDate.from(x1);
        LocalDate(ans)

    pub def adjustLocalDate(d: LocalDate, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let LocalDate(d1) = d;
        let dt1 = unsafe d1.adjustInto(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)

    // LocalDateTime methods

    pub def getLocalDateTime(x: OffsetDateTime): LocalDateTime = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JLocalDateTime.from(x1);
        LocalDateTime(ans)

    pub def adjustLocalDateTime(ldt: LocalDateTime, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let LocalDateTime(ldt1) = ldt;
        let dt1 = unsafe ldt1.adjustInto(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)


    /// LocalTime methods

    pub def getLocalTime(x: OffsetDateTime): LocalTime = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JLocalTime.from(x1);
        LocalTime(ans)


    pub def adjustLocalTime(lt: LocalTime, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let LocalTime(lt1) = lt;
        let dt1 = unsafe lt1.adjustInto(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)
        

    pub def getEpochDay(x: OffsetDateTime): Int64 = 
        let OffsetDateTime(x1) = x;
        let f1 = unsafe JChronoField.EPOCH_DAY;
        unsafe x1.getLong(f1)

    /// ZoneOffset methods

    pub def adjustZoneOffset(zo: ZoneOffset, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let ZoneOffset(zo1) = zo;
        let dt1 = unsafe zo1.adjustInto(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)

    // truncate functions

    pub def truncatedToDays(x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let u1 = unsafe JChronoUnit.DAYS;
        let ans = unsafe x1.truncatedTo(u1);
        OffsetDateTime(ans)

    // plus / minus functions

    pub def plusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusYears(years);
        OffsetDateTime(ans)

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusYears(years);
        OffsetDateTime(ans)

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusMonths(months);
        OffsetDateTime(ans)

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusMonths(months);
        OffsetDateTime(ans)

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusWeeks(weeks);
        OffsetDateTime(ans)

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusWeeks(weeks);
        OffsetDateTime(ans)

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusDays(days);
        OffsetDateTime(ans)

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusDays(days);
        OffsetDateTime(ans)

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusHours(hours);
        OffsetDateTime(ans)

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusHours(hours);
        OffsetDateTime(ans)

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusMinutes(minutes);
        OffsetDateTime(ans)

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusMinutes(minutes);
        OffsetDateTime(ans)

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusSeconds(seconds);
        OffsetDateTime(ans)

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusSeconds(seconds);
        OffsetDateTime(ans)

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.plusNanos(nanos);
        OffsetDateTime(ans)

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ans = unsafe x1.minusNanos(nanos);
        OffsetDateTime(ans)


    pub def plusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let DurationZ(d1) = d;
        let dt1 = unsafe d1.addTo(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)
    
    pub def minusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let DurationZ(d1) = d;
        let dt1 = unsafe d1.subtractFrom(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)

    // Period methods

    pub def plusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let Period(p1) = p;
        let dt1 = unsafe p1.addTo(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)

    pub def minusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let Period(p1) = p;
        let dt1 = unsafe p1.subtractFrom(x1);
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        OffsetDateTime(ans)


    // between / until functions

    pub def between(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): DurationZ =
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let ans = unsafe JDuration.between(b1, e1);
        DurationZ(ans)
        

    pub def secondsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.SECONDS;
        unsafe b1.until(e1, cu1)

    pub def minutesUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.MINUTES;
        unsafe b1.until(e1, cu1)

    pub def hoursUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.HOURS;
        unsafe b1.until(e1, cu1)

    pub def halfDaysUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.HALF_DAYS;
        unsafe b1.until(e1, cu1)

    pub def daysUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.DAYS;
        unsafe b1.until(e1, cu1)

    pub def monthsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.MONTHS;
        unsafe b1.until(e1, cu1)

    pub def yearsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JChronoUnit.YEARS;
        unsafe b1.until(e1, cu1)

    pub def quarterYearsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let cu1 = unsafe JIsoFields.QUARTER_YEARS;
        unsafe b1.until(e1, cu1)

}
