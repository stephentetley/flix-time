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

pub mod InteropTime.Chrono.ThaiBuddhistChronology {

    
    use ae::AdaptorExtras.Collection
    use ae::AdaptorExtras.AdaptorUnchecked

    use InteropTime.Chrono.ThaiBuddhistDate.ThaiBuddhistDate
    use InteropTime.Chrono.ThaiBuddhistEra.ThaiBuddhistEra
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ZoneId.ZoneId

    import java.time.chrono.{ThaiBuddhistChronology => JThaiBuddhistChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate,
        Era => JEra,
        ThaiBuddhistDate => JThaiBuddhistDate, 
        ThaiBuddhistEra => JThaiBuddhistEra}
    import java.util.{Iterator => JIterator}
    import java.lang.{Exception => JException}

    pub eff ThaiBuddhistChronology {
        def dateNow(): ThaiBuddhistDate
        def dateNowWithClock(clock: ClockZ): ThaiBuddhistDate 
        def dateNowWithZoneId(zone: ZoneId): ThaiBuddhistDate
        def eraOf(i: Int32): ThaiBuddhistEra
        def eras(): List[ThaiBuddhistEra]
        def getCalendarType(): String
        def getId(): String
        def isLeapYear(prolepticYear: Int64): Bool
    }


    pub def handle(f: a -> b \ ef): a -> b \ (ef + IO - ThaiBuddhistChronology) = x -> 
        let jchrono = JThaiBuddhistChronology.INSTANCE;
        run {
            f(x)
        } with handler ThaiBuddhistChronology {
            
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
                let xs = Collection.toList(jiter, e1 -> unchecked_cast(e1 as JThaiBuddhistEra) |> ToFlix.toFlix);
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

    pub def runThaiBuddhistChronology(f: Unit -> a \ ef): a \ (ef + IO - ThaiBuddhistChronology) = 
        handle(f)()

    // pub def dateYearDay(x: ThaiBuddhistChronology, year: Int32, day: Int32): ThaiBuddhistDate =
    //     AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.dateYearDay(year, day) })
        
    // pub def dateYearDayWithEra(x: ThaiBuddhistChronology, era: ThaiBuddhistEra, year: Int32, day: Int32): ThaiBuddhistDate =
    //     AdaptorUnchecked.op2(x, era, (x1, era1) -> {
    //         let ans: JChronoLocalDate = unsafe IO { x1.dateYearDay(era1, year, day) };
    //         unchecked_cast(ans as JThaiBuddhistDate)
    //     })

    // pub def isIsoBased(x: ThaiBuddhistChronology): Bool =
    //     AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.isIsoBased() })

    // pub def isLeapYear(x: ThaiBuddhistChronology, year: Int64): Bool =
    //     AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.isLeapYear(year) })

    // pub def prolepticYear(x: ThaiBuddhistChronology, era: ThaiBuddhistEra, year: Int32): Int32 =
    //     AdaptorUnchecked.extract2(x, era, (x1, era1) -> unsafe IO { x1.prolepticYear(era1, year) })


}

