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



namespace Time {

    ///
    /// A wrapper around a Java instant.
    ///
    pub opaque type Instant = ##java.time.Instant
    
    ///
    /// Returns the given instant `x` as a String using ISO-8601 representation.
    ///
    instance ToString[Instant] {
        def toString(x: Instant): String =
            import java.time.Instant.toString();
            let Instant(x1) = x;
            toString(x1) as & Pure
    }

    ///
    /// Parse the string `s` as an Instant, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO UTC format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[Instant] {
        def fromString(s: String): Option[Instant] =
            import java.lang.String.strip();
            import java.time.Instant:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(Instant(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[Instant] {
        def eq(x: Instant, y: Instant): Bool =
            import java.time.Instant.equals(##java.lang.Object);
            let Instant(x1) = x;
            let Instant(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure
        
        def neq(x: Instant, y: Instant): Bool = not (x == y)
    }

    instance Hash[Instant] {
        def hash(x: Instant): Int = Time/Instant.hashCode(x)
    }

    instance Order[Instant] {
        def less(x: Instant, y: Instant): Bool = Time/Instant.compareTo(x,y) < 0
        def lessEqual(x: Instant, y: Instant): Bool = Time/Instant.compareTo(x,y) < 0 or x == y
        def greater(x: Instant, y: Instant): Bool = Time/Instant.compareTo(x,y) > 0
        def greaterEqual(x: Instant, y: Instant): Bool = Time/Instant.compareTo(x,y) > 0 or x == y
        def compare(x: Instant, y: Instant): Comparison = match Time/Instant.compareTo(x,y) { 
            case x if x < 0 => LessThan
            case x if x == 0 => EqualTo
            case _ => GreaterThan
        }
    }

    instance LowerBound[Instant] {
        def minValue(): Instant = Time/Instant.min()            
    }

    instance UpperBound[Instant] {
        def maxValue(): Instant = Time/Instant.max()
    }


}   

namespace Time/Instant {

    use Time.Instant;
    use Time.Instant.{Instant};
    use Time.OffsetDateTime;
    use Time.OffsetDateTime.{OffsetDateTime};
    use Time/Temporal.ChronoField;
    use Time/Temporal.ChronoUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(x: {epochSecond: Int64, nano: Int64}): Instant =
        import java.time.Instant:ofEpochSecond(Int64, Int64);
        Instant(ofEpochSecond(x.epochSecond, x.nano)) as & Pure

    pub def getFields(x: Instant): {epochSecond: Int64, nano: Int32} = 
        {epochSecond = x.getEpochSecond(), nano = x.getNano()}

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): Instant & Impure =
        import java.time.Instant:now();
        Instant(now())

    ///
    /// Returns the start of epoch instant - 1970-01-01T00:00:00Z
    ///
    pub def epoch(): Instant =
        import get java.time.Instant:EPOCH as getEPOCH;
        Instant(getEPOCH()) as & Pure

    pub def min(): Instant =
        import get java.time.Instant:MIN as getMIN;
        Instant(getMIN()) as & Pure
    

    pub def max(): Instant =
        import get java.time.Instant:MAX as getMAX;
        Instant(getMAX()) as & Pure
    
    pub def fromEpochSecond(epochSecond: Int64): Instant =
        import java.time.Instant:ofEpochSecond(Int64);
        Instant(ofEpochSecond(epochSecond)) as & Pure

    

    pub def fromEpochMilli(epochMilli: Int64): Instant =
        import java.time.Instant:ofEpochMilli(Int64);
        Instant(ofEpochMilli(epochMilli)) as & Pure

    pub def toEpochMilli(x: Instant): Int64 =
        import java.time.Instant.toEpochMilli();
        let Instant(x1) = x;
        toEpochMilli(x1) as & Pure


    pub def hashCode(x: Instant): Int32 = 
        import java.time.Instant.hashCode();
        let Instant(x1) = x;
        hashCode(x1) as & Pure

    

    pub def atOffset(x: Instant, offset: ZoneOffset): OffsetDateTime =
        import java.time.Instant.atOffset(##java.time.ZoneOffset);
        let Instant(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(x1.atOffset(o1)) as & Pure

    pub def atZone(x: Instant, zone: ZoneId): ZonedDateTime =
        import java.time.Instant.atZone(##java.time.ZoneId);
        let Instant(x1) = x;
        let ZoneId(z1) = zone;
        ZonedDateTime(x1.atZone(z1)) as & Pure


    pub def getEpochSecond(x: Instant): Int64 =
        import java.time.Instant.getEpochSecond();
        let Instant(x1) = x;
        x1.getEpochSecond() as & Pure

    pub def getNano(x: Instant): Int32 =
        import java.time.Instant.getNano();
        let Instant(x1) = x;
        x1.getNano() as & Pure


    pub def compareTo(x: Instant, y: Instant): Int32 =
        import java.time.Instant.compareTo(##java.time.Instant);
        let Instant(x1) = x;
        let Instant(y1) = y;
        x1.compareTo(y1) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: Instant, y: Instant): Bool =
        import java.time.Instant.isBefore(##java.time.Instant);
        let Instant(t1) = x;
        let Instant(t2) = y;
        t1.isBefore(t2) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: Instant, y: Instant): Bool =
        import java.time.Instant.isAfter(##java.time.Instant);
        let Instant(t1) = x;
        let Instant(t2) = y;
        t1.isAfter(t2) as & Pure

    pub def plusSeconds(x: Instant, seconds: Int64): Instant =
        import java.time.Instant.plusSeconds(Int64);
        let Instant(x1) = x;
        Instant(x1.plusSeconds(seconds)) as & Pure

    pub def minusSeconds(x: Instant, seconds: Int64): Instant =
        import java.time.Instant.minusSeconds(Int64);
        let Instant(x1) = x;
        Instant(x1.minusSeconds(seconds)) as & Pure

    pub def plusMillis(x: Instant, millis: Int64): Instant =
        import java.time.Instant.plusMillis(Int64);
        let Instant(x1) = x;
        Instant(x1.plusMillis(millis)) as & Pure

    pub def minusMillis(x: Instant, millis: Int64): Instant =
        import java.time.Instant.minusMillis(Int64);
        let Instant(x1) = x;
        Instant(x1.minusMillis(millis)) as & Pure

    pub def plusNanos(x: Instant, nanos: Int64): Instant =
        import java.time.Instant.plusNanos(Int64);
        let Instant(x1) = x;
        Instant(x1.plusNanos(nanos)) as & Pure

    ///
    /// Returns the given instant `x` plus `d` number of nano seconds.
    ///
    pub def plus(x: Instant, d: Int64): Instant =
        import java.time.Instant.plusNanos(Int64);
        let Instant(t) = x;
        Instant(t.plusNanos(d)) as & Pure

    ///
    /// Returns the given instant `x` minus `d` number of nano seconds.
    ///
    pub def minus(x: Instant, d: Int64): Instant =
        import java.time.Instant.minusNanos(Int64);
        let Instant(t) = x;
        Instant(t.minusNanos(d)) as & Pure


    pub def until(b: Instant, e: Instant, cu: ChronoUnit): Int64 = 
        import java.time.Instant.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit);
        let Instant(b1) = b;
        let Instant(e1) = e;
        let cu1 = Time/Temporal/ChronoUnit.marshal(cu);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = cu1 as ##java.time.temporal.TemporalUnit;
        until(b1, te1, tu1) as & Pure

    pub def range(x: Instant, field: ChronoField): ValueRange = 
        import java.time.Instant.range(##java.time.temporal.TemporalField);
        let Instant(x1) = x;
        let field1 = Time/Temporal/ChronoField.marshal(field);
        let tfield1 = field1 as ##java.time.temporal.TemporalField;
        ValueRange(range(x1, tfield1)) as & Pure


    def truncatedTo(x: Instant, unit: ChronoUnit): Option[Instant] = 
        import java.time.Instant.truncatedTo(##java.time.temporal.TemporalUnit);
        try {
            let Instant(x1) = x;
            let unit1 = Time/Temporal/ChronoUnit.marshal(unit);
            let tunit1 = unit1 as ##java.time.temporal.TemporalUnit;
            Some(Instant(truncatedTo(x1, tunit1))) as & Pure
        } catch {
            case _: ##java.lang.Exception => None
        }
    
    pub def truncatedToNanos(x: Instant): Instant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Nanos) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }
    
    pub def truncatedToMillis(x: Instant): Instant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Millis) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToSeconds(x: Instant): Instant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Seconds) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToMinutes(x: Instant): Instant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Minutes) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToHours(x: Instant): Instant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Hours) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

    pub def truncatedToHalfDays(x: Instant): Instant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.HalfDays) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }


    pub def truncatedToDays(x: Instant): Instant = 
        match truncatedTo(x, Time/Temporal/ChronoUnit.Days) { 
            case Some(x1) => x1
            case None => x          /// Should be impossible!
        }

}
