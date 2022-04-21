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
    /// A wrapper around a Java LocalDateTime.
    ///
    pub opaque type LocalDateTime = ##java.time.LocalDateTime

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[LocalDateTime] {
        pub def toString(x: LocalDateTime): String =
            import java.time.LocalDateTime.toString(): String & Pure;
            let LocalDateTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDateTime] {
        pub def fromString(s: String): Option[LocalDateTime] =
            import static java.time.LocalDateTime.parse(##java.lang.CharSequence): ##java.time.LocalDateTime & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(LocalDateTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[LocalDateTime] {
        pub def eq(x: LocalDateTime, y: LocalDateTime): Bool = Time/LocalDateTime.equals(x, y)
    }

    instance Hash[LocalDateTime] {
        pub def hash(x: LocalDateTime): Int32 = Time/LocalDateTime.hashCode(x)
    }

    instance Order[LocalDateTime] {
        pub def compare(x: LocalDateTime, y: LocalDateTime): Comparison =
            Time/LocalDateTime.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[LocalDateTime] {
        pub def minValue(): LocalDateTime =
            import static get java.time.LocalDateTime.MIN: ##java.time.LocalDateTime & Pure as getMIN;
            LocalDateTime(getMIN())
    }

    instance UpperBound[LocalDateTime] {
        pub def maxValue(): LocalDateTime =
            import static get java.time.LocalDateTime.MAX: ##java.time.LocalDateTime & Pure as getMAX;
            LocalDateTime(getMAX())
    }

    instance Boxable[LocalDateTime]

    instance TemporalAccessor[LocalDateTime] {
        pub def marshalToNativeTemporalAccessor(x: LocalDateTime): ##java.time.temporal.TemporalAccessor =         
            Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): LocalDateTime = 
            LocalDateTime(x as ##java.time.LocalDateTime)
    }

    instance Temporal[LocalDateTime] {
        pub def marshalToNativeTemporal(x: LocalDateTime): ##java.time.temporal.Temporal =         
            Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): LocalDateTime = 
            LocalDateTime(x as ##java.time.LocalDateTime)
    }

    instance TemporalAdjuster[LocalDateTime] {
        pub def marshalToNativeTemporalAdjuster(x: LocalDateTime): ##java.time.temporal.TemporalAdjuster =         
            Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): LocalDateTime = 
            LocalDateTime(x as ##java.time.LocalDateTime)
    }

}

namespace Time/LocalDateTime {

    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.DateTimeFormat;
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;
    use Time/Temporal.TemporalAmount;
    use Time/Temporal.TemporalField;
    use Time/Temporal.TemporalUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.DayOfWeek;
    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time/Temporal.ChronoUnit;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};


    pub def getLocalDateTime(x: LocalDateTime): ##java.time.LocalDateTime = 
        let LocalDateTime(x1) = x;
        x1

    /// `fromTemporalAccessor` does not support all TemporalAccessor types
    pub def fromTemporalAccessor(x: a): Result[LocalDateTime, String] with TemporalAccessor[a] = 
        import static java.time.LocalDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDateTime & Pure as fromTA;
        try {
            let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
            LocalDateTime(fromTA(x1)) |> Ok
        } catch {
            case ex: ##java.lang.Exception => Err(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def localDateTime(r: {year :: Int32, month :: Int32, dayOfMonth :: Int32, hour :: Int32, minute :: Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime & Pure;
        LocalDateTime(of(r.year, r.month, r.dayOfMonth, r.hour, r.minute))

    pub def localDateTimeWithSecond(r: {year :: Int32, month :: Int32, dayOfMonth :: Int32,
                                hour :: Int32, minute :: Int32, second :: Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime & Pure;
        LocalDateTime(of(r.year, r.month, r.dayOfMonth, r.hour, r.minute, r.second))

    pub def localDateTimeWithSecondAndNano(r: {year :: Int32, month :: Int32, dayOfMonth :: Int32,
                                        hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32}): LocalDateTime =
        import static java.time.LocalDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32, Int32): ##java.time.LocalDateTime & Pure;
        LocalDateTime(of(r.year, r.month, r.dayOfMonth, r.hour, r.minute, r.second, r.nanoSecond))


    ///
    /// Returns the current date-time from the system clock.
    ///
    pub def now(): LocalDateTime & Impure =
        import static java.time.LocalDateTime.now(): ##java.time.LocalDateTime & Impure;
        LocalDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): LocalDateTime & Impure =
        import static java.time.LocalDateTime.now(##java.time.ZoneId): ##java.time.LocalDateTime & Impure;
        let ZoneId(z) = zone;
        LocalDateTime(now(z))



    pub def fromLocalDateLocalTime(d: LocalDate, t: LocalTime): LocalDateTime =
        import static java.time.LocalDateTime.of(##java.time.LocalDate, ##java.time.LocalTime): ##java.time.LocalDateTime & Pure;
        let LocalDate(d1) = d;
        let LocalTime(t1) = t;
        LocalDateTime(of(d1, t1))

    pub def fromEpochSecond(offset: {offset :: ZoneOffset}, epochSecond: Int64, nanoOfSecond: Int32): LocalDateTime =
        import static java.time.LocalDateTime.ofEpochSecond(Int64, Int32, ##java.time.ZoneOffset): ##java.time.LocalDateTime & Pure;
        let ZoneOffset(o1) = offset.offset;
        LocalDateTime(ofEpochSecond(epochSecond, nanoOfSecond, o1))

    pub def fromInstant(zone: {zone :: ZoneId}, x: ZInstant): LocalDateTime =
        import static java.time.LocalDateTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalDateTime & Pure;
        let ZInstant(x1) = x;
        let ZoneId(z1) = zone.zone;
        LocalDateTime(ofInstant(x1, z1))


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        import java.time.LocalDateTime.toLocalDate(): ##java.time.LocalDate & Pure;
        let LocalDateTime(x1) = x;
        LocalDate(toLocalDate(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        import java.time.LocalDateTime.toLocalTime(): ##java.time.LocalTime & Pure;
        let LocalDateTime(x1) = x;
        LocalTime(toLocalTime(x1))



    ///
    /// Returns LocalDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: LocalDateTime): String =
        import java.time.LocalDateTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let LocalDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Option[LocalDateTime] =
        import static java.time.LocalDateTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalDateTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(LocalDateTime(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.equals(##java.lang.Object): Bool & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.hashCode(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        hashCode(x1)

    pub def compareTo(x: LocalDateTime, y: LocalDateTime): Int32 =
        import java.time.LocalDateTime.compareTo(##java.time.chrono.ChronoLocalDateTime): Int32 & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        let cy1 = y1 as ##java.time.chrono.ChronoLocalDateTime;
        compareTo(x1, cy1)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isBefore(##java.time.chrono.ChronoLocalDateTime): Bool & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        isBefore(x1, y1 as ##java.time.chrono.ChronoLocalDateTime)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isAfter(##java.time.chrono.ChronoLocalDateTime): Bool & Pure;
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        isAfter(x1, y1 as ##java.time.chrono.ChronoLocalDateTime)

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusYears(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusYears(x1, years))

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusYears(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusYears(x1, years))

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMonths(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusMonths(x1, months))

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMonths(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusMonths(x1, months))

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusWeeks(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusWeeks(x1, weeks))

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusWeeks(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusWeeks(x1, weeks))

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusDays(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusDays(x1, days))

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusDays(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusDays(x1, days))

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusHours(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusHours(x1, hours))

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusHours(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusHours(x1, hours))

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMinutes(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMinutes(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusSeconds(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusSeconds(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusNanos(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(plusNanos(x1, nanos))

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusNanos(Int64): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(minusNanos(x1, nanos))

    pub def getYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getYear(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getYear(x1)

    pub def withYear(x: LocalDateTime, year: Int32): LocalDateTime =
        import java.time.LocalDateTime.withYear(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withYear(x1, year))

    pub def getMonth(x: LocalDateTime): Month =
        import java.time.LocalDateTime.getMonth(): ##java.time.Month & Pure;
        let LocalDateTime(x1) = x;
        Time/Month.unmarshal(getMonth(x1))

    pub def getMonthValue(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMonth(): ##java.time.Month & Pure;
        import java.time.Month.getValue(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getValue(getMonth(x1))


    pub def withMonth(x: LocalDateTime, month: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMonth(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withMonth(x1, month))

    pub def getDayOfYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfYear(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getDayOfYear(x1)

    pub def withDayOfYear(x: LocalDateTime, dayOfYear: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfYear(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withDayOfYear(x1, dayOfYear))

    pub def getDayOfMonth(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfMonth(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getDayOfMonth(x1)

    pub def withDayOfMonth(x: LocalDateTime, dayOfMonth: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfMonth(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfWeek(x: LocalDateTime): DayOfWeek =
        import java.time.LocalDateTime.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let LocalDateTime(x1) = x;
        Time/DayOfWeek.unmarshal(getDayOfWeek(x1))

    pub def getHour(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getHour(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getHour(x1)

    pub def withHour(x: LocalDateTime, hour: Int32): LocalDateTime =
        import java.time.LocalDateTime.withHour(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withHour(x1, hour))

    pub def getMinute(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMinute(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getMinute(x1)

    pub def withMinute(x: LocalDateTime, minute: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMinute(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withMinute(x1, minute))

    pub def getSecond(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getSecond(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getSecond(x1)

    pub def withSecond(x: LocalDateTime, second: Int32): LocalDateTime =
        import java.time.LocalDateTime.withSecond(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withSecond(x1, second))

    pub def getNano(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getNano(): Int32 & Pure;
        let LocalDateTime(x1) = x;
        getNano(x1)

    pub def withNano(x: LocalDateTime, nano: Int32): LocalDateTime =
        import java.time.LocalDateTime.withNano(Int32): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        LocalDateTime(withNano(x1, nano))

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def adjustInto(t: a, x: LocalDateTime): a with Temporal[a] = 
        import java.time.LocalDateTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = getLocalDateTime(x);
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))

    pub def get(t: a, x: LocalDateTime): Int32 with TemporalField[a] = 
        import java.time.LocalDateTime.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getLocalDateTime(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: LocalDateTime): Int64 with TemporalField[a] = 
        import java.time.LocalDateTime.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getLocalDateTime(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

    pub def plus(x: LocalDateTime, r: {amount :: Int64, temporalUnit :: a}): LocalDateTime with TemporalUnit[a] =
        import java.time.LocalDateTime.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDateTime & Pure;         
        try {
            let LocalDateTime(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            LocalDateTime(plus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minus(x: LocalDateTime, r: {amount :: Int64, temporalUnit :: a}): LocalDateTime with TemporalUnit[a] =
        import java.time.LocalDateTime.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDateTime & Pure;         
        try {
            let LocalDateTime(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            LocalDateTime(minus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def plusTemporalAmount(x: LocalDateTime, amount: a): LocalDateTime with TemporalAmount[a] =
        import java.time.LocalDateTime.plus(##java.time.temporal.TemporalAmount): ##java.time.LocalDateTime & Pure;         
        try {
            let LocalDateTime(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            LocalDateTime(plus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmount(x: LocalDateTime, amount: a): LocalDateTime with TemporalAmount[a] =
        import java.time.LocalDateTime.minus(##java.time.temporal.TemporalAmount): ##java.time.LocalDateTime & Pure;         
        try {
            let LocalDateTime(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            LocalDateTime(minus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def range(field: a, x: LocalDateTime): ValueRange with TemporalField[a] =
        import java.time.LocalDateTime.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let LocalDateTime(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def truncatedTo(unit: a, x: LocalDateTime): LocalDateTime with TemporalUnit[a] = 
        import java.time.LocalDateTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.LocalDateTime & Pure;
        let LocalDateTime(x1) = x;
        let unit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(unit);
        LocalDateTime(truncatedTo(x1, unit1))

    pub def until(units: t, r: {start :: LocalDateTime, end :: a}): Int64 with TemporalUnit[t], Temporal[a] = 
        import java.time.LocalDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getLocalDateTime(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        let units1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(units);
        until(b1, e1, units1)

    pub def withTemporalAdjuster(adj: a, x: LocalDateTime): LocalDateTime with TemporalAdjuster[a] =
        import java.time.LocalDateTime.with(##java.time.temporal.TemporalAdjuster): ##java.time.LocalDateTime & Pure as withTA;         
        try {
            let LocalDateTime(x1) = x;
            let adj1 = Time/Temporal/TemporalAdjuster.marshalToNativeTemporalAdjuster(adj);
            LocalDateTime(withTA(x1, adj1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalField(field: a, i: Int64, x: LocalDateTime): LocalDateTime with TemporalField[a] =
        import java.time.LocalDateTime.with(##java.time.temporal.TemporalField, Int64): ##java.time.LocalDateTime & Pure as withTF;         
        try {
            let LocalDateTime(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            LocalDateTime(withTF(x1, field1, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


}
