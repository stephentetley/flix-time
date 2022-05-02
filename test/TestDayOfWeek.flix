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
    // fromLocalDate                                                           //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fromLocalDate01(): Time.DayOfWeek & Impure = 
        let date = Time/LocalDate.localDate({year =2022, month = 4, dayOfMonth = 18});
        let dow = Time/DayOfWeek.fromLocalDate(date);
        println("DayOfWeek.fromLocalDate01(): ${dow}");
        dow



    /////////////////////////////////////////////////////////////////////////////
    // getValue                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def getValue01(): Int32 & Impure =         
        let dow = Time/DayOfWeek.Monday;
        let i = Time/DayOfWeek.getValue(dow);
        println("DayOfWeek.dayOfWeek(): ${i}");
        i


}