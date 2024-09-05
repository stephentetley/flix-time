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

    use Time.Chrono.HijrahChronology
    use Time.Chrono.HijrahChronology.{HijrahChronology}

    import java.time.chrono.{HijrahChronology => JHijrahChronology}

    pub enum HijrahChronology(JHijrahChronology)

    instance ToString[HijrahChronology] {
        pub def toString(x: HijrahChronology): String =
            Time.Chrono.HijrahChronology.toString(x)
    }


}


mod Time.Chrono.HijrahChronology {

    use Time.Chrono.HijrahChronology
    use Time.Chrono.HijrahChronology.{HijrahChronology}
    use Time.Chrono.HijrahDate
    use Time.Chrono.HijrahDate.{HijrahDate}
    use Time.Chrono.HijrahEra
    use Time.Chrono.Era.{Era}
    use Time.Format.ResolverStyle
    use Time.Format.TextStyle
    use Time.Clock
    use Time.Clock.{Clock}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.Internal.Chrono.AbstractChronology
    use Time.Internal.Chrono.AbstractChronology.{AbstractChronology}
    use Time.Internal.Chrono.Chronology
    use Time.Internal.Chrono.Chronology.{Chronology}

    import java.time.chrono.{HijrahChronology => JHijrahChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        HijrahDate => JHijrahDate,
        Era => JEra, 
        HijrahEra => JHijrahEra}

    pub def getHijrahChronology(x: HijrahChronology): JHijrahChronology = 
        let HijrahChronology(x1) = x;
        x1

    // pub def fromJavaObject(o: ##java.lang.Object): HijrahChronology = 
    //     HijrahChronology(unchecked_cast(o as ##java.time.chrono.HijrahChronology))


    // pub def asAbstractChronology(x: HijrahChronology): AbstractChronology = 
    //     let HijrahChronology(x1) = x;
    //     AbstractChronology(unchecked_cast(x1 as ##java.time.chrono.AbstractChronology))

    // pub def asChronology(x: HijrahChronology): Chronology = 
    //     let HijrahChronology(x1) = x;
    //     Chronology(unchecked_cast(x1 as ##java.time.chrono.Chronology))

    pub def getInstance(): HijrahChronology \ IO =
        HijrahChronology(JHijrahChronology.INSTANCE)

    // pub def date(r: {prolepticYear = Int32, month = Int32, dayOfMonth = Int32}, 
    //              x: HijrahChronology): HijrahDate =
    //     import java.time.chrono.HijrahChronology.date(Int32, Int32, Int32): ##java.time.chrono.HijrahDate \ {};
    //     let HijrahChronology(x1) = x;
    //     HijrahDate(unsafe x1.date(r#prolepticYear, r#month, r#dayOfMonth))

