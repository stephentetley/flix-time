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

use Time.OffsetDateTime;
use Time.OffsetDateTime.{OffsetDateTime};
use Time/Format.DateTimeFormatter;
use Time/Format.DateTimeFormatter.{DateTimeFormatter};
use Time.LocalDate;
use Time.LocalDate.{LocalDate};
use Time.LocalDateTime;
use Time.LocalDateTime.{LocalDateTime};
use Time.LocalTime;
use Time.LocalTime.{LocalTime};
use Time.OffsetTime;
use Time.OffsetTime.{OffsetTime};
use Time.ZonedDateTime;
use Time.ZonedDateTime.{ZonedDateTime};
use Time.ZoneId;
use Time.ZoneId.{ZoneId};
use Time.ZoneOffset;
use Time.ZoneOffset.{ZoneOffset};

namespace Time {

    ///
    /// A wrapper around a Java OffsetDateTime.
    ///
    pub opaque type OffsetDateTime = ##java.time.OffsetDateTime

}

namespace Time/OffsetDateTime {

    pub def new(year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32, offset: ZoneOffset): OffsetDateTime =
        import java.time.OffsetDateTime:of(Int32, Int32, Int32, Int32, Int32, Int32, Int32, ##java.time.ZoneOffset);
        let ZoneOffset(o1) = offset;
        OffsetDateTime(of(year, month, dayOfMonth, hour, minute, second, nanoSecond, o1)) as & Pure

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): OffsetDateTime & Impure =
        import java.time.OffsetDateTime:now();
        OffsetDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetDateTime & Impure =
        import java.time.OffsetDateTime:now(##java.time.ZoneId);
        let ZoneId(z) = zone;
        OffsetDateTime(now(z))

    ///
    /// ___
    ///
    pub def minValue(): OffsetDateTime =
        import get java.time.OffsetDateTime:MIN as get_min;
        OffsetDateTime(get_min()) as & Pure

    ///
    /// ___
    ///
    pub def maxValue(): OffsetDateTime =
        import get java.time.OffsetDateTime:MAX as get_max;
        OffsetDateTime(get_max()) as & Pure

    pub def fromLocalDateTime(dateTime: LocalDateTime, offset: ZoneOffset): OffsetDateTime =
        import java.time.OffsetDateTime:of(##java.time.LocalDateTime, ##java.time.ZoneOffset);
        let LocalDateTime(dt) = dateTime;
        let ZoneOffset(o) = offset;
        OffsetDateTime(of(dt, o)) as & Pure

    pub def fromLocalDateLocalTime(date: LocalDate, time: LocalTime, offset: ZoneOffset): OffsetDateTime =
        import java.time.OffsetDateTime:of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneOffset);
        let LocalDate(d) = date;
        let LocalTime(t) = time;
        let ZoneOffset(o) = offset;
        OffsetDateTime(of(d, t, o)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        import java.time.OffsetDateTime.toLocalDate();
        let OffsetDateTime(x1) = x;
        LocalDate(x1.toLocalDate()) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        import java.time.OffsetDateTime.toLocalTime();
        let OffsetDateTime(x1) = x;
        LocalTime(x1.toLocalTime()) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        import java.time.OffsetDateTime.toLocalDateTime();
        let OffsetDateTime(x1) = x;
        LocalDateTime(x1.toLocalDateTime()) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        import java.time.OffsetDateTime.toOffsetTime();
        let OffsetDateTime(x1) = x;
        OffsetTime(x1.toOffsetTime()) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.toZonedDateTime();
        let OffsetDateTime(x1) = x;
        ZonedDateTime(x1.toZonedDateTime()) as & Pure

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    pub def toString(x: OffsetDateTime): String =
        import java.time.OffsetDateTime.toString();
        let OffsetDateTime(x1) = x;
        x1.toString() as & Pure

    ///
    /// Returns OffsetDateTime `x` as a String using `formatter`.
    ///
    pub def format(x: OffsetDateTime, formatter: DateTimeFormatter): String =
        import java.time.OffsetDateTime.format(##java.time.format.DateTimeFormatter);
        let OffsetDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[OffsetDateTime, String] = try {
        import java.lang.String.strip();
        import java.time.OffsetDateTime:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(OffsetDateTime(parse(cs))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("OffsetDateTime.fromString")
    }

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromStringWithFormat(s: String, formatter: DateTimeFormatter): Result[OffsetDateTime, String] = try {
        import java.lang.String.strip();
        import java.time.OffsetDateTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        let DateTimeFormatter(fmtr) = formatter;
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(OffsetDateTime(cs.parse(fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("OffsetDateTime.fromStringWithFormat")
    }


    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def equals(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.equals(##java.lang.Object);
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def before(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isBefore(##java.time.OffsetDateTime);
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        x1.isBefore(y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def after(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isAfter(##java.time.OffsetDateTime);
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        x1.isAfter(y1) as & Pure

    pub def plusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusYears(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(years)) as & Pure

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusYears(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(years)) as & Pure

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMonths(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(months)) as & Pure

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMonths(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(months)) as & Pure

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusWeeks(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(weeks)) as & Pure

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusWeeks(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(weeks)) as & Pure

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusDays(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(days)) as & Pure

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusDays(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(days)) as & Pure

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusHours(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(hours)) as & Pure

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusHours(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(hours)) as & Pure

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMinutes(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(minutes)) as & Pure

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMinutes(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(minutes)) as & Pure

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusSeconds(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(seconds)) as & Pure

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusSeconds(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(seconds)) as & Pure

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusNanos(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.plus(nanos)) as & Pure

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusNanos(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.minus(nanos)) as & Pure

    pub def getYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getYear();
        let OffsetDateTime(x1) = x;
        x1.getYear() as & Pure

    pub def putYear(x: OffsetDateTime, year: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withYear(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withYear(year)) as & Pure

    /// TODO - probably Month is worth an enum
    /// Current we use 1 (January) - 12 (December)
    pub def getMonth(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMonth();
        import java.time.Month.getValue();
        let OffsetDateTime(x1) = x;
        x1.getMonth().getValue() as & Pure

    pub def putMonth(x: OffsetDateTime, month: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withMonth(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withMonth(month)) as & Pure

    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfYear();
        let OffsetDateTime(x1) = x;
        x1.getDayOfYear() as & Pure

    pub def putDayOfYear(x: OffsetDateTime, dayOfYear: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfYear(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withDayOfYear(dayOfYear)) as & Pure

    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfMonth();
        let OffsetDateTime(x1) = x;
        x1.getDayOfMonth() as & Pure

    pub def putDayOfMonth(x: OffsetDateTime, dayOfMonth: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfMonth(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withDayOfMonth(dayOfMonth)) as & Pure

    /// TODO - probably DayOfWeek is worth an enum
    /// Current we use 1 (Monday) - 7 (Sunday)
    pub def getDayOfWeek(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfWeek();
        import java.time.DayOfWeek.getValue();
        let OffsetDateTime(x1) = x;
        x1.getDayOfWeek().getValue() as & Pure

    pub def getHour(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getHour();
        let OffsetDateTime(x1) = x;
        x1.getHour() as & Pure

    pub def putHour(x: OffsetDateTime, hour: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withHour(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withHour(hour)) as & Pure

    pub def getMinute(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMinute();
        let OffsetDateTime(x1) = x;
        x1.getMinute() as & Pure

    pub def putMinute(x: OffsetDateTime, minute: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withMinute(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withMinute(minute)) as & Pure

    pub def getSecond(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getSecond();
        let OffsetDateTime(x1) = x;
        x1.getSecond() as & Pure

    pub def putSecond(x: OffsetDateTime, second: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withSecond(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withSecond(second)) as & Pure

    pub def getNano(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getNano();
        let OffsetDateTime(x1) = x;
        x1.getNano() as & Pure

    pub def putNano(x: OffsetDateTime, nano: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withNano(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(x1.withNano(nano)) as & Pure

}
