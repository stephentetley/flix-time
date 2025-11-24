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

    use Time.Chrono.JapaneseChronology
    use Time.Chrono.JapaneseChronology.{JapaneseChronology }

    import java.time.chrono.{JapaneseChronology => JJapaneseChronology }

    pub enum JapaneseChronology(JJapaneseChronology)

    instance ToString[JapaneseChronology] {
        pub def toString(x: JapaneseChronology): String =
            let JapaneseChronology(x1) = x;
            unsafe IO { x1.toString() }
    }

}

/// TODO should provide functions from the TemporalUnit interface

mod Time.Chrono.JapaneseChronology {

    use Time.Chrono.JapaneseChronology
    use Time.Chrono.JapaneseChronology.{JapaneseChronology }
    use Time.Chrono.JapaneseDate
    use Time.Chrono.JapaneseDate.{JapaneseDate }
    use Time.Chrono.JapaneseEra
    use Time.Chrono.JapaneseEra.{JapaneseEra }
    use Time.Clock
    use Time.Clock.{Clock }
    use Time.ZoneId
    use Time.ZoneId.{ZoneId }


    import java.time.chrono.{JapaneseChronology => JJapaneseChronology }
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate,
        Era => JEra,
        JapaneseDate => JJapaneseDate, 
        JapaneseEra => JJapaneseEra }

    pub def getInstance(): JapaneseChronology \ IO = 
        JapaneseChronology(checked_ecast(JJapaneseChronology.INSTANCE))

    pub def getCalendarType(x: JapaneseChronology): String = 
        let JapaneseChronology(x1) = x;
        unsafe IO { x1.getCalendarType() }

    pub def dateNow(x: JapaneseChronology): JapaneseDate \ IO = 
        let JapaneseChronology(x1) = x;
        let d1 = x1.dateNow();
        let ans = unchecked_cast(d1 as JJapaneseDate);
        JapaneseDate(ans)


    pub def dateNowWithClock(x: JapaneseChronology, clock: Clock): JapaneseDate \ IO =
        let JapaneseChronology(x1) = x;
        let Clock(clock1) = clock;
        let d1 = x1.dateNow(clock1);
        let ans = unchecked_cast(d1 as JJapaneseDate);
        JapaneseDate(ans)

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: JapaneseChronology, zone: ZoneId): JapaneseDate \ IO =
        let JapaneseChronology(x1) = x;
        let ZoneId(zone1) = zone;
        let d1 = x1.dateNow(zone1);
        let ans = unchecked_cast(d1 as JJapaneseDate);
        JapaneseDate(ans)

    pub def eraOf(x: JapaneseChronology, i: Int32): JapaneseEra = 
        let JapaneseChronology(x1) = x;
        let e1 = unsafe IO { x1.eraOf(i) };
        let ans = unchecked_cast(e1 as JJapaneseEra);
        JapaneseEra(ans)

    pub def eras(x: JapaneseChronology): List[JapaneseEra] = 
        let JapaneseChronology(x1) = x;
        let jlist = unsafe IO { x1.eras() };
        let xs: List[JJapaneseEra] = Adaptor.fromList(jlist);
        List.map(z -> JapaneseEra(z), xs)

}
