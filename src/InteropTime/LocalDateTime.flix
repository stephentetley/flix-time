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



pub mod InteropTime.LocalDateTime {

    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TemporalFormat
    use InteropTime.Format.TemporalParse
    use InteropTime.Format.DateTimeFormatter
    use InteropTime.DayOfWeek.DayOfWeek
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalTime.LocalTime
    use InteropTime.Month.Month
    use InteropTime.MonthDay.MonthDay
    use InteropTime.Period.Period
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.Year
    use InteropTime.YearMonth.YearMonth
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneOffset.ZoneOffset
    
    import java.time.{Duration => JDuration}
    import java.time.{DayOfWeek => JDayOfWeek}
    import java.time.{Year => JYear}
    import java.time.{LocalDate => JLocalDate}
    import java.time.{LocalDateTime => JLocalDateTime}
    import java.time.chrono.{ChronoLocalDate}
    import java.time.chrono.{ChronoLocalDateTime}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{IsoFields => JIsoFields}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java LocalDateTime.
    ///
    pub enum LocalDateTime(JLocalDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[LocalDateTime] {
        pub def toString(x: LocalDateTime): String =
            let LocalDateTime.LocalDateTime(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDateTime] {
        pub def fromString(s: String): Option[LocalDateTime] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JLocalDateTime.parse(s1) };
                Some(LocalDateTime.LocalDateTime(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[LocalDateTime] {
        pub def eq(x: LocalDateTime, y: LocalDateTime): Bool =
            let LocalDateTime.LocalDateTime(x1) = x;
            let LocalDateTime.LocalDateTime(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[LocalDateTime] {
        pub def hash(x: LocalDateTime): Int32 =
            let LocalDateTime.LocalDateTime(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[LocalDateTime] {
        pub def compare(x: LocalDateTime, y: LocalDateTime): Comparison =
            let LocalDateTime.LocalDateTime(x1) = x;
            let LocalDateTime.LocalDateTime(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance ToJava[LocalDateTime] {
        type Out = JLocalDateTime
        pub def toJava(x: LocalDateTime): JLocalDateTime = 
            let LocalDateTime.LocalDateTime(x1) = x;
            x1
    }

    instance ToFlix[LocalDateTime] {
        type In = JLocalDateTime
        pub def toFlix(x: JLocalDateTime): LocalDateTime = 
            LocalDateTime.LocalDateTime(x)
    }

    instance TemporalFormat[LocalDateTime] {
        type Formatter = DateTimeFormatter
        type Aef = {}
        pub def format(formatter: DateTimeFormatter, x: LocalDateTime): String =
            let LocalDateTime.LocalDateTime(x1) = x;
            let formatter1 = ToJava.toJava(formatter);
            unsafe IO { x1.format(formatter1) }
    }

    instance TemporalParse[LocalDateTime] {
        type Formatter = DateTimeFormatter
        type Aef = {}
        pub def parse(formatter: DateTimeFormatter, s: String): Result[String, LocalDateTime] = 
            AdaptorExtras.opWithResult(formatter, formatter1 -> {
                let s1 = String.trim(s);
                unsafe IO { JLocalDateTime.parse(s1, formatter1) }
            })
    }


    /// Constructors

    pub def localDateTime(year: {year = Int32}, 
                            month: {month = Int32}, 
                            dayOfMonth: {dayOfMonth = Int32}, 
                            hour: {hour = Int32}, 
                            minute: {minute = Int32}): LocalDateTime =
        LocalDateTime(unsafe IO { JLocalDateTime.of(year#year, month#month, dayOfMonth#dayOfMonth, hour#hour, minute#minute)}) 

    pub def localDateTimeWithSecond(year: {year = Int32}, 
                                    month: {month = Int32}, 
                                    dayOfMonth: {dayOfMonth = Int32},
                                    hour: {hour = Int32}, 
                                    minute: {minute = Int32}, 
                                    second: {second = Int32}): LocalDateTime =
        LocalDateTime(unsafe IO { JLocalDateTime.of(year#year, month#month, dayOfMonth#dayOfMonth, hour#hour, minute#minute, second#second) })

    pub def localDateTimeWithSecondAndNano(year: {year = Int32}, 
                                            month: {month = Int32}, 
                                            dayOfMonth: {dayOfMonth = Int32},
                                            hour: {hour = Int32}, 
                                            minute: {minute = Int32}, 
                                            second: {second = Int32}, 
                                            nanoSecond: {nanoSecond = Int32 }): LocalDateTime =
        LocalDateTime(unsafe IO { JLocalDateTime.of(year#year, month#month, dayOfMonth#dayOfMonth, hour#hour, minute#minute, second#second, nanoSecond#nanoSecond)}) 


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
        AdaptorExtras.op(zone, zone1 -> JLocalDateTime.now(zone1))


    /// `from` functions

    pub def fromLocalDateLocalTime(ld: LocalDate, lt: LocalTime): LocalDateTime =
        AdaptorExtras.op2(ld, lt, (ld1, lt1) -> unsafe IO { JLocalDateTime.of(ld1, lt1) })

    pub def ofEpochSecond(offset: ZoneOffset, epochSecond: Int64, nanoOfSecond: Int32): LocalDateTime =
        AdaptorExtras.op(offset, offset1 ->
            unsafe IO { JLocalDateTime.ofEpochSecond(epochSecond, nanoOfSecond, offset1) }
        )

    pub def ofInstant(zone: ZoneId, x: InstantZ): LocalDateTime =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JLocalDateTime.ofInstant(x1, zone1) }
        )

    // `fromTemporalAccessor` specialized

    pub def fromOffsetDateTime(x: OffsetDateTime): LocalDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JLocalDateTime.$from(x1) })

    pub def fromZonedDateTime(x: ZonedDateTime): LocalDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JLocalDateTime.$from(x1) })



    /// `to` functions

    pub def toDayOfWeek(x: LocalDateTime): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { JDayOfWeek.$from(x1) })

    pub def toYear(x: LocalDateTime): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })        

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalDate() })

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalTime() })



    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDateTime, y: LocalDateTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDateTime, y: LocalDateTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    /// LocalDateTime functions

    pub def getMonthValue(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.getMonth().getValue() }
        )

    /// Getters and Setters

    pub def getYear(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getYear() })

    pub def withYear(year: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withYear(year) })

    pub def getMonth(x: LocalDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getMonth() })

    pub def withMonth(month: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMonth(month) })

    pub def getDayOfYear(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfYear() })

