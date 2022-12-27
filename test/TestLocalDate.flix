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

    /// @test
    /// def withFirstDayOfMonth01(): Time.LocalDate \ IO = 
    ///     let d1 = Time/LocalDate.localDate({year = 2022, month = 4, dayOfMonth = 19});
    ///     let d2 = Time/LocalDate.withFirstDayOfMonth(d1);
    ///     println("LocalDate.withTemporalAdjuster01(): ${d1} ${d2}");
    ///     println("${Time/Temporal/TemporalAdjusters.firstDayOfMonth()}");
    ///     d2

    @test
    def setToLastDayOfMonth01(): Time.LocalDate \ IO = 
        let d1 = Time/LocalDate.localDate({year = 2022, month = 4, dayOfMonth = 19});
        let d2 = Time/LocalDate.adjustToLastDayOfMonth(d1);
        println("LocalDate.adjustToLastDayOfMonth01(): ${d1} ${d2}");        
        d2

       
}
