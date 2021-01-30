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
    
    ///
    /// java.time.chrono.HijrahChronology is a singleton we treat it as a "handle monad" 
    /// i.e. a Reader monad without local.
    /// TODO - it's likely we will need to include error handling.
    ///
    pub opaque type HijrahChronology[a] = ##java.time.chrono.HijrahChronology ~> a

}


namespace Time/Chrono/HijrahChronology {

    use Time/Chrono.HijrahChronology;
    use Time/Chrono.HijrahChronology.{HijrahChronology};
    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.HijrahEra;

    def getInstance(): ##java.time.chrono.HijrahChronology & Impure =
        import get java.time.chrono.HijrahChronology:INSTANCE      as getINSTANCE;
        getINSTANCE()
        

    pub def runHijrahChronology(x: HijrahChronology[a]): a & Impure = 
        let HijrahChronology(x1) = x;
        let hc = getInstance();
        x1(hc)

    pub def dateNow(): HijrahChronology[HijrahDate] = 
        import java.time.chrono.HijrahChronology.dateNow();
        HijrahChronology(r -> HijrahDate(dateNow(r)))


    pub def getCalendarType(): HijrahChronology[String] = 
        import java.time.chrono.HijrahChronology.getCalendarType();
        HijrahChronology(r -> getCalendarType(r))

    pub def eraOf(x: Int32): HijrahChronology[HijrahEra] = 
        import java.time.chrono.HijrahChronology.eraOf(Int32);
        use Time/Chrono/HijrahEra.{unmarshal};
        HijrahChronology(r -> unmarshal(eraOf(r, x)))
        
}
