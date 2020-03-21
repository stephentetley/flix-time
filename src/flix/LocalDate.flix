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
/// A wrapper around a Java LocalDate.
///
opaque type LocalDate = ##java.time.LocalDate

///
/// A wrapper around a Java DateTimeFormatter for dates.
///
opaque type DateFormatter = ##java.time.format.DateTimeFormatter

namespace LocalDate {

    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate & Impure =
        import java.time.LocalDate:now();
        LocalDate(now())

    ///
    /// Returns the given date `x` as a string using ____.
    ///
    pub def toString(x: LocalDate): String =
        import java.time.LocalDate.toString();
        let LocalDate(t) = x;
        t.toString() as & Pure

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[LocalDate, String] = try {
        import java.lang.String.strip();
        import java.time.LocalDate:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(LocalDate(parse(cs))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalDate.fromString")
    }

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromStringWithFormat(s: String, formatter: DateFormatter): Result[LocalDate, String] = try {
        import java.lang.String.strip();
        import java.time.LocalDate:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        let DateFormatter(fmtr) = formatter;
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(LocalDate(cs.parse(fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalDate.fromStringWithFormat")
    }

    pub def basic_iso_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:BASIC_ISO_DATE as get_basic_iso_date;
        DateFormatter(get_basic_iso_date()) as & Pure

    pub def iso_local_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_DATE as get_iso_local_date;
        DateFormatter(get_iso_local_date()) as & Pure

    pub def iso_offset_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_DATE as get_iso_offset_date;
        DateFormatter(get_iso_offset_date()) as & Pure

    pub def iso_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_DATE as get_iso_date;
        DateFormatter(get_iso_date()) as & Pure

    pub def iso_oridinal_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_ORDINAL_DATE as get_iso_oridinal_date;
        DateFormatter(get_iso_oridinal_date()) as & Pure

    pub def iso_week_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_WEEK_DATE as get_iso_week_date;
        DateFormatter(get_iso_week_date()) as & Pure


    pub def formatter(pattern: String): Result[DateFormatter, String] = try {
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        Ok(DateFormatter(pattern.strip().ofPattern())) as & Pure
    } catch {
        case _: ##java.lang.IllegalArgumentException => Err("Time/Formatter.formatter")
    }

    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def equals(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.equals(##java.lang.Object);
        let LocalDate(d1) = x;
        let LocalDate(d2) = y;
        d1.equals(d2 as ##java.lang.Object) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def before(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isBefore(##java.time.chrono.ChronoLocalDate);
        let LocalDate(d1) = x;
        let LocalDate(d2) = y;
        d1.isBefore(d2 as ##java.time.chrono.ChronoLocalDate) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def after(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isAfter(##java.time.chrono.ChronoLocalDate);
        let LocalDate(d1) = x;
        let LocalDate(d2) = y;
        d1.isAfter(d2 as ##java.time.chrono.ChronoLocalDate) as & Pure

    pub def plusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.plusYears(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(years)) as & Pure

    pub def minusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.minusYears(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(years)) as & Pure

    pub def plusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.plusMonths(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(months)) as & Pure

    pub def minusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.minusMonths(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(months)) as & Pure

    pub def plusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.plusWeeks(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(weeks)) as & Pure

    pub def minusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.minusWeeks(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(weeks)) as & Pure

    pub def plusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.plusDays(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(days)) as & Pure

    pub def minusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.minusDays(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(days)) as & Pure

    pub def withYear(x: LocalDate, year: Int32): LocalDate =
        import java.time.LocalDate.withYear(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withYear(year)) as & Pure

    pub def withMonth(x: LocalDate, month: Int32): LocalDate =
        import java.time.LocalDate.withMonth(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withMonth(month)) as & Pure

    pub def withDayOfYear(x: LocalDate, dayOfYear: Int32): LocalDate =
        import java.time.LocalDate.withDayOfYear(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withDayOfYear(dayOfYear)) as & Pure

    pub def withDayOfMonth(x: LocalDate, dayOfMonth: Int32): LocalDate =
        import java.time.LocalDate.withDayOfMonth(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withDayOfMonth(dayOfMonth)) as & Pure

}
