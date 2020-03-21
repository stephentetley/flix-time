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

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalDateTime & Impure =
        import java.time.LocalDateTime:now();
        LocalDateTime(now())


    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    pub def toString(x: LocalDateTime): String =
        import java.time.LocalDateTime.toString();
        let LocalDateTime(t) = x;
        t.toString() as & Pure

    ///
    /// Parse the string `s` as an LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[LocalDateTime, String] = try {
        import java.lang.String.strip();
        import flix.runtime.library.DateTimeWrapper:localDateTimeParse(String) as parse;
        Ok(LocalDateTime(s.strip().parse())) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalDateTime.fromString")
    }

    ///
    /// Parse the string `s` as an LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromStringWithFormat(s: String, formatter: DateTimeFormatter): Result[LocalDateTime, String] = try {
        import java.lang.String.strip();
        import flix.runtime.library.DateTimeWrapper:localDateTimeParseWithFormatter(String, ##java.time.format.DateTimeFormatter) as parseWithFormatter;
        let DateTimeFormatter(fmtr) = formatter;
        Ok(LocalDateTime(parseWithFormatter(s.strip(), fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalDateTime.fromStringWithFormat")
    }




}
