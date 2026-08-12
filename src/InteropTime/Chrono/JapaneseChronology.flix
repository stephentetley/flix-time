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

    
    use InteropTime.Internal.AdaptorExtras

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

    pub enum JapaneseChronology(JJapaneseChronology)

    instance ToString[JapaneseChronology] {
        pub def toString(x: JapaneseChronology): String =
            let JapaneseChronology(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance ToJava[JapaneseChronology] {
        type Out = JJapaneseChronology
        pub def toJava(x: JapaneseChronology): JJapaneseChronology = 
            let JapaneseChronology.JapaneseChronology(x1) = x;
            x1
    }

    instance ToFlix[JapaneseChronology] {
        type In = JJapaneseChronology
        pub def toFlix(x: JJapaneseChronology): JapaneseChronology = JapaneseChronology.JapaneseChronology(x)
    }



    pub def getInstance(): JapaneseChronology \ IO = 
        AdaptorExtras.of(() -> checked_ecast(JJapaneseChronology.INSTANCE))

    pub def getCalendarType(x: JapaneseChronology): String = 
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getCalendarType() })

    pub def dateNow(x: JapaneseChronology): JapaneseDate \ IO = 
        AdaptorExtras.op(x, x1 -> { x1.dateNow() })


    pub def dateNowWithClock(x: JapaneseChronology, clock: ClockZ): JapaneseDate \ IO =
        AdaptorExtras.op2(x, clock, (x1, clock1) -> { x1.dateNow(clock1) })

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: JapaneseChronology, zone: ZoneId): JapaneseDate \ IO =
        AdaptorExtras.op2(x, zone, (x1, zone1) -> { x1.dateNow(zone1) })

    pub def eraOf(x: JapaneseChronology, i: Int32): JapaneseEra = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.eraOf(i) })

    pub def eras(x: JapaneseChronology): List[JapaneseEra] = 
        AdaptorExtras.extract(x, x1 -> {
            let jiter: JIterator[JEra] = unsafe IO { let xs = x1.eras(); xs.iterator() };
            AdaptorExtras.Collection.toList(jiter, e1 -> unchecked_cast(e1 as JJapaneseEra) |> ToFlix.toFlix)
        })


}
