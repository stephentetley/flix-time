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


mod Time {

    use Time.Clock
    use Time.Clock.{Clock}

    ///
    /// A wrapper around a Java Clock.
    ///
    /// We currently consider Clock "immutable" as the factory methods like `fixed`
    /// always return an immutable clock. 
    ///
    /// TODO - add region?
    ///
    pub enum Clock(##java.time.Clock)

    instance Interop.Flix.Marshal[Clock] {
        pub def toJavaObject(x: Clock): ##java.lang.Object =
            let Clock(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): Clock = 
            Clock(unchecked_cast(o as ##java.time.Clock))
    }

}

mod Time.Clock {

    use Time.Clock
    use Time.Clock.{Clock}
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    /// ## Unwrap

    pub def getClock(x: Clock): ##java.time.Clock = 
        let Clock(x1) = x;
        x1

    /// ## "factory methods" (e.g. `fixedClock`)

    /// Pure or Impure? 
    pub def fixedClock(inst: InstantZ, zone: ZoneId): Clock \ IO =
        import static java.time.Clock.fixed(##java.time.Instant, ##java.time.ZoneId): ##java.time.Clock \ IO;
        let InstantZ(inst1) = inst;
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

    pub def offset(d: DurationZ, c: Clock): Clock \ IO =
        import static java.time.Clock.offset(##java.time.Clock, ##java.time.Duration): ##java.time.Clock \ IO;
        let DurationZ(d1) = d;
        let Clock(c1) = c;
        Clock(offset(c1, d1))

    pub def tick(d: DurationZ, c: Clock): Clock \ IO =
        import static java.time.Clock.tick(##java.time.Clock, ##java.time.Duration): ##java.time.Clock \ IO;
        let DurationZ(d1) = d;
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
    /// Impure as Clock keeps changing (so not a ToString instance).
    /// This uses the `java.lang.Object.toString()` method, the result is not expected to be user friendly.
    ///
    pub def toString(x: Clock): String \ IO =
        import java.lang.Object.toString(): String \ IO;
        let Clock(x1) = x;
        let o1 = checked_cast(x1);
        toString(o1)

    pub def millis(x: Clock): Int64 \ IO =
        import java.time.Clock.millis(): Int64 \ IO;
        let Clock(x1) = x;
        millis(x1)

    pub def instant(x: Clock): InstantZ \ IO =
        import java.time.Clock.instant(): ##java.time.Instant \ IO;
        let Clock(x1) = x;
        InstantZ(instant(x1))


    /// ## Getters and Setters

    pub def getZone(c: Clock): ZoneId \ IO =
        import java.time.Clock.getZone(): ##java.time.ZoneId \ IO;
        ZoneId(getZone(getClock(c)))

    pub def withZone(zone: ZoneId, c: Clock): Clock \ IO =
        import java.time.Clock.withZone(##java.time.ZoneId): ##java.time.Clock \ IO;
        let Clock(c1) = c;
        Clock(withZone(c1, Time.ZoneId.getZoneId(zone)))

    
}
