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

    use Time.Chrono.ThaiBuddhistChronology
    use Time.Chrono.ThaiBuddhistChronology.{ThaiBuddhistChronology}

    import java.time.chrono.{ThaiBuddhistChronology => JThaiBuddhistChronology}

    pub enum ThaiBuddhistChronology(JThaiBuddhistChronology)

    instance ToString[ThaiBuddhistChronology] {
        pub def toString(x: ThaiBuddhistChronology): String =
            let ThaiBuddhistChronology(x1) = x;
            unsafe x1.toString()
    }
}

mod Time.Chrono.ThaiBuddhistChronology {

    use Time.Chrono.ThaiBuddhistChronology
    use Time.Chrono.ThaiBuddhistChronology.{ThaiBuddhistChronology}
    use Time.Chrono.ThaiBuddhistDate
    use Time.Chrono.ThaiBuddhistDate.{ThaiBuddhistDate}
    use Time.Chrono.ThaiBuddhistEra
    use Time.Clock
    use Time.Clock.{Clock}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    import java.time.chrono.{ThaiBuddhistChronology => JThaiBuddhistChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate,
        Era => JEra,
        ThaiBuddhistDate => JThaiBuddhistDate, 
        ThaiBuddhistEra => JThaiBuddhistEra}

    pub def getInstance(): ThaiBuddhistChronology \ IO = 
        ThaiBuddhistChronology(JThaiBuddhistChronology.INSTANCE)

    pub def getCalendarType(x: ThaiBuddhistChronology): String  = 
        let ThaiBuddhistChronology(x1) = x;
        unsafe x1.getCalendarType()

    pub def dateNow(x: ThaiBuddhistChronology): ThaiBuddhistDate \ IO = 
        let ThaiBuddhistChronology(x1) = x;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JChronoLocalDate = cx1.dateNow();
        let ans1 = unchecked_cast(ans as JThaiBuddhistDate);
        ThaiBuddhistDate(ans1)

    pub def dateNowWithClock(x: ThaiBuddhistChronology, clock: Clock): ThaiBuddhistDate \ IO =
        let ThaiBuddhistChronology(x1) = x;
        let Clock(clock1) = clock;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JChronoLocalDate = cx1.dateNow(clock1);
        let ans1 = unchecked_cast(ans as JThaiBuddhistDate);
        ThaiBuddhistDate(ans1)

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: ThaiBuddhistChronology, zone: ZoneId): ThaiBuddhistDate \ IO =
        let ThaiBuddhistChronology(x1) = x;
        let ZoneId(zone1) = zone;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JChronoLocalDate = cx1.dateNow(zone1);
        let ans1 = unchecked_cast(ans as JThaiBuddhistDate);
        ThaiBuddhistDate(ans1)

    // Todo Result[]
    pub def eraOf(x: ThaiBuddhistChronology, i: Int32): ThaiBuddhistEra = 
        let ThaiBuddhistChronology(x1) = x;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JEra = unsafe cx1.eraOf(i);
        let ans1 = unchecked_cast(ans as JThaiBuddhistEra); 
        Time.Chrono.ThaiBuddhistEra.unmarshalThaiBuddhistEra(ans1)

}
