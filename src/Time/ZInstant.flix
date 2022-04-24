/*
 * Copyright 2019 Magnus Madsen, Stephen Tetley
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

/// The name is temporary due to a clash with Flix stdlib



namespace Time {

    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;

    ///
    /// A wrapper around a Java instant.
    ///
    pub opaque type ZInstant = ##java.time.Instant
    
    ///
    /// Returns the given instant `x` as a String using ISO-8601 representation.
    ///
    instance ToString[ZInstant] {
        pub def toString(x: ZInstant): String =
            import java.time.Instant.toString(): String & Pure;
            let ZInstant(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as an Instant, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO UTC format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[ZInstant] {
        pub def fromString(s: String): Option[ZInstant] =
            import static java.time.Instant.parse(##java.lang.CharSequence): ##java.time.Instant & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(ZInstant(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[ZInstant] {
        pub def eq(x: ZInstant, y: ZInstant): Bool = Time/ZInstant.equals(x, y)
    }

    instance Hash[ZInstant] {
        pub def hash(x: ZInstant): Int32 = Time/ZInstant.hashCode(x)
    }

    instance Order[ZInstant] {
        pub def compare(x: ZInstant, y: ZInstant): Comparison =
            Time/ZInstant.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[ZInstant] {
        pub def minValue(): ZInstant = Time/ZInstant.min()
    }

    instance UpperBound[ZInstant] {
        pub def maxValue(): ZInstant = Time/ZInstant.max()
    }

    instance Boxable[ZInstant]

    instance TemporalAccessor[ZInstant] {
        pub def marshalToNativeTemporalAccessor(x: ZInstant): ##java.time.temporal.TemporalAccessor =         
            Time/ZInstant.getInstant(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): ZInstant = 
            ZInstant(x as ##java.time.Instant)
    }

    instance Temporal[ZInstant] {
        pub def marshalToNativeTemporal(x: ZInstant): ##java.time.temporal.Temporal =         
            Time/ZInstant.getInstant(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): ZInstant = 
            ZInstant(x as ##java.time.Instant)
    }

    instance TemporalAdjuster[ZInstant] {
        pub def marshalToNativeTemporalAdjuster(x: ZInstant): ##java.time.temporal.TemporalAdjuster =         
            Time/ZInstant.getInstant(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): ZInstant = 
            ZInstant(x as ##java.time.Instant)
    }
}   

namespace Time/ZInstant {

    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;
    use Time/Temporal.TemporalAmount;
    use Time/Temporal.TemporalField;
    use Time/Temporal.TemporalUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.ZDuration;
    use Time.ZDuration.{ZDuration};
    use Time.OffsetDateTime;
    use Time.OffsetDateTime.{OffsetDateTime};
    use Time.Period;
    use Time.Period.{Period};
    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def getInstant(x: ZInstant): ##java.time.Instant = 
        let ZInstant(x1) = x;
        x1


    pub def instant(r: {epochSecond :: Int64, nano :: Int64}): ZInstant =
        import static java.time.Instant.ofEpochSecond(Int64, Int64): ##java.time.Instant & Pure;
        ZInstant(ofEpochSecond(r.epochSecond, r.nano))


    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): ZInstant & Impure =
        import static java.time.Instant.now(): ##java.time.Instant & Impure;
        ZInstant(now())

    ///
    /// Returns the start of epoch instant - 1970-01-01T00:00:00Z
    ///
    pub def epoch(): ZInstant =
        import static get java.time.Instant.EPOCH: ##java.time.Instant & Pure as get_EPOCH;
        ZInstant(get_EPOCH())

    pub def min(): ZInstant =
        import static get java.time.Instant.MIN: ##java.time.Instant & Pure as get_MIN;
        ZInstant(get_MIN())
    
    pub def max(): ZInstant =
        import static get java.time.Instant.MAX: ##java.time.Instant & Pure as get_MAX;
        ZInstant(get_MAX())
    
    pub def fromEpochSecond(epochSecond: Int64): ZInstant =
        import static java.time.Instant.ofEpochSecond(Int64): ##java.time.Instant & Pure;
        ZInstant(ofEpochSecond(epochSecond))


    pub def fromEpochMilli(epochMilli: Int64): ZInstant =
        import static java.time.Instant.ofEpochMilli(Int64): ##java.time.Instant & Pure;
        ZInstant(ofEpochMilli(epochMilli))

    pub def toEpochMilli(x: ZInstant): Int64 =
        import java.time.Instant.toEpochMilli(): Int64 & Pure;
        let ZInstant(x1) = x;
        toEpochMilli(x1)

    pub def equals(x: ZInstant, y: ZInstant): Bool =
        import java.time.Instant.equals(##java.lang.Object): Bool & Pure;
        let ZInstant(x1) = x;
        let ZInstant(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZInstant): Int32 = 
        import java.time.Instant.hashCode(): Int32 & Pure;
        let ZInstant(x1) = x;
        hashCode(x1)

    

    pub def atOffset(x: ZInstant, offset: ZoneOffset): OffsetDateTime =
        import java.time.Instant.atOffset(##java.time.ZoneOffset): ##java.time.OffsetDateTime & Pure;
        let ZInstant(x1) = x;
        let ZoneOffset(offset1) = offset;
        OffsetDateTime(atOffset(x1, offset1))

    pub def atZone(x: ZInstant, zone: ZoneId): ZonedDateTime =
        import java.time.Instant.atZone(##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let ZInstant(x1) = x;
        let ZoneId(zone1) = zone;
        ZonedDateTime(atZone(x1, zone1))


    pub def getEpochSecond(x: ZInstant): Int64 =
        import java.time.Instant.getEpochSecond(): Int64 & Pure;
        let ZInstant(x1) = x;
        getEpochSecond(x1)

    pub def getNano(x: ZInstant): Int32 =
        import java.time.Instant.getNano(): Int32 & Pure;
        let ZInstant(x1) = x;
        getNano(x1)


    pub def compareTo(x: ZInstant, y: ZInstant): Int32 =
        import java.time.Instant.compareTo(##java.time.Instant): Int32 & Pure;
        let ZInstant(x1) = x;
        let ZInstant(y1) = y;
        compareTo(x1, y1)

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: ZInstant, y: ZInstant): Bool =
        import java.time.Instant.isBefore(##java.time.Instant): Bool & Pure;
        let ZInstant(x1) = x;
        let ZInstant(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: ZInstant, y: ZInstant): Bool =
        import java.time.Instant.isAfter(##java.time.Instant): Bool & Pure;
        let ZInstant(x1) = x;
        let ZInstant(y1) = y;
        isAfter(x1, y1)

    pub def plusSeconds(x: ZInstant, seconds: Int64): ZInstant =
        import java.time.Instant.plusSeconds(Int64): ##java.time.Instant & Pure;
        let ZInstant(x1) = x;
        ZInstant(plusSeconds(x1, seconds))

    pub def minusSeconds(x: ZInstant, seconds: Int64): ZInstant =
        import java.time.Instant.minusSeconds(Int64): ##java.time.Instant & Pure;
        let ZInstant(x1) = x;
        ZInstant(minusSeconds(x1, seconds))

    pub def plusMillis(x: ZInstant, millis: Int64): ZInstant =
        import java.time.Instant.plusMillis(Int64): ##java.time.Instant & Pure;
        let ZInstant(x1) = x;
        ZInstant(plusMillis(x1, millis))

    pub def minusMillis(x: ZInstant, millis: Int64): ZInstant =
        import java.time.Instant.minusMillis(Int64): ##java.time.Instant & Pure;
        let ZInstant(x1) = x;
        ZInstant(minusMillis(x1, millis))

    pub def plusNanos(x: ZInstant, nanos: Int64): ZInstant =
        import java.time.Instant.plusNanos(Int64): ##java.time.Instant & Pure;
        let ZInstant(x1) = x;
        ZInstant(plusNanos(x1, nanos))


    /// Generic

    /// # `fromTemporalAccessor` specialized

    pub def fromOffsetDateTime(x: OffsetDateTime): ZInstant = 
        import static java.time.Instant.from(##java.time.temporal.TemporalAccessor): ##java.time.Instant & Pure as fromTA;
        try {
            let x1 = Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor;
            ZInstant(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromZonedDateTime(x: ZonedDateTime): ZInstant = 
        import static java.time.Instant.from(##java.time.temporal.TemporalAccessor): ##java.time.Instant & Pure as fromTA;
        try {
            let x1 = Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor;
            ZInstant(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def range(field: a, x: ZInstant): ValueRange with TemporalField[a] =
        import java.time.Instant.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let ZInstant(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    /// # `getLong` specialized

    def getLongHelper(field: ##java.time.temporal.TemporalField, x: ZInstant): Int64 =
        import java.time.Instant.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        try {
            let ZInstant(x1) = x;
            getLong(x1, field)
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def getNanoOfSecond(x: ZInstant): Int64 =
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_NANO_OF_SECOND;
        getLongHelper(get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField, x)

    pub def getMicroOfSecond(x: ZInstant): Int64 =
        import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MICRO_OF_SECOND;
        getLongHelper(get_MICRO_OF_SECOND() as ##java.time.temporal.TemporalField, x)

    pub def getMilliOfSecond(x: ZInstant): Int64 =
        import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MILLI_OF_SECOND;
        getLongHelper(get_MILLI_OF_SECOND() as ##java.time.temporal.TemporalField, x)

    pub def getInstantSeconds(x: ZInstant): Int64 =
        import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField & Pure as get_INSTANT_SECONDS;
        getLongHelper(get_INSTANT_SECONDS() as ##java.time.temporal.TemporalField, x)


    /// # `plus<TemporalAmount>` specialized
    def plusHelper(x: ZInstant, a: ##java.time.temporal.TemporalAmount): ZInstant =
        import java.time.Instant.plus(##java.time.temporal.TemporalAmount): ##java.time.Instant & Pure;         
        try {
            let ZInstant(x1) = x;
            ZInstant(plus(x1, a))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def plusDuration(x: ZInstant, d: ZDuration): ZInstant =
        let d1 = Time/ZDuration.getDuration(d) as ##java.time.temporal.TemporalAmount;
        plusHelper(x, d1)

    /// Period.ofMonths and Period.ofYears fail (None)
    pub def plusPeriod(x: ZInstant, p: Period): Option[ZInstant] =
        try { 
            let d1 = Time/Period.getPeriod(p) as ##java.time.temporal.TemporalAmount;
            Some(plusHelper(x, d1))
        } catch {
            case _: ##java.lang.Exception => None
        }

    /// # `minus<TemporalAmount>` specialized
    def minusHelper(x: ZInstant, a: ##java.time.temporal.TemporalAmount): ZInstant =
        import java.time.Instant.minus(##java.time.temporal.TemporalAmount): ##java.time.Instant & Pure;         
        try {
            let ZInstant(x1) = x;
            ZInstant(minus(x1, a))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def minusDuration(x: ZInstant, d: ZDuration): ZInstant =
        let d1 = Time/ZDuration.getDuration(d) as ##java.time.temporal.TemporalAmount;
        minusHelper(x, d1)

    /// Period.ofMonths and Period.ofYears fail (None)
    pub def minusPeriod(x: ZInstant, p: Period): Option[ZInstant] =
        try { 
            let d1 = Time/Period.getPeriod(p) as ##java.time.temporal.TemporalAmount;
            Some(minusHelper(x, d1))
        } catch {
            case _: ##java.lang.Exception => None
        }

    /// # `truncatedTo` specialized

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: ZInstant): ZInstant = 
        import java.time.Instant.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.Instant & Pure;
        let ZInstant(x1) = x;
        ZInstant(truncatedTo(x1, u))
    
    pub def truncatedToNanos(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit & Pure as get_NANOS;
        truncatedToHelper(get_NANOS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToMicros(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit & Pure as get_MICROS;
        truncatedToHelper(get_MICROS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToMillis(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit & Pure as get_MILLIS;
        truncatedToHelper(get_MILLIS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToSeconds(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as get_SECONDS;
        truncatedToHelper(get_SECONDS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToMinutes(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as get_MINUTES;
        truncatedToHelper(get_MINUTES() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToHours(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
        truncatedToHelper(get_HOURS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToHalfDays(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as get_HALF_DAYS;
        truncatedToHelper(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit, x)


    pub def truncatedToDays(x: ZInstant): ZInstant = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as get_DAYS;
        truncatedToHelper(get_DAYS() as ##java.time.temporal.TemporalUnit, x)


    /// # `until` specialized

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import java.time.Instant.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getInstant(r.start);
        let e1 = getInstant(r.end) as ##java.time.temporal.Temporal;
        until(b1, e1, u)


    pub def nanosUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit & Pure as get_NANOS;
        untilHelper(get_NANOS() as ##java.time.temporal.TemporalUnit, r)

    pub def microsUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit & Pure as get_MICROS;
        untilHelper(get_MICROS() as ##java.time.temporal.TemporalUnit, r)

    pub def millisUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit & Pure as get_MILLIS;
        untilHelper(get_MILLIS() as ##java.time.temporal.TemporalUnit, r)

    pub def secondsUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as get_SECONDS;
        untilHelper(get_SECONDS() as ##java.time.temporal.TemporalUnit, r)

    pub def minutesUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as get_MINUTES;
        untilHelper(get_MINUTES() as ##java.time.temporal.TemporalUnit, r)

    pub def hoursUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
        untilHelper(get_HOURS() as ##java.time.temporal.TemporalUnit, r)

    pub def halfDaysUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as get_HALF_DAYS;
        untilHelper(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit, r)

    pub def daysUntil(r: {start :: ZInstant, end :: ZInstant}): Int64 = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as get_DAYS;
        untilHelper(get_DAYS() as ##java.time.temporal.TemporalUnit, r)


    /// # `withTemporalAdjuster` specialized

    /// Only Instant is supported which is just identity

    /// # `withTemporalField` specialized

    def withTemporalFieldHelper(field: ##java.time.temporal.TemporalField, i: Int64, x: ZInstant): ZInstant =
        import java.time.Instant.with(##java.time.temporal.TemporalField, Int64): ##java.time.Instant & Pure as withTF;                   
        try {
            let ZInstant(x1) = x;
            ZInstant(withTF(x1, field, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withNanoOfSecond(i: Int64, x: ZInstant): ZInstant =
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_NANO_OF_SECOND;
        withTemporalFieldHelper(get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField, i, x)

    pub def withMicroOfSecond(i: Int64, x: ZInstant): ZInstant =
        import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MICRO_OF_SECOND;
        withTemporalFieldHelper(get_MICRO_OF_SECOND() as ##java.time.temporal.TemporalField, i, x)

    pub def withMilliOfSecond(i: Int64, x: ZInstant): ZInstant =
        import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MILLI_OF_SECOND;
        withTemporalFieldHelper(get_MILLI_OF_SECOND() as ##java.time.temporal.TemporalField, i, x)

    pub def withInstantSeconds(i: Int64, x: ZInstant): ZInstant =
        import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField & Pure as get_INSTANT_SECONDS;
        withTemporalFieldHelper(get_INSTANT_SECONDS() as ##java.time.temporal.TemporalField, i, x)

}


