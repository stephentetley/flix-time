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

    
    /////////////////////////////////////////////////////////////////////////////
    // until                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def until01(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant Time.Temporal.ChronoUnit.Days) == 0i64
    
    @test
    def until02(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant Time.Temporal.ChronoUnit.Months) == 0i64

    @test
    def until03(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant Time.Temporal.ChronoUnit.Years) == 0i64

    @test
    def until04(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant Time.Temporal.ChronoUnit.Centuries) == 0i64

    @test
    def until05(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant Time.Temporal.ChronoUnit.Millennia) == 0i64

    @test
    def until06(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.until(begin = d1, end = d2, open_variant Time.Temporal.ChronoUnit.Eras) == 0i64


    /////////////////////////////////////////////////////////////////////////////
    // plusChrono                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def plusChrono01(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant Time.Temporal.ChronoUnit.Days) == d1

    @test
    def plusChrono02(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant Time.Temporal.ChronoUnit.Months) == d1

    @test
    def plusChrono03(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant Time.Temporal.ChronoUnit.Years) == d1
    
    @test
    def plusChrono04(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant Time.Temporal.ChronoUnit.Centuries) == d1
    
    @test
    def plusChrono05(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.plusChrono(d1, 0i64, open_variant Time.Temporal.ChronoUnit.Millennia) == d1


    /////////////////////////////////////////////////////////////////////////////
    // withChrono                                                              //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def withChrono01(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let y1 = Time.Chrono.HijrahDate.getYear(d1) |> Int32.toInt64;
        Time.Chrono.HijrahDate.withChrono(d1, open_variant Time.Temporal.ChronoField.Year, y1) == d1

    @test
    def withChrono02(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let m1 = Time.Chrono.HijrahDate.getMonth(d1) |> Int32.toInt64;
        Time.Chrono.HijrahDate.withChrono(d1, open_variant Time.Temporal.ChronoField.MonthOfYear, m1) == d1
}
