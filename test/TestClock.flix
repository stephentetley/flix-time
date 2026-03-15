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

/*
mod TestClock {


    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toString01(): String \ IO = 
        InteropTime.Clock.toString(InteropTime.Clock.systemClockDefaultZone())


    /////////////////////////////////////////////////////////////////////////////
    // fixedClock                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fixedClock01(): Bool \ IO = 
        let i = InteropTime.InstantZ.now();
        let z = InteropTime.ZoneId.utc();
        let c = InteropTime.Clock.fixedClock(i, z);
        let ci1 = InteropTime.Clock.instant(c);
        let ci2 = InteropTime.Clock.instant(c);
        ci1 == ci2
        
    /////////////////////////////////////////////////////////////////////////////
    // systemClock                                                             //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def systemClock01(): Bool \ IO = 
        let c = InteropTime.Clock.systemClock(InteropTime.ZoneId.utc());
        InteropTime.Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // systemClockDefaultZone                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def systemClockDefaultZone01(): Bool \ IO = 
        let c = InteropTime.Clock.systemClockDefaultZone();
        InteropTime.Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // systemClockUTC                                                          //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def systemClockUTC01(): Bool \ IO = 
        let c = InteropTime.Clock.systemClockUTC();
        InteropTime.Clock.millis(c) > 0i64
       
    /////////////////////////////////////////////////////////////////////////////
    // offset                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def offset01(): Bool \ IO = 
        let c = InteropTime.Clock.offset(InteropTime.DurationZ.zero(), InteropTime.Clock.systemClockUTC());
        InteropTime.Clock.millis(c) > 0i64
       
    /////////////////////////////////////////////////////////////////////////////
    // tick                                                                    //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tick01(): Bool \ IO = 
        let c = InteropTime.Clock.tick(InteropTime.DurationZ.zero(), InteropTime.Clock.systemClockUTC());
        InteropTime.Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // tickMillis                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tickMillis01(): Bool \ IO = 
        let c = InteropTime.Clock.tickMillis(InteropTime.ZoneId.utc());
        InteropTime.Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // tickSeconds                                                             //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tickSeconds01(): Bool \ IO = 
        let c = InteropTime.Clock.tickSeconds(InteropTime.ZoneId.utc());
        InteropTime.Clock.millis(c) > 0i64

    /////////////////////////////////////////////////////////////////////////////
    // tickMinutes                                                             //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def tickMinutes01(): Bool \ IO = 
        let c = InteropTime.Clock.tickMinutes(InteropTime.ZoneId.utc());
        InteropTime.Clock.millis(c) > 0i64

}
*/
