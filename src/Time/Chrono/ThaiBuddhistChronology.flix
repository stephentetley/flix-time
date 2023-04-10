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

    pub enum ThaiBuddhistChronology(##java.time.chrono.ThaiBuddhistChronology)

    instance ToString[ThaiBuddhistChronology] {
        pub def toString(x: ThaiBuddhistChronology): String =
            import java.time.chrono.AbstractChronology.toString(): String \ {};
            let ThaiBuddhistChronology(x1) = x;
            toString(unchecked_cast(x1 as ##java.time.chrono.AbstractChronology))
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

    pub def getInstance(): ThaiBuddhistChronology \ IO = 
        import static get java.time.chrono.ThaiBuddhistChronology.INSTANCE: ##java.time.chrono.ThaiBuddhistChronology \ IO as getINSTANCE;
        ThaiBuddhistChronology(getINSTANCE())

    pub def getCalendarType(x: ThaiBuddhistChronology): String  = 
        import java.time.chrono.ThaiBuddhistChronology.getCalendarType(): String \ {};
        let ThaiBuddhistChronology(x1) = x;
        getCalendarType(x1)

    pub def dateNow(x: ThaiBuddhistChronology): ThaiBuddhistDate \ IO = 
        import java.time.chrono.ThaiBuddhistChronology.dateNow(): ##java.time.chrono.ThaiBuddhistDate \ IO;
        let ThaiBuddhistChronology(x1) = x;
        ThaiBuddhistDate(dateNow(x1))

    pub def dateNowWithClock(x: ThaiBuddhistChronology, clock: Clock): ThaiBuddhistDate \ IO =
        import java.time.chrono.ThaiBuddhistChronology.dateNow(##java.time.Clock): ##java.time.chrono.ThaiBuddhistDate \ IO;
        let ThaiBuddhistChronology(x1) = x;
        let Clock(clock1) = clock;
        ThaiBuddhistDate(dateNow(x1, clock1))

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: ThaiBuddhistChronology, zone: ZoneId): ThaiBuddhistDate \ IO =
        import java.time.chrono.ThaiBuddhistChronology.dateNow(##java.time.ZoneId): ##java.time.chrono.ThaiBuddhistDate \ IO;
        let ThaiBuddhistChronology(x1) = x;
        let ZoneId(zone1) = zone;
        ThaiBuddhistDate(dateNow(x1, zone1))

    pub def eraOf(x: ThaiBuddhistChronology, i: Int32): ThaiBuddhistEra = 
        import java.time.chrono.ThaiBuddhistChronology.eraOf(Int32): ##java.time.chrono.ThaiBuddhistEra \ {};
        let ThaiBuddhistChronology(x1) = x;
        Time.Chrono.ThaiBuddhistEra.unmarshal(eraOf(x1, i))

}