    pub def withDayOfYear(dayOfYear: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfYear(dayOfYear) })

    pub def getDayOfMonth(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfMonth() })

    pub def withDayOfMonth(dayOfMonth: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfMonth(dayOfMonth) })

    pub def getDayOfWeek(x: LocalDateTime): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDayOfWeek() })

    pub def getHour(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getHour() })

    pub def withHour(hour: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withHour(hour) })

    pub def getMinute(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMinute() })

    pub def withMinute(minute: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMinute(minute) })

    pub def getSecond(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getSecond() })

    pub def withSecond(second: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withSecond(second) })

    pub def getNano(x: LocalDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getNano() })

    pub def withNano(nano: Int32, x: LocalDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withNano(nano) })

    /// YearMonth methods

    pub def adjustYearMonth(ym: YearMonth, x: LocalDateTime): LocalDateTime = 
        AdaptorExtras.op2(ym, x, (ym1, x1) -> {
            let t1 = unsafe IO { ym1.adjustInto(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })

    /// LocalDate methods

    pub def adjustLocalDate(ld: LocalDate, x: LocalDateTime): LocalDateTime = 
        AdaptorExtras.op2(ld, x, (ld1, x1) -> {
            let t1 = unsafe IO { ld1.adjustInto(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })

    /// LocalTime methods

    pub def adjustLocalTime(lt: LocalTime, x: LocalDateTime): LocalDateTime = 
        AdaptorExtras.op2(lt, x, (lt1, x1) -> {
            let t1 = unsafe IO { lt1.adjustInto(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })

    /// DayOfWeek methods

    pub def adjustDayOfWeek(d: DayOfWeek, x: LocalDateTime): LocalDateTime = 
        AdaptorExtras.op2(d, x, (d1, x1) -> {
            let t1 = unsafe IO { d1.adjustInto(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })

    /// MonthDay methods

    pub def adjustMonthDay(md: MonthDay, x: LocalDateTime): LocalDateTime = 
        AdaptorExtras.op2(md, x, (md1, x1) -> {
            let t1 = unsafe IO { md1.adjustInto(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })
        


    // truncate functions

    pub def truncatedToDays(x: LocalDateTime): LocalDateTime = 
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.DAYS) }
        )

    // plus / minus functions

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusYears(years) })

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusYears(years) })

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMonths(months) })

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMonths(months) })

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusWeeks( weeks) })

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusWeeks(weeks) })

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusDays(days) })

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusDays(days) })

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusHours(hours) })

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusHours(hours) })

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMinutes(minutes) })

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMinutes(minutes) })

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusSeconds(seconds) })

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusSeconds(seconds) })

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusNanos(nanos) })

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusNanos(nanos) })


    pub def plusPeriod(x: LocalDateTime, p: Period): LocalDateTime =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.addTo(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })
    
    pub def minusPeriod(x: LocalDateTime, p: Period): LocalDateTime =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.subtractFrom(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })


    pub def plusDuration(x: LocalDateTime, d: DurationZ): LocalDateTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.addTo(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })
    
    pub def minusDuration(x: LocalDateTime, d: DurationZ): LocalDateTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.subtractFrom(x1) };
            unchecked_cast(t1 as JLocalDateTime)
        })


    // between / until functions

    pub def between(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): DurationZ =
        AdaptorExtras.op2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { JDuration.between(begin1, end1) }
        })

    pub def secondsUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.SECONDS) }
        )

    pub def minutesUntil(begin: {begin = LocalDateTime}, end: {end = LocalDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MINUTES) }
        )

    pub def hoursUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.HOURS) }
        )

    pub def halfDaysUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.HALF_DAYS) }
        )

    pub def daysUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.DAYS) }
        )

    pub def monthsUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MONTHS) }
        )

    pub def yearsUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.YEARS) }
        )

    pub def quarterYearsUntil(begin: {begin = LocalDateTime }, end: {end = LocalDateTime }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JIsoFields.QUARTER_YEARS) }
        )

}
