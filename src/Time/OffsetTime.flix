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
    /// A wrapper around a Java OffsetTime.
    ///
    pub opaque type OffsetTime = ##java.time.OffsetTime


    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[OffsetTime] {
        pub def toString(x: OffsetTime): String =
            import java.time.OffsetTime.toString(): String & Pure;
            let OffsetTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetTime] {
        pub def fromString(s: String): Option[OffsetTime] =
            import static java.time.OffsetTime.parse(##java.lang.CharSequence): ##java.time.OffsetTime & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(OffsetTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[OffsetTime] {
        pub def eq(x: OffsetTime, y: OffsetTime): Bool = Time/OffsetTime.equals(x, y)
    }

    instance Hash[OffsetTime] {
        pub def hash(x: OffsetTime): Int32 = Time/OffsetTime.hashCode(x)
    }

    instance Order[OffsetTime] {
        pub def compare(x: OffsetTime, y: OffsetTime): Comparison =
            Time/OffsetTime.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[OffsetTime] {
        pub def minValue(): OffsetTime =
            import static get java.time.OffsetTime.MIN: ##java.time.OffsetTime & Pure as getMIN;
            OffsetTime(getMIN())
    }

    instance UpperBound[OffsetTime] {
        pub def maxValue(): OffsetTime =
            import static get java.time.OffsetTime.MAX: ##java.time.OffsetTime & Pure as getMAX;
            OffsetTime(getMAX())
    }

    instance Boxable[OffsetTime]

    instance TemporalAccessor[OffsetTime] {
        pub def marshalToNativeTemporalAccessor(x: OffsetTime): ##java.time.temporal.TemporalAccessor =         
            Time/OffsetTime.getOffsetTime(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): OffsetTime = 
            OffsetTime(x as ##java.time.OffsetTime)
    }

    instance Temporal[OffsetTime] {
        pub def marshalToNativeTemporal(x: OffsetTime): ##java.time.temporal.Temporal =         
            Time/OffsetTime.getOffsetTime(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): OffsetTime = 
            OffsetTime(x as ##java.time.OffsetTime)
    }

    instance TemporalAdjuster[OffsetTime] {
        pub def marshalToNativeTemporalAdjuster(x: OffsetTime): ##java.time.temporal.TemporalAdjuster =         
            Time/OffsetTime.getOffsetTime(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): OffsetTime = 
            OffsetTime(x as ##java.time.OffsetTime)
    }

}

namespace Time/OffsetTime {

    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time/Temporal.ChronoUnit;
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.TimeFormat;
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;
    use Time/Temporal.TemporalAmount;
    use Time/Temporal.TemporalField;
    use Time/Temporal.TemporalUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.Instant;
    use Time.Instant.{Instant};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.OffsetDateTime;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZonedDateTime;
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def getOffsetTime(x: OffsetTime): ##java.time.OffsetTime = 
        let OffsetTime(x1) = x;
        x1




    pub def offsetTime(r: { hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32, offset :: ZoneOffset}): OffsetTime =
        import static java.time.OffsetTime.of(Int32, Int32, Int32, Int32, ##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        OffsetTime(of(r.hour, r.minute, r.second, r.nanoSecond, Time/ZoneOffset.getZoneOffset(r.offset)))



    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): OffsetTime & Impure =
        import static java.time.OffsetTime.now(): ##java.time.OffsetTime & Impure;
        OffsetTime(now())

    ///
    /// Returns the current time from the system clock.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetTime & Impure =
        import static java.time.OffsetTime.now(##java.time.ZoneId): ##java.time.OffsetTime & Impure;
        let ZoneId(z1) = zone;
        OffsetTime(now(z1))


    pub def fromLocalTime(offset: {offset :: ZoneOffset}, x: LocalTime): OffsetTime =
        import static java.time.OffsetTime.of(##java.time.LocalTime, ##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let LocalTime(x1) = x;
        let ZoneOffset(o1) = offset.offset;
        OffsetTime(of(x1, o1))


    pub def fromInstant(zone: {zone :: ZoneId}, x: Instant): OffsetTime =
        import static java.time.OffsetTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.OffsetTime & Pure;
        let Instant(x1) = x;
        let ZoneId(z1) = zone.zone;
        OffsetTime(ofInstant(x1, z1))



    ///
    /// Returns OffsetTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[TimeFormat], x: OffsetTime): String =
        import java.time.OffsetTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let OffsetTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[TimeFormat], s: String): Option[OffsetTime] =
        import static java.time.OffsetTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.OffsetTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(OffsetTime(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.equals(##java.lang.Object): Bool & Pure;
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: OffsetTime): Int32 =
        import java.time.OffsetTime.hashCode(): Int32 & Pure;
        let OffsetTime(x1) = x;
        hashCode(x1)

    ///
    /// Returns .
    ///
    pub def compareTo(x: OffsetTime, y: OffsetTime): Int32 =
        import java.time.OffsetTime.compareTo(##java.time.OffsetTime): Int32 & Pure;
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        compareTo(x1, y1)

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isBefore(##java.time.OffsetTime): Bool & Pure;
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isAfter(##java.time.OffsetTime): Bool & Pure;
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isAfter(x1, y1)

    pub def plusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.plusHours(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusHours(x1, hours))

    pub def minusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.minusHours(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusHours(x1, hours))

    pub def plusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.plusMinutes(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.minusMinutes(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.plusSeconds(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.minusSeconds(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.plusNanos(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusNanos(x1, nanos))

    pub def minusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.minusNanos(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusNanos(x1, nanos))

    /// Get/Set...

    pub def getHour(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getHour(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getHour(x1)

    pub def setHour(hour: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withHour(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withHour(x1, hour))

    pub def getMinute(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getMinute(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getMinute(x1)

    pub def setMinute(minute: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withMinute(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withMinute(x1, minute))

    pub def getSecond(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getSecond(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getSecond(x1)

    pub def setSecond(second: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withSecond(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withSecond(x1, second))

    pub def getNano(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getNano(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getNano(x1)

    pub def setNano(nano: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withNano(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withNano(x1, nano))

    pub def getOffset(x: OffsetTime): ZoneOffset =
        import java.time.OffsetTime.getOffset(): ##java.time.ZoneOffset & Pure;
        let OffsetTime(x1) = x;
        ZoneOffset(getOffset(x1))

    pub def setOffsetSameInstant(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameInstant(##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameInstant(x1, o1))

    pub def setOffsetSameLocal(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameLocal(##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameLocal(x1, o1))

    /// Generic



    /// # `fromTemporalAccessor` specialized

    pub def fromOffsetDateTime(x: OffsetDateTime): OffsetTime = 
        import static java.time.YearMonth.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetTime & Pure as fromTA;
        try {
            let x1 = Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor;
            OffsetTime(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromZonedDateTime(x: ZonedDateTime): OffsetTime = 
        import static java.time.OffsetTime.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetTime & Pure as fromTA;
        try {
            let x1 = Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor;
            OffsetTime(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def get(t: a, x: OffsetTime): Int32 with TemporalField[a] = 
        import java.time.OffsetTime.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getOffsetTime(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: OffsetTime): Int64 with TemporalField[a] = 
        import java.time.OffsetTime.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getOffsetTime(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

    pub def plus(x: OffsetTime, r: {amount :: Int64, temporalUnit :: a}): OffsetTime with TemporalUnit[a] =
        import java.time.OffsetTime.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.OffsetTime & Pure;         
        try {
            let OffsetTime(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            OffsetTime(plus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minus(x: OffsetTime, r: {amount :: Int64, temporalUnit :: a}): OffsetTime with TemporalUnit[a] =
        import java.time.OffsetTime.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.OffsetTime & Pure;         
        try {
            let OffsetTime(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            OffsetTime(minus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def plusTemporalAmount(x: OffsetTime, amount: a): OffsetTime with TemporalAmount[a] =
        import java.time.OffsetTime.plus(##java.time.temporal.TemporalAmount): ##java.time.OffsetTime & Pure;         
        try {
            let OffsetTime(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            OffsetTime(plus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmount(x: OffsetTime, amount: a): OffsetTime with TemporalAmount[a] =
        import java.time.OffsetTime.minus(##java.time.temporal.TemporalAmount): ##java.time.OffsetTime & Pure;         
        try {
            let OffsetTime(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            OffsetTime(minus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def range(field: a, x: OffsetTime): ValueRange with TemporalField[a] =
        import java.time.OffsetTime.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let OffsetTime(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def until(units: t, r: {start :: OffsetTime, end :: a}): Int64 with TemporalUnit[t], Temporal[a] = 
        import java.time.OffsetTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getOffsetTime(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        let units1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(units);
        until(b1, e1, units1)

    pub def truncatedTo(unit: a, x: OffsetTime): OffsetTime with TemporalUnit[a] = 
        import java.time.OffsetTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        let unit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(unit);
        OffsetTime(truncatedTo(x1, unit1))


    pub def withTemporalAdjuster(adj: a, x: OffsetTime): OffsetTime with TemporalAdjuster[a] =
        import java.time.OffsetTime.with(##java.time.temporal.TemporalAdjuster): ##java.time.OffsetTime & Pure as withTA;         
        try {
            let OffsetTime(x1) = x;
            let adj1 = Time/Temporal/TemporalAdjuster.marshalToNativeTemporalAdjuster(adj);
            OffsetTime(withTA(x1, adj1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalField(field: a, i: Int64, x: OffsetTime): OffsetTime with TemporalField[a] =
        import java.time.OffsetTime.with(##java.time.temporal.TemporalField, Int64): ##java.time.OffsetTime & Pure as withTF;         
        try {
            let OffsetTime(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            OffsetTime(withTF(x1, field1, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }



}
