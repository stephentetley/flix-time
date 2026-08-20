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


pub mod InteropTime.ZonedDateTime {

    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TemporalFormat
    use InteropTime.Format.TemporalParse
    use InteropTime.Format.DateTimeFormatter
    use InteropTime.DayOfWeek.DayOfWeek
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalTime.LocalTime
    use InteropTime.Month.Month
    use InteropTime.MonthDay.MonthDay
    use InteropTime.OffsetTime
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.Period.Period
    use InteropTime.Year
    use InteropTime.YearMonth.YearMonth
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneOffset.ZoneOffset

    import java.time.{DayOfWeek => JDayOfWeek}
    import java.time.{Month => JMonth}
    import java.time.{MonthDay => JMonthDay}
    import java.time.{YearMonth => JYearMonth}
    import java.time.{Year => JYear}
    import java.time.{Duration => JDuration}
    import java.time.{Instant => JInstant}
    import java.time.{OffsetDateTime => JOffsetDateTime}
    import java.time.{OffsetTime => JOffsetTime}
    import java.time.{ZonedDateTime => JZonedDateTime}
    import java.time.{ZoneId => JZoneId}
    import java.time.{LocalDateTime => JLocalDateTime, LocalDate => JLocalDate}
    import java.time.chrono.{ChronoZonedDateTime, ChronoLocalDate, ChronoLocalDateTime}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{IsoFields => JIsoFields}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java ZonedDateTime.
    ///
    pub enum ZonedDateTime(JZonedDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[ZonedDateTime] {
        pub def toString(x: ZonedDateTime): String =
            let ZonedDateTime.ZonedDateTime(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[ZonedDateTime] {
        pub def fromString(s: String): Option[ZonedDateTime] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JZonedDateTime.parse(s1) };
                Some(ZonedDateTime.ZonedDateTime(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[ZonedDateTime] {
        pub def eq(x: ZonedDateTime, y: ZonedDateTime): Bool =
            let ZonedDateTime.ZonedDateTime(x1) = x;
            let ZonedDateTime.ZonedDateTime(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[ZonedDateTime] {
        pub def hash(x: ZonedDateTime): Int32 =
            let ZonedDateTime.ZonedDateTime(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[ZonedDateTime] {
        pub def compare(x: ZonedDateTime, y: ZonedDateTime): Comparison =
            let ZonedDateTime.ZonedDateTime(x1) = x;
            let ZonedDateTime.ZonedDateTime(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }
    
    instance ToJava[ZonedDateTime] {
        type Out = JZonedDateTime
        pub def toJava(x: ZonedDateTime): JZonedDateTime = 
            let ZonedDateTime.ZonedDateTime(x1) = x;
            x1
    }

    instance ToFlix[ZonedDateTime] {
        type In = JZonedDateTime
        pub def toFlix(x: JZonedDateTime): ZonedDateTime = 
            ZonedDateTime.ZonedDateTime(x)
    }

    instance TemporalFormat[ZonedDateTime] {
        type Formatter = DateTimeFormatter
        type Aef = {}
        pub def format(formatter: DateTimeFormatter, x: ZonedDateTime): String =
            let ZonedDateTime.ZonedDateTime(x1) = x;
            let formatter1 = ToJava.toJava(formatter);
            unsafe IO { x1.format(formatter1) }
    }

    instance TemporalParse[ZonedDateTime] {
        type Formatter = DateTimeFormatter
        type Aef = {}
        pub def parse(formatter: DateTimeFormatter, s: String): Result[String, ZonedDateTime] = 
            AdaptorExtras.opWithResult(formatter, formatter1 -> {
                let s1 = String.trim(s);
                unsafe IO { JZonedDateTime.parse(s1, formatter1) }
            })
    }


    /// Constructors

    pub def zonedDateTime(year: {year = Int32}, 
                            month: {month = Int32}, 
                            dayOfMonth: {dayOfMonth = Int32}, 
                            hour: {hour = Int32}, 
                            minute: {minute = Int32}, 
                            second: {second = Int32}, 
                            nanoSecond: {nanoSecond = Int32}, 
                            zone: ZoneId): ZonedDateTime =
        AdaptorExtras.op(zone, zone1 -> 
            unsafe IO { JZonedDateTime.of(year#year, 
                                            month#month, 
                                            dayOfMonth#dayOfMonth, 
                                            hour#hour, minute#minute, 
                                            second#second, nanoSecond#nanoSecond, 
                                            zone1) }
            ) 


    /// `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): ZonedDateTime \ IO = ZonedDateTime(JZonedDateTime.now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): ZonedDateTime \ IO =
        AdaptorExtras.op(zone, zone1 -> JZonedDateTime.now(zone1))


    pub def ofLocalDateLocalTime(zone: ZoneId, date: LocalDate, time: LocalTime): ZonedDateTime =
        AdaptorExtras.op3(zone, date, time, (zone1, date1, time1) ->
            unsafe IO { JZonedDateTime.of(date1, time1, zone1) }
        )


    /// toX functions

    pub def toDayOfWeek(x: ZonedDateTime): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { JDayOfWeek.$from(x1) })

    pub def toInstant(x: ZonedDateTime): InstantZ = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JInstant.$from(x1) })

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: ZonedDateTime): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalDate() })

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: ZonedDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalDateTime() })
        
    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: ZonedDateTime): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalTime() })

    pub def toMonth(x: ZonedDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    pub def toMonthDay(x: ZonedDateTime): MonthDay =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonthDay.$from(x1) })


    pub def toOffsetTime(x: ZonedDateTime): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { JOffsetTime.$from(x1) }) 

    pub def toOffsetDateTime(x: ZonedDateTime): OffsetDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JOffsetDateTime.$from(x1) })

    pub def toYear(x: ZonedDateTime): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })

    pub def toYearMonth(x: ZonedDateTime): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYearMonth.$from(x1) })

    pub def toZoneOffset(x: ZonedDateTime): ZoneOffset =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getOffset() })



    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: ZonedDateTime, y: ZonedDateTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: ZonedDateTime, y: ZonedDateTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    /// Getters and Setters

    pub def getYear(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getYear() })

    pub def withYear(year: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withYear(year) })

    pub def getMonth(x: ZonedDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getMonth() })

    pub def withMonth(month: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMonth(month) })


    pub def getMonthValue(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> {
            let m1 = unsafe IO { x1.getMonth() };
            unsafe IO { m1.getValue() }
        })

    pub def getZoneId(x: ZonedDateTime): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })

    pub def getDayOfYear(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfYear() })

    pub def withDayOfYear(dayOfYear: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfYear(dayOfYear) })

    pub def getDayOfMonth(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfMonth() })

    pub def withDayOfMonth(dayOfMonth: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfMonth(dayOfMonth) })

    pub def getDayOfWeek(x: ZonedDateTime): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDayOfWeek() })

    // no setDayOfWeek

    pub def getHour(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getHour() })

    pub def withHour(hour: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withHour(hour) })

    pub def getMinute(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMinute() })

    pub def withMinute(minute: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMinute(minute) })

    pub def getSecond(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getSecond() })

    pub def withSecond(second: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withSecond(second) })

    pub def getNano(x: ZonedDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getNano() })

    pub def withNano(nano: Int32, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withNano(nano) })

    pub def withZoneSameInstant(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> 
            unsafe IO { x1.$withZoneSameInstant(zone1) }
        )

    pub def withZoneSameLocal(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> 
            unsafe IO { x1.$withZoneSameLocal(zone1) }
        )


    pub def withFixedOffsetZone(x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withFixedOffsetZone() })

    pub def withEarlierOffsetAtOverlap(x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withEarlierOffsetAtOverlap() })

    pub def withLaterOffsetAtOverlap(x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withLaterOffsetAtOverlap() })

    // DayOfWeek methods

    pub def adjustDayOfWeek(day: DayOfWeek, x: ZonedDateTime): ZonedDateTime =  
        AdaptorExtras.op2(day, x, (day1, x1) -> {
            let dt1 = unsafe IO { day1.adjustInto(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })

    // MonthDay methods

    pub def adjustMonthDay(mday: MonthDay, x: ZonedDateTime): ZonedDateTime =  
        AdaptorExtras.op2(mday, x, (mday1, x1) -> {
            let dt1 = unsafe IO { mday1.adjustInto(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })

    // ZoneOffset methods

    pub def adjustZoneOffset(zo: ZoneOffset, x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op2(zo, x, (zo1, x1) -> {
            let dt1 = unsafe IO { zo1.adjustInto(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })


    // YearMonth methods

    pub def adjustYearMonth(ymon: YearMonth, x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op2(ymon, x, (ymon1, x1) -> {
            let dt1 = unsafe IO { ymon1.adjustInto(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })

    // LocalDate methods

    pub def adjustLocalDate(ld: LocalDate, x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op2(ld, x, (ld1, x1) -> {
            let dt1 = unsafe IO { ld1.adjustInto(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })

    // LocalDateTime methods

    pub def adjustLocalDateTime(ldt: LocalDateTime, x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op2(ldt, x, (ldt1, x1) -> {
            let dt1 = unsafe IO { ldt1.adjustInto(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })

    // LocalTime methods

    pub def adjustLocalTime(lt: LocalTime, x: ZonedDateTime): ZonedDateTime = 
        AdaptorExtras.op2(lt, x, (lt1, x1) -> {
            let dt1 = unsafe IO { lt1.adjustInto(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })

    // plus / minus functions

    pub def plusYears(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusYears(i) })

    pub def minusYears(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusYears(i) })

    pub def plusMonths(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMonths(i) })

    pub def minusMonths(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMonths(i) })

    pub def plusWeeks(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusWeeks(i) })

    pub def minusWeeks(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusWeeks(i) })

    pub def plusDays(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusDays(i) })

    pub def minusDays(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusDays(i) })

    pub def plusHours(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusHours(i) })

    pub def minusHours(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusHours(i) })

    pub def plusMinutes(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMinutes(i) })

    pub def minusMinutes(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMinutes(i) })

    pub def plusSeconds(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusSeconds(i) })

    pub def minusSeconds(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusSeconds(i) })

    pub def plusNanos(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusNanos(i) })

    pub def minusNanos(x: ZonedDateTime, i: Int64): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusNanos(i) })

    pub def plusDuration(x: ZonedDateTime, d: DurationZ): ZonedDateTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let dt1 = unsafe IO { d1.addTo(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })
    
    pub def minusDuration(x: ZonedDateTime, d: DurationZ): ZonedDateTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let dt1 = unsafe IO { d1.subtractFrom(x1) };
            unchecked_cast(dt1 as JZonedDateTime)
        })

    // Period methods

    pub def plusPeriod(x: ZonedDateTime, p: Period): ZonedDateTime =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.addTo(x1) };
            unchecked_cast(t1 as JZonedDateTime)
        })
    
    pub def minusPeriod(x: ZonedDateTime, p: Period): ZonedDateTime =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.subtractFrom(x1) };
            unchecked_cast(t1 as JZonedDateTime)
        })



    // between / until functions 


    pub def between(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): DurationZ =
        AdaptorExtras.op2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { JDuration.between(begin1, end1) }
        )


    // `until` specialized


    pub def secondsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.SECONDS) }
        })


    pub def minutesUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MINUTES) }
        })


    pub def hoursUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.HOURS) }
        })


    pub def halfDaysUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.HALF_DAYS) }
        })


    pub def daysUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.DAYS) }
        })


    pub def monthsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MONTHS) }
        })


    pub def yearsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.YEARS) }
        })


    pub def quarterYearsUntil(begin: {begin = ZonedDateTime }, end: {end = ZonedDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { 
                let u1 = unchecked_cast(JIsoFields.QUARTER_YEARS as JChronoUnit);
                begin1.until(end1, u1) 
            }
        )


}
