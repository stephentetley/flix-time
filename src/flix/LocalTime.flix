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
/// A wrapper around a Java LocalTime.
///
opaque type LocalTime = ##java.time.LocalTime

namespace LocalTime {

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalTime & Impure =
        import java.time.LocalTime:now();
        LocalTime(now())

    ///
    /// Returns the given time `x` as a string using __.
    ///
    pub def toString(x: LocalTime): String =
        import java.time.LocalTime.toString();
        let LocalTime(t) = x;
        t.toString() as & Pure

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[LocalTime, String] = try {
        import java.lang.String.strip();
        import flix.runtime.library.DateTimeWrapper:localTimeParse(String) as timeParse;
        Ok(LocalTime(s.strip().timeParse())) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalTime.fromString")
    }

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromStringWithFormat(s: String, formatter: TimeFormatter): Result[LocalTime, String] = try {
        import java.lang.String.strip();
        import flix.runtime.library.DateTimeWrapper:localTimeParseWithFormatter(String, ##java.time.format.DateTimeFormatter) as parseWithFormatter;
        let TimeFormatter(fmtr) = formatter;
        Ok(LocalTime(parseWithFormatter(s.strip(), fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalTime.fromStringWithFormat")
    }




}
