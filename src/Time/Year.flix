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
    /// A wrapper around java.time.Year.
    ///
    pub opaque type Year = ##java.time.Year

    instance ToString[Year] {
        pub def toString(x: Year): String =
            import java.time.Year.toString(): String & Pure;
            let Year(x1) = x;
            toString(x1)
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[Year] {
        pub def fromString(s: String): Option[Year] =
            import static java.time.Year.parse(##java.lang.CharSequence): ##java.time.Year & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(Year(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[Year] {
        pub def eq(x: Year, y: Year): Bool = Time/Year.equals(x, y)
    }

    instance Hash[Year] {
        pub def hash(x: Year): Int32 = Time/Year.hashCode(x)
    }

    instance Order[Year] {
        pub def compare(x: Year, y: Year): Comparison =
            Time/Year.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[Year] {
        pub def minValue(): Year =
            import static get java.time.Year.MIN_VALUE: Int32 & Pure as getMIN_VALUE;
            import static java.time.Year.of(Int32): ##java.time.Year & Pure;
            Year(of(getMIN_VALUE()))
    }

    instance UpperBound[Year] {
        pub def maxValue(): Year =
            import static get java.time.Year.MAX_VALUE: Int32 & Pure as getMAX_VALUE;
            import static java.time.Year.of(Int32): ##java.time.Year & Pure;
            Year(of(getMAX_VALUE()))
    }

    instance TemporalAccessor[Year] {
        pub def marshalToNativeTemporalAccessor(x: Year): ##java.time.temporal.TemporalAccessor =         
            Time/Year.getYear(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): Year = 
            Year(x as ##java.time.Year)
    }

    instance Temporal[Year] {
        pub def marshalToNativeTemporal(x: Year): ##java.time.temporal.Temporal =         
            Time/Year.getYear(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): Year = 
            Year(x as ##java.time.Year)
    }

    instance TemporalAdjuster[Year] {
        pub def marshalToNativeTemporalAdjuster(x: Year): ##java.time.temporal.TemporalAdjuster =         
            Time/Year.getYear(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): Year = 
            Year(x as ##java.time.Year)
    }

}

namespace Time/Year {

    use Time.Year;
    use Time.Year.{Year};

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
    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalDateTime;
    use Time.Month;
    use Time.MonthDay;
    use Time.MonthDay.{MonthDay};
    use Time.OffsetDateTime;
    use Time.YearMonth;
    use Time.YearMonth.{YearMonth};
    use Time.ZonedDateTime;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def getYear(x: Year): ##java.time.Year = 
        let Year(x1) = x;
        x1


    class YearTemporalUnit[a] with TemporalUnit[a] {
        pub def marshalToNativeTemporalUnit(x: a): ##java.time.temporal.TemporalUnit = 
            Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(x)
    }





    pub def year(isoYear: {isoYear :: Int32}): Year =
        import static java.time.Year.of(Int32): ##java.time.Year & Pure;
        Year(of(isoYear.isoYear))


    pub def now(): Year & Impure =
        import static java.time.Year.now(): ##java.time.Year & Impure;
        Year(now())

    pub def nowWithClock(x: Clock): Year & Impure =
        import static java.time.Year.now(##java.time.Clock): ##java.time.Year & Impure;
        let Clock(x1) = x;
        Year(now(x1))

    pub def nowWithZoneId(x: ZoneId): Year & Impure =
        import static java.time.Year.now(##java.time.ZoneId): ##java.time.Year & Impure;
        let ZoneId(x1) = x;
        Year(now(x1))


    

    ///
    /// Parse the string `s` as a Year, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Option[Year] =
        import static java.time.Year.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.Year & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(Year(parse(cs, fmtr)))
        } catch {
            case _: ##java.lang.Exception => None
        }

    ///
    /// Returns the Year `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: Year): String =
        import java.time.Year.format(##java.time.format.DateTimeFormatter): String & Pure;
        let Year(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    pub def equals(x: Year, y: Year): Bool =
        import java.time.Year.equals(##java.lang.Object): Bool & Pure;
        let Year(x1) = x;
        let Year(y1) = y;
        equals(x1, y1 as ##java.lang.Object)


    pub def hashCode(x: Year): Int32 =
        import java.time.Year.hashCode(): Int32 & Pure;
        let Year(x1) = x;
        hashCode(x1)

    pub def atDay(x: Year, dayOfYear: Int32): Option[LocalDate] =
        import java.time.Year.atDay(Int32): ##java.time.LocalDate & Pure;
        try {
            let Year(x1) = x;
            Some(LocalDate(atDay(x1, dayOfYear)))
        } catch {
            case _: ##java.lang.Exception => None
        }

    pub def atMonth(x: Year, month: Int32): Option[YearMonth] =
        import java.time.Year.atMonth(Int32): ##java.time.YearMonth & Pure;
        try {
            let Year(x1) = x;
            Some(YearMonth(atMonth(x1, month)))
        } catch {
            case _: ##java.lang.Exception => None
        }

    pub def atMonthWithMonth(x: Year, month: Month): Option[YearMonth] =
        import java.time.Year.atMonth(##java.time.Month): ##java.time.YearMonth & Pure;
        try {
            let Year(x1) = x;
            let m1 = Time/Month.marshal(month);
            Some(YearMonth(atMonth(x1, m1)))
        } catch {
            case _: ##java.lang.Exception => None
        }

    pub def atMonthDay(x: Year, monthDay: MonthDay): LocalDate =
        import java.time.Year.atMonthDay(##java.time.MonthDay): ##java.time.LocalDate & Pure;
        let Year(x1) = x;
        let MonthDay(m1) = monthDay;
        LocalDate(atMonthDay(x1, m1))



    pub def compareTo(x: Year, y: Year): Int32 =
        import java.time.Year.compareTo(##java.time.Year): Int32 & Pure;
        let Year(x1) = x;
        let Year(y1) = y;
        compareTo(x1, y1)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: Year, y: Year): Bool =
        import java.time.Year.isBefore(##java.time.Year): Bool & Pure;
        let Year(x1) = x;
        let Year(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: Year, y: Year): Bool =
        import java.time.Year.isAfter(##java.time.Year): Bool & Pure;
        let Year(x1) = x;
        let Year(y1) = y;
        isAfter(x1, y1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeap(x: Year): Bool =
        import java.time.Year.isLeap(): Bool & Pure;
        let Year(x1) = x;
        isLeap(x1)

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: Int64): Bool =
        import static java.time.Year.isLeap(Int64): Bool & Pure;
        isLeap(x)


    ///
    /// Returns _
    ///
    pub def length(x: Year): Int32 =
        import java.time.Year.length(): Int32 & Pure;
        let Year(x1) = x;
        length(x1)

    pub def adjustInto(t: a, y: Year): a with Temporal[a] = 
        import java.time.Year.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let Year(y1) = y;
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(y1, t1))

    ///
    /// _
    ///
    pub def plusYears(x: Year, yearsToAdd: Int64): Year =
        import java.time.Year.plusYears(Int64): ##java.time.Year & Pure;
        let Year(x1) = x;
        Year(plusYears(x1, yearsToAdd))

    ///
    /// _
    ///
    pub def minusYears(x: Year, yearsToSubtract: Int64): Year =
        import java.time.Year.minusYears(Int64): ##java.time.Year & Pure;
        let Year(x1) = x;
        Year(minusYears(x1, yearsToSubtract))

    /// Generic

    /// # `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): Year = 
        import static java.time.Year.from(##java.time.temporal.TemporalAccessor): ##java.time.Year & Pure as fromTA;
        try {
            let x1 = Time/LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor;
            Year(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromLocalDateTime(x: LocalDateTime): Year = 
        import static java.time.Year.from(##java.time.temporal.TemporalAccessor): ##java.time.Year & Pure as fromTA;
        try {
            let x1 = Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor;
            Year(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): Year = 
        import static java.time.Year.from(##java.time.temporal.TemporalAccessor): ##java.time.Year & Pure as fromTA;
        try {
            let x1 = Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor;
            Year(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromYearMonth(x: YearMonth): Year = 
        import static java.time.Year.from(##java.time.temporal.TemporalAccessor): ##java.time.Year & Pure as fromTA;
        try {
            let x1 = Time/YearMonth.getYearMonth(x) as ##java.time.temporal.TemporalAccessor;
            Year(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromZonedDateTime(x: ZonedDateTime): Year = 
        import static java.time.Year.from(##java.time.temporal.TemporalAccessor): ##java.time.Year & Pure as fromTA;
        try {
            let x1 = Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor;
            Year(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }        



    pub def plus(x: Year, r: {amount :: Int64, temporalUnit :: a}): Year with YearTemporalUnit[a] =
        import java.time.Year.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Year & Pure;         
        try {
            let Year(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            Year(plus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minus(x: Year, r: {amount :: Int64, temporalUnit :: a}): Year with YearTemporalUnit[a] =
        import java.time.Year.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Year & Pure;         
        try {
            let Year(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            Year(minus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def plusTemporalAmount(x: Year, amount: a): Year with TemporalAmount[a] =
        import java.time.Year.plus(##java.time.temporal.TemporalAmount): ##java.time.Year & Pure;         
        try {
            let Year(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            Year(plus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmount(x: Year, amount: a): Year with TemporalAmount[a] =
        import java.time.Year.minus(##java.time.temporal.TemporalAmount): ##java.time.Year & Pure;         
        try {
            let Year(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            Year(minus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def range(field: a, x: Year): ValueRange with TemporalField[a] =
        import java.time.Year.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let Year(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    /// TODO refine class qualification of `t`
    pub def until(units: t, r: {start :: Year, end :: a}): Int64 with TemporalUnit[t], Temporal[a] = 
        import java.time.Year.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getYear(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        let units1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(units);
        until(b1, e1, units1)


    pub def withTemporalAdjuster(adj: a, x: Year): Year with TemporalAdjuster[a] =
        import java.time.Year.with(##java.time.temporal.TemporalAdjuster): ##java.time.Year & Pure as withTA;         
        try {
            let Year(x1) = x;
            let adj1 = Time/Temporal/TemporalAdjuster.marshalToNativeTemporalAdjuster(adj);
            Year(withTA(x1, adj1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalField(field: a, i: Int64, x: Year): Year with TemporalField[a] =
        import java.time.Year.with(##java.time.temporal.TemporalField, Int64): ##java.time.Year & Pure as withTF;         
        try {
            let Year(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            Year(withTF(x1, field1, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def get(t: a, x: Year): Int32 with TemporalField[a] = 
        import java.time.Year.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getYear(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: Year): Int64 with TemporalField[a] = 
        import java.time.Year.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getYear(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

}
