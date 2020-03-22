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

///
/// A wrapper around a Java LocalDateTime.
///
opaque type LocalDateTime = ##java.time.LocalDateTime



namespace LocalDateTime {

    pub def new(year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32): LocalDateTime =
        import java.time.LocalDateTime:of(Int32, Int32, Int32, Int32, Int32);
        LocalDateTime(of(year, month, dayOfMonth, hour, minute)) as & Pure

    pub def newWithSecond(year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32): LocalDateTime =
        import java.time.LocalDateTime:of(Int32, Int32, Int32, Int32, Int32, Int32);
        LocalDateTime(of(year, month, dayOfMonth, hour, minute, second)) as & Pure

    pub def newWithSecondAndNano(year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32): LocalDateTime =
        import java.time.LocalDateTime:of(Int32, Int32, Int32, Int32, Int32, Int32, Int32);
        LocalDateTime(of(year, month, dayOfMonth, hour, minute, second, nanoSecond)) as & Pure

    ///
    /// Returns the current date-time from the system clock.
    ///
    pub def now(): LocalDateTime & Impure =
        import java.time.LocalDateTime:now();
        LocalDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): LocalDateTime & Impure =
        import java.time.LocalDateTime:now(##java.time.ZoneId);
        let ZoneId(z) = zone;
        LocalDateTime(now(z))

    ///
    /// ___
    ///
    pub def minValue(): LocalDateTime =
        import get java.time.LocalDateTime:MIN as get_min;
        LocalDateTime(get_min()) as & Pure

    ///
    /// ___
    ///
    pub def maxValue(): LocalDateTime =
        import get java.time.LocalDateTime:MAX as get_max;
        LocalDateTime(get_max()) as & Pure

    pub def fromLocalDateLocalTime(date: LocalDate, time: LocalTime): LocalDateTime =
        import java.time.LocalDateTime:of(##java.time.LocalDate, ##java.time.LocalTime);
        let LocalDate(d) = date;
        let LocalTime(t) = time;
        LocalDateTime(of(d, t)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        import java.time.LocalDateTime.toLocalDate();
        let LocalDateTime(x1) = x;
        LocalDate(x1.toLocalDate()) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        import java.time.LocalDateTime.toLocalTime();
        let LocalDateTime(x1) = x;
        LocalTime(x1.toLocalTime()) as & Pure

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    pub def toString(x: LocalDateTime): String =
        import java.time.LocalDateTime.toString();
        let LocalDateTime(x1) = x;
        x1.toString() as & Pure

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[LocalDateTime, String] = try {
        import java.lang.String.strip();
        import java.time.LocalDateTime:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(LocalDateTime(parse(cs))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalDateTime.fromString")
    }

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromStringWithFormat(s: String, formatter: DateTimeFormatter): Result[LocalDateTime, String] = try {
        import java.lang.String.strip();
        import java.time.LocalDateTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        let DateTimeFormatter(fmtr) = formatter;
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(LocalDateTime(cs.parse(fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalDateTime.fromStringWithFormat")
    }


    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def equals(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.equals(##java.lang.Object);
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def before(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isBefore(##java.time.chrono.ChronoLocalDateTime);
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        x1.isBefore(y1 as ##java.time.chrono.ChronoLocalDateTime) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def after(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isAfter(##java.time.chrono.ChronoLocalDateTime);
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        x1.isAfter(y1 as ##java.time.chrono.ChronoLocalDateTime) as & Pure

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusYears(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(years)) as & Pure

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusYears(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(years)) as & Pure

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMonths(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(months)) as & Pure

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMonths(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(months)) as & Pure

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusWeeks(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(weeks)) as & Pure

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusWeeks(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(weeks)) as & Pure

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusDays(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(days)) as & Pure

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusDays(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(days)) as & Pure

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusHours(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(hours)) as & Pure

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusHours(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(hours)) as & Pure

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMinutes(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(minutes)) as & Pure

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMinutes(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(minutes)) as & Pure

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusSeconds(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(seconds)) as & Pure

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusSeconds(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(seconds)) as & Pure

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusNanos(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(nanos)) as & Pure

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusNanos(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(nanos)) as & Pure

    pub def withYear(x: LocalDateTime, year: Int32): LocalDateTime =
        import java.time.LocalDateTime.withYear(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withYear(year)) as & Pure

    pub def withMonth(x: LocalDateTime, month: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMonth(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withMonth(month)) as & Pure

    pub def withDayOfYear(x: LocalDateTime, dayOfYear: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfYear(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withDayOfYear(dayOfYear)) as & Pure

    pub def withDayOfMonth(x: LocalDateTime, dayOfMonth: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfMonth(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withDayOfMonth(dayOfMonth)) as & Pure

    pub def withHour(x: LocalDateTime, hour: Int32): LocalDateTime =
        import java.time.LocalDateTime.withHour(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withHour(hour)) as & Pure

    pub def withMinute(x: LocalDateTime, minute: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMinute(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withMinute(minute)) as & Pure

    pub def withSecond(x: LocalDateTime, second: Int32): LocalDateTime =
        import java.time.LocalDateTime.withSecond(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withSecond(second)) as & Pure

    pub def withNano(x: LocalDateTime, nano: Int32): LocalDateTime =
        import java.time.LocalDateTime.withNano(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withNano(nano)) as & Pure

}
