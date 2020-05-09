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

use Time.OffsetTime;
use Time.OffsetTime.{OffsetTime};
use Time.Error.{DateTimeParseException};
use Time/Format.TimeFormatter;
use Time/Format.TimeFormatter.{TimeFormatter};
use Time.Instant;
use Time.Instant.{Instant};
use Time.ZoneId;
use Time.ZoneId.{ZoneId};
use Time.ZoneOffset;
use Time.ZoneOffset.{ZoneOffset};

namespace Time {

    ///
    /// A wrapper around a Java OffsetTime.
    ///
    pub opaque type OffsetTime = ##java.time.OffsetTime

}

namespace Time/OffsetTime {

    pub def new(hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime:of(Int32, Int32, Int32, Int32, ##java.time.ZoneOffset);
        let ZoneOffset(o1) = offset;
        OffsetTime(of(hour, minute, second, nanoSecond, o1)) as & Pure

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

    ///
    /// ___
    ///
    pub def minValue(): OffsetTime =
        import get java.time.OffsetTime:MIN as get_min;
        OffsetTime(get_min()) as & Pure

    ///
    /// ___
    ///
    pub def maxValue(): OffsetTime =
        import get java.time.OffsetTime:MAX as get_max;
        OffsetTime(get_max()) as & Pure

    pub def fromInstant(x: Instant, zone: ZoneId): OffsetTime =
        import java.time.OffsetTime:ofInstant(##java.time.Instant, ##java.time.ZoneId);
        let Instant(x1) = x;
        let ZoneId(z1) = zone;
        OffsetTime(ofInstant(x1, z1)) as & Pure

    ///
    /// Returns the given time `x` as a string using __.
    ///
    pub def toString(x: OffsetTime): String =
        import java.time.OffsetTime.toString();
        let OffsetTime(t) = x;
        t.toString() as & Pure

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
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[OffsetTime, Time.Error] =
        import java.lang.String.strip();
        import java.time.OffsetTime:parse(##java.lang.CharSequence);
        try {
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Ok(OffsetTime(parse(cs))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => Err(DateTimeParseException)
        }

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromStringWithFormat(s: String, formatter: TimeFormatter): Result[OffsetTime, Time.Error] =
        import java.lang.String.strip();
        import java.time.OffsetTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
        let TimeFormatter(fmtr) = formatter;
        let cs = s.strip() as ##java.lang.CharSequence & Pure;
        Ok(OffsetTime(cs.parse(fmtr))) as & Pure
    } catch {
        case _: ##java.time.format.DateTimeParseException => Err(DateTimeParseException)
    }

    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def equals(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.equals(##java.lang.Object);
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def before(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isBefore(##java.time.OffsetTime);
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        x1.isBefore(y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def after(x: OffsetTime, y: OffsetTime): Bool =
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

}
