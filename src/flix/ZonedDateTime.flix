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
    pub opaque type ZonedDateTime = ##java.time.ZonedDateTime

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[ZonedDateTime] {
        pub def toString(x: ZonedDateTime): String =
            import java.time.ZonedDateTime.toString();
            let ZonedDateTime(x1) = x;
            x1.toString() as & Pure
    }

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[ZonedDateTime] {
        pub def fromString(s: String): Option[ZonedDateTime] =
            import java.lang.String.strip();
            import java.time.ZonedDateTime:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(ZonedDateTime(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[ZonedDateTime] {
        pub def eq(x: ZonedDateTime, y: ZonedDateTime): Bool =
            import java.time.ZonedDateTime.equals(##java.lang.Object);
            let ZonedDateTime(x1) = x;
            let ZonedDateTime(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure

        pub def neq(x: ZonedDateTime, y: ZonedDateTime): Bool = not (x == y)
    }

    instance Hash[ZonedDateTime] {
        pub def hash(x: ZonedDateTime): Int = Time/ZonedDateTime.hashCode(x)
    }

    instance Order[ZonedDateTime] {
        pub def less(x: ZonedDateTime, y: ZonedDateTime): Bool = Time/ZonedDateTime.compareTo(x,y) < 0
        pub def lessEqual(x: ZonedDateTime, y: ZonedDateTime): Bool = Time/ZonedDateTime.compareTo(x,y) < 0 or x == y
        pub def greater(x: ZonedDateTime, y: ZonedDateTime): Bool = Time/ZonedDateTime.compareTo(x,y) > 0
        pub def greaterEqual(x: ZonedDateTime, y: ZonedDateTime): Bool = Time/ZonedDateTime.compareTo(x,y) > 0 or x == y
        pub def compare(x: ZonedDateTime, y: ZonedDateTime): Comparison = match Time/ZonedDateTime.compareTo(x,y) {
            case x if x < 0 => LessThan
            case x if x == 0 => EqualTo
            case _ => GreaterThan
        }
    }
    
}

namespace Time/ZonedDateTime {

    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def new(year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32, zone: ZoneId): ZonedDateTime =
        import java.time.ZonedDateTime:of(Int32, Int32, Int32, Int32, Int32, Int32, Int32, ##java.time.ZoneId);
        let ZoneId(z1) = zone;
        ZonedDateTime(of(year, month, dayOfMonth, hour, minute, second, nanoSecond, z1)) as & Pure

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): ZonedDateTime & Impure =
        import java.time.ZonedDateTime:now();
        ZonedDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): ZonedDateTime & Impure =
        import java.time.ZonedDateTime:now(##java.time.ZoneId);
        let ZoneId(z) = zone;
        ZonedDateTime(now(z))

    pub def fromLocalDateTime(dateTime: LocalDateTime, zone: ZoneId): ZonedDateTime =
        import java.time.ZonedDateTime:of(##java.time.LocalDateTime, ##java.time.ZoneId);
        let LocalDateTime(dt) = dateTime;
        let ZoneId(z) = zone;
        ZonedDateTime(of(dt, z)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: ZonedDateTime): LocalDateTime =
        import java.time.ZonedDateTime.toLocalDateTime();
        let ZonedDateTime(x1) = x;
        LocalDateTime(x1.toLocalDateTime()) as & Pure

    pub def fromLocalDateLocalTime(date: LocalDate, time: LocalTime, zone: ZoneId): ZonedDateTime =
        import java.time.ZonedDateTime:of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneId);
        let LocalDate(d) = date;
        let LocalTime(t) = time;
        let ZoneId(z) = zone;
        ZonedDateTime(of(d, t, z)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: ZonedDateTime): LocalDate =
        import java.time.ZonedDateTime.toLocalDate();
        let ZonedDateTime(x1) = x;
        LocalDate(x1.toLocalDate()) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: ZonedDateTime): LocalTime =
        import java.time.ZonedDateTime.toLocalTime();
        let ZonedDateTime(x1) = x;
        LocalTime(x1.toLocalTime()) as & Pure



    ///
    /// Returns ZonedDateTime `x` as a String using `formatter`.
    ///
    pub def format(x: ZonedDateTime, formatter: DateTimeFormatter): String =
        import java.time.ZonedDateTime.format(##java.time.format.DateTimeFormatter);
        let ZonedDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(_)`, a parse failure is indicated by `None`.
    ///
    pub def parse(s: String, formatter: DateTimeFormatter): Option[ZonedDateTime] =
        import java.lang.String.strip();
        import java.time.ZonedDateTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(ZonedDateTime(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }


    pub def hashCode(x: ZonedDateTime): Int32 = 
        import java.time.ZonedDateTime.hashCode();
        let ZonedDateTime(x1) = x;
        hashCode(x1) as & Pure


    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def compareTo(x: ZonedDateTime, y: ZonedDateTime): Int32 =
        import java.time.chrono.ChronoZonedDateTime.compareTo(##java.time.chrono.ChronoZonedDateTime);
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        let cy1 = y1 as ##java.time.chrono.ChronoZonedDateTime;
        cx1.compareTo(cy1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.chrono.ChronoZonedDateTime.isBefore(##java.time.chrono.ChronoZonedDateTime);
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let zx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        zx1.isBefore(y1 as ##java.time.chrono.ChronoZonedDateTime) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.chrono.ChronoZonedDateTime.isAfter(##java.time.chrono.ChronoZonedDateTime);
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let zx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        zx1.isAfter(y1 as ##java.time.chrono.ChronoZonedDateTime) as & Pure

    pub def plusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusYears(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(years)) as & Pure

    pub def minusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusYears(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(years)) as & Pure

    pub def plusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusMonths(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(months)) as & Pure

    pub def minusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusMonths(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(months)) as & Pure

    pub def plusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusWeeks(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(weeks)) as & Pure

    pub def minusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusWeeks(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(weeks)) as & Pure

    pub def plusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusDays(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(days)) as & Pure

    pub def minusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusDays(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(days)) as & Pure

    pub def plusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusHours(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(hours)) as & Pure

    pub def minusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusHours(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(hours)) as & Pure

    pub def plusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusMinutes(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(minutes)) as & Pure

    pub def minusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusMinutes(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(minutes)) as & Pure

    pub def plusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusSeconds(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(seconds)) as & Pure

    pub def minusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusSeconds(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(seconds)) as & Pure

    pub def plusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusNanos(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.plus(nanos)) as & Pure

    pub def minusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusNanos(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.minus(nanos)) as & Pure

    pub def getYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getYear();
        let ZonedDateTime(x1) = x;
        x1.getYear() as & Pure

    pub def putYear(x: ZonedDateTime, year: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withYear(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withYear(year)) as & Pure

    pub def getMonth(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMonth();
        import java.time.Month.getValue();
        let ZonedDateTime(x1) = x;
        x1.getMonth().getValue() as & Pure

    pub def putMonth(x: ZonedDateTime, month: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withMonth(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withMonth(month)) as & Pure

    pub def getDayOfYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfYear();
        let ZonedDateTime(x1) = x;
        x1.getDayOfYear() as & Pure

    pub def putDayOfYear(x: ZonedDateTime, dayOfYear: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfYear(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withDayOfYear(dayOfYear)) as & Pure

    pub def getDayOfMonth(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfMonth();
        let ZonedDateTime(x1) = x;
        x1.getDayOfMonth() as & Pure

    pub def putDayOfMonth(x: ZonedDateTime, dayOfMonth: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfMonth(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withDayOfMonth(dayOfMonth)) as & Pure

    pub def getDayOfWeek(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfWeek();
        import java.time.DayOfWeek.getValue();
        let ZonedDateTime(x1) = x;
        x1.getDayOfWeek().getValue() as & Pure

    pub def getHour(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getHour();
        let ZonedDateTime(x1) = x;
        x1.getHour() as & Pure

    pub def putHour(x: ZonedDateTime, hour: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withHour(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withHour(hour)) as & Pure

    pub def getMinute(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMinute();
        let ZonedDateTime(x1) = x;
        x1.getMinute() as & Pure

    pub def putMinute(x: ZonedDateTime, minute: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withMinute(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withMinute(minute)) as & Pure

    pub def getSecond(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getSecond();
        let ZonedDateTime(x1) = x;
        x1.getSecond() as & Pure

    pub def putSecond(x: ZonedDateTime, second: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withSecond(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withSecond(second)) as & Pure

    pub def getNano(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getNano();
        let ZonedDateTime(x1) = x;
        x1.getNano() as & Pure

    pub def putNano(x: ZonedDateTime, nano: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withNano(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(x1.withNano(nano)) as & Pure

}
