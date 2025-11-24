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

    use Time.Chrono.MinguoChronology
    use Time.Chrono.MinguoChronology.{MinguoChronology }

    import java.time.chrono.{MinguoChronology => JMinguoChronology }

    pub enum MinguoChronology(JMinguoChronology)

    instance ToString[MinguoChronology] {
        pub def toString(x: MinguoChronology): String =
            let MinguoChronology(x1) = x;
            unsafe IO { x1.toString() }
    }

}

mod Time.Chrono.MinguoChronology {

    use Time.Chrono.MinguoChronology
    use Time.Chrono.MinguoChronology.{MinguoChronology }
    use Time.Chrono.MinguoDate
    use Time.Chrono.MinguoDate.{MinguoDate }
    use Time.Chrono.MinguoEra
    use Time.Clock
    use Time.Clock.{Clock }
    use Time.ZoneId
    use Time.ZoneId.{ZoneId }

    import java.time.chrono.{MinguoChronology => JMinguoChronology }
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate,
        Era => JEra,
        MinguoDate => JMinguoDate, 
        MinguoEra => JMinguoEra }

    pub def getInstance(): MinguoChronology \ IO = 
        MinguoChronology(checked_ecast(JMinguoChronology.INSTANCE))

    pub def getCalendarType(x: MinguoChronology): String = 
        let MinguoChronology(x1) = x;
        unsafe IO { x1.getCalendarType() }


    pub def dateNow(x: MinguoChronology): MinguoDate \ IO = 
        let MinguoChronology(x1) = x;
        let d1 = x1.dateNow();
        let ans = unchecked_cast(d1 as JMinguoDate);
        MinguoDate(ans)

    pub def dateNowWithClock(x: MinguoChronology, clock: Clock): MinguoDate \ IO =
        let MinguoChronology(x1) = x;
        let Clock(clock1) = clock;
        let d1 = x1.dateNow(clock1);
        let ans = unchecked_cast(d1 as JMinguoDate);
        MinguoDate(ans)


    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: MinguoChronology, zone: ZoneId): MinguoDate \ IO =
        let MinguoChronology(x1) = x;
        let ZoneId(zone1) = zone;
        let d1 = x1.dateNow(zone1);
        let ans = unchecked_cast(d1 as JMinguoDate);
        MinguoDate(ans)
                

    pub def eraOf(x: MinguoChronology, i: Int32): MinguoEra = 
        let MinguoChronology(x1) = x;
        let e1 = unsafe IO { x1.eraOf(i) };
        let ans1 = unchecked_cast(e1 as JMinguoEra); 
        Time.Chrono.MinguoEra.unmarshalMinguoEra(ans1)

    pub def eras(x: MinguoChronology): List[MinguoEra] = 
        let MinguoChronology(x1) = x;
        let jlist = unsafe IO { x1.eras() };
        let xs: List[JMinguoEra] = Adaptor.fromList(jlist);
        List.map(Time.Chrono.MinguoEra.unmarshalMinguoEra, xs)

}
