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


    use JavaInterop.AdaptorUnchecked

    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ
    use InteropTime.ZoneId.ZoneId
    
    import java.time.{Clock => JClock}

    ///
    /// A wrapper around a Java Clock.
    ///
    pub enum ClockZ(JClock)


    ///
    /// A effect for getting the current clock inside a run context.
    ///
    /// Users of flix-time shouldn't need to worry about this but we need 
    /// it so Instant, etc. can provide nowWithClock() functions via the 
    /// `ClockNow` trait
    ///
    pub eff ReifyClock {
        def getClock(): ClockZ
    }

    pub trait ClockNow[t] {
        pub type E: Eff
        pub def now(): t \ ClockNow.E[t]
    }


    ///
    /// An effect for running clocks.
    ///
    pub eff RunClock {
        def instant(): InstantZ
        def millis(): Int64
        def getZone(): ZoneId
    }

    pub def handle(clock: ClockZ, f: a -> b \ ef): a -> b \ (ef - ReifyClock - RunClock) = x -> 
        let jclock = ToJava.toJava(clock);
        run {
            f(x)
        } with handler ReifyClock {
            
            def getClock(k) = k(clock)

        } with handler RunClock {
            
            def instant(k) = {
                let inst = unsafe IO { jclock.instant() };
                k(ToFlix.toFlix(inst))
            }

            def millis(k) = {
                let m = unsafe IO { jclock.millis() };
                k(m)
            }

            def getZone(k) = {
                let zone = unsafe IO { jclock.getZone() };
                k(ToFlix.toFlix(zone))
            }
        }




    pub def runClock(clock: ClockZ, f: Unit -> a \ ef): a \ (ef - ReifyClock - RunClock) = 
        handle(clock, f)()


    

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


    pub def fixedClock(inst: InstantZ, zone: ZoneId): ClockZ  =
        AdaptorUnchecked.op2(inst, zone, (inst1, zone1) -> 
            unsafe IO { JClock.fixed(inst1, zone1) }
        )
        
    pub def systemClock(zone: ZoneId): ClockZ \ IO =
        AdaptorUnchecked.op(zone, zone1 -> { JClock.system(zone1) })

    pub def systemClockDefaultZone(): ClockZ \ IO = 
        AdaptorUnchecked.of(() -> { JClock.systemDefaultZone() })

    pub def systemClockUTC(): ClockZ \ IO = 
        AdaptorUnchecked.of(() -> { JClock.systemUTC() })

    pub def offset(d: DurationZ, c: ClockZ): ClockZ \ IO =
        AdaptorUnchecked.op2(d, c, (d1, c1) -> { JClock.offset(c1, d1) })

    pub def tick(d: DurationZ, c: ClockZ): ClockZ \ IO =
        AdaptorUnchecked.op2(d, c, (d1, c1) -> { JClock.tick(c1, d1) })


    pub def tickMillis(zone: ZoneId): ClockZ \ IO =
        AdaptorUnchecked.op(zone, zone1 -> { JClock.tickMillis(zone1) })

    pub def tickSeconds(zone: ZoneId): ClockZ \ IO =
        AdaptorUnchecked.op(zone, zone1 -> { JClock.tickSeconds(zone1) })

    pub def tickMinutes(zone: ZoneId): ClockZ \ IO =
        AdaptorUnchecked.op(zone, zone1 -> { JClock.tickMinutes(zone1) })


}

