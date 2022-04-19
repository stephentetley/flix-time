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
    // eq                                                                      //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def eq01(): Bool = Time/DayOfWeek.Monday == Time/DayOfWeek.Monday

    /////////////////////////////////////////////////////////////////////////////
    // neq                                                                      //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def neq01(): Bool = Time/DayOfWeek.Monday != Time/DayOfWeek.Tuesday


    /////////////////////////////////////////////////////////////////////////////
    // range                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def range01(): Time/Temporal.ValueRange & Impure = 
        let d1 = Time/DayOfWeek.Sunday;        
        let r1 = Time/DayOfWeek.range(Time/Temporal/ChronoField.dayOfWeek(), d1);
        println("DayOfWeek.range01(): ${r1}");
        r1

    /////////////////////////////////////////////////////////////////////////////
    // fromTemporalAccessor                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fromTemporalAccessor01(): Result[Time.DayOfWeek, String] & Impure = 
        let date = Time/LocalDate.of({year =2022, month = 4, dayOfMonth = 18});
        let dow = Time/DayOfWeek.fromTemporalAccessor(date);
        println("DayOfWeek.fromTemporalAccessor01(): ${dow}");
        dow


    @test
    def fromTemporalAccessor02(): Result[Time.DayOfWeek, String] & Impure = 
        let year = Time/Year.of(isoYear = 2022);
        let dow = Time/DayOfWeek.fromTemporalAccessor(year);
        println("DayOfWeek.fromTemporalAccessor02(): ${dow}");
        dow


    /////////////////////////////////////////////////////////////////////////////
    // get                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def get01(): Int32 & Impure =         
        let dow = Time/DayOfWeek.Monday;
        let i = Time/DayOfWeek.get(Time/Temporal/ChronoField.dayOfWeek(), dow);
        println("DayOfWeek.get01(): ${i}");
        i


}