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

namespace Time/Chrono {

    pub enum MinguoChronology(##java.time.chrono.MinguoChronology)

    instance ToString[MinguoChronology] {
        pub def toString(x: MinguoChronology): String =
            import java.time.chrono.AbstractChronology.toString(): String \ {};
            let MinguoChronology(x1) = x;
            toString(unchecked_cast(x1 as ##java.time.chrono.AbstractChronology))
    }

}

namespace Time/Chrono/MinguoChronology {

    use Time/Chrono.MinguoChronology;
    use Time/Chrono.MinguoChronology.{MinguoChronology};
    use Time/Chrono.MinguoDate;
    use Time/Chrono.MinguoDate.{MinguoDate};
    use Time/Chrono.MinguoEra;
    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def getInstance(): MinguoChronology \ IO = 
        import static get java.time.chrono.MinguoChronology.INSTANCE: ##java.time.chrono.MinguoChronology \ IO as getINSTANCE;
        MinguoChronology(getINSTANCE())

    pub def getCalendarType(x: MinguoChronology): String = 
        import java.time.chrono.MinguoChronology.getCalendarType(): String \ {};
        let MinguoChronology(x1) = x;
        getCalendarType(x1)


    pub def dateNow(x: MinguoChronology): MinguoDate \ IO = 
        import java.time.chrono.MinguoChronology.dateNow(): ##java.time.chrono.MinguoDate \ IO;
        let MinguoChronology(x1) = x;
        MinguoDate(dateNow(x1))

    pub def dateNowWithClock(x: MinguoChronology, clock: Clock): MinguoDate \ IO =
        import java.time.chrono.MinguoChronology.dateNow(##java.time.Clock): ##java.time.chrono.MinguoDate \ IO;
        let MinguoChronology(x1) = x;
        let Clock(clock1) = clock;
        MinguoDate(dateNow(x1, clock1))

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: MinguoChronology, zone: ZoneId): MinguoDate \ IO =
        import java.time.chrono.MinguoChronology.dateNow(##java.time.ZoneId): ##java.time.chrono.MinguoDate \ IO;
        let MinguoChronology(x1) = x;
        let ZoneId(zone1) = zone;
        MinguoDate(dateNow(x1, zone1))

    pub def eraOf(x: MinguoChronology, i: Int32): MinguoEra = 
        import java.time.chrono.MinguoChronology.eraOf(Int32): ##java.time.chrono.MinguoEra \ {};
        let MinguoChronology(x1) = x;
        Time/Chrono/MinguoEra.unmarshal(eraOf(x1, i))

}
