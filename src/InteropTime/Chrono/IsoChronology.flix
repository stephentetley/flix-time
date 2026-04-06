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

pub mod InteropTime.Chrono.IsoChronology {

    use InteropTime.Chrono.IsoChronology.IsoChronology
    use InteropTime.Chrono.IsoChronology.IsoChronology.{IsoChronology}
    use InteropTime.Chrono.IsoEra.IsoEra
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDate.LocalDate.{LocalDate}

    import java.time.chrono.{IsoChronology => JIsoChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        Era => JEra, 
        IsoEra => JIsoEra}
    import java.time.{LocalDate => JLocalDate}
    import java.util.{List => JList}


    pub enum IsoChronology(JIsoChronology)

    instance ToString[IsoChronology] {
        pub def toString(x: IsoChronology): String =
            let IsoChronology(x1) = x;
            unsafe IO { x1.toString() }
    }

    pub def getInstance(): IsoChronology \ IO = 
        IsoChronology(checked_ecast(JIsoChronology.INSTANCE))

    pub def getCalendarType(x: IsoChronology): String =
        let IsoChronology(x1) = x;
        unsafe IO { x1.getCalendarType() }

    pub def dateNow(x: IsoChronology): LocalDate \ IO = 
        let IsoChronology(x1) = x;
        let ans = x1.dateNow();
        LocalDate(ans)



    pub def eraOf(x: IsoChronology, i: Int32): IsoEra =
        let IsoChronology(x1) = x;
        let ans = unsafe IO { x1.eraOf(i) };
        InteropTime.Chrono.IsoEra.unmarshalIsoEra(ans)


    pub def eras(x: IsoChronology): List[IsoEra] =
        def convert(e) = {
            let e1: JIsoEra = unchecked_cast(e as JIsoEra);
            InteropTime.Chrono.IsoEra.unmarshalIsoEra(e1)
        };
        let IsoChronology(x1) = x;
        let jlist: JList[JEra] = unsafe IO { x1.eras() };
        let xs: List[JEra] = Adaptor.fromList(jlist);
        List.map(convert, xs)

    pub def getId(x: IsoChronology): String =
        let IsoChronology(x1) = x;
        unsafe IO { x1.getId() }

}
