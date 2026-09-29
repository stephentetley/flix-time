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

    use ae::JavaInterop.AdaptorExtras.Collection
    use ae::JavaInterop.AdaptorUnchecked

    use InteropTime.Chrono.IsoEra.IsoEra
    use InteropTime.LocalDate.LocalDate
    
    import java.time.chrono.{IsoChronology => JIsoChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        Era => JEra, 
        IsoEra => JIsoEra}
    import java.time.{LocalDate => JLocalDate}
    import java.util.{Iterator => JIterator}


    pub eff IsoChronology {
        def dateNow(): LocalDate
        def eraOf(i: Int32): IsoEra
        def eras(): List[IsoEra]
        def getCalendarType(): String
        def getId(): String
        def isLeapYear(prolepticYear: Int64): Bool
    }

    pub def handle(f: a -> b \ ef): a -> b \ (ef + IO - IsoChronology) = x -> 
        let jchrono = JIsoChronology.INSTANCE;
        run {
            f(x)
        } with handler IsoChronology {
            
            def dateNow(k) = {
                let d1 = jchrono.dateNow();
                k(ToFlix.toFlix(d1))
            }

            def eraOf(i, k) = {
                let ans = jchrono.eraOf(i);
                k(ToFlix.toFlix(ans))
            }

            def eras(k) = {
                let jiter: JIterator[JEra] = unsafe IO { let xs = jchrono.eras(); xs.iterator() };
                let xs = Collection.toList(jiter, e1 -> unchecked_cast(e1 as JIsoEra) |> ToFlix.toFlix);
                k(xs)
            }

            def getCalendarType(k) = {
                let ans = jchrono.getCalendarType();
                k(ans)
            }

            def getId(k) = {
                let ans = jchrono.getId();
                k(ans)
            }

            def isLeapYear(prolepticYear, k) = {
                let ans = jchrono.isLeapYear(prolepticYear);
                k(ans)
            }


        }

    pub def runIsoChronology(f: Unit -> a \ ef): a \ (ef + IO - IsoChronology) = 
        handle(f)()


}

