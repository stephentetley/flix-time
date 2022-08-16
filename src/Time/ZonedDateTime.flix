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


namespace Time {

    ///
    /// A wrapper around a Java ZonedDateTime.
    ///
    pub enum ZonedDateTime(##java.time.ZonedDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[ZonedDateTime] {
        pub def toString(x: ZonedDateTime): String =
            import java.time.ZonedDateTime.toString(): String & Pure;
            let ZonedDateTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[ZonedDateTime] {
        pub def fromString(s: String): Option[ZonedDateTime] =
            import static java.time.ZonedDateTime.parse(##java.lang.CharSequence): ##java.time.ZonedDateTime & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(ZonedDateTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[ZonedDateTime] {
        pub def eq(x: ZonedDateTime, y: ZonedDateTime): Bool =
            import java.time.ZonedDateTime.equals(##java.lang.Object): Bool & Pure;
            let ZonedDateTime(x1) = x;
            let ZonedDateTime(y1) = y;
            equals(x1, y1 as ##java.lang.Object)        
    }

    instance Hash[ZonedDateTime] {
        pub def hash(x: ZonedDateTime): Int32 =
            import java.time.ZonedDateTime.hashCode(): Int32 & Pure;
            let ZonedDateTime(x1) = x;
            hashCode(x1)
    }

    instance Order[ZonedDateTime] {
        pub def compare(x: ZonedDateTime, y: ZonedDateTime): Comparison =
            // Have to use ChronoZonedDateTime...
            import java.time.chrono.ChronoZonedDateTime.compareTo(##java.time.chrono.ChronoZonedDateTime): Int32 & Pure;
            let ZonedDateTime(x1) = x;
            let ZonedDateTime(y1) = y;
            let cx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
            let cy1 = y1 as ##java.time.chrono.ChronoZonedDateTime;
            compareTo(cx1, cy1) |> Comparison.fromInt32
    }


    instance Boxable[ZonedDateTime]

    instance Interop/Flix.Marshal[ZonedDateTime] {
        pub def toJavaObject(x: ZonedDateTime): ##java.lang.Object =
            let ZonedDateTime(x1) = x;
            x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): ZonedDateTime = 
            ZonedDateTime(o as ##java.time.ZonedDateTime)
    }

}

namespace Time/ZonedDateTime {

    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.DateTimeFormat;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.DayOfWeek;
    use Time.ZDuration;
    use Time.ZDuration.{ZDuration};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time.MonthDay;
    use Time.OffsetDateTime;
    use Time.Period;
    use Time.YearMonth;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;

    /// ## Unwrap

    pub def getZonedDateTime(x: ZonedDateTime): ##java.time.ZonedDateTime = 
        let ZonedDateTime(x1) = x;
        x1


    /// ## Constructors

    pub def zonedDateTime(r: {year :: Int32, month :: Int32, dayOfMonth :: Int32, hour :: Int32, 
                            minute :: Int32, second :: Int32, nanoSecond :: Int32, zoneId :: ZoneId}): ZonedDateTime =
        import static java.time.ZonedDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32, Int32, ##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        ZonedDateTime(of(r.year, r.month, r.dayOfMonth, r.hour, r.minute, r.second, r.nanoSecond, Time/ZoneId.getZoneId(r.zoneId)))


    /// ## `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): ZonedDateTime & Impure =
        import static java.time.ZonedDateTime.now(): ##java.time.ZonedDateTime & Impure;
        ZonedDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): ZonedDateTime & Impure =
        import static java.time.ZonedDateTime.now(##java.time.ZoneId): ##java.time.ZonedDateTime & Impure;
        let ZoneId(z1) = zone;
        ZonedDateTime(now(z1))

    /// ## `from` functions

    pub def fromLocalDateTime(zone: {zone :: ZoneId},dateTime: LocalDateTime): ZonedDateTime =
        import static java.time.ZonedDateTime.of(##java.time.LocalDateTime, ##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let LocalDateTime(dt1) = dateTime;
        let ZoneId(z1) = zone.zone;
        ZonedDateTime(of(dt1, z1))


    pub def fromLocalDateLocalTime(zone: {zone :: ZoneId}, date: LocalDate, time: LocalTime): ZonedDateTime =
        import static java.time.ZonedDateTime.of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneId(z1) = zone.zone;
        ZonedDateTime(of(d1, t1, z1))

    pub def fromOffsetDateTime(x: OffsetDateTime): ZonedDateTime = 
        fromTemporalAccessorHelper(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)


    /// ## `to` functions

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: ZonedDateTime): LocalDateTime =
        import java.time.ZonedDateTime.toLocalDateTime(): ##java.time.LocalDateTime & Pure;
        let ZonedDateTime(x1) = x;
        LocalDateTime(toLocalDateTime(x1))


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: ZonedDateTime): LocalDate =
        import java.time.ZonedDateTime.toLocalDate(): ##java.time.LocalDate & Pure;
        let ZonedDateTime(x1) = x;
        LocalDate(toLocalDate(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: ZonedDateTime): LocalTime =
        import java.time.ZonedDateTime.toLocalTime(): ##java.time.LocalTime & Pure;
        let ZonedDateTime(x1) = x;
        LocalTime(toLocalTime(x1))

    /// ## `parse` / `format` functions

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(_)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Result[ZonedDateTime, String] =
        import static java.time.ZonedDateTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.ZonedDateTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Ok(ZonedDateTime(parse(cs, fmtr)))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }

    ///
    /// Returns ZonedDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: ZonedDateTime): String =
        import java.time.ZonedDateTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let ZonedDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.chrono.ChronoZonedDateTime.isBefore(##java.time.chrono.ChronoZonedDateTime): Bool & Pure;
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        let cy1 = y1 as ##java.time.chrono.ChronoZonedDateTime;
        isBefore(cx1, cy1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.chrono.ChronoZonedDateTime.isAfter(##java.time.chrono.ChronoZonedDateTime): Bool & Pure;
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        let cy1 = y1 as ##java.time.chrono.ChronoZonedDateTime;
        isAfter(cx1, cy1)

    /// ## Getters and Setters

    pub def getYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getYear(): Int32 & Pure ;
        let ZonedDateTime(x1) = x;
        getYear(x1)

    pub def setYear(year: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withYear(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withYear(x1, year))

    pub def getMonth(x: ZonedDateTime): Month =
        import java.time.ZonedDateTime.getMonth(): ##java.time.Month & Pure;
        let ZonedDateTime(x1) = x;
        Time/Month.unmarshal(getMonth(x1))

    pub def setMonth(month: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withMonth(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withMonth(x1, month))


    pub def getMonthValue(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMonth(): ##java.time.Month & Pure;
        import java.time.Month.getValue(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getValue(getMonth(x1))


    pub def getDayOfYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfYear(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getDayOfYear(x1)

    pub def setDayOfYear(dayOfYear: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfYear(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withDayOfYear(x1, dayOfYear))

    pub def getDayOfMonth(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfMonth(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getDayOfMonth(x1)

    pub def setDayOfMonth(dayOfMonth: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfMonth(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfWeek(x: ZonedDateTime): DayOfWeek =
        import java.time.ZonedDateTime.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let ZonedDateTime(x1) = x;
        Time/DayOfWeek.unmarshal(getDayOfWeek(x1))

    // no setDayOfWeek

    pub def getHour(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getHour(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getHour(x1)

    pub def setHour(hour: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withHour(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withHour(x1, hour))

    pub def getMinute(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMinute(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getMinute(x1)

    pub def setMinute(minute: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withMinute(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withMinute(x1, minute))

    pub def getSecond(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getSecond(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getSecond(x1)

    pub def setSecond(second: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withSecond(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withSecond(x1, second))

    pub def getNano(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getNano(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getNano(x1)

    pub def setNano(nano: Int32, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withNano(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withNano(x1, nano))

    pub def setZoneSameInstant(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withZoneSameInstant(##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        let zone1 = Time/ZoneId.getZoneId(zone);
        ZonedDateTime(withZoneSameInstant(x1, zone1))

    pub def setZoneSameLocal(zone: ZoneId, x: ZonedDateTime): ZonedDateTime =
        import java.time.ZonedDateTime.withZoneSameLocal(##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        let zone1 = Time/ZoneId.getZoneId(zone);
        ZonedDateTime(withZoneSameLocal(x1, zone1))


    pub def setToFixedOffsetZone(t: ZonedDateTime): ZonedDateTime = 
        import java.time.ZonedDateTime.withFixedOffsetZone(): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(t1) = t;
        ZonedDateTime(withFixedOffsetZone(t1))

    pub def setToEarlierOffsetAtOverlap(t: ZonedDateTime): ZonedDateTime = 
        import java.time.ZonedDateTime.withEarlierOffsetAtOverlap(): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(t1) = t;
        ZonedDateTime(withEarlierOffsetAtOverlap(t1))

    pub def setToLaterOffsetAtOverlap(t: ZonedDateTime): ZonedDateTime = 
        import java.time.ZonedDateTime.withLaterOffsetAtOverlap(): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(t1) = t;
        ZonedDateTime(withLaterOffsetAtOverlap(t1))

    /// DayOfWeek methods

    pub def setDayOfWeek(x: DayOfWeek, d: ZonedDateTime): ZonedDateTime = 
        import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/DayOfWeek.marshal(x);
        let d1 = getZonedDateTime(d) as ##java.time.temporal.Temporal;
        ZonedDateTime(adjustInto(x1, d1) as ##java.time.ZonedDateTime)

    /// MonthDay methods

    pub def setMonthDay(x: MonthDay, d: ZonedDateTime): ZonedDateTime = 
        import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/MonthDay.getMonthDay(x);
        let d1 = getZonedDateTime(d) as ##java.time.temporal.Temporal;
        ZonedDateTime(adjustInto(x1, d1) as ##java.time.ZonedDateTime)

    /// ZoneOffset methods

    pub def setZoneOffset(zo: ZoneOffset, dt: ZonedDateTime): ZonedDateTime = 
        import java.time.ZoneOffset.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let zo1 = Time/ZoneOffset.getZoneOffset(zo);
        let dt1 = getZonedDateTime(dt) as ##java.time.temporal.Temporal;
        ZonedDateTime(adjustInto(zo1, dt1) as ##java.time.ZonedDateTime)

    /// YearMonth methods

    pub def setYearMonth(x: YearMonth, dt: ZonedDateTime): ZonedDateTime = 
        import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/YearMonth.getYearMonth(x);
        let dt1 = getZonedDateTime(dt) as ##java.time.temporal.Temporal;
        ZonedDateTime(adjustInto(x1, dt1) as ##java.time.ZonedDateTime)

    /// LocalDate methods

    pub def setLocalDate(x: LocalDate, dt: ZonedDateTime): ZonedDateTime = 
        import java.time.LocalDate.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/LocalDate.getLocalDate(x);
        let dt1 = getZonedDateTime(dt) as ##java.time.temporal.Temporal;
        ZonedDateTime(adjustInto(x1, dt1) as ##java.time.ZonedDateTime)

    /// LocalDateTime methods

    pub def setLocalDateTime(x: LocalDateTime, dt: ZonedDateTime): ZonedDateTime = 
        import java.time.LocalDateTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/LocalDateTime.getLocalDateTime(x);
        let dt1 = getZonedDateTime(dt) as ##java.time.temporal.Temporal;
        ZonedDateTime(adjustInto(x1, dt1) as ##java.time.ZonedDateTime)

    /// LocalTime methods

    pub def setLocalTime(x: LocalTime, dt: ZonedDateTime): ZonedDateTime = 
        import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/LocalTime.getLocalTime(x);
        let dt1 = getZonedDateTime(dt) as ##java.time.temporal.Temporal;
        ZonedDateTime(adjustInto(x1, dt1) as ##java.time.ZonedDateTime)

    /// ## plus / minus functions

    pub def plusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusYears(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, years))

    pub def minusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusYears(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, years))

    pub def plusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusMonths(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, months))

    pub def minusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusMonths(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, months))

    pub def plusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusWeeks(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, weeks))

    pub def minusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusWeeks(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, weeks))

    pub def plusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusDays(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, days))

    pub def minusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusDays(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, days))

    pub def plusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusHours(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, hours))

    pub def minusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusHours(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, hours))

    pub def plusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusMinutes(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, minutes))

    pub def minusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusMinutes(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, minutes))

    pub def plusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusSeconds(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, seconds))

    pub def minusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusSeconds(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, seconds))

    pub def plusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusNanos(Int64): ##java.time.ZonedDateTime & Pure as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, nanos))

    pub def minusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusNanos(Int64): ##java.time.ZonedDateTime & Pure as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, nanos))

    pub def plusDuration(i: ZonedDateTime, x: ZDuration): ZonedDateTime =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let i1 = getZonedDateTime(i) as ##java.time.temporal.Temporal;
        let ZDuration(x1) = x;
        ZonedDateTime(addTo(x1, i1) as ##java.time.ZonedDateTime)
    
    pub def minusDuration(i: ZonedDateTime, x: ZDuration): ZonedDateTime =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let i1 = getZonedDateTime(i) as ##java.time.temporal.Temporal;
        let ZDuration(x1) = x;
        ZonedDateTime(subtractFrom(x1, i1) as ##java.time.ZonedDateTime)

    /// Period methods

    pub def plusPeriod(i: ZonedDateTime, x: Period): ZonedDateTime =
        import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/Period.getPeriod(x);
        let i1 = getZonedDateTime(i) as ##java.time.temporal.Temporal;
        ZonedDateTime(addTo(x1, i1) as ##java.time.ZonedDateTime)
    
    pub def minusPeriod(i: ZonedDateTime, x: Period): ZonedDateTime =
        import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/Period.getPeriod(x);
        let i1 = getZonedDateTime(i) as ##java.time.temporal.Temporal;
        ZonedDateTime(subtractFrom(x1, i1) as ##java.time.ZonedDateTime)



    /// ## between / until functions 


    pub def between(r: {start :: ZonedDateTime, end :: ZonedDateTime}): ZDuration =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration & Pure;
        let s1 = getZonedDateTime(r.start) as ##java.time.temporal.Temporal;
        let e1 = getZonedDateTime(r.end) as ##java.time.temporal.Temporal;
        ZDuration(between(s1, e1))

    /// `until` specialized

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import java.time.ZonedDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getZonedDateTime(r.start);
        let e1 = getZonedDateTime(r.end) as ##java.time.temporal.Temporal;
        until(b1, e1, u)

    pub def secondsUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as get_SECONDS;
        untilHelper(get_SECONDS() as ##java.time.temporal.TemporalUnit, r)

    pub def minutesUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as get_MINUTES;
        untilHelper(get_MINUTES() as ##java.time.temporal.TemporalUnit, r)

    pub def hoursUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
        untilHelper(get_HOURS() as ##java.time.temporal.TemporalUnit, r)

    pub def halfDaysUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as get_HALF_DAYS;
        untilHelper(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit, r)

    pub def daysUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as get_DAYS;
        untilHelper(get_DAYS() as ##java.time.temporal.TemporalUnit, r)

    pub def monthsUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit & Pure as get_MONTHS;
        untilHelper(get_MONTHS() as ##java.time.temporal.TemporalUnit, r)

    pub def yearsUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit & Pure as get_YEARS;
        untilHelper(get_YEARS() as ##java.time.temporal.TemporalUnit, r)

    pub def quarterYearsUntil(r: {start :: ZonedDateTime, end :: ZonedDateTime}): Int64 = 
        import static get java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.TemporalUnit & Pure as get_QUARTER_YEARS;
        untilHelper(get_QUARTER_YEARS(), r)


    /// ## generic helper functions

    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): ZonedDateTime = 
        import static java.time.ZonedDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.ZonedDateTime & Pure as fromTA;
        try {
            ZonedDateTime(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & Pure;
                bug!(getMessage(ex))
        }


}
