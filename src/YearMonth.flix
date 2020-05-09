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

use Time.YearMonth;
use Time.YearMonth.{YearMonth};
use Time.Error.{DateTimeParseException};

namespace Time {

    ///
    /// A wrapper around java.time.YearMonth.
    ///
    pub opaque type YearMonth = ##java.time.YearMonth

}

namespace Time/YearMonth {

    pub def now(): YearMonth & Impure =         
        import java.time.YearMonth:now();
        YearMonth(now())

    ///
    /// 
    ///
    pub def toString(x: YearMonth): String =
        import java.time.YearMonth.toString();
        let YearMonth(x1) = x;
        x1.toString() as & Pure

    ///
    /// Returns the year ...
    ///
    pub def fromString(s: String): Result[YearMonth, Time.Error] = try {
        import java.lang.String.strip();
        import java.time.YearMonth:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(YearMonth(parse(cs))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err(DateTimeParseException)
    }


}