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
            toString(x1) as & Pure
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
                let cs = strip(s) as ##java.lang.CharSequence & Pure;
                Some(ZonedDateTime(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[ZonedDateTime] {
        pub def eq(x: ZonedDateTime, y: ZonedDateTime): Bool = Time/ZonedDateTime.equals(x, y)
    }

    instance Hash[ZonedDateTime] {
        pub def hash(x: ZonedDateTime): Int = Time/ZonedDateTime.hashCode(x)
    }

    instance Order[ZonedDateTime] {
        pub def compare(x: ZonedDateTime, y: ZonedDateTime): Comparison = match Time/ZonedDateTime.compareTo(x,y) {
            case n if n < 0 => LessThan
            case n if n == 0 => EqualTo
            case _ => GreaterThan
        }
    }

    instance Boxable[ZonedDateTime] {
        pub def box(x: ZonedDateTime): Boxed = {
            let ZonedDateTime(x1) = x;
            let value = x1 as ##java.lang.Object;
            let compare = (o1, o2) -> Order.compare(ZonedDateTime(o1 as ##java.time.ZonedDateTime), ZonedDateTime(o2 as ##java.time.ZonedDateTime));
            let toString = o -> ToString.toString(ZonedDateTime(o as ##java.time.ZonedDateTime));
            BoxedObject(value, compare, toString)
        }
        pub def unbox(x: Boxed): ZonedDateTime = match x {
            case BoxedObject(v, _, _) => ZonedDateTime(v as ##java.time.ZonedDateTime)
            case _                    => ?bug
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
        let ZoneId(z1) = zone;
        ZonedDateTime(now(z1))

    pub def ofLocalDateTime(dateTime: LocalDateTime, zone: ZoneId): ZonedDateTime =
        import java.time.ZonedDateTime:of(##java.time.LocalDateTime, ##java.time.ZoneId);
        let LocalDateTime(dt1) = dateTime;
        let ZoneId(z1) = zone;
        ZonedDateTime(of(dt1, z1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: ZonedDateTime): LocalDateTime =
        import java.time.ZonedDateTime.toLocalDateTime();
        let ZonedDateTime(x1) = x;
        LocalDateTime(toLocalDateTime(x1)) as & Pure

    pub def ofLocalDateLocalTime(date: LocalDate, time: LocalTime, zone: ZoneId): ZonedDateTime =
        import java.time.ZonedDateTime:of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneId);
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneId(z1) = zone;
        ZonedDateTime(of(d1, t1, z1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: ZonedDateTime): LocalDate =
        import java.time.ZonedDateTime.toLocalDate();
        let ZonedDateTime(x1) = x;
        LocalDate(toLocalDate(x1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: ZonedDateTime): LocalTime =
        import java.time.ZonedDateTime.toLocalTime();
        let ZonedDateTime(x1) = x;
        LocalTime(toLocalTime(x1)) as & Pure



    ///
    /// Returns ZonedDateTime `x` as a String using `formatter`.
    ///
    pub def format(x: ZonedDateTime, formatter: DateTimeFormatter): String =
        import java.time.ZonedDateTime.format(##java.time.format.DateTimeFormatter);
        let ZonedDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr) as & Pure

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
            let cs = strip(s) as ##java.lang.CharSequence & Pure;
            Some(ZonedDateTime(parse(cs, fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.ZonedDateTime.equals(##java.lang.Object);
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

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
        compareTo(cx1, cy1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.chrono.ChronoZonedDateTime.isBefore(##java.time.chrono.ChronoZonedDateTime);
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        let cy1 = y1 as ##java.time.chrono.ChronoZonedDateTime;
        isBefore(cx1, cy1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.chrono.ChronoZonedDateTime.isAfter(##java.time.chrono.ChronoZonedDateTime);
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        let cy1 = y1 as ##java.time.chrono.ChronoZonedDateTime;
        isAfter(cx1, cy1) as & Pure

    pub def plusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusYears(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, years)) as & Pure

    pub def minusYears(x: ZonedDateTime, years: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusYears(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, years)) as & Pure

    pub def plusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusMonths(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, months)) as & Pure

    pub def minusMonths(x: ZonedDateTime, months: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusMonths(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, months)) as & Pure

    pub def plusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusWeeks(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, weeks)) as & Pure

    pub def minusWeeks(x: ZonedDateTime, weeks: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusWeeks(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, weeks)) as & Pure

    pub def plusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusDays(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, days)) as & Pure

    pub def minusDays(x: ZonedDateTime, days: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusDays(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, days)) as & Pure

    pub def plusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusHours(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, hours)) as & Pure

    pub def minusHours(x: ZonedDateTime, hours: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusHours(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, hours)) as & Pure

    pub def plusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusMinutes(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, minutes)) as & Pure

    pub def minusMinutes(x: ZonedDateTime, minutes: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusMinutes(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, minutes)) as & Pure

    pub def plusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusSeconds(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, seconds)) as & Pure

    pub def minusSeconds(x: ZonedDateTime, seconds: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusSeconds(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, seconds)) as & Pure

    pub def plusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.plusNanos(Int64) as plus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(plus(x1, nanos)) as & Pure

    pub def minusNanos(x: ZonedDateTime, nanos: Int64): ZonedDateTime =
        import java.time.ZonedDateTime.minusNanos(Int64) as minus;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(minus(x1, nanos)) as & Pure

    pub def getYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getYear();
        let ZonedDateTime(x1) = x;
        getYear(x1) as & Pure

    pub def putYear(x: ZonedDateTime, year: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withYear(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withYear(x1, year)) as & Pure

    pub def getMonth(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMonth();
        import java.time.Month.getValue();
        let ZonedDateTime(x1) = x;
        getValue(getMonth(x1)) as & Pure

    pub def putMonth(x: ZonedDateTime, month: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withMonth(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withMonth(x1, month)) as & Pure

    pub def getDayOfYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfYear();
        let ZonedDateTime(x1) = x;
        getDayOfYear(x1) as & Pure

    pub def putDayOfYear(x: ZonedDateTime, dayOfYear: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfYear(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withDayOfYear(x1, dayOfYear)) as & Pure

    pub def getDayOfMonth(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfMonth();
        let ZonedDateTime(x1) = x;
        getDayOfMonth(x1) as & Pure

    pub def putDayOfMonth(x: ZonedDateTime, dayOfMonth: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfMonth(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withDayOfMonth(x1, dayOfMonth)) as & Pure

    pub def getDayOfWeek(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfWeek();
        import java.time.DayOfWeek.getValue();
        let ZonedDateTime(x1) = x;
        getValue(getDayOfWeek(x1)) as & Pure

    pub def getHour(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getHour();
        let ZonedDateTime(x1) = x;
        getHour(x1) as & Pure

    pub def putHour(x: ZonedDateTime, hour: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withHour(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withHour(x1, hour)) as & Pure

    pub def getMinute(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMinute();
        let ZonedDateTime(x1) = x;
        getMinute(x1) as & Pure

    pub def putMinute(x: ZonedDateTime, minute: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withMinute(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withMinute(x1, minute)) as & Pure

    pub def getSecond(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getSecond();
        let ZonedDateTime(x1) = x;
        getSecond(x1) as & Pure

    pub def putSecond(x: ZonedDateTime, second: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withSecond(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withSecond(x1, second)) as & Pure

    pub def getNano(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getNano();
        let ZonedDateTime(x1) = x;
        getNano(x1) as & Pure

    pub def putNano(x: ZonedDateTime, nano: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withNano(Int32);
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withNano(x1, nano)) as & Pure

}
