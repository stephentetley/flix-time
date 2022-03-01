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
            import java.lang.String.strip(): String & Pure;
            import static java.time.ZonedDateTime.parse(##java.lang.CharSequence): ##java.time.ZonedDateTime & Pure;
            try {
                let cs = strip(s) as ##java.lang.CharSequence & Pure;
                Some(ZonedDateTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[ZonedDateTime] {
        pub def eq(x: ZonedDateTime, y: ZonedDateTime): Bool = Time/ZonedDateTime.equals(x, y)
    }

    instance Hash[ZonedDateTime] {
        pub def hash(x: ZonedDateTime): Int32 = Time/ZonedDateTime.hashCode(x)
    }

    instance Order[ZonedDateTime] {
        pub def compare(x: ZonedDateTime, y: ZonedDateTime): Comparison =
            Time/ZonedDateTime.compareTo(x,y) |> Comparison.fromInt32
    }

    instance Boxable[ZonedDateTime]

}

namespace Time/ZonedDateTime {

    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time.DayOfWeek;
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def new(year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32, zone: ZoneId): ZonedDateTime =
        import static java.time.ZonedDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32, Int32, ##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let ZoneId(z1) = zone;
        ZonedDateTime(of(year, month, dayOfMonth, hour, minute, second, nanoSecond, z1))

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

    pub def ofLocalDateTime(dateTime: LocalDateTime, zone: ZoneId): ZonedDateTime =
        import static java.time.ZonedDateTime.of(##java.time.LocalDateTime, ##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let LocalDateTime(dt1) = dateTime;
        let ZoneId(z1) = zone;
        ZonedDateTime(of(dt1, z1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: ZonedDateTime): LocalDateTime =
        import java.time.ZonedDateTime.toLocalDateTime(): ##java.time.LocalDateTime & Pure;
        let ZonedDateTime(x1) = x;
        LocalDateTime(toLocalDateTime(x1))

    pub def ofLocalDateLocalTime(date: LocalDate, time: LocalTime, zone: ZoneId): ZonedDateTime =
        import static java.time.ZonedDateTime.of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneId(z1) = zone;
        ZonedDateTime(of(d1, t1, z1))

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


    ///
    /// Returns ZonedDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter, x: ZonedDateTime): String =
        import java.time.ZonedDateTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let ZonedDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a ZonedDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(_)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter, s: String): Option[ZonedDateTime] =
        import java.lang.String.strip(): String & Pure;
        import static java.time.ZonedDateTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.ZonedDateTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence & Pure;
            Some(ZonedDateTime(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: ZonedDateTime, y: ZonedDateTime): Bool =
        import java.time.ZonedDateTime.equals(##java.lang.Object): Bool & Pure;
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.hashCode(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        hashCode(x1)


    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def compareTo(x: ZonedDateTime, y: ZonedDateTime): Int32 =
        import java.time.chrono.ChronoZonedDateTime.compareTo(##java.time.chrono.ChronoZonedDateTime): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        let ZonedDateTime(y1) = y;
        let cx1 = x1 as ##java.time.chrono.ChronoZonedDateTime;
        let cy1 = y1 as ##java.time.chrono.ChronoZonedDateTime;
        compareTo(cx1, cy1)


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

    pub def getYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getYear(): Int32 & Pure ;
        let ZonedDateTime(x1) = x;
        getYear(x1)

    pub def putYear(x: ZonedDateTime, year: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withYear(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withYear(x1, year))

    pub def getMonth(x: ZonedDateTime): Month =
        import java.time.ZonedDateTime.getMonth(): ##java.time.Month & Pure;
        let ZonedDateTime(x1) = x;
        Time/Month.fromNative(getMonth(x1))

    pub def getMonthValue(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMonth(): ##java.time.Month & Pure;
        import java.time.Month.getValue(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getValue(getMonth(x1))

    pub def putMonth(x: ZonedDateTime, month: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withMonth(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withMonth(x1, month))

    pub def getDayOfYear(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfYear(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getDayOfYear(x1)

    pub def putDayOfYear(x: ZonedDateTime, dayOfYear: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfYear(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withDayOfYear(x1, dayOfYear))

    pub def getDayOfMonth(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getDayOfMonth(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getDayOfMonth(x1)

    pub def putDayOfMonth(x: ZonedDateTime, dayOfMonth: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withDayOfMonth(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfWeek(x: ZonedDateTime): DayOfWeek =
        import java.time.ZonedDateTime.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let ZonedDateTime(x1) = x;
        Time/DayOfWeek.fromNative(getDayOfWeek(x1))

    pub def getHour(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getHour(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getHour(x1)

    pub def putHour(x: ZonedDateTime, hour: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withHour(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withHour(x1, hour))

    pub def getMinute(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getMinute(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getMinute(x1)

    pub def putMinute(x: ZonedDateTime, minute: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withMinute(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withMinute(x1, minute))

    pub def getSecond(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getSecond(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getSecond(x1)

    pub def putSecond(x: ZonedDateTime, second: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withSecond(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withSecond(x1, second))

    pub def getNano(x: ZonedDateTime): Int32 =
        import java.time.ZonedDateTime.getNano(): Int32 & Pure;
        let ZonedDateTime(x1) = x;
        getNano(x1)

    pub def putNano(x: ZonedDateTime, nano: Int32): ZonedDateTime =
        import java.time.ZonedDateTime.withNano(Int32): ##java.time.ZonedDateTime & Pure;
        let ZonedDateTime(x1) = x;
        ZonedDateTime(withNano(x1, nano))

}
