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

namespace TestClock {


    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toString01(): String & Impure = Time/Clock.toString(Time/Clock.systemClockDefaultZone())


    /////////////////////////////////////////////////////////////////////////////
    // fixedClock                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fixedClock01(): Bool & Impure = 
        let i = Time/ZInstant.now();
        let z = Time/ZoneId.utc();
        let c = Time/Clock.fixedClock(i, z);
        let ci1 = Time/Clock.instant(c);
        let ci2 = Time/Clock.instant(c);
        ci1 == ci2
        
    /////////////////////////////////////////////////////////////////////////////
    // systemClock                                                             //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def systemClock01(): Bool & Impure = 
        let c = Time/Clock.systemClock(Time/ZoneId.utc());
        Time/Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // systemClockDefaultZone                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def systemClockDefaultZone01(): Bool & Impure = 
        let c = Time/Clock.systemClockDefaultZone();
        Time/Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // systemClockUTC                                                          //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def systemClockUTC01(): Bool & Impure = 
        let c = Time/Clock.systemClockUTC();
        Time/Clock.millis(c) > 0i64
       
    /////////////////////////////////////////////////////////////////////////////
    // offset                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def offset01(): Bool & Impure = 
        let c = Time/Clock.offset(Time/ZDuration.zero(), Time/Clock.systemClockUTC());
        Time/Clock.millis(c) > 0i64
       
    /////////////////////////////////////////////////////////////////////////////
    // tick                                                                    //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tick01(): Bool & Impure = 
        let c = Time/Clock.tick(Time/ZDuration.zero(), Time/Clock.systemClockUTC());
        Time/Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // tickMillis                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tickMillis01(): Bool & Impure = 
        let c = Time/Clock.tickMillis(Time/ZoneId.utc());
        Time/Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // tickSeconds                                                             //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tickSeconds01(): Bool & Impure = 
        let c = Time/Clock.tickSeconds(Time/ZoneId.utc());
        Time/Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // tickMinutes                                                             //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tickMinutes01(): Bool & Impure = 
        let c = Time/Clock.tickMinutes(Time/ZoneId.utc());
        Time/Clock.millis(c) > 0i64

}