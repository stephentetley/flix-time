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

    ///
    /// A wrapper around java.time.YearMonth.
    ///
    pub opaque type YearMonth = ##java.time.YearMonth

    ///
    /// 
    ///
    instance ToString[YearMonth] {
        pub def toString(x: YearMonth): String =
            import java.time.YearMonth.toString();
            let YearMonth(x1) = x;
            x1.toString() as & Pure
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[YearMonth] {
        pub def fromString(s: String): Option[YearMonth] = try {
            import java.lang.String.strip();
            import java.time.YearMonth:parse(##java.lang.CharSequence);
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(YearMonth(parse(cs))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }
    }


    instance Eq[YearMonth] {
        pub def eq(x: YearMonth, y: YearMonth): Bool =
            import java.time.YearMonth.equals(##java.lang.Object);
            let YearMonth(x1) = x;
            let YearMonth(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure

        pub def neq(x: YearMonth, y: YearMonth): Bool = not (x == y)
    }

    instance Hash[YearMonth] {
        pub def hash(x: YearMonth): Int = Time/YearMonth.hashCode(x)
    }

    instance Order[YearMonth] {
        pub def less(x: YearMonth, y: YearMonth): Bool = Time/YearMonth.compareTo(x,y) < 0
        pub def lessEqual(x: YearMonth, y: YearMonth): Bool = Time/YearMonth.compareTo(x,y) < 0 or x == y
        pub def greater(x: YearMonth, y: YearMonth): Bool = Time/YearMonth.compareTo(x,y) > 0
        pub def greaterEqual(x: YearMonth, y: YearMonth): Bool = Time/YearMonth.compareTo(x,y) > 0 or x == y
        pub def compare(x: YearMonth, y: YearMonth): Comparison = match Time/YearMonth.compareTo(x,y) {
            case n if n < 0 => LessThan
            case n if n == 0 => EqualTo
            case _ => GreaterThan
        }
    }
    
}

namespace Time/YearMonth {

    use Time/Format.DateFormatter;
    use Time/Format.DateFormatter.{DateFormatter};
    use Time.Month;
    use Time.YearMonth;
    use Time.YearMonth.{YearMonth};

    pub def new(x: {year: Int32, month: Int32}): YearMonth =
        import java.time.YearMonth:of(Int32, Int32);
        YearMonth(of(x.year, x.month)) as & Pure

    pub def newWithMonth(x: {year: Int, month: Month}): YearMonth =
        import java.time.YearMonth:of(Int32, ##java.time.Month);
        let m1 = Time/Month.marshal(x.month);
        YearMonth(of(x.year, m1)) as & Pure

    pub def now(): YearMonth & Impure =         
        import java.time.YearMonth:now();
        YearMonth(now())


    ///
    /// Returns YearMonth `x` as a String using `formatter`.
    ///
    pub def format(x: YearMonth, formatter: DateFormatter): String =
        import java.time.YearMonth.format(##java.time.format.DateTimeFormatter);
        let YearMonth(x1) = x;
        let DateFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    ///
    /// Parse the string `s` as a YearMonth, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(_)`, a parse failure is indicated by `None`.
    ///
    pub def parse(s: String, formatter: DateFormatter): Option[YearMonth] =
        import java.lang.String.strip();
        import java.time.YearMonth:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(YearMonth(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }


    pub def hashCode(x: YearMonth): Int32 = 
        import java.time.YearMonth.hashCode();
        let YearMonth(x1) = x;
        hashCode(x1) as & Pure


    ///
    /// Returns ...
    ///
    pub def compareTo(x: YearMonth, y: YearMonth): Int32 =
        import java.time.YearMonth.compareTo(##java.time.YearMonth);
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        x1.compareTo(y1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: YearMonth, y: YearMonth): Bool =
        import java.time.YearMonth.isBefore(##java.time.YearMonth);
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        x1.isBefore(y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: YearMonth, y: YearMonth): Bool =
        import java.time.YearMonth.isAfter(##java.time.YearMonth);
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        x1.isAfter(y1) as & Pure

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: YearMonth): Bool =
        import java.time.YearMonth.isLeapYear();
        let YearMonth(x1) = x;
        x1.isLeapYear() as & Pure

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isValidDay(x: YearMonth, dayOfMonth: Int32): Bool =
        import java.time.YearMonth.isValidDay(Int32);
        let YearMonth(x1) = x;
        x1.isValidDay(dayOfMonth) as & Pure

    ///
    /// Returns the length of the month.
    ///
    pub def lengthOfMonth(x: YearMonth): Int32 =
        import java.time.YearMonth.lengthOfMonth();
        let YearMonth(x1) = x;
        x1.lengthOfMonth() as & Pure

    ///
    /// Returns the length of the year.
    ///
    pub def lengthOfYear(x: YearMonth): Int32 =
        import java.time.YearMonth.lengthOfYear();
        let YearMonth(x1) = x;
        x1.lengthOfYear() as & Pure


    pub def plusMonths(x: YearMonth, months: Int64): YearMonth =
        import java.time.YearMonth.plusMonths(Int64);
        let YearMonth(x1) = x;
        YearMonth(x1.plusMonths(months)) as & Pure

    pub def minusMonths(x: YearMonth, months: Int64): YearMonth =
        import java.time.YearMonth.minusMonths(Int64);
        let YearMonth(x1) = x;
        YearMonth(x1.minusMonths(months)) as & Pure

    pub def plusYears(x: YearMonth, years: Int64): YearMonth =
        import java.time.YearMonth.plusYears(Int64);
        let YearMonth(x1) = x;
        YearMonth(x1.plusYears(years)) as & Pure

    pub def minusYears(x: YearMonth, years: Int64): YearMonth =
        import java.time.YearMonth.minusYears(Int64);
        let YearMonth(x1) = x;
        YearMonth(x1.minusYears(years)) as & Pure


    pub def getMonth(x: YearMonth): Month =
        import java.time.YearMonth.getMonth();
        use Time/Month.{unmarshal};
        let YearMonth(x1) = x;
        x1.getMonth().unmarshal() as & Pure

    pub def putMonth(x: YearMonth, month: Month): YearMonth =
        newWithMonth({year = getYear(x), month = month})

    pub def getMonthValue(x: YearMonth): Int32 =
        import java.time.YearMonth.getMonthValue();
        let YearMonth(x1) = x;
        x1.getMonthValue() as & Pure

    pub def putMonthValue(x: YearMonth, month: Int32): YearMonth =
        import java.time.YearMonth.withMonth(Int32);
        let YearMonth(x1) = x;
        YearMonth(x1.withMonth(month)) as & Pure

    pub def getYear(x: YearMonth): Int32 =
        import java.time.YearMonth.getYear();
        let YearMonth(x1) = x;
        x1.getYear() as & Pure

    pub def putYear(x: YearMonth, year: Int32): YearMonth =
        import java.time.YearMonth.withYear(Int32);
        let YearMonth(x1) = x;
        YearMonth(x1.withYear(year)) as & Pure

}