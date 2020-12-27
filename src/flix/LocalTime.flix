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
        def toString(x: LocalTime): String =
            import java.time.LocalTime.toString();
            let LocalTime(t) = x;
            t.toString() as & Pure
    }

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[LocalTime] {
        def fromString(s: String): Option[LocalTime] =
            import java.lang.String.strip();
            import java.time.LocalTime:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(LocalTime(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance LowerBound[LocalTime] {
        def minValue(): LocalTime =
            import get java.time.LocalTime:MIN as getMIN;
            LocalTime(getMIN()) as & Pure
    }
    
    instance UpperBound[LocalTime] {
        def maxValue(): LocalTime =
            import get java.time.LocalTime:MAX as getMAX;
            LocalTime(getMAX()) as & Pure
    }

}

namespace Time/LocalTime {

    use System.Error.{Generic};

    use Time.Instant;
    use Time.Instant.{Instant};
    use Time/Format.TimeFormatter;
    use Time/Format.TimeFormatter.{TimeFormatter};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def new(x: {hour: Int32, minute: Int32}): LocalTime =
        import java.time.LocalTime:of(Int32, Int32);
        LocalTime(of(x.hour, x.minute)) as & Pure

    pub def newWithSecond(x: {hour: Int32, minute: Int32, second: Int32}): LocalTime =
        import java.time.LocalTime:of(Int32, Int32, Int32);
        LocalTime(of(x.hour, x.minute, x.second)) as & Pure

    pub def newWithSecondAndNano(x: {hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32}): LocalTime =
        import java.time.LocalTime:of(Int32, Int32, Int32, Int32);
        LocalTime(of(x.hour, x.minute, x.second, x.nanoSecond)) as & Pure

    pub def getFields(x: LocalTime): {hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32} =
        {hour = x.getHour(), minute = x.getMinute(), second = x.getSecond(), nanoSecond= x.getNano()}

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalTime & Impure =
        import java.time.LocalTime:now();
        LocalTime(now())


    ///
    /// ___
    ///
    pub def midnight(): LocalTime =
        import get java.time.LocalTime:MIDNIGHT as getMIDNIGHT;
        LocalTime(getMIDNIGHT()) as & Pure

    ///
    /// ___
    ///
    pub def noon(): LocalTime =
        import get java.time.LocalTime:NOON as getNOON;
        LocalTime(getNOON()) as & Pure


    pub def fromHoursMinutes(hours: Int32, minutes: Int32): LocalTime =
        import java.time.LocalTime:of(Int32, Int32);
        LocalTime(of(hours, minutes)) as & Pure

    pub def fromHoursMinutesSeconds(hours: Int32, minutes: Int32, seconds: Int32): LocalTime =
        import java.time.LocalTime:of(Int32, Int32, Int32);
        LocalTime(of(hours, minutes, seconds)) as & Pure

    pub def fromHoursMinutesSecondsNanos(hours: Int32, minutes: Int32, seconds: Int32, nanos: Int32): LocalTime =
        import java.time.LocalTime:of(Int32, Int32, Int32, Int32);
        LocalTime(of(hours, minutes, seconds, nanos)) as & Pure

    pub def fromInstant(x: Instant, zone: ZoneId): LocalTime =
        import java.time.LocalTime:ofInstant(##java.time.Instant, ##java.time.ZoneId);
        let Instant(x1) = x;
        let ZoneId(z1) = zone;
        LocalTime(ofInstant(x1, z1)) as & Pure

    pub def fromSecondOfDay(secondOfDay: Int64): LocalTime =
        import java.time.LocalTime:ofSecondOfDay(Int64);
        LocalTime(ofSecondOfDay(secondOfDay)) as & Pure

    pub def toSecondOfDay(time: LocalTime): Int32 =
        import java.time.LocalTime.toSecondOfDay();
        let LocalTime(x1) = time;
        x1.toSecondOfDay() as & Pure

    pub def fromNanoOfDay(nanoOfDay: Int64): LocalTime =
        import java.time.LocalTime:ofNanoOfDay(Int64);
        LocalTime(ofNanoOfDay(nanoOfDay)) as & Pure

    pub def toNanoOfDay(time: LocalTime): Int64 =
        import java.time.LocalTime.toNanoOfDay();
        let LocalTime(x1) = time;
        x1.toNanoOfDay() as & Pure


    ///
    /// Returns the given LocalTime `x` as a String using `formatter`.
    ///
    pub def format(x: LocalTime, formatter: TimeFormatter): String =
        import java.time.LocalTime.format(##java.time.format.DateTimeFormatter);
        let LocalTime(x1) = x;
        let TimeFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    
    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(s: String, formatter: TimeFormatter): Option[LocalTime] =
        import java.lang.String.strip();
        import java.time.LocalTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let TimeFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(LocalTime(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def __eq(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.equals(##java.lang.Object);
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    ///
    /// Returns
    ///
    pub def compare(x: LocalTime, y: LocalTime): Int32 =
        import java.time.LocalTime.compareTo(##java.time.LocalTime);
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        x1.compareTo(y1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isBefore(##java.time.LocalTime);
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        x1.isBefore(y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isAfter(##java.time.LocalTime);
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        x1.isAfter(y1) as & Pure

    pub def plusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.plusHours(Int64) as plus;
        let LocalTime(x1) = x;
        LocalTime(x1.plus(hours)) as & Pure

    pub def minusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.minusHours(Int64) as minus;
        let LocalTime(x1) = x;
        LocalTime(x1.minus(hours)) as & Pure

    pub def plusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.plusMinutes(Int64) as plus;
        let LocalTime(x1) = x;
        LocalTime(x1.plus(minutes)) as & Pure

    pub def minusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.minusMinutes(Int64) as minus;
        let LocalTime(x1) = x;
        LocalTime(x1.minus(minutes)) as & Pure

    pub def plusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.plusSeconds(Int64) as plus;
        let LocalTime(x1) = x;
        LocalTime(x1.plus(seconds)) as & Pure

    pub def minusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.minusSeconds(Int64) as minus;
        let LocalTime(x1) = x;
        LocalTime(x1.minus(seconds)) as & Pure

    pub def plusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.plusNanos(Int64) as plus;
        let LocalTime(x1) = x;
        LocalTime(x1.plus(nanos)) as & Pure

    pub def minusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.minusNanos(Int64) as minus;
        let LocalTime(x1) = x;
        LocalTime(x1.minus(nanos)) as & Pure

    pub def getHour(x: LocalTime): Int32 =
        import java.time.LocalTime.getHour();
        let LocalTime(x1) = x;
        x1.getHour() as & Pure

    pub def putHour(x: LocalTime, hour: Int32): LocalTime =
        import java.time.LocalTime.withHour(Int32);
        let LocalTime(x1) = x;
        LocalTime(x1.withHour(hour)) as & Pure

    pub def getMinute(x: LocalTime): Int32 =
        import java.time.LocalTime.getMinute();
        let LocalTime(x1) = x;
        x1.getMinute() as & Pure

    pub def putMinute(x: LocalTime, minute: Int32): LocalTime =
        import java.time.LocalTime.withMinute(Int32);
        let LocalTime(x1) = x;
        LocalTime(x1.withMinute(minute)) as & Pure

    pub def getSecond(x: LocalTime): Int32 =
        import java.time.LocalTime.getSecond();
        let LocalTime(x1) = x;
        x1.getSecond() as & Pure

    pub def putSecond(x: LocalTime, second: Int32): LocalTime =
        import java.time.LocalTime.withSecond(Int32);
        let LocalTime(x1) = x;
        LocalTime(x1.withSecond(second)) as & Pure

    pub def getNano(x: LocalTime): Int32 =
        import java.time.LocalTime.getNano();
        let LocalTime(x1) = x;
        x1.getNano() as & Pure

    pub def putNano(x: LocalTime, nano: Int32): LocalTime =
        import java.time.LocalTime.withNano(Int32);
        let LocalTime(x1) = x;
        LocalTime(x1.withNano(nano)) as & Pure

}
