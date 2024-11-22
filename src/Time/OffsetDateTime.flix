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
                let cs  = (checked_cast(s1) : CharSequence);
                OffsetDateTime(unsafe JOffsetDateTime.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[OffsetDateTime] {
        pub def eq(x: OffsetDateTime, y: OffsetDateTime): Bool =
            let OffsetDateTime(x1) = x;
            let OffsetDateTime(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)

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
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}
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

    import java.time.{Duration => JDuration}
    import java.time.{OffsetDateTime => JOffsetDateTime}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{IsoFields => JIsoFields}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.lang.{Object, CharSequence}

    /// Unwrap

    pub def getOffsetDateTime(x: OffsetDateTime): JOffsetDateTime = 
        let OffsetDateTime(x1) = x;
        x1

    pub def asTemporalAccessor(x: OffsetDateTime): TemporalAccessor =
        let OffsetDateTime(x1) = x;
        let cx1 = unchecked_cast(x1 as JTemporalAccessor);
        TemporalAccessor(cx1)

    /// Constructors

    pub def offsetDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, minute = Int32,
                    second = Int32, nanoSecond = Int32, offset = ZoneOffset}): OffsetDateTime =
        let ZoneOffset(o1) = r#offset;
        OffsetDateTime(unsafe JOffsetDateTime.of(r#year, r#month, r#dayOfMonth, r#hour, r#minute, r#second, r#nanoSecond, o1))


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
        OffsetDateTime(JOffsetDateTime.now(z1))

    /// `at` functions

    pub def atZoneSameInstant(zone: {zone = ZoneId}, x: OffsetDateTime): ZonedDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone#zone;
        ZonedDateTime(unsafe x1.atZoneSameInstant(z1))

    pub def atZoneSimilarLocal(zone: {zone = ZoneId}, x: OffsetDateTime): ZonedDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone#zone;
        ZonedDateTime(unsafe x1.atZoneSimilarLocal(z1))


    pub def fromLocalDateTime(offset: {offset = ZoneOffset}, dateTime: LocalDateTime): OffsetDateTime =
        let LocalDateTime(dt1) = dateTime;
        let ZoneOffset(o1) = offset#offset;
        OffsetDateTime(unsafe JOffsetDateTime.of(dt1, o1))


    /// `from` functions

    pub def fromLocalDateLocalTime(offset: {offset = ZoneOffset}, date: LocalDate, time: LocalTime): OffsetDateTime =
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneOffset(o1) = offset#offset;
        OffsetDateTime(unsafe JOffsetDateTime.of(d1, t1, o1))

    /// `fromTemporalAccessor` specialized

    // def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): OffsetDateTime = 
    //     import static java.time.OffsetDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetDateTime \ {} as fromTA;
    //     try {
    //         OffsetDateTime(fromTA(x))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }

    // pub def fromZonedDateTime(x: ZonedDateTime): OffsetDateTime = 
    //     let x1 = unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor);
    //     fromTemporalAccessorHelper(x1)

    /// `to` functions


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        let OffsetDateTime(x1) = x;
        LocalDate(unsafe x1.toLocalDate())

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        let OffsetDateTime(x1) = x;
        LocalTime(unsafe x1.toLocalTime())

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        let OffsetDateTime(x1) = x;
        LocalDateTime(unsafe x1.toLocalDateTime())


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        let OffsetDateTime(x1) = x;
        OffsetTime(unsafe x1.toOffsetTime())

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        let OffsetDateTime(x1) = x;
        ZonedDateTime(unsafe x1.toZonedDateTime())


    pub def toInstant(x: OffsetDateTime): InstantZ =
        let OffsetDateTime(x1) = x;
        InstantZ(unsafe x1.toInstant())

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
            let cs  = (checked_cast(s1) : CharSequence);
            OffsetDateTime(unsafe JOffsetDateTime.parse(cs, fmtr))
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


    // pub def isAmOfDay(x: OffsetDateTime): Bool = 
    //     import static java_get_field java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
    //     getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 0

    // pub def isPmOfDay(x: OffsetDateTime): Bool = 
    //     import static java_get_field java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
    //     getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 1

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
        ZoneOffset(unsafe x1.getOffset())

    pub def withOffsetSameInstant(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(unsafe x1.withOffsetSameInstant(o1))

    pub def withOffsetSameLocal(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(unsafe x1.withOffsetSameLocal(o1))


    pub def getNano(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getNano()

    pub def withNano(nano: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withNano(nano))

    pub def getSecond(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getSecond()

    pub def withSecond(second: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withSecond(second))


    pub def getMinute(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getMinute()

    pub def withMinute(minute: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withMinute(minute))


    pub def getHour(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getHour()

    pub def withHour(hour: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withHour(hour))


    pub def getDayOfWeek(x: OffsetDateTime): DayOfWeek =
        let OffsetDateTime(x1) = x;
        Time.DayOfWeek.unmarshalDayOfWeek(unsafe x1.getDayOfWeek())


    // pub def adjustDayOfWeek(x: DayOfWeek, d: OffsetDateTime): OffsetDateTime = 
    //     import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.DayOfWeek.marshalDayOfWeek(x);
    //     let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.OffsetDateTime))


    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getDayOfMonth()

    pub def withDayOfMonth(dayOfMonth: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withDayOfMonth(dayOfMonth))


    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getDayOfYear()

    pub def withDayOfYear(dayOfYear: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withDayOfYear(dayOfYear))

    pub def getMonth(x: OffsetDateTime): Month =
        let OffsetDateTime(x1) = x;
        Time.Month.unmarshalMonth(unsafe x1.getMonth())

    pub def getMonthValue(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        let m1 = unsafe x1.getMonth();
        unsafe m1.getValue()

    pub def withMonth(month: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withMonth(month))

    pub def getYear(x: OffsetDateTime): Int32 =
        let OffsetDateTime(x1) = x;
        unsafe x1.getYear()

    pub def withYear(year: Int32, x: OffsetDateTime): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.withYear(year))

    // MonthDay methods

    // pub def getMonthDay(d: OffsetDateTime): MonthDay = 
    //     import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
    //     let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
    //     MonthDay(fromTA(d1))

    // pub def adjustMonthDay(x: MonthDay, d: OffsetDateTime): OffsetDateTime = 
    //     import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.MonthDay.getMonthDay(x);
    //     let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.OffsetDateTime))

    // YearMonth methods

    // pub def getYearMonth(d: OffsetDateTime): YearMonth = 
    //     import static java.time.YearMonth.from(##java.time.temporal.TemporalAccessor): ##java.time.YearMonth \ {} as fromTA;
    //     let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
    //     YearMonth(fromTA(d1))

    // pub def adjustYearMonth(x: YearMonth, dt: OffsetDateTime): OffsetDateTime = 
    //     import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.YearMonth.getYearMonth(x);
    //     let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    // LocalDate methods

    // pub def getLocalDate(d: OffsetDateTime): LocalDate = 
    //     import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromTA;
    //     let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
    //     LocalDate(fromTA(d1))


    // pub def adjustLocalDate(x: LocalDate, dt: OffsetDateTime): OffsetDateTime = 
    //     import java.time.LocalDate.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalDate.getLocalDate(x);
    //     let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    // LocalDateTime methods

    // pub def getLocalDateTime(d: OffsetDateTime): LocalDateTime = 
    //     import static java.time.LocalDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDateTime \ {} as fromTA;
    //     let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
    //     LocalDateTime(fromTA(d1))

    // pub def adjustLocalDateTime(x: LocalDateTime, dt: OffsetDateTime): OffsetDateTime = 
    //     import java.time.LocalDateTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalDateTime.getLocalDateTime(x);
    //     let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    /// LocalTime methods

    // pub def getLocalTime(d: OffsetDateTime): LocalTime = 
    //     import static java.time.LocalTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalTime \ {} as fromTA;
    //     let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
    //     LocalTime(fromTA(d1))


    pub def adjustLocalTime(lt: LocalTime, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let LocalTime(lt1) = lt;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe lt1.adjustInto(t1);
        let ans = unchecked_cast(t2 as JOffsetDateTime);
        OffsetDateTime(ans)
        

    pub def getEpochDay(x: OffsetDateTime): Int64 = 
        let OffsetDateTime(x1) = x;
        let f1 = unsafe JChronoField.EPOCH_DAY;
        unsafe x1.getLong(f1)

    /// ZoneOffset methods

    pub def adjustZoneOffset(zo: ZoneOffset, x: OffsetDateTime): OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        let ZoneOffset(zo1) = zo;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe zo1.adjustInto(t1);
        let ans = unchecked_cast(t2 as JOffsetDateTime);
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
        OffsetDateTime(unsafe x1.plusYears(years))

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusYears(years))

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.plusMonths(months))

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusMonths(months))

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.plusWeeks(weeks))

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusWeeks(weeks))

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.plusDays(days))

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusDays(days))

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.plusHours(hours))

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusHours(hours))

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.plusMinutes(minutes))

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusMinutes(minutes))

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.plusSeconds(seconds))

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusSeconds(seconds))

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.plusNanos(nanos))

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        OffsetDateTime(unsafe x1.minusNanos(nanos))


    pub def plusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let DurationZ(d1) = d;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe d1.addTo(t1);
        let ans = unchecked_cast(t2 as JOffsetDateTime);
        OffsetDateTime(ans)
    
    pub def minusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let DurationZ(d1) = d;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe d1.subtractFrom(t1);
        let ans = unchecked_cast(t2 as JOffsetDateTime);
        OffsetDateTime(ans)

    // Period methods

    pub def plusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let Period(p1) = p;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe p1.addTo(t1);
        let ans = unchecked_cast(t2 as JOffsetDateTime);
        OffsetDateTime(ans)

    pub def minusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        let OffsetDateTime(x1) = x;
        let Period(p1) = p;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe p1.subtractFrom(t1);
        let ans = unchecked_cast(t2 as JOffsetDateTime);
        OffsetDateTime(ans)


    // between / until functions

    pub def between(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): DurationZ =
        let OffsetDateTime(b1) = begin#begin;
        let OffsetDateTime(e1) = end#end;
        let tb1: JTemporal = checked_cast(b1);
        let te1: JTemporal = checked_cast(e1);
        let ans = unsafe JDuration.between(tb1, te1);
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
