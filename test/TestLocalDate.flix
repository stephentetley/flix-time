/*
 * Copyright 2022 Stephen Tetley
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

namespace TestLocalDate {

    

    /////////////////////////////////////////////////////////////////////////////
    // withTemporalAdjuster                                                    //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def withTemporalAdjuster01(): Time.LocalDate & Impure = 
        let d1 = Time/LocalDate.of({year = 2022, month = 4, dayOfMonth = 19});
        let d2 = Time/LocalDate.withTemporalAdjuster(Time/Temporal/TemporalAdjusters.firstDayOfMonth(), d1);
        println("LocalDate.withTemporalAdjuster01(): ${d1} ${d2}");
        println("${Time/Temporal/TemporalAdjusters.firstDayOfMonth()}");
        d2

    @test
    def withTemporalAdjuster02(): Time.LocalDate & Impure = 
        let d1 = Time/LocalDate.of({year = 2022, month = 4, dayOfMonth = 19});
        let d2 = Time/LocalDate.withTemporalAdjuster(Time/Temporal/TemporalAdjusters.lastDayOfMonth(), d1);
        println("LocalDate.withTemporalAdjuster02(): ${d1} ${d2}");        
        d2


        
}