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
    /// A wrapper around a Java LocalDate.
    ///
    pub opaque type LocalDate = ##java.time.LocalDate

    ///
    /// Returns the given date `x` as a string using the Java builtin toString method.
    ///
    instance ToString[LocalDate] {
        pub def toString(x: LocalDate): String =
            import java.time.LocalDate.toString(): String & Pure;
            let LocalDate(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDate] {
        pub def fromString(s: String): Option[LocalDate] =
            import static java.time.LocalDate.parse(##java.lang.CharSequence): ##java.time.LocalDate & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(LocalDate(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[LocalDate] {
        pub def eq(x: LocalDate, y: LocalDate): Bool = Time/LocalDate.equals(x, y)
    }

    instance Hash[LocalDate] {
        pub def hash(x: LocalDate): Int32 = Time/LocalDate.hashCode(x)
    }


    instance Order[LocalDate] {
        pub def compare(x: LocalDate, y: LocalDate): Comparison =
            Time/LocalDate.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[LocalDate] {
        pub def minValue(): LocalDate =
            import static get java.time.LocalDate.MIN: ##java.time.LocalDate & Pure as getMIN;
            LocalDate(getMIN())
    }

    instance UpperBound[LocalDate] {
        pub def maxValue(): LocalDate =
            import static get java.time.LocalDate.MAX: ##java.time.LocalDate & Pure as getMAX;
            LocalDate(getMAX())
    }

    instance Boxable[LocalDate]

    instance TemporalAccessor[LocalDate] {
        pub def marshalToNativeTemporalAccessor(x: LocalDate): ##java.time.temporal.TemporalAccessor =         
            Time/LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): LocalDate = 
            LocalDate(x as ##java.time.LocalDate)
    }

    instance Temporal[LocalDate] {
        pub def marshalToNativeTemporal(x: LocalDate): ##java.time.temporal.Temporal =         
            Time/LocalDate.getLocalDate(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): LocalDate = 
            LocalDate(x as ##java.time.LocalDate)
    }

    instance TemporalAdjuster[LocalDate] {
        pub def marshalToNativeTemporalAdjuster(x: LocalDate): ##java.time.temporal.TemporalAdjuster =         
            Time/LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): LocalDate = 
            LocalDate(x as ##java.time.LocalDate)
    }

}

namespace Time/LocalDate {

    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
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
    use Time.DayOfWeek;
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time.OffsetDateTime;
    use Time.OffsetDateTime.{OffsetDateTime};
    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};


    pub def getLocalDate(x: LocalDate): ##java.time.LocalDate = 
        let LocalDate(x1) = x;
        x1

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def fromTemporalAccessor(x: a): LocalDate with TemporalAccessor[a] = 
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate & Pure as fromTA;
        let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
        LocalDate(fromTA(x1))


    pub def of(r: {year :: Int32, month :: Int32, dayOfMonth :: Int32}): LocalDate =
        import static java.time.LocalDate.of(Int32, Int32, Int32): ##java.time.LocalDate & Pure;
        LocalDate(of(r.year, r.month, r.dayOfMonth))

    pub def ofWithMonth(r: {year :: Int32, month :: Month, dayOfMonth :: Int32}): LocalDate =
        import static java.time.LocalDate.of(Int32, ##java.time.Month, Int32): ##java.time.LocalDate & Pure;
        let m1 = Time/Month.marshal(r.month);
        LocalDate(of(r.year, m1, r.dayOfMonth))

    /// TODO - potentially remove getFields...
    pub def getFields(x: LocalDate): {year :: Int32, month :: Int32, dayOfMonth :: Int32} =
        {year = getYear(x), month = getMonthValue(x), dayOfMonth = getDayOfMonth(x)}


    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate & Impure =
        import static java.time.LocalDate.now(): ##java.time.LocalDate & Impure;
        LocalDate(now())

    ///
    /// Returns the current date from the system clock using zoneId.
    ///
    pub def nowWithZoneId(zoneId: ZoneId): LocalDate & Impure =
        import static java.time.LocalDate.now(##java.time.ZoneId): ##java.time.LocalDate & Impure;
        let ZoneId(z1) = zoneId;
        LocalDate(now(z1))


    ///
    /// ___
    ///
    pub def epoch(): LocalDate =
        import static get java.time.LocalDate.EPOCH: ##java.time.LocalDate & Pure as getEPOCH;
        LocalDate(getEPOCH())



    pub def atStartOfDay(x: LocalDate): LocalDateTime =
        import java.time.LocalDate.atStartOfDay(): ##java.time.LocalDateTime & Pure;
        let LocalDate(x1) = x;
        LocalDateTime(atStartOfDay(x1))

    pub def atStartOfDayWithZoneId(x: LocalDate, zoneId: ZoneId): ZonedDateTime =
        import java.time.LocalDate.atStartOfDay(##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let LocalDate(x1) = x;
        let ZoneId(z1) = zoneId;
        ZonedDateTime(atStartOfDay(x1, z1))

    pub def atTimeWithLocalTime(x: LocalDate, t: LocalTime): LocalDateTime =
        import java.time.LocalDate.atTime(##java.time.LocalTime): ##java.time.LocalDateTime & Pure;
        let LocalDate(x1) = x;
        let LocalTime(t1) = t;
        LocalDateTime(atTime(x1, t1))

    pub def atTimeWithOffsetTime(x: LocalDate, t: OffsetTime): OffsetDateTime =
        import java.time.LocalDate.atTime(##java.time.OffsetTime): ##java.time.OffsetDateTime & Pure;
        let LocalDate(x1) = x;
        let OffsetTime(t1) = t;
        OffsetDateTime(atTime(x1, t1))


    pub def ofInstant(x: ZInstant, zoneId: ZoneId): LocalDate =
        import static java.time.LocalDate.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalDate & Pure;
        let ZInstant(x1) = x;
        let ZoneId(z1) = zoneId;
        LocalDate(ofInstant(x1, z1))


    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Option[LocalDate] =
        import static java.time.LocalDate.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalDate & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(LocalDate(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    ///
    /// Returns LocalDate `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: LocalDate): String =
        import java.time.LocalDate.format(##java.time.format.DateTimeFormatter): String & Pure;
        let LocalDate(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    pub def equals(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.equals(##java.lang.Object): Bool & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object)


    pub def hashCode(x: LocalDate): Int32 =
        import java.time.LocalDate.hashCode(): Int32 & Pure;
        let LocalDate(x1) = x;
        hashCode(x1)


    pub def ofEpochDay(x: Int64): LocalDate =
        import static java.time.LocalDate.ofEpochDay(Int64): ##java.time.LocalDate & Pure;
        LocalDate(ofEpochDay(x))

    pub def toEpochDay(x: LocalDate): Int64 =
        import java.time.chrono.ChronoLocalDate.toEpochDay(): Int64 & Pure;
        let LocalDate(x1) = x;
        toEpochDay(x1 as ##java.time.chrono.ChronoLocalDate)



    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def compareTo(x: LocalDate, y: LocalDate): Int32 =
        import java.time.LocalDate.compareTo(##java.time.chrono.ChronoLocalDate): Int32 & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        compareTo(x1, y1 as ##java.time.chrono.ChronoLocalDate)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isBefore(##java.time.chrono.ChronoLocalDate): Bool & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        isBefore(x1, y1 as ##java.time.chrono.ChronoLocalDate)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isAfter(##java.time.chrono.ChronoLocalDate): Bool & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        isAfter(x1, y1 as ##java.time.chrono.ChronoLocalDate)


    pub def plusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.plusYears(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusYears(x1, years))

    pub def minusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.minusYears(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusYears(x1, years))

    pub def plusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.plusMonths(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusMonths(x1, months))

    pub def minusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.minusMonths(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusMonths(x1, months))

    pub def plusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.plusWeeks(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusWeeks(x1, weeks))

    pub def minusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.minusWeeks(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusWeeks(x1, weeks))

    pub def plusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.plusDays(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusDays(x1, days))

    pub def minusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.minusDays(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusDays(x1, days))


    pub def getDayOfWeek(x: LocalDate): DayOfWeek =
        use Time/DayOfWeek.{unmarshal};
        import java.time.LocalDate.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let LocalDate(x1) = x;
        unmarshal(getDayOfWeek(x1))

    pub def getDayOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfMonth(): Int32 & Pure;
        let LocalDate(x1) = x;
        getDayOfMonth(x1)

    pub def withDayOfMonth(x: LocalDate, dayOfMonth: Int32): LocalDate =
        import java.time.LocalDate.withDayOfMonth(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfYear(): Int32 & Pure;
        let LocalDate(x1) = x;
        getDayOfYear(x1)

    pub def withDayOfYear(x: LocalDate, dayOfYear: Int32): LocalDate =
        import java.time.LocalDate.withDayOfYear(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withDayOfYear(x1, dayOfYear))

    pub def getMonth(x: LocalDate): Month =
        import java.time.LocalDate.getMonth(): ##java.time.Month & Pure;
        let LocalDate(x1) = x;
        Time/Month.unmarshal(getMonth(x1))


    pub def getMonthValue(x: LocalDate): Int32 =
        import java.time.LocalDate.getMonth(): ##java.time.Month & Pure;
        import java.time.Month.getValue(): Int32 & Pure;
        let LocalDate(x1) = x;
        getValue(getMonth(x1))

    pub def withMonth(x: LocalDate, month: Int32): LocalDate =
        import java.time.LocalDate.withMonth(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withMonth(x1, month))

    pub def getYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getYear(): Int32 & Pure;
        let LocalDate(x1) = x;
        getYear(x1)

    pub def withYear(x: LocalDate, year: Int32): LocalDate =
        import java.time.LocalDate.withYear(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withYear(x1, year))

    pub def isLeapYear(x: LocalDate): Bool =
        import java.time.LocalDate.isLeapYear(): Bool & Pure;
        let LocalDate(x1) = x;
        isLeapYear(x1)

    pub def lengthOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfMonth(): Int32 & Pure;
        let LocalDate(x1) = x;
        lengthOfMonth(x1)

    pub def lengthOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfYear(): Int32 & Pure;
        let LocalDate(x1) = x;
        lengthOfYear(x1)



    /// NOTE - maybe this should return Option [/ Result] ?
    pub def adjustInto(t: a, x: LocalDate): a with Temporal[a] = 
        import java.time.LocalDate.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = getLocalDate(x);
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))


    pub def get(t: a, x: LocalDate): Int32 with TemporalField[a] = 
        import java.time.LocalDate.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getLocalDate(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: LocalDate): Int64 with TemporalField[a] = 
        import java.time.LocalDate.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getLocalDate(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

    pub def plus(x: LocalDate, r: {amount :: Int64, temporalUnit :: a}): LocalDate with TemporalUnit[a] =
        import java.time.LocalDate.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate & Pure;         
        try {
            let LocalDate(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            LocalDate(plus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minus(x: LocalDate, r: {amount :: Int64, temporalUnit :: a}): LocalDate with TemporalUnit[a] =
        import java.time.LocalDate.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate & Pure;         
        try {
            let LocalDate(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            LocalDate(minus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def plusTemporalAmount(x: LocalDate, amount: a): LocalDate with TemporalAmount[a] =
        import java.time.LocalDate.plus(##java.time.temporal.TemporalAmount): ##java.time.LocalDate & Pure;         
        try {
            let LocalDate(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            LocalDate(plus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmount(x: LocalDate, amount: a): LocalDate with TemporalAmount[a] =
        import java.time.LocalDate.minus(##java.time.temporal.TemporalAmount): ##java.time.LocalDate & Pure;         
        try {
            let LocalDate(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            LocalDate(minus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def range(field: a, x: LocalDate): ValueRange with TemporalField[a] =
        import java.time.LocalDate.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let LocalDate(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def until(units: t, r: {start :: LocalDate, end :: a}): Int64 with TemporalUnit[t], Temporal[a] = 
        import java.time.LocalDate.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getLocalDate(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        let units1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(units);
        until(b1, e1, units1)

    pub def withTemporalAdjuster(adj: a, x: LocalDate): LocalDate with TemporalAdjuster[a] =
        import java.time.LocalDate.with(##java.time.temporal.TemporalAdjuster): ##java.time.LocalDate & Pure as withTA;         
        try {
            let LocalDate(x1) = x;
            let adj1 = Time/Temporal/TemporalAdjuster.marshalToNativeTemporalAdjuster(adj);
            LocalDate(withTA(x1, adj1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalField(field: a, i: Int64, x: LocalDate): LocalDate with TemporalField[a] =
        import java.time.LocalDate.with(##java.time.temporal.TemporalField, Int64): ##java.time.LocalDate & Pure as withTF;         
        try {
            let LocalDate(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            LocalDate(withTF(x1, field1, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    /// pub def until(b: LocalDate, e: LocalDate, unit: ChronoUnit): Int64 =
    ///     import java.time.LocalDate.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
    ///     let LocalDate(b1) = b;
    ///     let LocalDate(e1) = e;
    ///     let u1 = Time/Temporal/ChronoUnit.marshal(unit);
    ///     let te1 = e1 as ##java.time.temporal.Temporal;
    ///     let tu1 = u1 as ##java.time.temporal.TemporalUnit;
    ///     until(b1, te1, tu1)

}
