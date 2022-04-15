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
            import java.lang.String.strip(): String & Pure;
            import static java.time.OffsetTime.parse(##java.lang.CharSequence): ##java.time.OffsetTime & Pure;
            try {
                let cs = strip(s) as ##java.lang.CharSequence;
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

    pub def getOffsetTime(x: OffsetTime): ##java.time.OffsetTime = 
        let OffsetTime(x1) = x;
        x1

    pub def of(r: { hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32, offset :: ZoneOffset}): OffsetTime =
        import static java.time.OffsetTime.of(Int32, Int32, Int32, Int32, ##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        OffsetTime(of(r.hour, r.minute, r.second, r.nanoSecond, Time/ZoneOffset.getZoneOffset(r.offset)))

    pub def getFields(x: OffsetTime): { hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32, offset :: ZoneOffset} =
        { hour = getHour(x), minute = getMinute(x), second = getSecond(x), nanoSecond = getNano(x), offset = getOffset(x) }


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


    pub def ofLocalTime(x: LocalTime, offset: ZoneOffset): OffsetTime =
        import static java.time.OffsetTime.of(##java.time.LocalTime, ##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let LocalTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(of(x1, o1))


    pub def ofInstant(x: Instant, zone: ZoneId): OffsetTime =
        import static java.time.OffsetTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.OffsetTime & Pure;
        let Instant(x1) = x;
        let ZoneId(z1) = zone;
        OffsetTime(ofInstant(x1, z1))



    ///
    /// Returns OffsetTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: TimeFormatter, x: OffsetTime): String =
        import java.time.OffsetTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let OffsetTime(x1) = x;
        let TimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: TimeFormatter, s: String): Option[OffsetTime] =
        import java.lang.String.strip(): String & Pure;
        import static java.time.OffsetTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.OffsetTime & Pure;
        try {
            let TimeFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence;
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

    pub def getHour(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getHour(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getHour(x1)

    pub def withHour(x: OffsetTime, hour: Int32): OffsetTime =
        import java.time.OffsetTime.withHour(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withHour(x1, hour))

    pub def getMinute(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getMinute(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getMinute(x1)

    pub def withMinute(x: OffsetTime, minute: Int32): OffsetTime =
        import java.time.OffsetTime.withMinute(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withMinute(x1, minute))

    pub def getSecond(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getSecond(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getSecond(x1)

    pub def withSecond(x: OffsetTime, second: Int32): OffsetTime =
        import java.time.OffsetTime.withSecond(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withSecond(x1, second))

    pub def getNano(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getNano(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getNano(x1)

    pub def withNano(x: OffsetTime, nano: Int32): OffsetTime =
        import java.time.OffsetTime.withNano(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withNano(x1, nano))

    pub def getOffset(x: OffsetTime): ZoneOffset =
        import java.time.OffsetTime.getOffset(): ##java.time.ZoneOffset & Pure;
        let OffsetTime(x1) = x;
        ZoneOffset(getOffset(x1))

    pub def withOffsetSameInstant(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameInstant(##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameInstant(x1, o1))

    pub def withOffsetSameLocal(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameLocal(##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameLocal(x1, o1))

    pub def until(b: OffsetTime, e: OffsetTime, unit: ChronoUnit): Int64 =
        import java.time.OffsetTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let OffsetTime(b1) = b;
        let OffsetTime(e1) = e;
        let u1 = Time/Temporal/ChronoUnit.marshal(unit);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        until(b1, te1, tu1)

}
