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

use Time.MonthDay;
use Time.MonthDay.{MonthDay};
use Time.Error.{DateTimeParseException};

namespace Time {

    ///
    /// A wrapper around java.time.MonthDay.
    ///
    pub opaque type MonthDay = ##java.time.MonthDay

}

namespace Time/MonthDay {

    pub def now(): MonthDay & Impure =         
        import java.time.MonthDay:now();
        MonthDay(now())

    ///
    /// 
    ///
    pub def toString(x: MonthDay): String =
        import java.time.MonthDay.toString();
        let MonthDay(x1) = x;
        x1.toString() as & Pure

    ///
    /// Returns the month / day ...
    ///
    pub def fromString(s: String): Result[MonthDay, Time.Error] = try {
        import java.lang.String.strip();
        import java.time.MonthDay:parse(##java.lang.CharSequence);
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(MonthDay(parse(cs))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err(DateTimeParseException)
    }


}