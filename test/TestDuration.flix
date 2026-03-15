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

mod TestDuration {

    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toString01(): Bool = ToString.toString(InteropTime.Duration.new({seconds=1i64, nanos=0i64})) == "PT1S"

    @test
    def toString02(): Bool = ToString.toString(InteropTime.Duration.new({seconds=30i64, nanos=0i64})) == "PT30S"

    @test
    def toString03(): Bool = ToString.toString(InteropTime.Duration.new({seconds=60i64, nanos=0i64})) == "PT1M"

    /////////////////////////////////////////////////////////////////////////////
    // fromString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fromString01(): Bool = FromString.fromString(""): Option[Time.Duration] == None

    @test
    def fromString02(): Bool = FromString.fromString("TP1S"): Option[Time.Duration] == None

    @test
    def fromString03(): Bool = FromString.fromString("PT1S") == Some(InteropTime.Duration.fromSeconds(1i64))

    @test
    def fromString04(): Bool = FromString.fromString("PT30S") == Some(InteropTime.Duration.fromSeconds(30i64))

    @test
    def fromString05(): Bool = FromString.fromString("PT1M") == Some(InteropTime.Duration.fromMinutes(1i64))

    /////////////////////////////////////////////////////////////////////////////
    // add                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def add01(): Bool = InteropTime.Duration.fromSeconds(1i64) + InteropTime.Duration.fromSeconds(0i64) == InteropTime.Duration.fromSeconds(1i64)

    @test
    def add02(): Bool = InteropTime.Duration.fromSeconds(1i64) + InteropTime.Duration.fromSeconds(1i64) == InteropTime.Duration.fromSeconds(2i64)

    @test
    def add03(): Bool = InteropTime.Duration.fromHours(2i64) + InteropTime.Duration.fromHours(2i64) == InteropTime.Duration.fromHours(4i64)

    /////////////////////////////////////////////////////////////////////////////
    // sub                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def sub01(): Bool = InteropTime.Duration.fromSeconds(1i64) - InteropTime.Duration.fromSeconds(0i64) == InteropTime.Duration.fromSeconds(1i64)

    @test
    def sub02(): Bool = InteropTime.Duration.fromSeconds(1i64) - InteropTime.Duration.fromSeconds(1i64) == InteropTime.Duration.fromSeconds(0i64)

    @test
    def sub03(): Bool = InteropTime.Duration.fromHours(2i64) - InteropTime.Duration.fromHours(1i64) == InteropTime.Duration.fromHours(1i64)

    /////////////////////////////////////////////////////////////////////////////
    // neg                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def neg01(): Bool = -(InteropTime.Duration.fromSeconds(0i64)) == InteropTime.Duration.fromSeconds(0i64)

    @test
    def neg02(): Bool = -(InteropTime.Duration.fromSeconds(1i64)) == InteropTime.Duration.fromSeconds(-1i64)

    @test
    def neg03(): Bool = - InteropTime.Duration.fromHours(1i64) == InteropTime.Duration.fromHours(-1i64)

    /////////////////////////////////////////////////////////////////////////////
    // new                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def new01(): InteropTime.Duration = InteropTime.Duration.new({seconds=1i64, nanos=0i64})

    @test
    def new02(): InteropTime.Duration = InteropTime.Duration.new({seconds=0i64, nanos=1i64})

    @test
    def new03(): InteropTime.Duration = InteropTime.Duration.new({seconds=10i64, nanos=0i64})

    @test
    def new04(): InteropTime.Duration = InteropTime.Duration.new({seconds=60i64, nanos=0i64})

    /////////////////////////////////////////////////////////////////////////////
    // getFields                                                               //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def getFields01(): Bool =
        let x = InteropTime.Duration.getFields(InteropTime.Duration.fromSeconds(0i64));
        x.seconds == 0i64 and x.nanos == 0

    /////////////////////////////////////////////////////////////////////////////
    // zero                                                                    //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def zero01(): Bool = InteropTime.Duration.zero() == InteropTime.Duration.fromSeconds(0i64)

    /////////////////////////////////////////////////////////////////////////////
    // fromDays                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fromDays01(): Bool = InteropTime.Duration.fromDays(0i64) == InteropTime.Duration.zero()


    /////////////////////////////////////////////////////////////////////////////
    // toDays                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toDays01(): Bool = InteropTime.Duration.toDays(InteropTime.Duration.zero()) == 0i64

    /////////////////////////////////////////////////////////////////////////////
    // isZero                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def isZero01(): Bool = InteropTime.Duration.isZero(InteropTime.Duration.fromSeconds(0i64)) == true

    /////////////////////////////////////////////////////////////////////////////
    // isPositive                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def isPositive01(): Bool = InteropTime.Duration.isPositive(InteropTime.Duration.fromSeconds(1i64)) == true

    @test
    def isPositive02(): Bool = InteropTime.Duration.isPositive(InteropTime.Duration.fromSeconds(-1i64)) == false

}

*/
