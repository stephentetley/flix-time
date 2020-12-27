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

    ///
    /// 
    ///
    instance ToString[MonthDay] {
        def toString(x: MonthDay): String =
            import java.time.MonthDay.toString();
            let MonthDay(x1) = x;
            x1.toString() as & Pure
    }

    ///
    /// Returns the month / day ...
    ///
    instance FromString[MonthDay] {
        def fromString(s: String): Option[MonthDay] = try {
            import java.lang.String.strip();
            import java.time.MonthDay:parse(##java.lang.CharSequence);
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(MonthDay(parse(cs))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }
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

    pub def new(x: {month: Int32, dayOfMonth: Int32}): MonthDay =
        import java.time.MonthDay:of(Int32, Int32);
        MonthDay(of(x.month, x.dayOfMonth)) as & Pure

    pub def newWithMonth(x: {month: Month, dayOfMonth: Int32}): MonthDay =
        import java.time.MonthDay:of(##java.time.Month, Int32);
        let m1 = Time/Month.marshal(x.month);
        MonthDay(of(m1, x.dayOfMonth)) as & Pure

    pub def now(): MonthDay & Impure =         
        import java.time.MonthDay:now();
        MonthDay(now())

    pub def nowWithZoneId(x: ZoneId): MonthDay & Impure =         
        import java.time.MonthDay:now(##java.time.ZoneId);
        let ZoneId(x1) = x;
        MonthDay(now(x1))

    ///
    /// Returns MonthDay `x` as a String using `formatter`.
    ///
    pub def format(x: MonthDay, formatter: DateFormatter): String =
        import java.time.MonthDay.format(##java.time.format.DateTimeFormatter);
        let MonthDay(x1) = x;
        let DateFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    ///
    /// Parse the string `s` as a MonthDay, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(s: String, formatter: DateFormatter): Option[MonthDay] =
        import java.lang.String.strip();
        import java.time.MonthDay:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(MonthDay(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def __eq(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.equals(##java.lang.Object);
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    ///
    /// Returns ...
    ///
    pub def compare(x: MonthDay, y: MonthDay): Int32 =
        import java.time.MonthDay.compareTo(##java.time.MonthDay);
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        x1.compareTo(y1) as & Pure

    pub def getDayOfMonth(x: MonthDay): Int32 =
        import java.time.MonthDay.getDayOfMonth();
        let MonthDay(x1) = x;
        x1.getDayOfMonth() as & Pure

    pub def putDayOfMonth(x: MonthDay, dayOfMonth: Int32): MonthDay =
        import java.time.MonthDay.withDayOfMonth(Int32);
        let MonthDay(x1) = x;
        MonthDay(x1.withDayOfMonth(dayOfMonth)) as & Pure

    pub def getMonth(x: MonthDay): Month =
        import java.time.MonthDay.getMonth();
        use Time/Month.{unmarshal};
        let MonthDay(x1) = x;
        x1.getMonth().unmarshal() as & Pure

    pub def putMonth(x: MonthDay, month: Month): MonthDay =
        import java.time.MonthDay.with(##java.time.Month);
        use Time/Month.{marshal};
        let MonthDay(x1) = x;
        let m1 = month.marshal();
        MonthDay(x1.with(m1)) as & Pure

    pub def getMonthValue(x: MonthDay): Int32 =
        import java.time.MonthDay.getMonthValue();
        let MonthDay(x1) = x;
        x1.getMonthValue() as & Pure

    pub def putMonthValue(x: MonthDay, month: Int32): MonthDay =
        import java.time.MonthDay.withMonth(Int32);
        let MonthDay(x1) = x;
        MonthDay(x1.withMonth(month)) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isBefore(##java.time.MonthDay);
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        x1.isBefore(y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isAfter(##java.time.MonthDay);
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        x1.isAfter(y1) as & Pure

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(x: MonthDay, year: Int32): Bool =
        import java.time.MonthDay.isValidYear(Int32);
        let MonthDay(x1) = x;
        x1.isValidYear(year) as & Pure

}