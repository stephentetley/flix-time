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

mod TestMonthDay {
    
    use Assert.{assertEq, assertTrue, assertFalse, fail};
    use ToString.toString;

    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def toString01(): Unit \ {Assert, IO} = 
        InteropTime.MonthDay.monthDay({month = 1, dayOfMonth = 1}) |> toString |> println;
        assertTrue(true)

    /////////////////////////////////////////////////////////////////////////////
    // fromLocalDate                                                           //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def fromLocalDate01(): InteropTime.MonthDay \ IO = 
    //     let date = InteropTime.LocalDate.localDate({year =2022, month = 4, dayOfMonth = 18});
    //     let md = InteropTime.MonthDay.fromLocalDate(date);
    //     println("MonthDay.fromLocalDate01(): ${md}");
    //     md

    /////////////////////////////////////////////////////////////////////////////
    // get                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def get01(): Int32 \ IO =         
    //     let md = InteropTime.MonthDay.monthDay({month = 1, dayOfMonth = 1});
    //     let i = InteropTime.MonthDay.get(InteropTime.Temporal.ChronoField.monthOfYear(), md);
    //     println("MonthDay.get01(): ${i}");
    //     i

    // @Test
    // def get02(): Int32 \ IO =         
    //     let md = InteropTime.MonthDay.monthDay({month = 1, dayOfMonth = 1});
    //     let i = InteropTime.MonthDay.get(InteropTime.Temporal.ChronoField.dayOfMonth(), md);
    //     println("MonthDay.get02(): ${i}");
    //     i  

}
