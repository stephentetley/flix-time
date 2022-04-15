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
    /// A wrapper around a Java LocalTime.
    ///
    pub opaque type LocalTime = ##java.time.LocalTime

    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[LocalTime] {
        pub def toString(x: LocalTime): String =
            import java.time.LocalTime.toString(): String & Pure;
            let LocalTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[LocalTime] {
        pub def fromString(s: String): Option[LocalTime] =
            import java.lang.String.strip(): String & Pure;
            import static java.time.LocalTime.parse(##java.lang.CharSequence): ##java.time.LocalTime & Pure;
            try {
                let cs = strip(s) as ##java.lang.CharSequence;
                Some(LocalTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }


    instance Eq[LocalTime] {
        pub def eq(x: LocalTime, y: LocalTime): Bool = Time/LocalTime.equals(x, y)
    }
    
    instance Hash[LocalTime] {
        pub def hash(x: LocalTime): Int32 = Time/LocalTime.hashCode(x)
    }

    instance Order[LocalTime] {
        pub def compare(x: LocalTime, y: LocalTime): Comparison = 
            Time/LocalTime.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[LocalTime] {
        pub def minValue(): LocalTime =
            import static get java.time.LocalTime.MIN: ##java.time.LocalTime & Pure as getMIN;
            LocalTime(getMIN())
    }
    
    instance UpperBound[LocalTime] {
        pub def maxValue(): LocalTime =
            import static get java.time.LocalTime.MAX: ##java.time.LocalTime & Pure as getMAX;
            LocalTime(getMAX())
    }

    instance Boxable[LocalTime]

}

namespace Time/LocalTime {

    use Time.Instant;
    use Time.Instant.{Instant};
    use Time/Format.TimeFormatter;
    use Time/Format.TimeFormatter.{TimeFormatter};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def getLocalTime(x: LocalTime): ##java.time.LocalTime = 
        let LocalTime(x1) = x;
        x1

    pub def of(r: {hour :: Int32, minute :: Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(r.hour, r.minute))

    pub def ofWithSecond(r: {hour :: Int32, minute :: Int32, second :: Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(r.hour, r.minute, r.second))

    pub def ofWithSecondAndNano(r: {hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(r.hour, r.minute, r.second, r.nanoSecond))

    pub def getFields(x: LocalTime): {hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32} =
        {hour = getHour(x), minute = getMinute(x), second = getSecond(x), nanoSecond= getNano(x)}

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalTime & Impure =
        import static java.time.LocalTime.now(): ##java.time.LocalTime & Impure;
        LocalTime(now())


    ///
    /// ___
    ///
    pub def midnight(): LocalTime =
        import static get java.time.LocalTime.MIDNIGHT: ##java.time.LocalTime & Pure as getMIDNIGHT;
        LocalTime(getMIDNIGHT())

    ///
    /// ___
    ///
    pub def noon(): LocalTime =
        import static get java.time.LocalTime.NOON: ##java.time.LocalTime & Pure as getNOON;
        LocalTime(getNOON())


    pub def ofHoursMinutes(hours: Int32, minutes: Int32): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(hours, minutes))

    pub def ofHoursMinutesSeconds(hours: Int32, minutes: Int32, seconds: Int32): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(hours, minutes, seconds))

    pub def ofHoursMinutesSecondsNanos(hours: Int32, minutes: Int32, seconds: Int32, nanos: Int32): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(hours, minutes, seconds, nanos))

    pub def ofInstant(x: Instant, zone: ZoneId): LocalTime =
        import static java.time.LocalTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalTime & Pure;
        let Instant(x1) = x;
        let ZoneId(z1) = zone;
        LocalTime(ofInstant(x1, z1))

    pub def ofSecondOfDay(secondOfDay: Int64): LocalTime =
        import static java.time.LocalTime.ofSecondOfDay(Int64): ##java.time.LocalTime & Pure;
        LocalTime(ofSecondOfDay(secondOfDay))

    pub def toSecondOfDay(time: LocalTime): Int32 =
        import java.time.LocalTime.toSecondOfDay(): Int32 & Pure;
        let LocalTime(x1) = time;
        toSecondOfDay(x1)

    pub def ofNanoOfDay(nanoOfDay: Int64): LocalTime =
        import static java.time.LocalTime.ofNanoOfDay(Int64): ##java.time.LocalTime & Pure;
        LocalTime(ofNanoOfDay(nanoOfDay))

    pub def toNanoOfDay(time: LocalTime): Int64 =
        import java.time.LocalTime.toNanoOfDay(): Int64 & Pure;
        let LocalTime(x1) = time;
        toNanoOfDay(x1)


    ///
    /// Returns the given LocalTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: TimeFormatter, x: LocalTime): String =
        import java.time.LocalTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let LocalTime(x1) = x;
        let TimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    
    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: TimeFormatter, s: String): Option[LocalTime] =
        import java.lang.String.strip(): String & Pure;
        import static java.time.LocalTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalTime & Pure;
        try {
            let TimeFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence;
            Some(LocalTime(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.equals(##java.lang.Object): Bool & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: LocalTime): Int32 = 
        import java.time.LocalTime.hashCode(): Int32 & Pure;
        let LocalTime(x1) = x;
        hashCode(x1)

    ///
    /// Returns
    ///
    pub def compareTo(x: LocalTime, y: LocalTime): Int32 =
        import java.time.LocalTime.compareTo(##java.time.LocalTime): Int32 & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        compareTo(x1, y1)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isBefore(##java.time.LocalTime): Bool & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isAfter(##java.time.LocalTime): Bool & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        isAfter(x1, y1)

    pub def plusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.plusHours(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusHours(x1, hours))

    pub def minusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.minusHours(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusHours(x1, hours))

    pub def plusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.plusMinutes(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.minusMinutes(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.plusSeconds(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.minusSeconds(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.plusNanos(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusNanos(x1, nanos))

    pub def minusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.minusNanos(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusNanos(x1, nanos))

    pub def getHour(x: LocalTime): Int32 =
        import java.time.LocalTime.getHour(): Int32 & Pure;
        let LocalTime(x1) = x;
        getHour(x1)

    pub def withHour(x: LocalTime, hour: Int32): LocalTime =
        import java.time.LocalTime.withHour(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withHour(x1, hour))

    pub def getMinute(x: LocalTime): Int32 =
        import java.time.LocalTime.getMinute(): Int32 & Pure;
        let LocalTime(x1) = x;
        getMinute(x1)

    pub def withMinute(x: LocalTime, minute: Int32): LocalTime =
        import java.time.LocalTime.withMinute(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withMinute(x1, minute))

    pub def getSecond(x: LocalTime): Int32 =
        import java.time.LocalTime.getSecond(): Int32 & Pure;
        let LocalTime(x1) = x;
        getSecond(x1)

    pub def withSecond(x: LocalTime, second: Int32): LocalTime =
        import java.time.LocalTime.withSecond(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withSecond(x1, second))

    pub def getNano(x: LocalTime): Int32 =
        import java.time.LocalTime.getNano(): Int32 & Pure;
        let LocalTime(x1) = x;
        getNano(x1)

    pub def withNano(x: LocalTime, nano: Int32): LocalTime =
        import java.time.LocalTime.withNano(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withNano(x1, nano))

}
