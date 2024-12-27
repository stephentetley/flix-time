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

    /////////////////////////////////////////////////////////////////////////////
    // daysUntil                                                               //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def daysUntil01(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.daysUntil(begin = d1, end = d2) == 0i64

    /////////////////////////////////////////////////////////////////////////////
    // monthsUntil                                                             //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def monthsUntil01(): Bool \ IO = 
        let d1 = Time.Chrono.HijrahDate.now();
        let d2 = Time.Chrono.HijrahDate.now();
        Time.Chrono.HijrahDate.monthsUntil(begin = d1, end = d2) == 0i64

}