    pub def dateWithEra(r: {era = HijrahEra, yearOfEra = Int32, month = Int32, dayOfMonth = Int32}, 
                        x: HijrahChronology): HijrahDate =
        let HijrahChronology(x1) = x;
        let cx1 = (checked_cast(x1): JChronology);
        let era1 = Time.Chrono.HijrahEra.marshalHijrahEra(r#era);
        let ans : JChronoLocalDate = unsafe cx1.date(era1, r#yearOfEra, r#month, r#dayOfMonth);
        let ans1 = unchecked_cast(ans as JHijrahDate);
        HijrahDate(ans1)


    pub def dateNow(x: HijrahChronology): HijrahDate \ IO = 
        let HijrahChronology(x1) = x;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JChronoLocalDate = cx1.dateNow();
        let ans1 = unchecked_cast(ans as JHijrahDate);
        HijrahDate(ans1)

    pub def dateNowWithClock(x: HijrahChronology, clock: Clock): HijrahDate \ IO =
        let HijrahChronology(x1) = x;
        let Clock(clock1) = clock;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JChronoLocalDate = cx1.dateNow(clock1);
        let ans1 = unchecked_cast(ans as JHijrahDate);
        HijrahDate(ans1)

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: HijrahChronology, zone: ZoneId): HijrahDate \ IO =
        let HijrahChronology(x1) = x;
        let ZoneId(zone1) = zone;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JChronoLocalDate = cx1.dateNow(zone1);
        let ans1 = unchecked_cast(ans as JHijrahDate);
        HijrahDate(ans1)

    pub def dateEpochDay(x: HijrahChronology, epochDay: Int64): Result[String, HijrahDate] = 
        Result.tryCatch(_ -> {
            let HijrahChronology(x1) = x;
            let cx1 = (checked_cast(x1): JChronology);
            let ans : JChronoLocalDate = unsafe cx1.dateEpochDay(epochDay);
            let ans1 = unchecked_cast(ans as JHijrahDate);
            HijrahDate(ans1)
        })

    pub def toString(x: HijrahChronology): String =
        let HijrahChronology(x1) = x;
        unsafe x1.toString()
            

    pub def getDisplayName(style: TextStyle, loc: Locale, x: HijrahChronology): String = 
        let HijrahChronology(x1) = x;
        let s1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale.Locale(loc1) = loc;
        unsafe x1.getDisplayName(s1, loc1)


    pub def getCalendarType(x: HijrahChronology): String = 
        let HijrahChronology(x1) = x;
        unsafe x1.getCalendarType()

    pub def eraOf(x: HijrahChronology, i: Int32): HijrahEra = 
        let HijrahChronology(x1) = x;
        let cx1 = (checked_cast(x1): JChronology);
        let ans : JEra = unsafe cx1.eraOf(i);
        let ans1 = unchecked_cast(ans as JHijrahEra); 
        Time.Chrono.HijrahEra.unmarshalHijrahEra(ans1)

    // pub def eras(hc: HijrahChronology): List[HijrahEra] =
    //     import java.time.chrono.HijrahChronology.eras(): ##java.util.List \ {};
    //     let HijrahChronology(hc1) = hc;
    //     let eras1: List[##java.time.chrono.HijrahEra] = eras(hc1) |> Adaptor.fromList;
    //     List.map(Time.Chrono.HijrahEra.unmarshalHijrahEra, eras1)


    pub def getId(x: HijrahChronology): String = 
        let HijrahChronology(x1) = x;
        unsafe x1.getId()
        
    pub def isLeapYear(prolepticYear: Int64, x: HijrahChronology): Bool = 
        let HijrahChronology(x1) = x;
        unsafe x1.isLeapYear(prolepticYear)

    
    pub def prolepticYear(era: HijrahEra, yearOfEra: Int32, x: HijrahChronology): Int32 = 
        let HijrahChronology(x1) = x;
        let era1 = Time.Chrono.HijrahEra.marshalHijrahEra(era);
        unsafe x1.prolepticYear(era1, yearOfEra)


    // pub def resolveDate(fieldValues: List[(a, Int64)], resolverStyle: ResolverStyle, x: HijrahChronology): HijrahDate with TemporalField[a] =
    //     import java.time.chrono.HijrahChronology.resolveDate(##java.util.Map, ##java.time.format.ResolverStyle): ##java.time.chrono.HijrahDate \ {};
    //     let x1 = getHijrahChronology(x);
    //     let resolverStyle1 = Time.Format.ResolverStyle.marshal(resolverStyle);
    //     let upcastKey = field -> Time.Temporal.TemporalField.marshalToNativeTemporalField(field) as ##java.lang.Object;
    //     let upcastVal = i -> Interop.Collections/... /Marshal.marshalInt64(i) as ##java.lang.Object;
    //     let fieldValues1 = Interop.Collections/... /Marshal.marshalAssocListToMap(upcastKey, upcastVal, fieldValues);
    //     HijrahDate(resolveDate(x1, fieldValues1, resolverStyle1))

}
