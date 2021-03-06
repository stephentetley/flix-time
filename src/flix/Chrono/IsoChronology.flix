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

    pub opaque type IsoChronology = ##java.time.chrono.IsoChronology

}

namespace Time/Chrono/IsoChronology {

    use Time/Chrono.IsoChronology;
    use Time/Chrono.IsoChronology.{IsoChronology};    
    use Time/Chrono.IsoEra;
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    pub def getInstance(): IsoChronology & Impure = 
        import get java.time.chrono.IsoChronology:INSTANCE      as getINSTANCE;
        IsoChronology(getINSTANCE())

    pub def getCalendarType(x: IsoChronology): String = 
        import java.time.chrono.IsoChronology.getCalendarType();
        let IsoChronology(x1) = x;
        getCalendarType(x1) as & Pure

    pub def dateNow(x: IsoChronology): LocalDate & Impure = 
        import java.time.chrono.IsoChronology.dateNow();
        let IsoChronology(x1) = x;
        LocalDate(dateNow(x1))

    pub def eraOf(x: IsoChronology, i: Int32): IsoEra = 
        import java.time.chrono.IsoChronology.eraOf(Int32);
        let IsoChronology(x1) = x;
        Time/Chrono/IsoEra.unmarshal(eraOf(x1, i)) as & Pure

    pub def getId(x: IsoChronology): String = 
        import java.time.chrono.IsoChronology.getId();
        let IsoChronology(x1) = x;
        getId(x1) as & Pure

}
