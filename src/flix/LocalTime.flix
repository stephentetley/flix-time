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

///
/// A wrapper around a Java DateTimeFormatter for times.
///
opaque type TimeFormatter = ##java.time.format.DateTimeFormatter

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
        import java.time.LocalTime:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(LocalTime(parse(cs))) as & Pure
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
        import java.time.LocalTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        let TimeFormatter(fmtr) = formatter;
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(LocalTime(cs.parse(fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("LocalTime.fromStringWithFormat")
    }

    pub def iso_local_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_TIME as get_iso_local_time;
        TimeFormatter(get_iso_local_time()) as & Pure

    pub def iso_offset_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_TIME as get_iso_offset_time;
        TimeFormatter(get_iso_offset_time()) as & Pure

    pub def basic_iso_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_TIME as get_iso_time;
        TimeFormatter(get_iso_time()) as & Pure

    pub def formatter(pattern: String): Result[TimeFormatter, String] = try {
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        Ok(TimeFormatter(pattern.strip().ofPattern())) as & Pure
    } catch {
        case _: ##java.lang.IllegalArgumentException => Err("Time/Formatter.formatter")
    }


}
