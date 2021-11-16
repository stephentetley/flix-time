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
    /// A wrapper around a Java Clock.
    ///
    pub opaque type Clock = ##java.time.Clock

    ///
    /// Returns the given Clock `x` as a String.
    ///
    /// This uses the `java.lang.Object.toString()` method, the result is not expected to be user friendly.
    ///
    instance ToString[Clock] {
        pub def toString(x: Clock): String =
            import java.lang.Object.toString();
            let Clock(x1) = x;
            let o1 = x1 as ##java.lang.Object;
            toString(o1) as & Pure
    }

    instance Eq[Clock] {
        pub def eq(x: Clock, y: Clock): Bool = Time/Clock.equals(x, y)
    }

    instance Hash[Clock] {
        pub def hash(x: Clock): Int = Time/Clock.hashCode(x)
    }

}

namespace Time/Clock {

    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.Instant;
    use Time.Instant.{Instant};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def system(x: ZoneId): Clock & Impure =
        import java.time.Clock:system(##java.time.ZoneId);
        let ZoneId(x1) = x;
        Clock(system(x1))


    pub def systemDefaultZone(): Clock & Impure =
        import java.time.Clock:systemDefaultZone();
        Clock(systemDefaultZone())

    pub def systemUTC(): Clock & Impure =
        import java.time.Clock:systemUTC();
        Clock(systemUTC())

    pub def equals(x: Clock, y: Clock): Bool =
        import java.time.Clock.equals(##java.lang.Object);
        let Clock(x1) = x;
        let Clock(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: Clock): Int32 =
        import java.time.Clock.hashCode();
        let Clock(x1) = x;
        hashCode(x1) as & Pure

    pub def millis(x: Clock): Int64 & Impure =
        import java.time.Clock.millis();
        let Clock(x1) = x;
        millis(x1)

    pub def instant(x: Clock): Instant & Impure =
        import java.time.Clock.instant();
        let Clock(x1) = x;
        Instant(instant(x1))


    pub def tickMillis(zoneId: ZoneId): Clock & Impure =
        import java.time.Clock:tickMillis(##java.time.ZoneId);
        let ZoneId(zoneId1) = zoneId;
        Clock(tickMillis(zoneId1))

    pub def tickSeconds(zoneId: ZoneId): Clock & Impure =
        import java.time.Clock:tickSeconds(##java.time.ZoneId);
        let ZoneId(zoneId1) = zoneId;
        Clock(tickSeconds(zoneId1))

    pub def tickMinutes(zoneId: ZoneId): Clock & Impure =
        import java.time.Clock:tickMinutes(##java.time.ZoneId);
        let ZoneId(zoneId1) = zoneId;
        Clock(tickMinutes(zoneId1))

    
    pub def getZone(x: Clock): ZoneId =
        import java.time.Clock.getZone();
        let Clock(x1) = x;
        ZoneId(getZone(x1)) as & Pure

    pub def putZone(x: Clock, zoneId: ZoneId): Clock =
        import java.time.Clock.withZone(##java.time.ZoneId);
        let Clock(x1) = x;
        let ZoneId(zoneId1) = zoneId;
        Clock(withZone(x1, zoneId1)) as & Pure

}
