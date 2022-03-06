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
    /// A wrapper around java.time.MonthDay.
    ///
    pub opaque type MonthDay = ##java.time.MonthDay


    instance ToString[MonthDay] {
        pub def toString(x: MonthDay): String =
            import java.time.MonthDay.toString(): String & Pure;
            let MonthDay(x1) = x;
            toString(x1)
    }

    ///
    /// Returns the month / day ...
    ///
    instance FromString[MonthDay] {
        pub def fromString(s: String): Option[MonthDay] = try {
            import java.lang.String.strip(): String & Pure;
            import static java.time.MonthDay.parse(##java.lang.CharSequence): ##java.time.MonthDay & Pure;
            let cs = strip(s) as ##java.lang.CharSequence;
            Some(MonthDay(parse(cs)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }
    }

    instance Eq[MonthDay] {
        pub def eq(x: MonthDay, y: MonthDay): Bool = Time/MonthDay.equals(x, y)
    }

    instance Hash[MonthDay] {
        pub def hash(x: MonthDay): Int32 = Time/MonthDay.hashCode(x)
    }

    instance Order[MonthDay] {
        pub def compare(x: MonthDay, y: MonthDay): Comparison =
            Time/MonthDay.compareTo(x,y) |> Comparison.fromInt32
    }

}

namespace Time/MonthDay {

    use Time/Format.DateFormatter;
    use Time/Format.DateFormatter.{DateFormatter};
    use Time.Month;
    use Time.MonthDay;
    use Time.MonthDay.{MonthDay};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def new(x: {month :: Int32, dayOfMonth :: Int32}): MonthDay =
        import static java.time.MonthDay.of(Int32, Int32): ##java.time.MonthDay & Pure;
        MonthDay(of(x.month, x.dayOfMonth))

    pub def newWithMonth(x: {month :: Month, dayOfMonth :: Int32}): MonthDay =
        import static java.time.MonthDay.of(##java.time.Month, Int32): ##java.time.MonthDay & Pure;
        let m1 = Time/Month.toNative(x.month);
        MonthDay(of(m1, x.dayOfMonth))

    pub def now(): MonthDay & Impure =
        import static java.time.MonthDay.now(): ##java.time.MonthDay & Impure;
        MonthDay(now())

    pub def nowWithZoneId(x: ZoneId): MonthDay & Impure =
        import static java.time.MonthDay.now(##java.time.ZoneId): ##java.time.MonthDay & Impure;
        let ZoneId(x1) = x;
        MonthDay(now(x1))

    ///
    /// Returns MonthDay `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateFormatter, x: MonthDay): String =
        import java.time.MonthDay.format(##java.time.format.DateTimeFormatter): String & Pure;
        let MonthDay(x1) = x;
        let DateFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a MonthDay, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateFormatter, s: String): Option[MonthDay] =
        import java.lang.String.strip(): String & Pure;
        import static java.time.MonthDay.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.MonthDay & Pure;
        try {
            let DateFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence;
            Some(MonthDay(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.equals(##java.lang.Object): Bool & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: MonthDay): Int32 =
        import java.time.MonthDay.hashCode(): Int32 & Pure;
        let MonthDay(x1) = x;
        hashCode(x1)

    ///
    /// Returns ...
    ///
    pub def compareTo(x: MonthDay, y: MonthDay): Int32 =
        import java.time.MonthDay.compareTo(##java.time.MonthDay): Int32 & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        compareTo(x1, y1)

    pub def getDayOfMonth(x: MonthDay): Int32 =
        import java.time.MonthDay.getDayOfMonth(): Int32 & Pure;
        let MonthDay(x1) = x;
        getDayOfMonth(x1)

    pub def putDayOfMonth(x: MonthDay, dayOfMonth: Int32): MonthDay =
        import java.time.MonthDay.withDayOfMonth(Int32): ##java.time.MonthDay & Pure;
        let MonthDay(x1) = x;
        MonthDay(withDayOfMonth(x1, dayOfMonth))

    pub def getMonth(x: MonthDay): Month =
        import java.time.MonthDay.getMonth(): ##java.time.Month & Pure;
        use Time/Month.{fromNative};
        let MonthDay(x1) = x;
        fromNative(getMonth(x1))

    pub def putMonth(x: MonthDay, month: Month): MonthDay =
        import java.time.MonthDay.with(##java.time.Month): ##java.time.MonthDay & Pure;
        use Time/Month.{toNative};
        let MonthDay(x1) = x;
        let m1 = toNative(month);
        MonthDay(with(x1, m1))

    pub def getMonthValue(x: MonthDay): Int32 =
        import java.time.MonthDay.getMonthValue(): Int32 & Pure;
        let MonthDay(x1) = x;
        getMonthValue(x1)

    pub def putMonthValue(x: MonthDay, month: Int32): MonthDay =
        import java.time.MonthDay.withMonth(Int32): ##java.time.MonthDay & Pure;
        let MonthDay(x1) = x;
        MonthDay(withMonth(x1, month))

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isBefore(##java.time.MonthDay): Bool & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isAfter(##java.time.MonthDay): Bool & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        isAfter(x1, y1)

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(x: MonthDay, year: Int32): Bool =
        import java.time.MonthDay.isValidYear(Int32): Bool & Pure;
        let MonthDay(x1) = x;
        isValidYear(x1, year)

}