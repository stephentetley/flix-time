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
        import flix.runtime.library.DateTimeWrapper:localDateParse(String) as dateParse;
        Ok(LocalDate(s.strip().dateParse())) as & Pure
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
        import flix.runtime.library.DateTimeWrapper:localDateParseWithFormatter(String, ##java.time.format.DateTimeFormatter) as parseWithFormatter;
        let DateFormatter(fmtr) = formatter;
        Ok(LocalDate(parseWithFormatter(s.strip(), fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalDate.fromStringWithFormat")
    }




}
