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


pub mod InteropTime.Chrono.MinguoChronology {


    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Chrono.MinguoDate.MinguoDate
    use InteropTime.Chrono.MinguoDate.MinguoDate.{MinguoDate}
    use InteropTime.Chrono.MinguoEra.MinguoEra
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ClockZ.ClockZ.{ClockZ}
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneId.ZoneId.{ZoneId}

    import java.time.chrono.{MinguoChronology => JMinguoChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate,
        Era => JEra,
        MinguoDate => JMinguoDate, 
        MinguoEra => JMinguoEra}
    import java.util.{List => JList}

    pub enum MinguoChronology(JMinguoChronology)

    instance ToString[MinguoChronology] {
        pub def toString(x: MinguoChronology): String =
            let MinguoChronology.MinguoChronology(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance ToJava[MinguoChronology] {
        type Out = JMinguoChronology
        pub def toJava(x: MinguoChronology): JMinguoChronology = 
            let MinguoChronology.MinguoChronology(x1) = x;
            x1
    }

    instance ToFlix[MinguoChronology] {
        type In = JMinguoChronology
        pub def toFlix(x: JMinguoChronology): MinguoChronology = 
            MinguoChronology.MinguoChronology(x)
    }


    pub def getInstance(): MinguoChronology \ IO = 
        AdaptorExtras.of(() -> checked_ecast(JMinguoChronology.INSTANCE))

    pub def getCalendarType(x: MinguoChronology): String = 
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getCalendarType() })


    pub def dateNow(x: MinguoChronology): MinguoDate \ IO = 
        AdaptorExtras.op(x, x1 -> { x1.dateNow() })

    pub def dateNowWithClock(x: MinguoChronology, clock: ClockZ): MinguoDate \ IO =
        AdaptorExtras.op2(x, clock, (x1, clock1) -> { x1.dateNow(clock1) })


    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: MinguoChronology, zone: ZoneId): MinguoDate \ IO =
        AdaptorExtras.op2(x, zone, (x1, zone1) -> { x1.dateNow(zone1) })
                

    pub def eraOf(x: MinguoChronology, i: Int32): MinguoEra = 
        AdaptorExtras.op(x, x1 ->  unsafe IO { x1.eraOf(i) })

    pub def eras(x: MinguoChronology): List[MinguoEra] = 
        AdaptorExtras.extract(x, x1 -> {
            let jlist: JList[JEra] = unsafe IO { x1.eras() };
            AdaptorExtras.Collection.toList(jlist, e1 -> unchecked_cast(e1 as JMinguoEra) |> ToFlix.toFlix)
        })

}
