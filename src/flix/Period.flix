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
/// A wrapper around a Java Period.
///
opaque type Period = ##java.time.Period


namespace Period {

    pub def new(years: Int32, months: Int32, days: Int32): Period =
        import java.time.Period:of(Int32, Int32, Int32);
        Period(of(years, months, days)) as & Pure

    ///
    /// The period of zero.
    ///
    pub def zero(): Period =
        import get java.time.Period:ZERO as get_zero;
        Period(get_zero()) as & Pure

    pub def fromYears(years: Int32): Period =
        import java.time.Period:ofYears(Int32);
        Period(ofYears(years)) as & Pure

    pub def fromMonths(months: Int32): Period =
        import java.time.Period:ofMonths(Int32);
        Period(ofMonths(months)) as & Pure

    pub def fromWeeks(weeks: Int32): Period =
        import java.time.Period:ofWeeks(Int32);
        Period(ofWeeks(weeks)) as & Pure

    pub def fromDays(days: Int32): Period =
        import java.time.Period:ofDays(Int32);
        Period(ofDays(days)) as & Pure
        
    ///
    /// Parse the string `s` as a Period, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[Period, String] = try {
        import java.lang.String.strip();
        import java.time.Period:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(Period(parse(cs))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err("Period.fromString")
    }

    ///
    /// Returns the given period `x` as a string using ____.
    ///
    pub def toString(x: Period): String =
        import java.time.Period.toString();
        let Period(t) = x;
        t.toString() as & Pure

}