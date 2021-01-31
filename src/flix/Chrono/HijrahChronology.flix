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

    pub opaque type HijrahChronology = ##java.time.chrono.HijrahChronology

}


namespace Time/Chrono/HijrahChronology {

    use Time/Chrono.HijrahChronology;
    use Time/Chrono.HijrahChronology.{HijrahChronology};
    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.HijrahEra;

    pub def getInstance(): HijrahChronology & Impure =
        import get java.time.chrono.HijrahChronology:INSTANCE as getINSTANCE;
        HijrahChronology(getINSTANCE())

    pub def date(x: HijrahChronology, r: {prolepticYear: Int32, month: Int32, dayOfMonth: Int32}): HijrahDate = 
        import java.time.chrono.HijrahChronology.date(Int32, Int32, Int32);
        let HijrahChronology(x1) = x;
        HijrahDate(date(x1, r.prolepticYear, r.month, r.dayOfMonth) as & Pure)

    pub def dateWithEra(x: HijrahChronology, r: {era: HijrahEra, yearOfEra: Int32, month: Int32, dayOfMonth: Int32}): HijrahDate = 
        import java.time.chrono.HijrahChronology.date(##java.time.chrono.Era, Int32, Int32, Int32);
        let HijrahChronology(x1) = x;
        let era1 = Time/Chrono/HijrahEra.marshal(r.era) as ##java.time.chrono.Era;
        HijrahDate(date(x1, era1, r.yearOfEra, r.month, r.dayOfMonth) as & Pure)


    pub def dateNow(x: HijrahChronology): HijrahDate & Impure = 
        import java.time.chrono.HijrahChronology.dateNow();
        let HijrahChronology(x1) = x;
        HijrahDate(dateNow(x1))

    pub def dateEpochDay(x: HijrahChronology, epochDay: Int64): HijrahDate = 
        import java.time.chrono.HijrahChronology.dateEpochDay(Int64);
        let HijrahChronology(x1) = x;
        HijrahDate(dateEpochDay(x1, epochDay) as & Pure)

    pub def getCalendarType(x: HijrahChronology): String = 
        import java.time.chrono.HijrahChronology.getCalendarType();
        let HijrahChronology(x1) = x;
        getCalendarType(x1) as & Pure

    pub def eraOf(x: HijrahChronology, i: Int32): HijrahEra = 
        import java.time.chrono.HijrahChronology.eraOf(Int32);
        use Time/Chrono/HijrahEra.{unmarshal};
        let HijrahChronology(x1) = x;
        unmarshal(eraOf(x1, i) as & Pure)

    /// pub def getId(x: HijrahChronology): String = 
    ///     import java.time.chrono.HijrahChronology.getId();
    ///     let HijrahChronology(x1) = x;
    ///     getId(x1) as & Pure

}
