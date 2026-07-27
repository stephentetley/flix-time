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



pub mod InteropTime.ClockZ {

    use InteropTime.ClockZ.ClockZ
    use InteropTime.ClockZ.ClockZ.{ClockZ}
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ
    use InteropTime.ZoneId.ZoneId
    
    import java.time.{Clock => JClock}

    ///
    /// A wrapper around a Java Clock.
    ///
    /// Should be an effect?
    ///
    pub enum ClockZ(JClock)


    instance ToJava[ClockZ] {
        type Out = JClock
        pub def toJava(x: ClockZ): JClock = 
            let ClockZ.ClockZ(x1) = x;
            x1
    }

    instance ToFlix[ClockZ] {
        type In = JClock
        pub def toFlix(x: JClock): ClockZ = ClockZ.ClockZ(x)
    }


    /// "factory methods" (e.g. `fixedClock`)

    /// Pure or Impure? 
    pub def fixedClock(inst: InstantZ, zone: ZoneId): ClockZ \ IO =
        let inst1 = ToJava.toJava(inst);
        let zone1 = ToJava.toJava(zone);
        let ans = JClock.fixed(inst1, zone1);
        ClockZ(ans)

    pub def systemClock(zone: ZoneId): ClockZ \ IO =
        let zone1 = ToJava.toJava(zone);
        let ans = JClock.system(zone1);
        ClockZ(ans)

    pub def systemClockDefaultZone(): ClockZ \ IO = ClockZ(JClock.systemDefaultZone())

    pub def systemClockUTC(): ClockZ \ IO = ClockZ(JClock.systemUTC())

    pub def offset(d: DurationZ, c: ClockZ): ClockZ \ IO =
        let d1 = ToJava.toJava(d);
        let c1 = ToJava.toJava(c);
        let ans = JClock.offset(c1, d1);
        ClockZ(ans)

    pub def tick(d: DurationZ, c: ClockZ): ClockZ \ IO =
        let d1 = ToJava.toJava(d);
        let c1 = ToJava.toJava(c);
        let ans = JClock.tick(c1, d1);
        ClockZ(ans)


    pub def tickMillis(zoneId: ZoneId): ClockZ \ IO =
        let zoneId1 = ToJava.toJava(zoneId);
        let ans = JClock.tickMillis(zoneId1);
        ClockZ(ans)

    pub def tickSeconds(zoneId: ZoneId): ClockZ \ IO =
        let zoneId1 = ToJava.toJava(zoneId);
        let ans = JClock.tickSeconds(zoneId1);
        ClockZ(ans)

    pub def tickMinutes(zoneId: ZoneId): ClockZ \ IO =
        let zoneId1 = ToJava.toJava(zoneId);
        let ans = JClock.tickMinutes(zoneId1);
        ClockZ(ans)

    /// Clock functions

    ///
    /// Impure as Clock keeps changing (so not a ToString instance).
    /// This uses the `java.lang.Object.toString()` method, the result is not expected to be user friendly.
    ///
    pub def toString(x: ClockZ): String \ IO =
        let x1 = ToJava.toJava(x);
        x1.toString()

    pub def millis(x: ClockZ): Int64 \ IO =
        let x1 = ToJava.toJava(x);
        x1.millis()

    pub def instant(x: ClockZ): InstantZ \ IO =
        let x1 = ToJava.toJava(x);
        let ans = x1.instant();
        ToFlix.toFlix(ans)


    // Getters and Setters (getZone and withZone are abstract in Java)

    // pub def getZone(c: Clock): ZoneId \ IO =
    //     let c1 = ToJava.toJava(c);
    //     ZoneId(c1.getZone())

    // pub def withZone(zone: ZoneId, c: Clock): Clock \ IO =
    //     let c1 = ToJava.toJava(c);
    //     let zone1 = ToJava.toJava(zone);
    //     Clock(c1.withZone(zone1))

    
}
