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

    use InteropTime.Chrono.MinguoChronology.MinguoChronology
    use InteropTime.Chrono.MinguoChronology.MinguoChronology.{MinguoChronology}

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
            let MinguoChronology(x1) = x;
            unsafe IO { x1.toString() }
    }


    pub def getInstance(): MinguoChronology \ IO = 
        MinguoChronology(checked_ecast(JMinguoChronology.INSTANCE))

    pub def getCalendarType(x: MinguoChronology): String = 
        let MinguoChronology(x1) = x;
        unsafe IO { x1.getCalendarType() }


    pub def dateNow(x: MinguoChronology): MinguoDate \ IO = 
        let MinguoChronology(x1) = x;
        let ans = x1.dateNow();
        MinguoDate(ans)

    pub def dateNowWithClock(x: MinguoChronology, clock: ClockZ): MinguoDate \ IO =
        let MinguoChronology(x1) = x;
        let ClockZ(clock1) = clock;
        let ans = x1.dateNow(clock1);
        MinguoDate(ans)


    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: MinguoChronology, zone: ZoneId): MinguoDate \ IO =
        let MinguoChronology(x1) = x;
        let ZoneId(zone1) = zone;
        let ans = x1.dateNow(zone1);        
        MinguoDate(ans)
                

    pub def eraOf(x: MinguoChronology, i: Int32): MinguoEra = 
        let MinguoChronology(x1) = x;
        let ans = unsafe IO { x1.eraOf(i) };
        InteropTime.Chrono.MinguoEra.unmarshalMinguoEra(ans)

    pub def eras(x: MinguoChronology): List[MinguoEra] = 
        def convert(e) = {
            let e1: JMinguoEra = unchecked_cast(e as JMinguoEra);
            InteropTime.Chrono.MinguoEra.unmarshalMinguoEra(e1)
        };
        let MinguoChronology(x1) = x;
        let jlist: JList[JEra] = unsafe IO { x1.eras() };
        let xs: List[JEra] = Adaptor.fromList(jlist);
        List.map(convert, xs)

}
