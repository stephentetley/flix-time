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

    pub enum IsoChronology(##java.time.chrono.IsoChronology)
    
    instance ToString[IsoChronology] {
        pub def toString(x: IsoChronology): String =
            import java.time.chrono.AbstractChronology.toString(): String \ {};
            let IsoChronology(x1) = x;
            toString(unsafe_cast x1 as ##java.time.chrono.AbstractChronology)
    }

    instance Interop/Flix.Marshal[IsoChronology] {
        pub def toJavaObject(x: IsoChronology): ##java.lang.Object =
            let IsoChronology(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): IsoChronology = 
            IsoChronology(unsafe_cast o as ##java.time.chrono.IsoChronology)
    }

}

namespace Time/Chrono/IsoChronology {

    use Time/Chrono.IsoChronology;
    use Time/Chrono.IsoChronology.{IsoChronology};    
    use Time/Chrono.IsoEra;
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    pub def getInstance(): IsoChronology \ IO = 
        import static get java.time.chrono.IsoChronology.INSTANCE: ##java.time.chrono.IsoChronology \ IO as get_INSTANCE;
        IsoChronology(get_INSTANCE())

    pub def getCalendarType(x: IsoChronology): String = 
        import java.time.chrono.IsoChronology.getCalendarType(): String \ {};
        let IsoChronology(x1) = x;
        getCalendarType(x1)

    pub def dateNow(x: IsoChronology): LocalDate \ IO = 
        import java.time.chrono.IsoChronology.dateNow(): ##java.time.LocalDate \ IO;
        let IsoChronology(x1) = x;
        LocalDate(dateNow(x1))

    pub def eraOf(x: IsoChronology, i: Int32): IsoEra = 
        import java.time.chrono.IsoChronology.eraOf(Int32): ##java.time.chrono.IsoEra \ {};
        let IsoChronology(x1) = x;
        Time/Chrono/IsoEra.unmarshal(eraOf(x1, i))

    /// pub def eras(x: IsoChronology): List[IsoEra] = 
    ///     import java.time.chrono.IsoChronology.eras(): ##java.util.List \ {};
    ///     let IsoChronology(x1) = x;
    ///     let jxs = eras(x1);
    ///     Interop/Collections/... .unmarshalList(o -> Time/Chrono/IsoEra.unmarshal(o as ##java.time.chrono.IsoEra), jxs)


    pub def getId(x: IsoChronology): String = 
        import java.time.chrono.IsoChronology.getId(): String \ {};
        let IsoChronology(x1) = x;
        getId(x1)

}
