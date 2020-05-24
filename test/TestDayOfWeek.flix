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
// toInt32                                                                 //
/////////////////////////////////////////////////////////////////////////////

@test
def toInt3201(): Bool = Time/DayOfWeek.toInt32(Time/DayOfWeek.Monday) == 1

@test
def toInt3202(): Bool = Time/DayOfWeek.toInt32(Time/DayOfWeek.Tuesday) == 2

@test
def toInt3203(): Bool = Time/DayOfWeek.toInt32(Time/DayOfWeek.Wednesday) == 3

@test
def toInt3204(): Bool = Time/DayOfWeek.toInt32(Time/DayOfWeek.Thursday) == 4

@test
def toInt3205(): Bool = Time/DayOfWeek.toInt32(Time/DayOfWeek.Friday) == 5

@test
def toInt3206(): Bool = Time/DayOfWeek.toInt32(Time/DayOfWeek.Saturday) == 6

@test
def toInt3207(): Bool = Time/DayOfWeek.toInt32(Time/DayOfWeek.Sunday) == 7

/////////////////////////////////////////////////////////////////////////////
// fromInt32                                                               //
/////////////////////////////////////////////////////////////////////////////

@test
def fromInt3201(): Bool = Time/DayOfWeek.fromInt32(1) == Ok(Time/DayOfWeek.Monday)

@test
def fromInt3202(): Bool = Time/DayOfWeek.fromInt32(2) == Ok(Time/DayOfWeek.Tuesday)

@test
def fromInt3203(): Bool = Time/DayOfWeek.fromInt32(3) == Ok(Time/DayOfWeek.Wednesday)

@test
def fromInt3204(): Bool = Time/DayOfWeek.fromInt32(4) == Ok(Time/DayOfWeek.Thursday)

@test
def fromInt3205(): Bool = Time/DayOfWeek.fromInt32(5) == Ok(Time/DayOfWeek.Friday)

@test
def fromInt3206(): Bool = Time/DayOfWeek.fromInt32(6) == Ok(Time/DayOfWeek.Saturday)

@test
def fromInt3207(): Bool = Time/DayOfWeek.fromInt32(7) == Ok(Time/DayOfWeek.Sunday)

@test
def fromInt3208(): Bool = Time/DayOfWeek.fromInt32(0) |> Result.isErr

@test
def fromInt3209(): Bool = Time/DayOfWeek.fromInt32(8) |> Result.isErr

}