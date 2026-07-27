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



pub mod InteropTime.OffsetDateTime {

    use InteropTime.Format.DateTimeFormatter.DateTimeFormatter
    use InteropTime.Format.DateTimeFormatter.DateTimeFormatter.{DateTimeFormatter}
    use InteropTime.Format.DateTimeFormatter.DateTimeFormat
    use InteropTime.DayOfWeek.DayOfWeek
    use InteropTime.DurationZ.DurationZ
    use InteropTime.DurationZ.DurationZ.{DurationZ }
    use InteropTime.InstantZ.InstantZ
    use InteropTime.InstantZ.InstantZ.{InstantZ}
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDate.LocalDate.{LocalDate}
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalDateTime.LocalDateTime.{LocalDateTime}
    use InteropTime.LocalTime.LocalTime
    use InteropTime.LocalTime.LocalTime.{LocalTime}
    use InteropTime.Month.Month
    use InteropTime.MonthDay.MonthDay
    use InteropTime.MonthDay.MonthDay.{MonthDay}
    use InteropTime.OffsetTime.OffsetTime
    use InteropTime.OffsetTime.OffsetTime.{OffsetTime}
    use InteropTime.Period.Period
    use InteropTime.Period.Period.{Period}
    use InteropTime.YearMonth.YearMonth
    use InteropTime.YearMonth.YearMonth.{YearMonth}
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZonedDateTime.ZonedDateTime.{ZonedDateTime }
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneId.ZoneId.{ZoneId}
    use InteropTime.ZoneOffset.ZoneOffset
    use InteropTime.ZoneOffset.ZoneOffset.{ZoneOffset}

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
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java OffsetDateTime.
    ///
    pub enum OffsetDateTime(JOffsetDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[OffsetDateTime] {
        pub def toString(x: OffsetDateTime): String =
            let OffsetDateTime.OffsetDateTime(x1) = x;
            unsafe IO { x1.toString() }
   }

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetDateTime] {
        pub def fromString(s: String): Option[OffsetDateTime] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JOffsetDateTime.parse(s1) };
                Some(OffsetDateTime.OffsetDateTime(ans))
            } catch {
                case _: JException => None
            }
   }

    instance Eq[OffsetDateTime] {
        pub def eq(x: OffsetDateTime, y: OffsetDateTime): Bool =
            let OffsetDateTime.OffsetDateTime(x1) = x;
            let OffsetDateTime.OffsetDateTime(y1) = y;
            unsafe IO { x1.equals(y1) }

   }

    instance Hash[OffsetDateTime] {
        pub def hash(x: OffsetDateTime): Int32 =
            let OffsetDateTime.OffsetDateTime(x1) = x;
            unsafe IO { x1.hashCode() }
   }

    instance Order[OffsetDateTime] {
        pub def compare(x: OffsetDateTime, y: OffsetDateTime): Comparison =
            let OffsetDateTime.OffsetDateTime(x1) = x;
            let OffsetDateTime.OffsetDateTime(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
   }


    instance ToJava[OffsetDateTime] {
        type Out = JOffsetDateTime
        pub def toJava(x: OffsetDateTime): JOffsetDateTime = 
            let OffsetDateTime.OffsetDateTime(x1) = x;
            x1
    }

    instance ToFlix[OffsetDateTime] {
        type In = JOffsetDateTime
        pub def toFlix(x: JOffsetDateTime): OffsetDateTime = OffsetDateTime.OffsetDateTime(x)
    }


    /// Constructors

    pub def offsetDateTime(year: {year = Int32}, 
                            month: {month = Int32}, 
                            dayOfMonth: {dayOfMonth = Int32}, 
                            hour: {hour = Int32}, 
                            minute: {minute = Int32},
                            second: {second = Int32}, 
                            nanoSecond: {nanoSecond = Int32}, 
                            offset: {offset = ZoneOffset}): OffsetDateTime =
        let ZoneOffset(o1) = offset#offset;
        let ans = unsafe IO { JOffsetDateTime.of(year#year, month#month, dayOfMonth#dayOfMonth, hour#hour, minute#minute, second#second, nanoSecond#nanoSecond, o1) };
        ToFlix.toFlix(ans)


    /// `now` functions

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): OffsetDateTime \ IO = ToFlix.toFlix(JOffsetDateTime.now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetDateTime \ IO =
        let z1 = ToJava.toJava(zone);
        let ans = JOffsetDateTime.now(z1);
        ToFlix.toFlix(ans)

    /// `at` functions

    pub def atZoneSameInstant(zone: {zone = ZoneId }, x: OffsetDateTime): ZonedDateTime =
        let x1 = ToJava.toJava(x);
        let z1 = ToJava.toJava(zone#zone);
        let ans = unsafe IO { x1.atZoneSameInstant(z1) };
        ToFlix.toFlix(ans)

    pub def atZoneSimilarLocal(zone: {zone = ZoneId }, x: OffsetDateTime): ZonedDateTime =
        let x1 = ToJava.toJava(x);
        let z1 = ToJava.toJava(zone#zone);
        let ans = unsafe IO { x1.atZoneSimilarLocal(z1) };
        ToFlix.toFlix(ans)


    pub def fromLocalDateTime(offset: {offset = ZoneOffset }, dateTime: LocalDateTime): OffsetDateTime =
        let dt1 = ToJava.toJava(dateTime);
        let o1 = ToJava.toJava(offset#offset);
        let ans = unsafe IO { JOffsetDateTime.of(dt1, o1) };
        ToFlix.toFlix(ans)


    /// `from` functions

    pub def fromLocalDateLocalTime(offset: {offset = ZoneOffset }, date: LocalDate, time: LocalTime): OffsetDateTime =
        let d1 = ToJava.toJava(date);
        let t1 = ToJava.toJava(time);
        let zo1 = ToJava.toJava(offset#offset);
        let ans = unsafe IO { JOffsetDateTime.of(d1, t1, zo1) };
        ToFlix.toFlix(ans)

    /// `fromTemporalAccessor` specialized

    pub def fromZonedDateTime(x: ZonedDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JOffsetDateTime.$from(x1) };
        ToFlix.toFlix(ans)

    /// `to` functions


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.toLocalDate() };
        LocalDate(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.toLocalTime() };
        LocalTime(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.toLocalDateTime() };
        LocalDateTime(ans)


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.toOffsetTime() };
        OffsetTime(ans)

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.toZonedDateTime() };
        ZonedDateTime(ans)


    pub def toInstant(x: OffsetDateTime): InstantZ =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.toInstant() };
        InstantZ(ans)

    pub def toEpochSecond(x: OffsetDateTime): Int64 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.toEpochSecond() }

    /// `parse` / `format` functions
    
    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Result[String, OffsetDateTime] =
        try {
            let fmt1 = ToJava.toJava(formatter);
            let s1 = String.trim(s);
            let ans = unsafe IO { JOffsetDateTime.parse(s1, fmt1) };
            Ok(ToFlix.toFlix(ans))
        } catch {
            case e: JException => Err(e.getMessage())
        }


    ///
    /// Returns OffsetDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: OffsetDateTime): String =
        let x1 = ToJava.toJava(x);
        let fmt1 = ToJava.toJava(formatter);
        unsafe IO { x1.format(fmt1) }

    // predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetDateTime, y: OffsetDateTime): Bool =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        unsafe IO { x1.isBefore(y1) }

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetDateTime, y: OffsetDateTime): Bool =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        unsafe IO { x1.isAfter(y1) }


    pub def isInstantEqual(x: OffsetDateTime, y: OffsetDateTime): Bool =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        unsafe IO { x1.isEqual(y1) }


    pub def isAmOfDay(x: OffsetDateTime): Bool = 
        let x1 = ToJava.toJava(x);
        let tf1 = unsafe IO { JChronoField.AMPM_OF_DAY };
        unsafe IO { x1.get(tf1) == 0 }


    pub def isPmOfDay(x: OffsetDateTime): Bool = 
        let x1 = ToJava.toJava(x);
        let tf1 = unsafe IO { JChronoField.AMPM_OF_DAY };
        unsafe IO { x1.get(tf1) == 1 }


    /// OffsetDateTime functions

    // pub def timeLineOrder(x: OffsetDateTime, y: OffsetDateTime): Comparison =
    //     import static java.time.OffsetDateTime.timeLineOrder(): ##java.util.Comparator \ {};
    //     import java.util.Comparator.compare(##java.lang.Object, ##java.lang.Object): Int32 \ {};
    //     let x1 = ToJava.toJava(x);
    //     let y1 = ToJava.toJava(y);
    //     let cmp = timeLineOrder();
    //     compare(cmp, checked_cast(x1), checked_cast(y1)) |> Comparison.fromInt32

    /// Getters and Setters
    /// Get / Set...

    pub def getOffset(x: OffsetDateTime): ZoneOffset =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.getOffset() };
        ToFlix.toFlix(ans)

    pub def withOffsetSameInstant(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let o1 = ToJava.toJava(offset);
        let ans = unsafe IO { x1.$withOffsetSameInstant(o1) };
        ToFlix.toFlix(ans)

    pub def withOffsetSameLocal(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let o1 = ToJava.toJava(offset);
        let ans = unsafe IO { x1.$withOffsetSameLocal(o1) };
        ToFlix.toFlix(ans)


    pub def getNano(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getNano() }

    pub def withNano(nano: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withNano(nano) };
        ToFlix.toFlix(ans)

    pub def getSecond(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getSecond() }

    pub def withSecond(second: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withSecond(second) };
        ToFlix.toFlix(ans)


    pub def getMinute(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getMinute() }

    pub def withMinute(minute: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withMinute(minute) };
        ToFlix.toFlix(ans)


    pub def getHour(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getHour() }

    pub def withHour(hour: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withHour(hour) };
        ToFlix.toFlix(ans)


    pub def getDayOfWeek(x: OffsetDateTime): DayOfWeek =
        let x1 = ToJava.toJava(x);
        let d1 = unsafe IO { x1.getDayOfWeek() };
        ToFlix.toFlix(d1)


    pub def adjustDayOfWeek(d: DayOfWeek, x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let d1 = ToJava.toJava(d);
        let t1 = unsafe IO { d1.adjustInto(x1) };
        let ans = unchecked_cast(t1 as JOffsetDateTime);
        ToFlix.toFlix(ans)


    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getDayOfMonth() }

    pub def withDayOfMonth(dayOfMonth: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withDayOfMonth(dayOfMonth) };
        ToFlix.toFlix(ans)


    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getDayOfYear() }

    pub def withDayOfYear(dayOfYear: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withDayOfYear(dayOfYear) };
        ToFlix.toFlix(ans)

    pub def getMonth(x: OffsetDateTime): Month =
        let x1 = ToJava.toJava(x);
        let m1 = unsafe IO { x1.getMonth() };
        ToFlix.toFlix(m1)

    pub def getMonthValue(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        let m1 = unsafe IO { x1.getMonth() };
        unsafe IO { m1.getValue() }

    pub def withMonth(month: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withMonth(month) };
        ToFlix.toFlix(ans)

    pub def getYear(x: OffsetDateTime): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getYear() }

    pub def withYear(year: Int32, x: OffsetDateTime): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withYear(year) };
        ToFlix.toFlix(ans)

    // MonthDay methods

    pub def getMonthDay(x: OffsetDateTime): MonthDay = 
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)

    pub def adjustMonthDay(md: MonthDay, x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let md1 = ToJava.toJava(md);
        let dt1 = unsafe IO { md1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)

    // YearMonth methods

    pub def getYearMonth(x: OffsetDateTime): YearMonth = 
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JYearMonth.$from(x1) };
        YearMonth(ans)


    pub def adjustYearMonth(ym: YearMonth, x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let ym1 = ToJava.toJava(ym);
        let dt1 = unsafe IO { ym1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)


    // LocalDate methods

    pub def getLocalDate(x: OffsetDateTime): LocalDate = 
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JLocalDate.$from(x1) };
        ToFlix.toFlix(ans)

    pub def adjustLocalDate(d: LocalDate, x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let d1 = ToJava.toJava(d);
        let dt1 = unsafe IO { d1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)

    // LocalDateTime methods

    pub def getLocalDateTime(x: OffsetDateTime): LocalDateTime = 
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JLocalDateTime.$from(x1) };
        ToFlix.toFlix(ans)

    pub def adjustLocalDateTime(ldt: LocalDateTime, x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let ldt1 = ToJava.toJava(ldt);
        let dt1 = unsafe IO { ldt1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)


    /// LocalTime methods

    pub def getLocalTime(x: OffsetDateTime): LocalTime = 
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JLocalTime.$from(x1) };
        ToFlix.toFlix(ans)


    pub def adjustLocalTime(lt: LocalTime, x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let lt1 = ToJava.toJava(lt);
        let dt1 = unsafe IO { lt1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)
        

    pub def getEpochDay(x: OffsetDateTime): Int64 = 
        let x1 = ToJava.toJava(x);
        let f1 = unsafe IO { JChronoField.EPOCH_DAY };
        unsafe IO { x1.getLong(f1) }

    /// ZoneOffset methods

    pub def adjustZoneOffset(zo: ZoneOffset, x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let zo1 = ToJava.toJava(zo);
        let dt1 = unsafe IO { zo1.adjustInto(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)

    // truncate functions

    pub def truncatedToDays(x: OffsetDateTime): OffsetDateTime = 
        let x1 = ToJava.toJava(x);
        let u1 = unsafe IO { JChronoUnit.DAYS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        ToFlix.toFlix(ans)

    // plus / minus functions

    pub def plusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusYears(years) };
        ToFlix.toFlix(ans)

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusYears(years) };
        ToFlix.toFlix(ans)

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusMonths(months) };
        ToFlix.toFlix(ans)

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusMonths(months) };
        ToFlix.toFlix(ans)

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusWeeks(weeks) };
        ToFlix.toFlix(ans)

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusWeeks(weeks) };
        ToFlix.toFlix(ans)

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusDays(days) };
        ToFlix.toFlix(ans)

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusDays(days) };
        ToFlix.toFlix(ans)

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusHours(hours) };
        ToFlix.toFlix(ans)

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusHours(hours) };
        ToFlix.toFlix(ans)

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusMinutes(minutes) };
        ToFlix.toFlix(ans)

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusMinutes(minutes) };
        ToFlix.toFlix(ans)

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusSeconds(seconds) };
        ToFlix.toFlix(ans)

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusSeconds(seconds) };
        ToFlix.toFlix(ans)

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plusNanos(nanos) };
        ToFlix.toFlix(ans)

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minusNanos(nanos) };
        ToFlix.toFlix(ans)


    pub def plusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let d1 = ToJava.toJava(d);
        let dt1 = unsafe IO { d1.addTo(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)
    
    pub def minusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let d1 = ToJava.toJava(d);
        let dt1 = unsafe IO { d1.subtractFrom(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)

    // Period methods

    pub def plusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let p1 = ToJava.toJava(p);
        let dt1 = unsafe IO { p1.addTo(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)

    pub def minusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        let x1 = ToJava.toJava(x);
        let p1 = ToJava.toJava(p);
        let dt1 = unsafe IO { p1.subtractFrom(x1) };
        let ans = unchecked_cast(dt1 as JOffsetDateTime);
        ToFlix.toFlix(ans)


    // between / until functions

    pub def between(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): DurationZ =
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let ans = unsafe IO { JDuration.between(b1, e1) };
        DurationZ(ans)
        

    pub def secondsUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JChronoUnit.SECONDS };
        unsafe IO { b1.until(e1, cu1) }

    pub def minutesUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JChronoUnit.MINUTES };
        unsafe IO { b1.until(e1, cu1) }

    pub def hoursUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JChronoUnit.HOURS };
        unsafe IO { b1.until(e1, cu1) }

    pub def halfDaysUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JChronoUnit.HALF_DAYS };
        unsafe IO { b1.until(e1, cu1) }

    pub def daysUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JChronoUnit.DAYS };
        unsafe IO { b1.until(e1, cu1) }

    pub def monthsUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JChronoUnit.MONTHS };
        unsafe IO { b1.until(e1, cu1) }

    pub def yearsUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JChronoUnit.YEARS };
        unsafe IO { b1.until(e1, cu1) }

    pub def quarterYearsUntil(begin: {begin = OffsetDateTime }, end: {end = OffsetDateTime }): Int64 = 
        let b1 = ToJava.toJava(begin#begin);
        let e1 = ToJava.toJava(end#end);
        let cu1 = unsafe IO { JIsoFields.QUARTER_YEARS };
        unsafe IO { b1.until(e1, cu1) }

}

