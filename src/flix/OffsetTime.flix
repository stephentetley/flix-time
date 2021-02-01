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
    /// A wrapper around a Java OffsetTime.
    ///
    pub opaque type OffsetTime = ##java.time.OffsetTime


    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[OffsetTime] {
        def toString(x: OffsetTime): String =
            import java.time.OffsetTime.toString();
            let OffsetTime(x1) = x;
            x1.toString() as & Pure
    }

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetTime] {
        def fromString(s: String): Option[OffsetTime] =
            import java.lang.String.strip();
            import java.time.OffsetTime:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(OffsetTime(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[OffsetTime] {
        def eq(x: OffsetTime, y: OffsetTime): Bool =
            import java.time.OffsetTime.equals(##java.lang.Object);
            let OffsetTime(x1) = x;
            let OffsetTime(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure

        def neq(x: OffsetTime, y: OffsetTime): Bool = not (x == y)
    }

    instance Hash[OffsetTime] {
        def hash(x: OffsetTime): Int = Time/OffsetTime.hashCode(x)
    }

    instance Order[OffsetTime] {
        def less(x: OffsetTime, y: OffsetTime): Bool = Time/OffsetTime.compareTo(x,y) < 0
        def lessEqual(x: OffsetTime, y: OffsetTime): Bool = Time/OffsetTime.compareTo(x,y) < 0 or x == y
        def greater(x: OffsetTime, y: OffsetTime): Bool = Time/OffsetTime.compareTo(x,y) > 0
        def greaterEqual(x: OffsetTime, y: OffsetTime): Bool = Time/OffsetTime.compareTo(x,y) > 0 or x == y
        def compare(x: OffsetTime, y: OffsetTime): Comparison = match Time/OffsetTime.compareTo(x,y) { 
            case x if x < 0 => LessThan
            case x if x == 0 => EqualTo
            case _ => GreaterThan
        }
    }

    instance LowerBound[OffsetTime] {
        def minValue(): OffsetTime =
            import get java.time.OffsetTime:MIN as getMIN;
            OffsetTime(getMIN()) as & Pure
    }

    instance UpperBound[OffsetTime] {
        def maxValue(): OffsetTime =
            import get java.time.OffsetTime:MAX as getMAX;
            OffsetTime(getMAX()) as & Pure
    }

}

namespace Time/OffsetTime {

    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time/Format.TimeFormatter;
    use Time/Format.TimeFormatter.{TimeFormatter};
    use Time.Instant;
    use Time.Instant.{Instant};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time/Temporal.ChronoUnit;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(x: { hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32, offset: ZoneOffset}): OffsetTime =
        import java.time.OffsetTime:of(Int32, Int32, Int32, Int32, ##java.time.ZoneOffset);
        let ZoneOffset(o1) = x.offset;
        OffsetTime(of(x.hour, x.minute, x.second, x.nanoSecond, o1)) as & Pure

    pub def getFields(x: OffsetTime): { hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32, offset: ZoneOffset} =
        { hour = x.getHour(), minute = x.getMinute(), second = x.getSecond()
        , nanoSecond = x.getNano(), offset = x.getOffset() }
        

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): OffsetTime & Impure =
        import java.time.OffsetTime:now();
        OffsetTime(now())

    ///
    /// Returns the current time from the system clock.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetTime & Impure =
        import java.time.OffsetTime:now(##java.time.ZoneId);
        let ZoneId(z) = zone;
        OffsetTime(now(z))


    pub def fromLocalTime(x: LocalTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime:of(##java.time.LocalTime, ##java.time.ZoneOffset);
        let LocalTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(of(x1, o1)) as & Pure


    pub def fromInstant(x: Instant, zone: ZoneId): OffsetTime =
        import java.time.OffsetTime:ofInstant(##java.time.Instant, ##java.time.ZoneId);
        let Instant(x1) = x;
        let ZoneId(z1) = zone;
        OffsetTime(ofInstant(x1, z1)) as & Pure



    ///
    /// Returns OffsetTime `x` as a String using `formatter`.
    ///
    pub def format(x: OffsetTime, formatter: TimeFormatter): String =
        import java.time.OffsetTime.format(##java.time.format.DateTimeFormatter);
        let OffsetTime(x1) = x;
        let TimeFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(s: String, formatter: TimeFormatter): Option[OffsetTime] =
        import java.lang.String.strip();
        import java.time.OffsetTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let TimeFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(OffsetTime(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }


    pub def hashCode(x: OffsetTime): Int32 = 
        import java.time.OffsetTime.hashCode();
        let OffsetTime(x1) = x;
        hashCode(x1) as & Pure

    ///
    /// Returns .
    ///
    pub def compareTo(x: OffsetTime, y: OffsetTime): Int32 =
        import java.time.OffsetTime.compareTo(##java.time.OffsetTime);
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        x1.compareTo(y1) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isBefore(##java.time.OffsetTime);
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        x1.isBefore(y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isAfter(##java.time.OffsetTime);
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        x1.isAfter(y1) as & Pure

    pub def plusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.plusHours(Int64) as plus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.plus(hours)) as & Pure

    pub def minusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.minusHours(Int64) as minus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.minus(hours)) as & Pure

    pub def plusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.plusMinutes(Int64) as plus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.plus(minutes)) as & Pure

    pub def minusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.minusMinutes(Int64) as minus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.minus(minutes)) as & Pure

    pub def plusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.plusSeconds(Int64) as plus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.plus(seconds)) as & Pure

    pub def minusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.minusSeconds(Int64) as minus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.minus(seconds)) as & Pure

    pub def plusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.plusNanos(Int64) as plus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.plus(nanos)) as & Pure

    pub def minusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.minusNanos(Int64) as minus;
        let OffsetTime(x1) = x;
        OffsetTime(x1.minus(nanos)) as & Pure

    pub def getHour(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getHour();
        let OffsetTime(x1) = x;
        x1.getHour() as & Pure

    pub def putHour(x: OffsetTime, hour: Int32): OffsetTime =
        import java.time.OffsetTime.withHour(Int32);
        let OffsetTime(x1) = x;
        OffsetTime(x1.withHour(hour)) as & Pure

    pub def getMinute(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getMinute();
        let OffsetTime(x1) = x;
        x1.getMinute() as & Pure

    pub def putMinute(x: OffsetTime, minute: Int32): OffsetTime =
        import java.time.OffsetTime.withMinute(Int32);
        let OffsetTime(x1) = x;
        OffsetTime(x1.withMinute(minute)) as & Pure

    pub def getSecond(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getSecond();
        let OffsetTime(x1) = x;
        x1.getSecond() as & Pure

    pub def putSecond(x: OffsetTime, second: Int32): OffsetTime =
        import java.time.OffsetTime.withSecond(Int32);
        let OffsetTime(x1) = x;
        OffsetTime(x1.withSecond(second)) as & Pure

    pub def getNano(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getNano();
        let OffsetTime(x1) = x;
        x1.getNano() as & Pure

    pub def putNano(x: OffsetTime, nano: Int32): OffsetTime =
        import java.time.OffsetTime.withNano(Int32);
        let OffsetTime(x1) = x;
        OffsetTime(x1.withNano(nano)) as & Pure

    pub def getOffset(x: OffsetTime): ZoneOffset =
        import java.time.OffsetTime.getOffset();
        let OffsetTime(x1) = x;
        ZoneOffset(x1.getOffset()) as & Pure

    pub def putOffsetSameInstant(x: OffsetTime, offset: ZoneOffset): OffsetTime = 
        import java.time.OffsetTime.withOffsetSameInstant(##java.time.ZoneOffset);
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameInstant(x1, o1)) as & Pure
    
    pub def putOffsetSameLocal(x: OffsetTime, offset: ZoneOffset): OffsetTime = 
        import java.time.OffsetTime.withOffsetSameLocal(##java.time.ZoneOffset);
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameLocal(x1, o1)) as & Pure

    pub def until(b: OffsetTime, e: OffsetTime, unit: ChronoUnit): Int64 = 
        import java.time.OffsetTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit);
        let OffsetTime(b1) = b;
        let OffsetTime(e1) = e;
        let u1 = Time/Temporal/ChronoUnit.marshal(unit);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        b1.until(te1, tu1) as & Pure

}
