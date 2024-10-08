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
    use Time.YearMonth
    use Time.YearMonth.{YearMonth}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    import java.time.{OffsetDateTime => JOffsetDateTime}
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


    // pub def adjustLocalTime(x: LocalTime, dt: OffsetDateTime): OffsetDateTime = 
    //     import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalTime.getLocalTime(x);
    //     let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    // pub def getEpochDay(x: OffsetDateTime): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField \ {} as get_EPOCH_DAY;        
    //     getLongHelper(unchecked_cast(get_EPOCH_DAY() as ##java.time.temporal.TemporalField), x)

    /// ZoneOffset methods

    // pub def adjustZoneOffset(zo: ZoneOffset, dt: OffsetDateTime): OffsetDateTime = 
    //     import java.time.ZoneOffset.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let zo1 = Time.ZoneOffset.getZoneOffset(zo);
    //     let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(adjustInto(zo1, dt1) as ##java.time.OffsetDateTime))


    // truncate functions

    // def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: OffsetDateTime): OffsetDateTime = 
    //     import java.time.OffsetDateTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.OffsetDateTime \ {};
    //     let OffsetDateTime(x1) = x;
    //     OffsetDateTime(truncatedTo(x1, u))

    // pub def truncatedToDays(x: OffsetDateTime): OffsetDateTime = 
    //     import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
    //     truncatedToHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), x)

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


    // pub def plusDuration(i: OffsetDateTime, x: DurationZ): OffsetDateTime =
    //     import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let DurationZ(x1) = x;
    //     let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(addTo(x1, i1) as ##java.time.OffsetDateTime))
    
    // pub def minusDuration(i: OffsetDateTime, x: DurationZ): OffsetDateTime =
    //     import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let DurationZ(x1) = x;
    //     let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.OffsetDateTime))

    // Period methods

    // pub def plusPeriod(i: OffsetDateTime, x: Period): OffsetDateTime =
    //     import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.Period.getPeriod(x);
    //     let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(addTo(x1, i1) as ##java.time.OffsetDateTime))
    
    // pub def minusPeriod(i: OffsetDateTime, x: Period): OffsetDateTime =
    //     import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.Period.getPeriod(x);
    //     let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
    //     OffsetDateTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.OffsetDateTime))



    // between / until functions

    // pub def between(r: {start = OffsetDateTime, end = OffsetDateTime}): DurationZ =
    //     import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
    //     let s1 = unchecked_cast(getOffsetDateTime(r#start) as ##java.time.temporal.Temporal);
    //     let e1 = unchecked_cast(getOffsetDateTime(r#end) as ##java.time.temporal.Temporal);
    //     DurationZ(between(s1, e1))


    // def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import java.time.OffsetDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
    //     let b1 = getOffsetDateTime(r#start);
    //     let e1 = unchecked_cast(getOffsetDateTime(r#end) as ##java.time.temporal.Temporal);
    //     until(b1, e1, u)


    // pub def secondsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
    //     untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    // pub def minutesUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
    //     untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    // pub def hoursUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
    //     untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)

    // pub def halfDaysUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
    //     untilHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), r)

    // pub def daysUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
    //     untilHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), r)

    // pub def monthsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
    //     untilHelper(unchecked_cast(get_MONTHS() as ##java.time.temporal.TemporalUnit), r)

    // pub def yearsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
    //     untilHelper(unchecked_cast(get_YEARS() as ##java.time.temporal.TemporalUnit), r)

    // pub def quarterYearsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
    //     import static java_get_field java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.TemporalUnit \ {} as get_QUARTER_YEARS;
    //     untilHelper(get_QUARTER_YEARS(), r)

    // generic helper functions

    // def getHelper(t: ##java.time.temporal.TemporalField, x: OffsetDateTime): Int32 = 
    //     import java.time.OffsetDateTime.get(##java.time.temporal.TemporalField): Int32 \ {};
    //     let x1 = getOffsetDateTime(x);
    //     get(x1, t)

    // def getLongHelper(t: ##java.time.temporal.TemporalField, x: OffsetDateTime): Int64 = 
    //     import java.time.OffsetDateTime.getLong(##java.time.temporal.TemporalField): Int64 \ {};
    //     let x1 = getOffsetDateTime(x);
    //     getLong(x1, t)


 
}
