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

}   

namespace Time/ZInstant {

    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};
    use Time/Temporal.ChronoField;
    use Time/Temporal.ChronoUnit;
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

    pub def of(r: {epochSecond :: Int64, nano :: Int64}): ZInstant =
        import static java.time.Instant.ofEpochSecond(Int64, Int64): ##java.time.Instant & Pure;
        ZInstant(ofEpochSecond(r.epochSecond, r.nano))

    pub def getFields(x: ZInstant): {epochSecond :: Int64, nano :: Int32} =
        {epochSecond = getEpochSecond(x), nano = getNano(x)}

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
    
    pub def ofEpochSecond(epochSecond: Int64): ZInstant =
        import static java.time.Instant.ofEpochSecond(Int64): ##java.time.Instant & Pure;
        ZInstant(ofEpochSecond(epochSecond))

    

    pub def ofEpochMilli(epochMilli: Int64): ZInstant =
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


    pub def plusDuration(x: ZInstant, d: ZDuration): ZInstant =
        import java.time.Instant.plus(##java.time.temporal.TemporalAmount): ##java.time.Instant & Pure;
        let ZInstant(x1) = x;
        let ZDuration(d1) = d;
        ZInstant(plus(x1, d1 as ##java.time.temporal.TemporalAmount))

    /// Period.ofMonths and Period.ofYears fail (None)
    pub def plusPeriod(x: ZInstant, p: Period): Option[ZInstant] =
        import java.time.Instant.plus(##java.time.temporal.TemporalAmount): ##java.time.Instant & Pure;
        try { 
            let ZInstant(x1) = x;
            let Period(p1) = p;
            Some(ZInstant(plus(x1, p1 as ##java.time.temporal.TemporalAmount)))
        } catch {
            case _: ##java.lang.Exception => None
        }


    pub def until(b: ZInstant, e: ZInstant, cu: ChronoUnit): Int64 = 
        import java.time.Instant.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let ZInstant(b1) = b;
        let ZInstant(e1) = e;
        let cu1 = Time/Temporal/ChronoUnit.marshal(cu);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = cu1 as ##java.time.temporal.TemporalUnit;
        until(b1, te1, tu1)

    /// pub def range(x: ZInstant, field: ChronoField): ValueRange = 
    ///     import java.time.Instant.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;
    ///     let ZInstant(x1) = x;
    ///     let field1 = Time/Temporal/ChronoField.marshal(field);
    ///     let tfield1 = field1 as ##java.time.temporal.TemporalField;
    ///     ValueRange(range(x1, tfield1))


    def truncatedTo(x: ZInstant, unit: ChronoUnit): Option[ZInstant] = 
        import java.time.Instant.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.Instant & Pure;
        try {
            let ZInstant(x1) = x;
            let unit1 = Time/Temporal/ChronoUnit.marshal(unit);
            let tunit1 = unit1 as ##java.time.temporal.TemporalUnit;
            Some(ZInstant(truncatedTo(x1, tunit1)))
        } catch {
            case _: ##java.lang.Exception => None
        }
    
    pub def truncatedToNanos(x: ZInstant): ZInstant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Nanos) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }
    
    pub def truncatedToMillis(x: ZInstant): ZInstant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Millis) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToSeconds(x: ZInstant): ZInstant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Seconds) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToMinutes(x: ZInstant): ZInstant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Minutes) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToHours(x: ZInstant): ZInstant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Hours) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToHalfDays(x: ZInstant): ZInstant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.HalfDays) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }


    pub def truncatedToDays(x: ZInstant): ZInstant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Days) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

}


