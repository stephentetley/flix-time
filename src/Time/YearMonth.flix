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
            import java.time.YearMonth.toString(): String & Pure;
            let YearMonth(x1) = x;
            toString(x1)
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[YearMonth] {
        pub def fromString(s: String): Option[YearMonth] = try {
            import java.lang.String.strip(): String & Pure;
            import static java.time.YearMonth.parse(##java.lang.CharSequence): ##java.time.YearMonth & Pure;
            let cs = strip(s) as ##java.lang.CharSequence;
            Some(YearMonth(parse(cs)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }
    }


    instance Eq[YearMonth] {
        pub def eq(x: YearMonth, y: YearMonth): Bool = Time/YearMonth.equals(x, y)
    }

    instance Hash[YearMonth] {
        pub def hash(x: YearMonth): Int32 = Time/YearMonth.hashCode(x)
    }

    instance Order[YearMonth] {
        pub def compare(x: YearMonth, y: YearMonth): Comparison =
            Time/YearMonth.compareTo(x,y) |> Comparison.fromInt32
    }

}

namespace Time/YearMonth {

    use Time/Format.DateFormatter;
    use Time/Format.DateFormatter.{DateFormatter};
    use Time.Month;
    use Time.YearMonth;
    use Time.YearMonth.{YearMonth};


    pub def getYearMonth(x: YearMonth): ##java.time.YearMonth = 
        let YearMonth(x1) = x;
        x1


    pub def of(r: {year :: Int32, month :: Int32}): YearMonth =
        import static java.time.YearMonth.of(Int32, Int32): ##java.time.YearMonth & Pure;
        YearMonth(of(r.year, r.month))

    pub def ofWithMonth(r: {year :: Int32, month :: Month}): YearMonth =
        import static java.time.YearMonth.of(Int32, ##java.time.Month): ##java.time.YearMonth & Pure;
        let m1 = Time/Month.marshal(r.month);
        YearMonth(of(r.year, m1))

    pub def now(): YearMonth & Impure =
        import static java.time.YearMonth.now(): ##java.time.YearMonth & Impure;
        YearMonth(now())


    ///
    /// Returns YearMonth `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateFormatter, x: YearMonth): String =
        import java.time.YearMonth.format(##java.time.format.DateTimeFormatter): String & Pure;
        let YearMonth(x1) = x;
        let DateFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a YearMonth, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(_)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateFormatter, s: String): Option[YearMonth] =
        import java.lang.String.strip(): String & Pure;
        import static java.time.YearMonth.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.YearMonth & Pure;
        try {
            let DateFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence;
            Some(YearMonth(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: YearMonth, y: YearMonth): Bool =
        import java.time.YearMonth.equals(##java.lang.Object): Bool & Pure;
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: YearMonth): Int32 =
        import java.time.YearMonth.hashCode(): Int32 & Pure;
        let YearMonth(x1) = x;
        hashCode(x1)


    ///
    /// Returns ...
    ///
    pub def compareTo(x: YearMonth, y: YearMonth): Int32 =
        import java.time.YearMonth.compareTo(##java.time.YearMonth): Int32 & Pure;
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        compareTo(x1, y1)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: YearMonth, y: YearMonth): Bool =
        import java.time.YearMonth.isBefore(##java.time.YearMonth): Bool & Pure;
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: YearMonth, y: YearMonth): Bool =
        import java.time.YearMonth.isAfter(##java.time.YearMonth): Bool & Pure;
        let YearMonth(x1) = x;
        let YearMonth(y1) = y;
        isAfter(x1, y1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: YearMonth): Bool =
        import java.time.YearMonth.isLeapYear(): Bool & Pure;
        let YearMonth(x1) = x;
        isLeapYear(x1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isValidDay(x: YearMonth, dayOfMonth: Int32): Bool =
        import java.time.YearMonth.isValidDay(Int32): Bool & Pure;
        let YearMonth(x1) = x;
        isValidDay(x1, dayOfMonth)

    ///
    /// Returns the length of the month.
    ///
    pub def lengthOfMonth(x: YearMonth): Int32 =
        import java.time.YearMonth.lengthOfMonth(): Int32 & Pure;
        let YearMonth(x1) = x;
        lengthOfMonth(x1)

    ///
    /// Returns the length of the year.
    ///
    pub def lengthOfYear(x: YearMonth): Int32 =
        import java.time.YearMonth.lengthOfYear(): Int32 & Pure;
        let YearMonth(x1) = x;
        lengthOfYear(x1)

    pub def plusMonths(x: YearMonth, months: Int64): YearMonth =
        import java.time.YearMonth.plusMonths(Int64): ##java.time.YearMonth & Pure;
        let YearMonth(x1) = x;
        YearMonth(plusMonths(x1, months))

    pub def minusMonths(x: YearMonth, months: Int64): YearMonth =
        import java.time.YearMonth.minusMonths(Int64): ##java.time.YearMonth & Pure;
        let YearMonth(x1) = x;
        YearMonth(minusMonths(x1, months))

    pub def plusYears(x: YearMonth, years: Int64): YearMonth =
        import java.time.YearMonth.plusYears(Int64): ##java.time.YearMonth & Pure;
        let YearMonth(x1) = x;
        YearMonth(plusYears(x1, years))

    pub def minusYears(x: YearMonth, years: Int64): YearMonth =
        import java.time.YearMonth.minusYears(Int64): ##java.time.YearMonth & Pure;
        let YearMonth(x1) = x;
        YearMonth(minusYears(x1, years))


    pub def getMonth(x: YearMonth): Month =
        import java.time.YearMonth.getMonth(): ##java.time.Month & Pure;
        use Time/Month.{unmarshal};
        let YearMonth(x1) = x;
        (getMonth(x1) |> unmarshal)

    pub def withMonth(x: YearMonth, month: Month): YearMonth =
        ofWithMonth({year = getYear(x), month = month})

    pub def getMonthValue(x: YearMonth): Int32 =
        import java.time.YearMonth.getMonthValue(): Int32 & Pure;
        let YearMonth(x1) = x;
        getMonthValue(x1)

    pub def withMonthValue(x: YearMonth, month: Int32): YearMonth =
        import java.time.YearMonth.withMonth(Int32): ##java.time.YearMonth & Pure;
        let YearMonth(x1) = x;
        YearMonth(withMonth(x1, month))

    pub def getYear(x: YearMonth): Int32 =
        import java.time.YearMonth.getYear(): Int32 & Pure;
        let YearMonth(x1) = x;
        getYear(x1)

    pub def withYear(x: YearMonth, year: Int32): YearMonth =
        import java.time.YearMonth.withYear(Int32): ##java.time.YearMonth & Pure;
        let YearMonth(x1) = x;
        YearMonth(withYear(x1, year))

}
