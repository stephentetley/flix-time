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

    import java.time.{Clock => JClock}

    ///
    /// A wrapper around a Java Clock.
    ///
    /// We currently consider Clock "immutable" as the factory methods like `fixed`
    /// always return an immutable clock. 
    ///
    /// TODO - add region?
    ///
    pub enum Clock(JClock)


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

    import java.time.{Clock => JClock}


    /// Unwrap

    pub def getClock(x: Clock): JClock = 
        let Clock(x1) = x;
        x1

    /// "factory methods" (e.g. `fixedClock`)

    /// Pure or Impure? 
    pub def fixedClock(inst: InstantZ, zone: ZoneId): Clock \ IO =
        let InstantZ(inst1) = inst;
        let ZoneId(zone1) = zone;
        Clock(JClock.fixed(inst1, zone1))

    pub def systemClock(zone: ZoneId): Clock \ IO =
        let ZoneId(zone1) = zone;
        Clock(JClock.system(zone1))

    pub def systemClockDefaultZone(): Clock \ IO = Clock(JClock.systemDefaultZone())

    pub def systemClockUTC(): Clock \ IO = Clock(JClock.systemUTC())

    pub def offset(d: DurationZ, c: Clock): Clock \ IO =
        let DurationZ(d1) = d;
        let Clock(c1) = c;
        Clock(JClock.offset(c1, d1))

    pub def tick(d: DurationZ, c: Clock): Clock \ IO =
        let DurationZ(d1) = d;
        let Clock(c1) = c;
        Clock(JClock.tick(c1, d1))


    pub def tickMillis(zoneId: ZoneId): Clock \ IO =
        let ZoneId(zoneId1) = zoneId;
        Clock(JClock.tickMillis(zoneId1))

    pub def tickSeconds(zoneId: ZoneId): Clock \ IO =
        let ZoneId(zoneId1) = zoneId;
        Clock(JClock.tickSeconds(zoneId1))

    pub def tickMinutes(zoneId: ZoneId): Clock \ IO =
        let ZoneId(zoneId1) = zoneId;
        Clock(JClock.tickMinutes(zoneId1))

    /// Clock functions

    ///
    /// Impure as Clock keeps changing (so not a ToString instance).
    /// This uses the `java.lang.Object.toString()` method, the result is not expected to be user friendly.
    ///
    pub def toString(x: Clock): String \ IO =
        let Clock(x1) = x;
        x1.toString()

    pub def millis(x: Clock): Int64 \ IO =
        let Clock(x1) = x;
        x1.millis()

    pub def instant(x: Clock): InstantZ \ IO =
        let Clock(x1) = x;
        InstantZ(x1.instant())


    // Getters and Setters (getZone and withZone are abstract in Java)

    // pub def getZone(c: Clock): ZoneId \ IO =
    //     let Clock(c1) = c;
    //     ZoneId(c1.getZone())

    // pub def withZone(zone: ZoneId, c: Clock): Clock \ IO =
    //     let Clock(c1) = c;
    //     let ZoneId(zone1) = zone;
    //     Clock(c1.withZone(zone1))

    
}
