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

mod Time.Chrono {

    use Time.Chrono.IsoChronology
    use Time.Chrono.IsoChronology.{IsoChronology}

    import java.time.chrono.{IsoChronology => JIsoChronology}

    pub enum IsoChronology(JIsoChronology)
    
    instance ToString[IsoChronology] {
        pub def toString(x: IsoChronology): String =
            let IsoChronology(x1) = x;
            unsafe x1.toString()
    }

}

mod Time.Chrono.IsoChronology {

    use Time.Chrono.IsoChronology
    use Time.Chrono.IsoChronology.{IsoChronology}
    use Time.Chrono.IsoEra
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}

    import java.time.chrono.{IsoChronology => JIsoChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        Era => JEra, 
        IsoEra => JIsoEra}
    import java.time.{LocalDate => JLocalDate}


    pub def getInstance(): IsoChronology \ IO = 
        IsoChronology(JIsoChronology.INSTANCE)

    pub def getCalendarType(x: IsoChronology): String = 
        let IsoChronology(x1) = x;
        unsafe x1.getCalendarType()

    pub def dateNow(x: IsoChronology): LocalDate \ IO = 
        let IsoChronology(x1) = x;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JChronoLocalDate = cx1.dateNow();
        let ans1 = unchecked_cast(ans as JLocalDate);
        LocalDate(ans1)



    pub def eraOf(x: IsoChronology, i: Int32): IsoEra = 
        let IsoChronology(x1) = x;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JEra = unsafe cx1.eraOf(i);
        let ans1 = unchecked_cast(ans as JIsoEra); 
        Time.Chrono.IsoEra.unmarshalIsoEra(ans1)


    /// pub def eras(x: IsoChronology): List[IsoEra] = 
    ///     import java.time.chrono.IsoChronology.eras(): ##java.util.List \ {};
    ///     let IsoChronology(x1) = x;
    ///     let jxs = eras(x1);
    ///     Interop.Collections/... .unmarshalList(o -> Time.Chrono.IsoEra.unmarshal(o as ##java.time.chrono.IsoEra), jxs)


    pub def getId(x: IsoChronology): String = 
        let IsoChronology(x1) = x;
        unsafe x1.getId()

}
