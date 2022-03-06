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
    /// A wrapper around a Java LocalDateTime.
    ///
    pub opaque type LocalDateTime = ##java.time.LocalDateTime

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[LocalDateTime] {
        pub def toString(x: LocalDateTime): String =
            import java.time.LocalDateTime.toString(): String & Pure;
            let LocalDateTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDateTime] {
        pub def fromString(s: String): Option[LocalDateTime] =
            import java.lang.String.strip(): String & Pure;
            import static java.time.LocalDateTime.parse(##java.lang.CharSequence): ##java.time.LocalDateTime & Pure;
            try {
                let cs = strip(s) as ##java.lang.CharSequence;
                Some(LocalDateTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[LocalDateTime] {
        pub def eq(x: LocalDateTime, y: LocalDateTime): Bool = Time/LocalDateTime.equals(x, y)
    }

    instance Hash[LocalDateTime] {
        pub def hash(x: LocalDateTime): Int32 = Time/LocalDateTime.hashCode(x)
    }

    instance Order[LocalDateTime] {
        pub def compare(x: LocalDateTime, y: LocalDateTime): Comparison =
            Time/LocalDateTime.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[LocalDateTime] {
        pub def minValue(): LocalDateTime =
            import static get java.time.LocalDateTime.MIN: ##java.time.LocalDateTime & Pure as getMIN;
            LocalDateTime(getMIN())
    }

    instance UpperBound[LocalDateTime] {
        pub def maxValue(): LocalDateTime =
            import static get java.time.LocalDateTime.MAX: ##java.time.LocalDateTime & Pure as getMAX;
            LocalDateTime(getMAX())
    }

    instance Boxable[LocalDateTime]

}

namespace Time/LocalDateTime {

    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time.DayOfWeek;
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time/Temporal.ChronoUnit;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(x: {year :: Int32, month :: Int32, dayOfMonth :: Int32, hour :: Int32, minute :: Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime & Pure;
        LocalDateTime(of(x.year, x.month, x.dayOfMonth, x.hour, x.minute))

    pub def newWithSecond(x: {year :: Int32, month :: Int32, dayOfMonth :: Int32,
                                hour :: Int32, minute :: Int32, second :: Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime & Pure;
        LocalDateTime(of(x.year, x.month, x.dayOfMonth, x.hour, x.minute, x.second))

    pub def newWithSecondAndNano(x: {year :: Int32, month :: Int32, dayOfMonth :: Int32,
                                        hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime & Pure;
        LocalDateTime(of(x.year, x.month, x.dayOfMonth, x.hour, x.minute, x.second, x.nanoSecond))

    /// TODO - potentially remove getFields...
    pub def getFields(x: LocalDateTime): {year :: Int32, month :: Int32, dayOfMonth :: Int32,
                                            hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32} =
        { year = getYear(x), month = getMonthValue(x), dayOfMonth = getDayOfMonth(x)
        , hour = getHour(x), minute = getMinute(x), second = getSecond(x)
        , nanoSecond = getNano(x) }

    ///
    /// Returns the current date-time from the system clock.
    ///
    pub def now(): LocalDateTime & Impure =
        import static java.time.LocalDateTime.now(): ##java.time.LocalDateTime & Impure;
        LocalDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): LocalDateTime & Impure =
        import static java.time.LocalDateTime.now(##java.time.ZoneId): ##java.time.LocalDateTime & Impure;
        let ZoneId(z) = zone;
        LocalDateTime(now(z))



    pub def ofLocalDateLocalTime(d: LocalDate, t: LocalTime): LocalDateTime =
        import static java.time.LocalDateTime.of(##java.time.LocalDate, ##java.time.LocalTime): ##java.time.LocalDateTime & Pure;
        let LocalDate(d1) = d;
        let LocalTime(t1) = t;
        LocalDateTime(of(d1, t1))

    pub def ofEpochSecond(epochSecond: Int64, nanoOfSecond: Int32, offset: ZoneOffset): LocalDateTime =
        import static java.time.LocalDateTime.ofEpochSecond(Int64, Int32, ##java.time.ZoneOffset): ##java.time.LocalDateTime & Pure;
        let ZoneOffset(o1) = offset;
        LocalDateTime(ofEpochSecond(epochSecond, nanoOfSecond, o1))

/*
    pub def ofInstant(x: Instant, zoneId: ZoneId): LocalDateTime =
        import static java.time.LocalDateTime.ofInstant(##java.time.Instant, ##java.time.ZoneId);
        let Instant(x1) = x;
        let ZoneId(z1) = zoneId;
        LocalDateTime(ofInstant(x1, z1)) as & Pure
*/

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        import java.time.LocalDateTime.toLocalDate(): ##java.time.LocalDate & Pure;
        let LocalDateTime(x1) = x;
        LocalDate(toLocalDate(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        import java.time.LocalDateTime.toLocalTime(): ##java.time.LocalTime & Pure;
        let LocalDateTime(x1) = x;
        LocalTime(toLocalTime(x1))



    ///
    /// Returns LocalDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter, x: LocalDateTime): String =
        import java.time.LocalDateTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let LocalDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter, s: String): Option[LocalDateTime] =
        import java.lang.String.strip(): String & Pure;
        import static java.time.LocalDateTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalDateTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence;
            Some(LocalDateTime(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.equals(##java.lang.Object): Bool & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.hashCode(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        hashCode(x1)

    pub def compareTo(x: LocalDateTime, y: LocalDateTime): Int32 =
        import java.time.LocalDateTime.compareTo(##java.time.chrono.ChronoLocalDateTime): Int32 & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        let cy1 = y1 as ##java.time.chrono.ChronoLocalDateTime;
        compareTo(x1, cy1)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isBefore(##java.time.chrono.ChronoLocalDateTime): Bool & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        isBefore(x1, y1 as ##java.time.chrono.ChronoLocalDateTime)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isAfter(##java.time.chrono.ChronoLocalDateTime): Bool & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        isAfter(x1, y1 as ##java.time.chrono.ChronoLocalDateTime)

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusYears(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusYears(x1, years))

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusYears(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusYears(x1, years))

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMonths(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusMonths(x1, months))

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMonths(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusMonths(x1, months))

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusWeeks(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusWeeks(x1, weeks))

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusWeeks(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusWeeks(x1, weeks))

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusDays(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusDays(x1, days))

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusDays(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusDays(x1, days))

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusHours(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusHours(x1, hours))

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusHours(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusHours(x1, hours))

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMinutes(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMinutes(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusSeconds(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusSeconds(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusNanos(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusNanos(x1, nanos))

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusNanos(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusNanos(x1, nanos))

    pub def getYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getYear(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getYear(x1)

    pub def putYear(x: LocalDateTime, year: Int32): LocalDateTime =
        import java.time.LocalDateTime.withYear(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withYear(x1, year))

    pub def getMonth(x: LocalDateTime): Month =
        import java.time.LocalDateTime.getMonth(): ##java.time.Month & Pure;
        let LocalDateTime(x1) = x;
        Time/Month.fromNative(getMonth(x1))

    pub def getMonthValue(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMonth(): ##java.time.Month & Pure;
        import java.time.Month.getValue(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getValue(getMonth(x1))


    pub def putMonth(x: LocalDateTime, month: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMonth(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withMonth(x1, month))

    pub def getDayOfYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfYear(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getDayOfYear(x1)

    pub def putDayOfYear(x: LocalDateTime, dayOfYear: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfYear(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withDayOfYear(x1, dayOfYear))

    pub def getDayOfMonth(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfMonth(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getDayOfMonth(x1)

    pub def putDayOfMonth(x: LocalDateTime, dayOfMonth: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfMonth(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfWeek(x: LocalDateTime): DayOfWeek =
        import java.time.LocalDateTime.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let LocalDateTime(x1) = x;
        Time/DayOfWeek.fromNative(getDayOfWeek(x1))

    pub def getHour(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getHour(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getHour(x1)

    pub def putHour(x: LocalDateTime, hour: Int32): LocalDateTime =
        import java.time.LocalDateTime.withHour(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withHour(x1, hour))

    pub def getMinute(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMinute(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getMinute(x1)

    pub def putMinute(x: LocalDateTime, minute: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMinute(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withMinute(x1, minute))

    pub def getSecond(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getSecond(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getSecond(x1)

    pub def putSecond(x: LocalDateTime, second: Int32): LocalDateTime =
        import java.time.LocalDateTime.withSecond(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withSecond(x1, second))

    pub def getNano(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getNano(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getNano(x1)

    pub def putNano(x: LocalDateTime, nano: Int32): LocalDateTime =
        import java.time.LocalDateTime.withNano(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withNano(x1, nano))

    pub def until(b: LocalDateTime, e: LocalDateTime, unit: ChronoUnit): Int64 =
        import java.time.LocalDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let LocalDateTime(b1) = b;
        let LocalDateTime(e1) = e;
        let u1 = Time/Temporal/ChronoUnit.toNative(unit);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        until(b1, te1, tu1)

}