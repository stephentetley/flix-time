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

    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;

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
        pub def fromString(s: String): Option[YearMonth] = 
        import static java.time.YearMonth.parse(##java.lang.CharSequence): ##java.time.YearMonth & Pure;        
        try {
            let cs = String.trim(s) as ##java.lang.CharSequence;
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

    instance TemporalAccessor[YearMonth] {
        pub def marshalToNativeTemporalAccessor(x: YearMonth): ##java.time.temporal.TemporalAccessor =         
            Time/YearMonth.getYearMonth(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): YearMonth = 
            YearMonth(x as ##java.time.YearMonth)
    }

    instance Temporal[YearMonth] {
        pub def marshalToNativeTemporal(x: YearMonth): ##java.time.temporal.Temporal =         
            Time/YearMonth.getYearMonth(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): YearMonth = 
            YearMonth(x as ##java.time.YearMonth)
    }

    instance TemporalAdjuster[YearMonth] {
        pub def marshalToNativeTemporalAdjuster(x: YearMonth): ##java.time.temporal.TemporalAdjuster =         
            Time/YearMonth.getYearMonth(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): YearMonth = 
            YearMonth(x as ##java.time.YearMonth)
    }


}

namespace Time/YearMonth {

    use Time/Format.DateFormat;
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;
    use Time/Temporal.TemporalAmount;
    use Time/Temporal.TemporalField;
    use Time/Temporal.TemporalUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.Month;
    use Time.YearMonth;
    use Time.YearMonth.{YearMonth};


    pub def getYearMonth(x: YearMonth): ##java.time.YearMonth = 
        let YearMonth(x1) = x;
        x1

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def fromTemporalAccessor(x: a): YearMonth with TemporalAccessor[a] = 
        import static java.time.YearMonth.from(##java.time.temporal.TemporalAccessor): ##java.time.YearMonth & Pure as fromTA;
        let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
        YearMonth(fromTA(x1))


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
    pub def format(formatter: DateTimeFormatter[DateFormat], x: YearMonth): String =
        import java.time.YearMonth.format(##java.time.format.DateTimeFormatter): String & Pure;
        let YearMonth(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a YearMonth, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(_)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Option[YearMonth] =
        import static java.time.YearMonth.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.YearMonth & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
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

    pub def get(t: a, x: YearMonth): Int32 with TemporalField[a] = 
        import java.time.YearMonth.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getYearMonth(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: YearMonth): Int64 with TemporalField[a] = 
        import java.time.YearMonth.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getYearMonth(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

    pub def adjustInto(t: a, x: YearMonth): a with Temporal[a] = 
        import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let YearMonth(x1) = x;
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))


    pub def plusTemporalAmount(x: YearMonth, amount: a): YearMonth with TemporalAmount[a] =
        import java.time.YearMonth.plus(##java.time.temporal.TemporalAmount): ##java.time.YearMonth & Pure;         
        try {
            let YearMonth(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            YearMonth(plus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmount(x: YearMonth, amount: a): YearMonth with TemporalAmount[a] =
        import java.time.YearMonth.minus(##java.time.temporal.TemporalAmount): ##java.time.YearMonth & Pure;         
        try {
            let YearMonth(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            YearMonth(minus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def plusAmount(x: YearMonth, amount: Int64, unit: a): YearMonth with TemporalUnit[a] =
        import java.time.YearMonth.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.YearMonth & Pure;         
        try {
            let YearMonth(x1) = x;
            let unit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(unit);
            YearMonth(plus(x1, amount, unit1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusAmount(x: YearMonth, amount: Int64, unit: a): YearMonth with TemporalUnit[a] =
        import java.time.YearMonth.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.YearMonth & Pure;         
        try {
            let YearMonth(x1) = x;
            let unit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(unit);
            YearMonth(minus(x1, amount, unit1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def range(field: a, x: YearMonth): ValueRange with TemporalField[a] =
        import java.time.YearMonth.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let YearMonth(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    /// TODO refine class qualification of `t`
    pub def until(units: t, r: {start :: YearMonth, end :: a}): Int64 with TemporalUnit[t], Temporal[a] = 
        import java.time.YearMonth.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getYearMonth(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        let units1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(units);
        until(b1, e1, units1)

    pub def withTemporalField(field: a, i: Int64, x: YearMonth): YearMonth with TemporalField[a] =
        import java.time.YearMonth.with(##java.time.temporal.TemporalField, Int64): ##java.time.YearMonth & Pure as withTF;         
        try {
            let YearMonth(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            YearMonth(withTF(x1, field1, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalAdjuster(adj: a, x: YearMonth): YearMonth with TemporalAdjuster[a] =
        import java.time.YearMonth.with(##java.time.temporal.TemporalAdjuster): ##java.time.YearMonth & Pure as withTA;         
        try {
            let YearMonth(x1) = x;
            let adj1 = Time/Temporal/TemporalAdjuster.marshalToNativeTemporalAdjuster(adj);
            YearMonth(withTA(x1, adj1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

}
