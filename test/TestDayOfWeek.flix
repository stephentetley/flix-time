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

namespace TestDayOfWeek {

    /////////////////////////////////////////////////////////////////////////////
    // fromEnum                                                                 //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fromEnum01(): Bool = Time/DayOfWeek.fromEnum(Time/DayOfWeek.Monday) == 0

    @test
    def fromEnum02(): Bool = Time/DayOfWeek.fromEnum(Time/DayOfWeek.Tuesday) == 1

    @test
    def fromEnum03(): Bool = Time/DayOfWeek.fromEnum(Time/DayOfWeek.Wednesday) == 2

    @test
    def fromEnum04(): Bool = Time/DayOfWeek.fromEnum(Time/DayOfWeek.Thursday) == 3

    @test
    def fromEnum05(): Bool = Time/DayOfWeek.fromEnum(Time/DayOfWeek.Friday) == 4

    @test
    def fromEnum06(): Bool = Time/DayOfWeek.fromEnum(Time/DayOfWeek.Saturday) == 5

    @test
    def fromEnum07(): Bool = Time/DayOfWeek.fromEnum(Time/DayOfWeek.Sunday) == 6

    /////////////////////////////////////////////////////////////////////////////
    // toEnum                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toEnum01(): Bool = Time/DayOfWeek.toEnum(0) == Some(Time/DayOfWeek.Monday)

    @test
    def toEnum02(): Bool = Time/DayOfWeek.toEnum(1) == Some(Time/DayOfWeek.Tuesday)

    @test
    def toEnum03(): Bool = Time/DayOfWeek.toEnum(2) == Some(Time/DayOfWeek.Wednesday)

    @test
    def toEnum04(): Bool = Time/DayOfWeek.toEnum(3) == Some(Time/DayOfWeek.Thursday)

    @test
    def toEnum05(): Bool = Time/DayOfWeek.toEnum(4) == Some(Time/DayOfWeek.Friday)

    @test
    def toEnum06(): Bool = Time/DayOfWeek.toEnum(5) == Some(Time/DayOfWeek.Saturday)

    @test
    def toEnum07(): Bool = Time/DayOfWeek.toEnum(6) == Some(Time/DayOfWeek.Sunday)

    @test
    def toEnum08(): Bool = Time/DayOfWeek.toEnum(7) == None

    @test
    def toEnum09(): Bool = Time/DayOfWeek.toEnum(8) == None

}