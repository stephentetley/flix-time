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

    use ToString.toString;

    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toString01(): String & Impure = toString(Time/Clock.systemClockDefaultZone())


    /////////////////////////////////////////////////////////////////////////////
    // fixed                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fixed01(): Bool & Impure = 
        let i = Time/ZInstant.now();
        let z = Time/ZoneId.utc();
        let c = Time/Clock.fixedClock(i, z);
        let ci1 = Time/Clock.instant(c);
        let ci2 = Time/Clock.instant(c);
        println("Clock.fixed01(): ${ci1} ${ci2}");
        ci1 == ci2
        
}