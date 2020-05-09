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

use Time.LocalDate;
use Time.LocalDate.{LocalDate};
use Time.Error.{DateTimeParseException};
use Time/Format.DateFormatter;
use Time/Format.DateFormatter.{DateFormatter};

namespace Time {

    ///
    /// A wrapper around a Java LocalDate.
    ///
    pub opaque type LocalDate = ##java.time.LocalDate

}

namespace Time/LocalDate {

    pub def new(year: Int32, month: Int32, dayOfMonth: Int32): LocalDate =
        import java.time.LocalDate:of(Int32, Int32, Int32);
        LocalDate(of(year, month, dayOfMonth)) as & Pure

    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate & Impure =
        import java.time.LocalDate:now();
        LocalDate(now())

    ///
    /// ___
    ///
    pub def epoch(): LocalDate =
        import get java.time.LocalDate:EPOCH as get_epoch;
        LocalDate(get_epoch()) as & Pure

    ///
    /// ___
    ///
    pub def minValue(): LocalDate =
        import get java.time.LocalDate:MIN as get_min;
        LocalDate(get_min()) as & Pure

    ///
    /// ___
    ///
    pub def maxValue(): LocalDate =
        import get java.time.LocalDate:MAX as get_max;
        LocalDate(get_max()) as & Pure

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[LocalDate, Time.Error] = 
        import java.lang.String.strip();
        import java.time.LocalDate:parse(##java.lang.CharSequence);
        try {        
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Ok(LocalDate(parse(cs))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => Err(DateTimeParseException)
        }

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromStringWithFormat(s: String, formatter: DateFormatter): Result[LocalDate, Time.Error] = 
        import java.lang.String.strip();
        import java.time.LocalDate:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Ok(LocalDate(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => Err(DateTimeParseException)
        }


    ///
    /// Returns the given date `x` as a string using ____.
    ///
    pub def toString(x: LocalDate): String =
        import java.time.LocalDate.toString();
        let LocalDate(t) = x;
        t.toString() as & Pure

    ///
    /// Returns LocalDate `x` as a String using `formatter`.
    ///
    pub def format(x: LocalDate, formatter: DateFormatter): String =
        import java.time.LocalDate.format(##java.time.format.DateTimeFormatter);
        let LocalDate(x1) = x;
        let DateFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def equals(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.equals(##java.lang.Object);
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def before(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isBefore(##java.time.chrono.ChronoLocalDate);
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        x1.isBefore(y1 as ##java.time.chrono.ChronoLocalDate) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def after(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isAfter(##java.time.chrono.ChronoLocalDate);
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        x1.isAfter(y1 as ##java.time.chrono.ChronoLocalDate) as & Pure

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

    pub def getYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getYear();
        let LocalDate(x1) = x;
        x1.getYear() as & Pure

    pub def putYear(x: LocalDate, year: Int32): LocalDate =
        import java.time.LocalDate.withYear(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withYear(year)) as & Pure

    pub def getMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.getMonth();
        import java.time.Month.getValue();
        let LocalDate(x1) = x;
        x1.getMonth().getValue() as & Pure

    pub def putMonth(x: LocalDate, month: Int32): LocalDate =
        import java.time.LocalDate.withMonth(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withMonth(month)) as & Pure

    pub def getDayOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfYear();
        let LocalDate(x1) = x;
        x1.getDayOfYear() as & Pure

    pub def putDayOfYear(x: LocalDate, dayOfYear: Int32): LocalDate =
        import java.time.LocalDate.withDayOfYear(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withDayOfYear(dayOfYear)) as & Pure

    pub def getDayOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfMonth();
        let LocalDate(x1) = x;
        x1.getDayOfMonth() as & Pure

    pub def putDayOfMonth(x: LocalDate, dayOfMonth: Int32): LocalDate =
        import java.time.LocalDate.withDayOfMonth(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withDayOfMonth(dayOfMonth)) as & Pure

}
