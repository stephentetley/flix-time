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
    pub enum Clock(##java.time.Clock)


}

namespace Time/Clock {

    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.ZDuration;
    use Time.ZDuration.{ZDuration};
    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    /// ## Unwrap

    pub def getClock(x: Clock): ##java.time.Clock = 
        let Clock(x1) = x;
        x1

    /// ## "abstract constructors" (e.g. `fixedClock`)

    /// Pure or Impure? 
    pub def fixedClock(inst: ZInstant, zone: ZoneId): Clock \ IO =
        import static java.time.Clock.fixed(##java.time.Instant, ##java.time.ZoneId): ##java.time.Clock \ IO;
        let ZInstant(inst1) = inst;
        let ZoneId(zone1) = zone;
        Clock(fixed(inst1, zone1))

    pub def systemClock(zone: ZoneId): Clock \ IO =
        import static java.time.Clock.system(##java.time.ZoneId): ##java.time.Clock \ IO;
        let ZoneId(zone1) = zone;
        Clock(system(zone1))

    pub def systemClockDefaultZone(): Clock \ IO =
        import static java.time.Clock.systemDefaultZone(): ##java.time.Clock \ IO;
        Clock(systemDefaultZone())

    pub def systemClockUTC(): Clock \ IO =
        import static java.time.Clock.systemUTC(): ##java.time.Clock \ IO;
        Clock(systemUTC())

    pub def offset(d: ZDuration, c: Clock): Clock \ IO =
        import static java.time.Clock.offset(##java.time.Clock, ##java.time.Duration): ##java.time.Clock \ IO;
        let ZDuration(d1) = d;
        let Clock(c1) = c;
        Clock(offset(c1, d1))

    pub def tick(d: ZDuration, c: Clock): Clock \ IO =
        import static java.time.Clock.tick(##java.time.Clock, ##java.time.Duration): ##java.time.Clock \ IO;
        let ZDuration(d1) = d;
        let Clock(c1) = c;
        Clock(tick(c1, d1))


    pub def tickMillis(zoneId: ZoneId): Clock \ IO =
        import static java.time.Clock.tickMillis(##java.time.ZoneId): ##java.time.Clock \ IO;
        let ZoneId(zoneId1) = zoneId;
        Clock(tickMillis(zoneId1))

    pub def tickSeconds(zoneId: ZoneId): Clock \ IO =
        import static java.time.Clock.tickSeconds(##java.time.ZoneId): ##java.time.Clock \ IO;
        let ZoneId(zoneId1) = zoneId;
        Clock(tickSeconds(zoneId1))

    pub def tickMinutes(zoneId: ZoneId): Clock \ IO =
        import static java.time.Clock.tickMinutes(##java.time.ZoneId): ##java.time.Clock \ IO;
        let ZoneId(zoneId1) = zoneId;
        Clock(tickMinutes(zoneId1))

    /// ## Clock functions

    ///
    /// Impure so not a ToString instance.
    /// This uses the `java.lang.Object.toString()` method, the result is not expected to be user friendly.
    ///
    pub def toString(x: Clock): String \ IO =
        import java.lang.Object.toString(): String \ IO;
        let Clock(x1) = x;
        let o1 = x1 as ##java.lang.Object;
        toString(o1)

    pub def millis(x: Clock): Int64 \ IO =
        import java.time.Clock.millis(): Int64 \ IO;
        let Clock(x1) = x;
        millis(x1)

    pub def instant(x: Clock): ZInstant \ IO =
        import java.time.Clock.instant(): ##java.time.Instant \ IO;
        let Clock(x1) = x;
        ZInstant(instant(x1))


    /// ## Getters and Setters

    pub def getZone(c: Clock): ZoneId \ IO =
        import java.time.Clock.getZone(): ##java.time.ZoneId \ IO;
        ZoneId(getZone(getClock(c)))

    pub def setZone(zone: ZoneId, c: Clock): Clock \ IO =
        import java.time.Clock.withZone(##java.time.ZoneId): ##java.time.Clock \ IO;
        let Clock(c1) = c;
        Clock(withZone(c1, Time/ZoneId.getZoneId(zone)))

    
}
