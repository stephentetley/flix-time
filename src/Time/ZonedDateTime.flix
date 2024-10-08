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
            unsafe x1.toString()
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
                let cs  = (checked_cast(s1) : CharSequence);
                ZonedDateTime(unsafe JZonedDateTime.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[ZonedDateTime] {
        pub def eq(x: ZonedDateTime, y: ZonedDateTime): Bool =
            let ZonedDateTime(x1) = x;
            let ZonedDateTime(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }

    instance Hash[ZonedDateTime] {
        pub def hash(x: ZonedDateTime): Int32 =
            let ZonedDateTime(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[ZonedDateTime] {
        pub def compare(x: ZonedDateTime, y: ZonedDateTime): Comparison =
            // Have to use ChronoZonedDateTime...
            let ZonedDateTime(x1) = x;
            let ZonedDateTime(y1) = y;
            let cx1 = (checked_cast(x1) : ChronoZonedDateTime);
            let cy1 = (checked_cast(y1) : ChronoZonedDateTime);
            unsafe cx1.compareTo(cy1) |> Comparison.fromInt32
    }


}

mod Time.ZonedDateTime {

    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Format.DateTimeFormat
    use Time.DayOfWeek
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.Month
    use Time.MonthDay
    use Time.OffsetDateTime
    use Time.Period
    use Time.YearMonth
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZoneOffset
    import java.time.{ZonedDateTime => JZonedDateTime}
    import java.time.{LocalDateTime => JLocalDateTime, LocalDate => JLocalDate}
    import java.time.chrono.{ChronoZonedDateTime, ChronoLocalDate, ChronoLocalDateTime}
    import java.lang.{CharSequence}

    /// Unwrap

    pub def getZonedDateTime(x: ZonedDateTime): JZonedDateTime = 
        let ZonedDateTime(x1) = x;
        x1

    // pub def asTemporalAccessor(x: ZonedDateTime): TemporalAccessor =
    //     let ZonedDateTime(x1) = x;
    //     TemporalAccessor(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor))

    /// Constructors

    pub def zonedDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, 
                            minute = Int32, second = Int32, nanoSecond = Int32, zoneId = ZoneId}): ZonedDateTime =
        ZonedDateTime(unsafe JZonedDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second, r#nanoSecond, Time.ZoneId.getZoneId(r#zoneId)))


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
        ZonedDateTime(JZonedDateTime.now(z1))

    /// `from` functions

    pub def fromLocalDateTime(zone: {zone = ZoneId},dateTime: LocalDateTime): ZonedDateTime =
        let LocalDateTime(dt1) = dateTime;
        let ZoneId(z1) = zone#zone;
        ZonedDateTime(unsafe JZonedDateTime.of(dt1, z1))


    pub def fromLocalDateLocalTime(zone: {zone = ZoneId}, date: LocalDate, time: LocalTime): ZonedDateTime =
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneId(z1) = zone#zone;
        ZonedDateTime(unsafe JZonedDateTime.of(d1, t1, z1))

    // pub def fromOffsetDateTime(x: OffsetDateTime): ZonedDateTime = 
    //     fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))


    /// `to` functions

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: ZonedDateTime): LocalDateTime =
        let ZonedDateTime(x1) = x;
        let cx1 : ChronoZonedDateTime = (checked_cast(x1) : ChronoZonedDateTime);
        let ans : ChronoLocalDateTime = unsafe cx1.toLocalDateTime();
        let ans1 : JLocalDateTime = unchecked_cast(ans as JLocalDateTime);
        LocalDateTime(ans1)
        


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: ZonedDateTime): LocalDate =
        let ZonedDateTime(x1) = x;
        let cx1 : ChronoZonedDateTime = (checked_cast(x1) : ChronoZonedDateTime);
        let ans : ChronoLocalDate = unsafe cx1.toLocalDate();
        let ans1 : JLocalDate = unchecked_cast(ans as JLocalDate);
        LocalDate(ans1)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: ZonedDateTime): LocalTime =
        let ZonedDateTime(x1) = x;
        LocalTime(unsafe x1.toLocalTime())

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
            let cs  = (checked_cast(s1) : CharSequence);
            ZonedDateTime(unsafe JZonedDateTime.parse(cs, fmtr))
        })

    ///
    /// Returns ZonedDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: ZonedDateTime): String =
        let ZonedDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)

    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: ZonedDateTime, y: ZonedDateTime): Bool =
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = (checked_cast(x1) : ChronoZonedDateTime);
        let cy1 = (checked_cast(y1) : ChronoZonedDateTime);
        unsafe cx1.isBefore(cy1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: ZonedDateTime, y: ZonedDateTime): Bool =
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = (checked_cast(x1) : ChronoZonedDateTime);
        let cy1 = (checked_cast(y1) : ChronoZonedDateTime);
        unsafe cx1.isAfter(cy1)

    /// Getters and Setters

    pub def getYear(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe x1.getYear()

    pub def withYear(year: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withYear(year))

    pub def getMonth(x: ZonedDateTime): Month =
        let ZonedDateTime(x1) = x;
        Time.Month.unmarshalMonth(unsafe x1.getMonth())

    pub def withMonth(month: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withMonth(month))


    pub def getMonthValue(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        let mon = unsafe x1.getMonth();
        unsafe mon.getValue()


    pub def getDayOfYear(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe x1.getDayOfYear()

    pub def withDayOfYear(dayOfYear: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withDayOfYear(dayOfYear))

    pub def getDayOfMonth(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe x1.getDayOfMonth()

    pub def withDayOfMonth(dayOfMonth: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withDayOfMonth(dayOfMonth))

    pub def getDayOfWeek(x: ZonedDateTime): DayOfWeek =
        let ZonedDateTime(x1) = x;
        Time.DayOfWeek.unmarshalDayOfWeek(unsafe x1.getDayOfWeek())

    // no setDayOfWeek

    pub def getHour(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe x1.getHour()

    pub def withHour(hour: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withHour(hour))

    pub def getMinute(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe x1.getMinute()

    pub def withMinute(minute: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withMinute(minute))

    pub def getSecond(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe x1.getSecond()

    pub def withSecond(second: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withSecond(second))

    pub def getNano(x: ZonedDateTime): Int32 =
        let ZonedDateTime(x1) = x;
        unsafe x1.getNano()

    pub def withNano(nano: Int32, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        ZonedDateTime(unsafe x1.withNano(nano))

    pub def withZoneSameInstant(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ZoneId(zone1) = zone;
        let cx1 = (checked_cast(x1) : ChronoZonedDateTime);
        let ans = unsafe cx1.withZoneSameInstant(zone1);
        let ans1 : JZonedDateTime = unchecked_cast(ans as JZonedDateTime);
        ZonedDateTime(ans1)

    pub def withZoneSameLocal(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        let ZonedDateTime(x1) = x;
        let ZoneId(zone1) = zone;
        let cx1 = (checked_cast(x1) : ChronoZonedDateTime);
        let ans = unsafe cx1.withZoneSameLocal(zone1);
        let ans1 : JZonedDateTime = unchecked_cast(ans as JZonedDateTime);
        ZonedDateTime(ans1)


    pub def withFixedOffsetZone(t: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(t1) = t;
        ZonedDateTime(unsafe t1.withFixedOffsetZone())

    pub def withEarlierOffsetAtOverlap(t: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(t1) = t;
        let ct1 = (checked_cast(t1) : ChronoZonedDateTime);
        let ans = unsafe ct1.withEarlierOffsetAtOverlap();
        let ans1 : JZonedDateTime = unchecked_cast(ans as JZonedDateTime);
        ZonedDateTime(ans1)

    pub def withLaterOffsetAtOverlap(t: ZonedDateTime): ZonedDateTime = 
        let ZonedDateTime(t1) = t;
        let ct1 = (checked_cast(t1) : ChronoZonedDateTime);
        let ans = unsafe ct1.withLaterOffsetAtOverlap();
        let ans1 : JZonedDateTime = unchecked_cast(ans as JZonedDateTime);
        ZonedDateTime(ans1)

    // DayOfWeek methods

    // pub def adjustDayOfWeek(x: DayOfWeek, d: ZonedDateTime): ZonedDateTime = 
    //     import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.DayOfWeek.marshalDayOfWeek(x);
    //     let d1 = unchecked_cast(getZonedDateTime(d) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.ZonedDateTime))

    // MonthDay methods

    // pub def adjustMonthDay(x: MonthDay, d: ZonedDateTime): ZonedDateTime = 
    //     import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.MonthDay.getMonthDay(x);
    //     let d1 = unchecked_cast(getZonedDateTime(d) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.ZonedDateTime))

    // ZoneOffset methods

    // pub def adjustZoneOffset(zo: ZoneOffset, dt: ZonedDateTime): ZonedDateTime = 
    //     import java.time.ZoneOffset.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let zo1 = Time.ZoneOffset.getZoneOffset(zo);
    //     let dt1 = unchecked_cast(getZonedDateTime(dt) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(adjustInto(zo1, dt1) as ##java.time.ZonedDateTime))

    // YearMonth methods

    // pub def adjustYearMonth(x: YearMonth, dt: ZonedDateTime): ZonedDateTime = 
    //     import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.YearMonth.getYearMonth(x);
    //     let dt1 = unchecked_cast(getZonedDateTime(dt) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.ZonedDateTime))

    // LocalDate methods

    // pub def adjustLocalDate(x: LocalDate, dt: ZonedDateTime): ZonedDateTime = 
    //     import java.time.LocalDate.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalDate.getLocalDate(x);
    //     let dt1 = unchecked_cast(getZonedDateTime(dt) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.ZonedDateTime))

    // LocalDateTime methods

    // pub def adjustLocalDateTime(x: LocalDateTime, dt: ZonedDateTime): ZonedDateTime = 
    //     import java.time.LocalDateTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalDateTime.getLocalDateTime(x);
    //     let dt1 = unchecked_cast(getZonedDateTime(dt) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.ZonedDateTime))

    // LocalTime methods

    // pub def adjustLocalTime(x: LocalTime, dt: ZonedDateTime): ZonedDateTime = 
    //     import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalTime.getLocalTime(x);
    //     let dt1 = unchecked_cast(getZonedDateTime(dt) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.ZonedDateTime))

    // plus / minus functions

    // pub def plusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusYears(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, years))

    // pub def minusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusYears(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, years))

    // pub def plusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusMonths(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, months))

    // pub def minusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusMonths(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, months))

    // pub def plusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusWeeks(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, weeks))

    // pub def minusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusWeeks(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, weeks))

    // pub def plusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusDays(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, days))

    // pub def minusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusDays(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, days))

    // pub def plusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusHours(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, hours))

    // pub def minusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusHours(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, hours))

    // pub def plusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusMinutes(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, minutes))

    // pub def minusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusMinutes(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, minutes))

    // pub def plusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusSeconds(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, seconds))

    // pub def minusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusSeconds(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, seconds))

    // pub def plusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.plusNanos(Int64): ##java.time.ZonedDateTime \ {} as plus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(plus(x1, nanos))

    // pub def minusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
    //     import java.time.ZonedDateTime.minusNanos(Int64): ##java.time.ZonedDateTime \ {} as minus;
    //     let ZonedDateTime(x1) = x;
    //     ZonedDateTime(minus(x1, nanos))

    // pub def plusDuration(i: ZonedDateTime, x: DurationZ): ZonedDateTime =
    //     import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let i1 = unchecked_cast(getZonedDateTime(i) as ##java.time.temporal.Temporal);
    //     let DurationZ(x1) = x;
    //     ZonedDateTime(unchecked_cast(addTo(x1, i1) as ##java.time.ZonedDateTime))
    
    // pub def minusDuration(i: ZonedDateTime, x: DurationZ): ZonedDateTime =
    //     import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let i1 = unchecked_cast(getZonedDateTime(i) as ##java.time.temporal.Temporal);
    //     let DurationZ(x1) = x;
    //     ZonedDateTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.ZonedDateTime))

    // Period methods

    // pub def plusPeriod(i: ZonedDateTime, x: Period): ZonedDateTime =
    //     import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.Period.getPeriod(x);
    //     let i1 = unchecked_cast(getZonedDateTime(i) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(addTo(x1, i1) as ##java.time.ZonedDateTime))
    
    // pub def minusPeriod(i: ZonedDateTime, x: Period): ZonedDateTime =
    //     import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.Period.getPeriod(x);
    //     let i1 = unchecked_cast(getZonedDateTime(i) as ##java.time.temporal.Temporal);
    //     ZonedDateTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.ZonedDateTime))



    // between / until functions 


    // pub def between(r: {start = ZonedDateTime, end = ZonedDateTime}): DurationZ =
    //     import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
    //     let s1 = unchecked_cast(getZonedDateTime(r#start) as ##java.time.temporal.Temporal);
    //     let e1 = unchecked_cast(getZonedDateTime(r#end) as ##java.time.temporal.Temporal);
    //     DurationZ(between(s1, e1))

    // `until` specialized

    // def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import java.time.ZonedDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
    //     let b1 = getZonedDateTime(r#start);
    //     let e1 = unchecked_cast(getZonedDateTime(r#end) as ##java.time.temporal.Temporal);
    //     until(b1, e1, u)

    // pub def secondsUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
    //     untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    // pub def minutesUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
    //     untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    // pub def hoursUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
    //     untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)

    // pub def halfDaysUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
    //     untilHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), r)

    // pub def daysUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
    //     untilHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), r)

    // pub def monthsUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
    //     untilHelper(unchecked_cast(get_MONTHS() as ##java.time.temporal.TemporalUnit), r)

    // pub def yearsUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
    //     untilHelper(unchecked_cast(get_YEARS() as ##java.time.temporal.TemporalUnit), r)

    // pub def quarterYearsUntil(r: {start = ZonedDateTime, end = ZonedDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.TemporalUnit \ {} as get_QUARTER_YEARS;
    //     untilHelper(get_QUARTER_YEARS(), r)


    // generic helper functions

    // def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): ZonedDateTime = 
    //     import static java.time.ZonedDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.ZonedDateTime \ {} as fromTA;
    //     try {
    //         ZonedDateTime(fromTA(x))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }


}
