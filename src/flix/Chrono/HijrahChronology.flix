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

    pub opaque type HijrahChronology = ##java.time.chrono.HijrahChronology

}


namespace Time/Chrono/HijrahChronology {

    use Time/Chrono.HijrahChronology;
    use Time/Chrono.HijrahChronology.{HijrahChronology};
    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.HijrahEra;

    pub def getInstance(): HijrahChronology & Impure =
        import get java.time.chrono.HijrahChronology:INSTANCE as getINSTANCE;
        HijrahChronology(getINSTANCE())
        

    pub def dateNow(x: HijrahChronology): HijrahDate & Impure = 
        import java.time.chrono.HijrahChronology.dateNow();
        let HijrahChronology(x1) = x;
        HijrahDate(dateNow(x1))


    pub def getCalendarType(x: HijrahChronology): String = 
        import java.time.chrono.HijrahChronology.getCalendarType();
        let HijrahChronology(x1) = x;
        getCalendarType(x1) as & Pure

    pub def eraOf(x: HijrahChronology, i: Int32): HijrahEra = 
        import java.time.chrono.HijrahChronology.eraOf(Int32);
        use Time/Chrono/HijrahEra.{unmarshal};
        let HijrahChronology(x1) = x;
        unmarshal(eraOf(x1, i) as & Pure)
        
}
