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

    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TemporalFormat
    use InteropTime.Format.TemporalParse
    use InteropTime.Format.DateTimeFormatter
    use InteropTime.DayOfWeek.DayOfWeek
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalTime.LocalTime
    use InteropTime.Month.Month
    use InteropTime.MonthDay.MonthDay
    use InteropTime.OffsetTime.OffsetTime
    use InteropTime.Period.Period
    use InteropTime.Year
    use InteropTime.YearMonth.YearMonth
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneOffset.ZoneOffset

    import java.time.{DayOfWeek => JDayOfWeek}
    import java.time.{Month => JMonth}
    import java.time.{MonthDay => JMonthDay}
    import java.time.{Year => JYear}
    import java.time.{YearMonth => JYearMonth}
    import java.time.{Duration => JDuration}
    import java.time.{LocalDate => JLocalDate}
    import java.time.{LocalDateTime => JLocalDateTime}
    import java.time.{LocalTime => JLocalTime}
    import java.time.{OffsetDateTime => JOffsetDateTime}
    import java.time.{ZoneId => JZoneId}
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
        pub def toFlix(x: JOffsetDateTime): OffsetDateTime = 
            OffsetDateTime.OffsetDateTime(x)
    }

    instance TemporalFormat[OffsetDateTime] {
        type Formatter = DateTimeFormatter
        type Aef = {}
        pub def format(formatter: DateTimeFormatter, x: OffsetDateTime): String =
            let OffsetDateTime.OffsetDateTime(x1) = x;
            let formatter1 = ToJava.toJava(formatter);
            unsafe IO { x1.format(formatter1) }
    }

    instance TemporalParse[OffsetDateTime] {
        type Formatter = DateTimeFormatter
        type Aef = {}
        pub def parse(formatter: DateTimeFormatter, s: String): Result[String, OffsetDateTime] = 
            AdaptorExtras.opWithResult(formatter, formatter1 -> {
                let s1 = String.trim(s);
                unsafe IO { JOffsetDateTime.parse(s1, formatter1) }
            })
    }

    /// Constructors

    pub def offsetDateTime(year: {year = Int32}, 
                            month: {month = Int32}, 
                            dayOfMonth: {dayOfMonth = Int32}, 
                            hour: {hour = Int32}, 
                            minute: {minute = Int32},
                            second: {second = Int32}, 
                            nanoSecond: {nanoSecond = Int32}, 
                            offset: ZoneOffset): OffsetDateTime =
        AdaptorExtras.op(offset, offset1 ->
            unsafe IO { JOffsetDateTime.of(year#year, 
                                            month#month, 
                                            dayOfMonth#dayOfMonth, 
                                            hour#hour, 
                                            minute#minute, 
                                            second#second, 
                                            nanoSecond#nanoSecond, 
                                            offset1) }
        )


    /// `now` functions

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): OffsetDateTime \ IO = 
        AdaptorExtras.of(() -> JOffsetDateTime.now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetDateTime \ IO =
        AdaptorExtras.op(zone, zone1 -> JOffsetDateTime.now(zone1))

    /// `at` functions

    pub def atZoneSameInstant(zone: ZoneId, x: OffsetDateTime): ZonedDateTime =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> unsafe IO { x1.atZoneSameInstant(zone1) })

    pub def atZoneSimilarLocal(zone: ZoneId, x: OffsetDateTime): ZonedDateTime =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> unsafe IO { x1.atZoneSimilarLocal(zone1) })




    /// `from` functions

    pub def fromLocalDateLocalTime(offset: ZoneOffset, ld: LocalDate, lt: LocalTime): OffsetDateTime =
        AdaptorExtras.op3(offset, ld, lt, (offset1, ld1, lt1) -> 
            unsafe IO { JOffsetDateTime.of(ld1, lt1, offset1) }
        )


    pub def fromZonedDateTime(x: ZonedDateTime): OffsetDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JOffsetDateTime.$from(x1) })

    /// `to` functions

    pub def toDayOfWeek(x: OffsetDateTime): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { JDayOfWeek.$from(x1) })

    pub def toEpochSecond(x: OffsetDateTime): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toEpochSecond() })


    pub def toInstant(x: OffsetDateTime): InstantZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toInstant() })

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalDate() })

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalDateTime() })

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toLocalTime() })
    
    pub def toMonth(x: OffsetDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })

    pub def toMonthDay(x: OffsetDateTime): MonthDay =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonthDay.$from(x1) })


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toOffsetTime() })

    pub def toYear(x: OffsetDateTime): Year =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYear.$from(x1) })


    pub def toYearMonth(x: OffsetDateTime): YearMonth =
        AdaptorExtras.op(x, x1 -> unsafe IO { JYearMonth.$from(x1) })

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.toZonedDateTime() })




    // predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetDateTime, y: OffsetDateTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetDateTime, y: OffsetDateTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })


    pub def isInstantEqual(x: OffsetDateTime, y: OffsetDateTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isEqual(y1) })


    pub def isAmOfDay(x: OffsetDateTime): Bool = 
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.get(JChronoField.AMPM_OF_DAY) == 0 }
        )


    pub def isPmOfDay(x: OffsetDateTime): Bool = 
        AdaptorExtras.extract(x, x1 ->
            unsafe IO { x1.get(JChronoField.AMPM_OF_DAY) == 1 }
        )


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


    pub def getZoneId(x: OffsetDateTime): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })

    pub def getOffset(x: OffsetDateTime): ZoneOffset =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getOffset() })

    pub def withOffsetSameInstant(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op2(offset, x, (offset1, x1) -> 
            unsafe IO { x1.$withOffsetSameInstant(offset1) }
        )

    pub def withOffsetSameLocal(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op2(offset, x, (offset1, x1) -> 
            unsafe IO { x1.$withOffsetSameLocal(offset1) }
        )


    pub def getNano(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getNano() })

    pub def withNano(nano: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withNano(nano) })

    pub def getSecond(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getSecond() })

    pub def withSecond(second: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withSecond(second) })


    pub def getMinute(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMinute() })

    pub def withMinute(minute: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMinute(minute) })


    pub def getHour(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getHour() })

    pub def withHour(hour: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withHour(hour) })


    pub def getDayOfWeek(x: OffsetDateTime): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDayOfWeek() })


    pub def adjustDayOfWeek(d: DayOfWeek, x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op2(d, x, (d1, x1) -> {
            let t1 = unsafe IO { d1.adjustInto(x1) };
            unchecked_cast(t1 as JOffsetDateTime)
        })


    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfMonth() })

    pub def withDayOfMonth(dayOfMonth: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfMonth(dayOfMonth) })


    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfYear() })

    pub def withDayOfYear(dayOfYear: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfYear(dayOfYear) })

    pub def getMonth(x: OffsetDateTime): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getMonth() })

    pub def getMonthValue(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.getMonth().getValue() }
        )

    pub def withMonth(month: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMonth(month) })

    pub def getYear(x: OffsetDateTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getYear() })

    pub def withYear(year: Int32, x: OffsetDateTime): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withYear(year) })

    // MonthDay methods

    pub def getMonthDay(x: OffsetDateTime): MonthDay = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonthDay.$from(x1) })

    pub def adjustMonthDay(md: MonthDay, x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op2(md, x, (md1, x1) -> {
            let dt1 = unsafe IO { md1.adjustInto(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })

    // YearMonth methods

    pub def getYearMonth(x: OffsetDateTime): YearMonth = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JYearMonth.$from(x1) })


    pub def adjustYearMonth(ym: YearMonth, x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op2(ym, x, (ym1, x1) -> {
            let dt1 = unsafe IO { ym1.adjustInto(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })


    // LocalDate methods

    pub def getLocalDate(x: OffsetDateTime): LocalDate = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JLocalDate.$from(x1) })

    pub def adjustLocalDate(ld: LocalDate, x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op2(ld, x, (ld1, x1) -> {
            let dt1 = unsafe IO { ld1.adjustInto(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })

    // LocalDateTime methods

    pub def getLocalDateTime(x: OffsetDateTime): LocalDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JLocalDateTime.$from(x1) })

    pub def adjustLocalDateTime(ldt: LocalDateTime, x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op2(ldt, x, (ldt1, x1) -> {
            let dt1 = unsafe IO { ldt1.adjustInto(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })


    /// LocalTime methods

    pub def getLocalTime(x: OffsetDateTime): LocalTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JLocalTime.$from(x1) })


    pub def adjustLocalTime(lt: LocalTime, x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op2(lt, x, (lt1, x1) -> {
            let dt1 = unsafe IO { lt1.adjustInto(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })
        

    pub def getEpochDay(x: OffsetDateTime): Int64 = 
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.getLong(JChronoField.EPOCH_DAY) }
        )

    /// ZoneOffset methods

    pub def adjustZoneOffset(zo: ZoneOffset, x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op2(zo, x, (zo1, x1) -> {
            let dt1 = unsafe IO { zo1.adjustInto(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })

    // truncate functions

    pub def truncatedToDays(x: OffsetDateTime): OffsetDateTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.truncatedTo(JChronoUnit.DAYS) })

    // plus / minus functions

    pub def plusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusYears(years) })

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusYears(years) })

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMonths(months) })

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMonths(months) })

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusWeeks(weeks) })

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusWeeks(weeks) })

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusDays(days) })

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusDays(days) })

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusHours(hours) })

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusHours(hours) })

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMinutes(minutes) })

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMinutes(minutes) })

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusSeconds(seconds) })

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusSeconds(seconds) })

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusNanos(nanos) })

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusNanos(nanos) })

    pub def plusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let dt1 = unsafe IO { d1.addTo(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })
    
    pub def minusDuration(x: OffsetDateTime, d: DurationZ): OffsetDateTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let dt1 = unsafe IO { d1.subtractFrom(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })

    // Period methods

    pub def plusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let dt1 = unsafe IO { p1.addTo(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })

    pub def minusPeriod(x: OffsetDateTime, p: Period): OffsetDateTime =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let dt1 = unsafe IO { p1.subtractFrom(x1) };
            unchecked_cast(dt1 as JOffsetDateTime)
        })


    // between / until functions

    pub def between(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): DurationZ =
        AdaptorExtras.op2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { JDuration.between(begin1, end1) }
        )
        

    pub def secondsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.SECONDS) }
        )

    pub def minutesUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MINUTES) }
        )

    pub def hoursUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.HOURS) }
        )

    pub def halfDaysUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.HALF_DAYS) }
        )

    pub def daysUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.DAYS) }
        )

    pub def monthsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MONTHS) }
        )

    pub def yearsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.YEARS) }
        )

    pub def quarterYearsUntil(begin: {begin = OffsetDateTime}, end: {end = OffsetDateTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JIsoFields.QUARTER_YEARS) }
        )

}

