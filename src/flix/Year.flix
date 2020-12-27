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


namespace Time {

    use class Time/Temporal.Temporal;
    use class Time/Temporal.TemporalAmount;

    ///
    /// A wrapper around java.time.Year.
    ///
    pub opaque type Year = ##java.time.Year

    instance ToString[Year] {
        def toString(x: Year): String = 
            import java.time.Year.toString();
            let Year(x1) = x;
            x1.toString() as & Pure
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[Year] {
        def fromString(s: String): Option[Year] =
            import java.lang.String.strip();
            import java.time.Year:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(Year(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Temporal[Year] {
        def marshal(x: Year): ##java.time.temporal.Temporal = 
            let Year(x1) = x;
            x1 as ##java.time.temporal.Temporal
        
        def unmarshal(x: ##java.time.temporal.Temporal): Year = 
            let x1 = x as ##java.time.Year;
            Year(x1)

        def plus[b: TemporalAmount](x: Year, y: b): Year = 
            import java.time.temporal.Temporal.plus(##java.time.temporal.TemporalAmount);
            let Year(x1) = x;
            let t1 = x1 as ##java.time.temporal.Temporal;
            let y1 = Time/Temporal/TemporalAmount.marshal(y);
            Year(plus(t1, y1) as ##java.time.Year) as & Pure

    }

}

namespace Time/Year {
    
    use Time.Year;
    use Time.Year.{Year};

    pub def now(): Year & Impure =         
        import java.time.Year:now();
        Year(now())


    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def __eq(x: Year, y: Year): Bool =
        import java.time.Year.equals(##java.lang.Object);
        let Year(x1) = x;
        let Year(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    pub def compare(x: Year, y: Year): Int32 =
        import java.time.Year.compareTo(##java.time.Year);
        let Year(x1) = x;
        let Year(y1) = y;
        x1.compareTo(y1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: Year, y: Year): Bool =
        import java.time.Year.isBefore(##java.time.Year);
        let Year(x1) = x;
        let Year(y1) = y;
        x1.isBefore(y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: Year, y: Year): Bool =
        import java.time.Year.isAfter(##java.time.Year);
        let Year(x1) = x;
        let Year(y1) = y;
        x1.isAfter(y1) as & Pure

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeap(x: Year): Bool =
        import java.time.Year.isLeap();
        let Year(x1) = x;
        x1.isLeap() as & Pure

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: Int64): Bool =
        import java.time.Year:isLeap(Int64);
        isLeap(x) as & Pure


}