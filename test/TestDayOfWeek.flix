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
    // toString                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toString01(): Bool = ToString.toString(Time/DayOfWeek.Monday) == "Monday"

    /////////////////////////////////////////////////////////////////////////////
    // fromString                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fromString01(): Bool = FromString.fromString("Monday") == Some(Time/DayOfWeek.Monday)


    @test
    def fromString02(): Bool = (FromString.fromString("MONDAY") : Option[Time.DayOfWeek]) == None

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
    // dayOfWeek                                                               //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def dayOfWeek01(): Bool = 
        Time/DayOfWeek.dayOfWeek(1) == Some(Time/DayOfWeek.Monday)

    @test
    def dayOfWeek02(): Bool = 
        Time/DayOfWeek.dayOfWeek(0) == None

    /////////////////////////////////////////////////////////////////////////////
    // fromLocalDate                                                           //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def fromLocalDate01(): Bool = 
        let date = Time/LocalDate.localDate({year = 2022, month = 5, dayOfMonth = 1});
        Time/DayOfWeek.fromLocalDate(date) == Time/DayOfWeek.Sunday

    @test
    def fromLocalDate02(): Bool =
        let date = Time/LocalDate.localDate({year = 2022, month = 5, dayOfMonth = 2});
        Time/DayOfWeek.fromLocalDate(date) == Time/DayOfWeek.Monday


    /////////////////////////////////////////////////////////////////////////////
    // getValue                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def getValue01(): Int32 & Impure =         
        let dow = Time/DayOfWeek.Monday;
        let i = Time/DayOfWeek.getValue(dow);
        println("DayOfWeek.dayOfWeek(): ${i}");
        i

    /////////////////////////////////////////////////////////////////////////////
    // getValue                                                                //
    /////////////////////////////////////////////////////////////////////////////
    
    pub def getDisplayName01(): Bool & Impure =         
        Time/DayOfWeek.getDisplayName(Time/Format/TextStyle.Full, FlixSandbox/I18n/Locale.getDefault(), Time/DayOfWeek.Monday) != ""


}