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


    use InteropTime.Internal.AdaptorExtras

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
        pub def toFlix(x: JClock): ClockZ = 
            ClockZ.ClockZ(x)
    }


    /// "factory methods" (e.g. `fixedClock`)

    /// Pure or Impure? 
    pub def fixedClock(inst: InstantZ, zone: ZoneId): ClockZ \ IO =
        AdaptorExtras.op2(inst, zone, (inst1, zone1) -> { JClock.fixed(inst1, zone1) })
        
    pub def systemClock(zone: ZoneId): ClockZ \ IO =
        AdaptorExtras.op(zone, zone1 -> { JClock.system(zone1) })

    pub def systemClockDefaultZone(): ClockZ \ IO = 
        AdaptorExtras.of(() -> { JClock.systemDefaultZone() })

    pub def systemClockUTC(): ClockZ \ IO = 
        AdaptorExtras.of(() -> { JClock.systemUTC() })

    pub def offset(d: DurationZ, c: ClockZ): ClockZ \ IO =
        AdaptorExtras.op2(d, c, (d1, c1) -> { JClock.offset(c1, d1) })

    pub def tick(d: DurationZ, c: ClockZ): ClockZ \ IO =
        AdaptorExtras.op2(d, c, (d1, c1) -> { JClock.tick(c1, d1) })


    pub def tickMillis(zoneId: ZoneId): ClockZ \ IO =
        AdaptorExtras.op(zoneId, zoneId1 -> { JClock.tickMillis(zoneId1) })

    pub def tickSeconds(zoneId: ZoneId): ClockZ \ IO =
        AdaptorExtras.op(zoneId, zoneId1 -> { JClock.tickSeconds(zoneId1) })

    pub def tickMinutes(zoneId: ZoneId): ClockZ \ IO =
        AdaptorExtras.op(zoneId, zoneId1 -> { JClock.tickMinutes(zoneId1) })

    /// Clock functions

    ///
    /// Impure as Clock keeps changing (so not a ToString instance).
    /// This uses the `java.lang.Object.toString()` method, the result is not expected to be user friendly.
    ///
    pub def toString(x: ClockZ): String \ IO =
        AdaptorExtras.extract(x, x1 -> { x1.toString() })

    pub def millis(x: ClockZ): Int64 \ IO =
        AdaptorExtras.extract(x, x1 -> { x1.millis() })

    pub def instant(x: ClockZ): InstantZ \ IO =
        AdaptorExtras.op(x, x1 -> { x1.instant() })


    // Getters and Setters (getZone and withZone are abstract in Java)

    // pub def getZone(c: Clock): ZoneId \ IO =
    //     let c1 = ToJava.toJava(c);
    //     ZoneId(c1.getZone())

    // pub def withZone(zone: ZoneId, c: Clock): Clock \ IO =
    //     let c1 = ToJava.toJava(c);
    //     let zone1 = ToJava.toJava(zone);
    //     Clock(c1.withZone(zone1))

    
}
