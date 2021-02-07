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


namespace Time/Chrono {

    pub opaque type JapaneseChronology = ##java.time.chrono.JapaneseChronology

}

/// TODO should provide functions from the TemporalUnit interface

namespace Time/Chrono/JapaneseChronology {

    use Time/Chrono.JapaneseChronology;
    use Time/Chrono.JapaneseChronology.{JapaneseChronology};
    use Time/Chrono.JapaneseDate;
    use Time/Chrono.JapaneseDate.{JapaneseDate};
    use Time/Chrono.JapaneseEra;
    use Time/Chrono.JapaneseEra.{JapaneseEra};


    pub def getInstance(): JapaneseChronology & Impure = 
        import get java.time.chrono.JapaneseChronology:INSTANCE as getINSTANCE;
        JapaneseChronology(getINSTANCE())

    pub def getCalendarType(x: JapaneseChronology): String = 
        import java.time.chrono.JapaneseChronology.getCalendarType();
        let JapaneseChronology(x1) = x;
        getCalendarType(x1) as & Pure

    pub def dateNow(x: JapaneseChronology): JapaneseDate & Impure = 
        import java.time.chrono.JapaneseChronology.dateNow();
        let JapaneseChronology(x1) = x;
        JapaneseDate(dateNow(x1))

    pub def eraOf(x: JapaneseChronology, i: Int32): JapaneseEra = 
        import java.time.chrono.JapaneseChronology.eraOf(Int32);
        let JapaneseChronology(x1) = x;
        JapaneseEra(eraOf(x1, i) as & Pure)


}
