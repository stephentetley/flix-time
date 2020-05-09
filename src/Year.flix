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

use Time.Year;
use Time.Year.{Year};
use Time.Error.{DateTimeParseException};

namespace Time {

    ///
    /// A wrapper around java.time.Year.
    ///
    pub opaque type Year = ##java.time.Year

}

namespace Time/Year {

    pub def now(): Year & Impure =         
        import java.time.Year:now();
        Year(now())

    ///
    /// 
    ///
    pub def toString(x: Year): String =
        import java.time.Year.toString();
        let Year(x1) = x;
        x1.toString() as & Pure

    ///
    /// Returns the year ...
    ///
    pub def fromString(s: String): Result[Year, Time.Error] = try {
        import java.lang.String.strip();
        import java.time.Year:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(Year(parse(cs))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err(DateTimeParseException)
    }


}