/*
 * Copyright 2019 Magnus Madsen
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

///
/// A wrapper around a Java instant.
///
opaque type Instant = ##java.time.Instant

namespace Instant {

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): Instant & Impure =
        import java.time.Instant:now();
        Instant(now())

    ///
    /// ___
    ///
    pub def epoch(): Instant & Pure =
        import get java.time.Instant:EPOCH as get_epoch;
        Instant(get_epoch()) as & Pure

    ///
    /// ___
    ///
    pub def minValue(): Instant & Pure =
        import get java.time.Instant:MIN as get_min;
        Instant(get_min()) as & Pure

    ///
    /// ___
    ///
    pub def maxValue(): Instant & Pure =
        import get java.time.Instant:MAX as get_max;
        Instant(get_max()) as & Pure

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

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def before(x: Instant, y: Instant): Bool =
        import java.time.Instant.isBefore(##java.time.Instant);
        let Instant(t1) = x;
        let Instant(t2) = y;
        t1.isBefore(t2) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def after(x: Instant, y: Instant): Bool =
        import java.time.Instant.isAfter(##java.time.Instant);
        let Instant(t1) = x;
        let Instant(t2) = y;
        t1.isAfter(t2) as & Pure

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


    ///
    /// Returns the given instant `x` as a String using ISO-8601 representation.
    ///
    pub def toString(x: Instant): String =
        import java.time.Instant.toString();
        let Instant(t) = x;
        t.toString() as & Pure

}
