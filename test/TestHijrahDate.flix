/*
 * Copyright 2024 Stephen Tetley
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

mod TestHirjahDate {

    use InteropTime.Temporal.ChronoUnit.ChronoUnit
    use InteropTime.Temporal.ChronoField.ChronoField

    use Assert.{assertEq, assertTrue, assertFalse, fail};
    
    /////////////////////////////////////////////////////////////////////////////
    // until                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def until01(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let d2 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant ChronoUnit.Days) == 0i64)
    
    @Test
    def until02(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let d2 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant ChronoUnit.Months) == 0i64)

    @Test
    def until03(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let d2 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant ChronoUnit.Years) == 0i64)

    @Test
    def until04(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let d2 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant ChronoUnit.Centuries) == 0i64)

    @Test
    def until05(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let d2 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant ChronoUnit.Millennia) == 0i64)

    @Test
    def until06(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let d2 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant ChronoUnit.Eras) == 0i64)


    /////////////////////////////////////////////////////////////////////////////
    // plusChrono                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def plusChrono01(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant ChronoUnit.Days) == d1)

    @Test
    def plusChrono02(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant ChronoUnit.Months) == d1)

    @Test
    def plusChrono03(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant ChronoUnit.Years) == d1)
    
    @Test
    def plusChrono04(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant ChronoUnit.Centuries) == d1)
    
    @Test
    def plusChrono05(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        assertTrue(InteropTime.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant ChronoUnit.Millennia) == d1)


    /////////////////////////////////////////////////////////////////////////////
    // withChrono                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def withChrono01(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let y1 = InteropTime.Chrono.HijrahDate.getYear(d1) |> Int32.toInt64;
        assertTrue(InteropTime.Chrono.HijrahDate.withChrono(d1, open_variant ChronoField.Year, y1) == d1)

    @Test
    def withChrono02(): Unit \ {Assert, IO} = 
        let d1 = InteropTime.Chrono.HijrahDate.now();
        let m1 = InteropTime.Chrono.HijrahDate.getMonth(d1) |> Int32.toInt64;
        assertTrue(InteropTime.Chrono.HijrahDate.withChrono(d1, open_variant ChronoField.MonthOfYear, m1) == d1)
        
}
