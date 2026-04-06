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

    use InteropTime.Chrono.JapaneseChronology.JapaneseChronology
    use InteropTime.Chrono.JapaneseChronology.JapaneseChronology.{JapaneseChronology}

    use InteropTime.Chrono.JapaneseDate.JapaneseDate
    use InteropTime.Chrono.JapaneseDate.JapaneseDate.{JapaneseDate}
    use InteropTime.Chrono.JapaneseEra.JapaneseEra
    use InteropTime.Chrono.JapaneseEra.JapaneseEra.{JapaneseEra}
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ClockZ.ClockZ.{ClockZ}
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneId.ZoneId.{ZoneId}

    import java.util.{List => JList}
    import java.time.chrono.{JapaneseChronology => JJapaneseChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate,
        Era => JEra,
        JapaneseDate => JJapaneseDate, 
        JapaneseEra => JJapaneseEra}
    import java.util.{List => JList}

    pub enum JapaneseChronology(JJapaneseChronology)

    instance ToString[JapaneseChronology] {
        pub def toString(x: JapaneseChronology): String =
            let JapaneseChronology(x1) = x;
            unsafe IO { x1.toString() }
    }


    pub def getInstance(): JapaneseChronology \ IO = 
        JapaneseChronology(checked_ecast(JJapaneseChronology.INSTANCE))

    pub def getCalendarType(x: JapaneseChronology): String = 
        let JapaneseChronology(x1) = x;
        unsafe IO { x1.getCalendarType() }

    pub def dateNow(x: JapaneseChronology): JapaneseDate \ IO = 
        let JapaneseChronology(x1) = x;
        let ans = x1.dateNow();
        JapaneseDate(ans)


    pub def dateNowWithClock(x: JapaneseChronology, clock: ClockZ): JapaneseDate \ IO =
        let JapaneseChronology(x1) = x;
        let ClockZ(clock1) = clock;
        let ans = x1.dateNow(clock1);
        JapaneseDate(ans)

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: JapaneseChronology, zone: ZoneId): JapaneseDate \ IO =
        let JapaneseChronology(x1) = x;
        let ZoneId(zone1) = zone;
        let ans = x1.dateNow(zone1);
        JapaneseDate(ans)

    pub def eraOf(x: JapaneseChronology, i: Int32): JapaneseEra = 
        let JapaneseChronology(x1) = x;
        let ans = unsafe IO { x1.eraOf(i) };
        JapaneseEra(ans)

    pub def eras(x: JapaneseChronology): List[JapaneseEra] = 
        def convert(e) = {
            let e1: JJapaneseEra = unchecked_cast(e as JJapaneseEra);
            JapaneseEra.JapaneseEra(e1)
        };
        let JapaneseChronology(x1) = x;
        let jlist: JList[JEra] = unsafe IO { x1.eras() };
        let xs: List[JEra] = Adaptor.fromList(jlist);
        List.map(convert, xs)

}
