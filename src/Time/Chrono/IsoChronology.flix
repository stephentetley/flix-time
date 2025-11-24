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
            unsafe IO { x1.toString() }
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
        IsoChronology(checked_ecast(JIsoChronology.INSTANCE))

    pub def getCalendarType(x: IsoChronology): String =
        let IsoChronology(x1) = x;
        unsafe IO { x1.getCalendarType() }

    pub def dateNow(x: IsoChronology): LocalDate \ IO = 
        let IsoChronology(x1) = x;
        let d1 = x1.dateNow();
        let ans = unchecked_cast(d1 as JLocalDate);
        LocalDate(ans)



    pub def eraOf(x: IsoChronology, i: Int32): IsoEra =
        let IsoChronology(x1) = x;
        let e1 = unsafe IO { x1.eraOf(i) };
        let ans = unchecked_cast(e1 as JIsoEra);
        Time.Chrono.IsoEra.unmarshalIsoEra(ans)


    pub def eras(x: IsoChronology): List[IsoEra] =
        let IsoChronology(x1) = x;
        let jlist = unsafe IO { x1.eras() };
        let xs: List[JIsoEra] = Adaptor.fromList(jlist);
        List.map(Time.Chrono.IsoEra.unmarshalIsoEra, xs)

    pub def getId(x: IsoChronology): String =
        let IsoChronology(x1) = x;
        unsafe IO { x1.getId() }

}
