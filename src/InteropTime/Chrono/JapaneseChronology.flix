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


/// TODO should provide functions from the TemporalUnit interface

pub mod InteropTime.Chrono.JapaneseChronology {

    use JavaInterop.AdaptorExtras.Collection
    use JavaInterop.AdaptorUnchecked

    use InteropTime.Chrono.JapaneseDate.JapaneseDate
    use InteropTime.Chrono.JapaneseEra.JapaneseEra
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ZoneId.ZoneId

    import java.util.{List => JList}
    import java.time.chrono.{JapaneseChronology => JJapaneseChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate,
        Era => JEra,
        JapaneseDate => JJapaneseDate, 
        JapaneseEra => JJapaneseEra}
    import java.util.{Iterator => JIterator}

    pub eff JapaneseChronology {
        def dateNow(): JapaneseDate
        def dateNowWithClock(clock: ClockZ): JapaneseDate 
        def dateNowWithZoneId(zone: ZoneId): JapaneseDate
        def eraOf(i: Int32): JapaneseEra
        def eras(): List[JapaneseEra]
        def getCalendarType(): String
        def getId(): String
        def isLeapYear(prolepticYear: Int64): Bool
    }
    
    pub def handle(f: a -> b \ ef): a -> b \ (ef + IO - JapaneseChronology) = x -> 
        let jchrono = JJapaneseChronology.INSTANCE;
        run {
            f(x)
        } with handler JapaneseChronology {
            
            def dateNow(k) = {
                let d1 = jchrono.dateNow();
                k(ToFlix.toFlix(d1))
            }
            
            def dateNowWithClock(clock, k) = {
                let clock1 = ToJava.toJava(clock);
                let d1 = jchrono.dateNow(clock1);
                k(ToFlix.toFlix(d1))
            }

            def dateNowWithZoneId(zone, k) = {
                let zone1 = ToJava.toJava(zone);
                let d1 = jchrono.dateNow(zone1);
                k(ToFlix.toFlix(d1))
            }

            def eraOf(i, k) = {
                let ans = jchrono.eraOf(i);
                k(ToFlix.toFlix(ans))
            }

            def eras(k) = {
                let jiter: JIterator[JEra] = unsafe IO { let xs = jchrono.eras(); xs.iterator() };
                let xs = Collection.toList(jiter, e1 -> unchecked_cast(e1 as JJapaneseEra) |> ToFlix.toFlix);
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

    pub def runJapaneseChronology(f: Unit -> a \ ef): a \ (ef + IO - JapaneseChronology) = 
        handle(f)()


}

