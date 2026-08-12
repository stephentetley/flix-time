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

    
    use InteropTime.Internal.AdaptorExtras

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

    pub enum ThaiBuddhistChronology(JThaiBuddhistChronology)

    instance ToString[ThaiBuddhistChronology] {
        pub def toString(x: ThaiBuddhistChronology): String =
            let ThaiBuddhistChronology.ThaiBuddhistChronology(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance ToJava[ThaiBuddhistChronology] {
        type Out = JThaiBuddhistChronology
        pub def toJava(x: ThaiBuddhistChronology): JThaiBuddhistChronology = 
            let ThaiBuddhistChronology.ThaiBuddhistChronology(x1) = x;
            x1
    }

    instance ToFlix[ThaiBuddhistChronology] {
        type In = JThaiBuddhistChronology
        pub def toFlix(x: JThaiBuddhistChronology): ThaiBuddhistChronology = ThaiBuddhistChronology.ThaiBuddhistChronology(x)
    }

    pub def getInstance(): ThaiBuddhistChronology \ IO = 
        AdaptorExtras.of(() -> checked_ecast(JThaiBuddhistChronology.INSTANCE))

    pub def getCalendarType(x: ThaiBuddhistChronology): String  = 
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getCalendarType() })

    pub def dateNow(x: ThaiBuddhistChronology): ThaiBuddhistDate \ IO = 
        AdaptorExtras.op(x, x1 -> { x1.dateNow() })

    pub def dateNowWithClock(x: ThaiBuddhistChronology, clock: ClockZ): ThaiBuddhistDate \ IO =
        AdaptorExtras.op2(x, clock, (x1, clock1) -> { x1.dateNow(clock1) })

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: ThaiBuddhistChronology, zone: ZoneId): ThaiBuddhistDate \ IO =
        AdaptorExtras.op2(x, zone, (x1, zone1) -> { x1.dateNow(zone1) })

    pub def dateYearDay(x: ThaiBuddhistChronology, year: Int32, day: Int32): ThaiBuddhistDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.dateYearDay(year, day) })
        
    pub def dateYearDayWithEra(x: ThaiBuddhistChronology, era: ThaiBuddhistEra, year: Int32, day: Int32): ThaiBuddhistDate =
        AdaptorExtras.op2(x, era, (x1, era1) -> {
            let ans: JChronoLocalDate = unsafe IO { x1.dateYearDay(era1, year, day) };
            unchecked_cast(ans as JThaiBuddhistDate)
        })

    // Todo Result[]
    pub def eraOf(x: ThaiBuddhistChronology, i: Int32): Result[String, ThaiBuddhistEra] = 
        AdaptorExtras.opWithResult(x, x1 -> unsafe IO { x1.eraOf(i) })

    pub def eras(x: ThaiBuddhistChronology): List[ThaiBuddhistEra] = 
        AdaptorExtras.extract(x, x1 -> {
            let jiter: JIterator[JEra] = unsafe IO { let xs = x1.eras(); xs.iterator() };
            AdaptorExtras.Collection.toList(jiter, e1 -> unchecked_cast(e1 as JThaiBuddhistEra) |> ToFlix.toFlix)
        })

    pub def isIsoBased(x: ThaiBuddhistChronology): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isIsoBased() })

    pub def isLeapYear(x: ThaiBuddhistChronology, year: Int64): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isLeapYear(year) })

    pub def prolepticYear(x: ThaiBuddhistChronology, era: ThaiBuddhistEra, year: Int32): Int32 =
        AdaptorExtras.extract2(x, era, (x1, era1) -> unsafe IO { x1.prolepticYear(era1, year) })


}

