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

use System.Error.{Generic};

use Time.Instant;
use Time.Instant.{Instant};
use Time.OffsetDateTime;
use Time.OffsetDateTime.{OffsetDateTime};
use Time/Temporal.ChronoUnit;
use Time.ZonedDateTime;
use Time.ZonedDateTime.{ZonedDateTime};
use Time.ZoneId;
use Time.ZoneId.{ZoneId};
use Time.ZoneOffset;
use Time.ZoneOffset.{ZoneOffset};

namespace Time {

    ///
    /// A wrapper around a Java instant.
    ///
    pub opaque type Instant = ##java.time.Instant

}

namespace Time/Instant {

    pub def new(epochSecond: Int64, nanoAdjustment: Int64): Instant =
        import java.time.Instant:ofEpochSecond(Int64, Int64);
        Instant(ofEpochSecond(epochSecond, nanoAdjustment)) as & Pure

    pub def getFields(x: Instant): {epochSecond: Int64, nano: Int32} = 
        {epochSecond = x.getEpochSecond(), nano = x.getNano()}

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): Instant & Impure =
        import java.time.Instant:now();
        Instant(now())

    ///
    /// ___
    ///
    pub def epoch(): Instant =
        import get java.time.Instant:EPOCH as getEPOCH;
        Instant(getEPOCH()) as & Pure

    ///
    /// ___
    ///
    pub def minValue(): Instant =
        import get java.time.Instant:MIN as getMIN;
        Instant(getMIN()) as & Pure

    ///
    /// ___
    ///
    pub def maxValue(): Instant =
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


    ///
    /// Parse the string `s` as an Instant, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO UTC format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def fromString(s: String): Result[Instant, System.Error] =
        import java.lang.String.strip();
        import java.time.Instant:parse(##java.lang.CharSequence);
        try {
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Ok(Instant(parse(cs))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => Err(Generic("DateTimeParseException"))
        }

    ///
    /// Returns the given instant `x` as a String using ISO-8601 representation.
    ///
    pub def toString(x: Instant): String =
        import java.time.Instant.toString();
        let Instant(t) = x;
        t.toString() as & Pure

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


    pub def compare(x: Instant, y: Instant): Int32 =
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


    pub def until(b: Instant, e: Instant, unit: ChronoUnit): Int64 = 
        import java.time.Instant.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit);
        let Instant(b1) = b;
        let Instant(e1) = e;
        let u1 = Time/Temporal/ChronoUnit.marshal(unit);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        b1.until(te1, tu1) as & Pure


}
