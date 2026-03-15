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

mod TestDayOfWeek {

    use InteropTime.DayOfWeek
    use InteropTime.DayOfWeek.DayOfWeek

    use Assert.{assertEq, assertTrue, assertFalse, fail};
    
    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def toString01(): Unit \ Assert = 
        assertTrue(ToString.toString(DayOfWeek.Monday) == "Monday")

    /////////////////////////////////////////////////////////////////////////////
    // fromString                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def fromString01(): Unit \ Assert = 
        assertTrue(FromString.fromString("Monday") == Some(DayOfWeek.Monday))


    @Test
    def fromString02(): Unit \ Assert = 
        assertTrue((FromString.fromString("MONDAY") : Option[DayOfWeek]) == None)

    /////////////////////////////////////////////////////////////////////////////
    // eq                                                                      //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def eq01(): Unit \ Assert = 
        assertTrue(DayOfWeek.Monday == DayOfWeek.Monday)

    /////////////////////////////////////////////////////////////////////////////
    // neq                                                                      //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def neq01(): Unit \ Assert = 
        assertTrue(DayOfWeek.Monday != DayOfWeek.Tuesday)


    /////////////////////////////////////////////////////////////////////////////
    // dayOfWeek                                                               //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def dayOfWeek01(): Unit \ Assert = 
        assertTrue(InteropTime.DayOfWeek.dayOfWeek(1) == Some(DayOfWeek.Monday))

    @Test
    def dayOfWeek02(): Unit \ Assert = 
        assertTrue(InteropTime.DayOfWeek.dayOfWeek(0) == None)

    /////////////////////////////////////////////////////////////////////////////
    // fromLocalDate                                                           //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def fromLocalDate01(): Bool = 
    //     let date = InteropTime.LocalDate.localDate({year = 2022, month = 5, dayOfMonth = 1});
    //     InteropTime.DayOfWeek.$fromLocalDate(date) == InteropTime.DayOfWeek.Sunday

    // @Test
    // def fromLocalDate02(): Bool =
    //     let date = InteropTime.LocalDate.localDate({year = 2022, month = 5, dayOfMonth = 2});
    //     InteropTime.DayOfWeek.$fromLocalDate(date) == InteropTime.DayOfWeek.Monday


    /////////////////////////////////////////////////////////////////////////////
    // getValue                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def getValue01(): Unit \ {Assert, IO} =         
        let dow = DayOfWeek.Monday;
        let i = InteropTime.DayOfWeek.getValue(dow);
        println("DayOfWeek.dayOfWeek(): ${i}");
        assertTrue(i == 1)

    /////////////////////////////////////////////////////////////////////////////
    // getValue                                                                //
    /////////////////////////////////////////////////////////////////////////////
    
    @Test
    pub def getDisplayName01(): Unit \ {Assert, IO} =
        assertTrue(InteropTime.DayOfWeek.getDisplayName(InteropTime.Format.TextStyle.TextStyle.Full, InteropLocale.Locale.getDefault(), DayOfWeek.Monday) != "")


}
