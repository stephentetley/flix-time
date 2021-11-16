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
    use Time/Temporal.TemporalAmount;

    ///
    /// A wrapper around java.time.Year.
    ///
    pub opaque type Year = ##java.time.Year

    instance ToString[Year] {
        pub def toString(x: Year): String =
            import java.time.Year.toString();
            let Year(x1) = x;
            toString(x1) as & Pure
    }

    ///
    /// Returns the year ...
    ///
    instance FromString[Year] {
        pub def fromString(s: String): Option[Year] =
            import java.lang.String.strip();
            import java.time.Year:parse(##java.lang.CharSequence);
            try {
                let cs = strip(s) as ##java.lang.CharSequence & Pure;
                Some(Year(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[Year] {
        pub def eq(x: Year, y: Year): Bool = Time/Year.equals(x, y)
    }

    instance Hash[Year] {
        pub def hash(x: Year): Int = Time/Year.hashCode(x)
    }

    instance Order[Year] {
        pub def compare(x: Year, y: Year): Comparison = 
            Time/Year.compareTo(x,y) |> Comparison.fromInt
    }
    
    instance LowerBound[Year] {
        pub def minValue(): Year =
            import get java.time.Year:MIN_VALUE as getMIN_VALUE;
            import java.time.Year:of(Int32);
            Year(of(getMIN_VALUE())) as & Pure
    }

    instance UpperBound[Year] {
        pub def maxValue(): Year =
            import get java.time.Year:MAX_VALUE as getMAX_VALUE;
            import java.time.Year:of(Int32);
            Year(of(getMAX_VALUE())) as & Pure
    }

}

namespace Time/Year {
    
    use Time.Year;
    use Time.Year.{Year};

    use Time/Format.DateFormatter;
    use Time/Format.DateFormatter.{DateFormatter};
    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.Month;
    use Time.MonthDay;
    use Time.MonthDay.{MonthDay};
    use Time.YearMonth;
    use Time.YearMonth.{YearMonth};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};


    pub def new(year: Int32): Year =
        import java.time.Year:of(Int32);
        Year(of(year)) as & Pure


    pub def now(): Year & Impure =         
        import java.time.Year:now();
        Year(now())

    pub def nowWithClock(x: Clock): Year & Impure =         
        import java.time.Year:now(##java.time.Clock);
        let Clock(x1) = x;
        Year(now(x1))

    pub def nowWithZoneId(x: ZoneId): Year & Impure =         
        import java.time.Year:now(##java.time.ZoneId);
        let ZoneId(x1) = x;
        Year(now(x1))


    /// 
    /// Parse the string `s` as a Year, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateFormatter, s: String): Option[Year] =
        import java.lang.String.strip();
        import java.time.Year:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence & Pure;
            Some(Year(parse(cs, fmtr))) as & Pure
        } catch {
            case _: ##java.lang.Exception => None
        }

    ///
    /// Returns the Year `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateFormatter, x: Year): String =
        import java.time.Year.format(##java.time.format.DateTimeFormatter);
        let Year(x1) = x;
        let DateFormatter(fmtr) = formatter;
        format(x1, fmtr) as & Pure

    pub def equals(x: Year, y: Year): Bool =
        import java.time.Year.equals(##java.lang.Object);
        let Year(x1) = x;
        let Year(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure


    pub def hashCode(x: Year): Int32 = 
        import java.time.Year.hashCode();
        let Year(x1) = x;
        hashCode(x1) as & Pure

    pub def atDay(x: Year, dayOfYear: Int32): Option[LocalDate] =
        import java.time.Year.atDay(Int32);
        try {
            let Year(x1) = x;
            Some(LocalDate(atDay(x1, dayOfYear))) as & Pure
        } catch {
            case _: ##java.lang.Exception => None
        }

    pub def atMonth(x: Year, month: Int32): Option[YearMonth] =
        import java.time.Year.atMonth(Int32);
        try {
            let Year(x1) = x;
            Some(YearMonth(atMonth(x1, month))) as & Pure
        } catch {
            case _: ##java.lang.Exception => None
        }  

    pub def atMonthWithMonth(x: Year, month: Month): Option[YearMonth] =
        import java.time.Year.atMonth(##java.time.Month);
        try {
            let Year(x1) = x;
            let m1 = Time/Month.toNative(month);
            Some(YearMonth(atMonth(x1, m1))) as & Pure
        } catch {
            case _: ##java.lang.Exception => None
        }        
    
    pub def atMonthDay(x: Year, monthDay: MonthDay): LocalDate =
        import java.time.Year.atMonthDay(##java.time.MonthDay);
        let Year(x1) = x;
        let MonthDay(m1) = monthDay;
        LocalDate(atMonthDay(x1, m1)) as & Pure
        
    

    pub def compareTo(x: Year, y: Year): Int32 =
        import java.time.Year.compareTo(##java.time.Year);
        let Year(x1) = x;
        let Year(y1) = y;
        compareTo(x1, y1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: Year, y: Year): Bool =
        import java.time.Year.isBefore(##java.time.Year);
        let Year(x1) = x;
        let Year(y1) = y;
        isBefore(x1, y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: Year, y: Year): Bool =
        import java.time.Year.isAfter(##java.time.Year);
        let Year(x1) = x;
        let Year(y1) = y;
        isAfter(x1, y1) as & Pure

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeap(x: Year): Bool =
        import java.time.Year.isLeap();
        let Year(x1) = x;
        isLeap(x1) as & Pure

    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def isLeapYear(x: Int64): Bool =
        import java.time.Year:isLeap(Int64);
        isLeap(x) as & Pure


    ///
    /// Returns `true` if `x` is a leap year.
    ///
    pub def length(x: Year): Int32 =
        import java.time.Year.length();
        let Year(x1) = x;
        length(x1) as & Pure

    ///
    /// _
    ///
    pub def plusYears(x: Year, yearsToAdd: Int64): Year =
        import java.time.Year.plusYears(Int64);
        let Year(x1) = x;
        Year(plusYears(x1, yearsToAdd)) as & Pure

    ///
    /// _
    ///
    pub def minusYears(x: Year, yearsToSubtract: Int64): Year =
        import java.time.Year.minusYears(Int64);
        let Year(x1) = x;
        Year(minusYears(x1, yearsToSubtract)) as & Pure    

    pub def plusDecades(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getDECADES() as ##java.time.temporal.TemporalUnit;
        plusHelper(x, i, unit)
    
    pub def minusDecades(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getDECADES() as ##java.time.temporal.TemporalUnit;
        minusHelper(x, i, unit)

    pub def plusCenturies(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getCENTURIES() as ##java.time.temporal.TemporalUnit;
        plusHelper(x, i, unit)
    
    pub def minusCenturies(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getCENTURIES() as ##java.time.temporal.TemporalUnit;
        minusHelper(x, i, unit)

    pub def plusMillennia(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getMILLENNIA() as ##java.time.temporal.TemporalUnit;
        plusHelper(x, i, unit)
    
    pub def minusMillenia(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getMILLENNIA() as ##java.time.temporal.TemporalUnit;
        minusHelper(x, i, unit)

    pub def plusEras(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getERAS() as ##java.time.temporal.TemporalUnit;
        plusHelper(x, i, unit)
    
    pub def minusEras(x: Year, i: Int64): Year =
        let unit = Time/Internal/ChronoUnit.getERAS() as ##java.time.temporal.TemporalUnit;
        minusHelper(x, i, unit)

    def plusHelper(x: Year, amountToAdd: Int64, unit: ##java.time.temporal.TemporalUnit): Year =
        import java.time.Year.plus(Int64, ##java.time.temporal.TemporalUnit);
        let Year(x1) = x;
        Year(plus(x1, amountToAdd, unit)) as & Pure
    
    def minusHelper(x: Year, amountToSubtract: Int64, unit: ##java.time.temporal.TemporalUnit): Year =
        import java.time.Year.minus(Int64, ##java.time.temporal.TemporalUnit);
        let Year(x1) = x;
        Year(minus(x1, amountToSubtract, unit)) as & Pure

    pub def yearsBetween(x: Year, y: Year): Int64 = 
        let unit = Time/Internal/ChronoUnit.getYEARS() as ##java.time.temporal.TemporalUnit;
        betweenHelper(x, y, unit)

    pub def decadesBetween(x: Year, y: Year): Int64 = 
        let unit = Time/Internal/ChronoUnit.getDECADES() as ##java.time.temporal.TemporalUnit;
        betweenHelper(x, y, unit)

    pub def centuriesBetween(x: Year, y: Year): Int64 = 
        let unit = Time/Internal/ChronoUnit.getCENTURIES() as ##java.time.temporal.TemporalUnit;
        betweenHelper(x, y, unit)

    pub def millenniaBetween(x: Year, y: Year): Int64 = 
        let unit = Time/Internal/ChronoUnit.getMILLENNIA() as ##java.time.temporal.TemporalUnit;
        betweenHelper(x, y, unit)

    pub def erasBetween(x: Year, y: Year): Int64 = 
        let unit = Time/Internal/ChronoUnit.getERAS() as ##java.time.temporal.TemporalUnit;
        betweenHelper(x, y, unit)

    def betweenHelper(x:Year, y: Year, unit: ##java.time.temporal.TemporalUnit): Int64 = 
        import java.time.Year.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit);
        let Year(x1) = x;
        let Year(y1) = y;
        let ty1 = y1 as ##java.time.temporal.Temporal;
        until(x1, ty1, unit) as & Pure

    pub def withYear(x: Year, i: Int64): Year = 
        let field = Time/Internal/ChronoField.getYEAR() as ##java.time.temporal.TemporalField;
        withHelper(x, field, i)

    
    pub def withEraBCE(x: Year): Year = 
        let field = Time/Internal/ChronoField.getERA() as ##java.time.temporal.TemporalField;
        withHelper(x, field, 0i64)

    pub def withEraCE(x: Year): Year = 
        let field = Time/Internal/ChronoField.getERA() as ##java.time.temporal.TemporalField;
        withHelper(x, field, 1i64)


    pub def withYearOfEra(x: Year, i: Int64): Year = 
        let field = Time/Internal/ChronoField.getYEAR_OF_ERA() as ##java.time.temporal.TemporalField;
        withHelper(x, field, i)

    def withHelper(x:Year, field: ##java.time.temporal.TemporalField, i: Int64): Year = 
        import java.time.Year.with(##java.time.temporal.TemporalField, Int64) as withX;
        let Year(x1) = x;
        Year(withX(x1, field, i)) as & Pure


}
