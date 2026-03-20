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



pub mod InteropTime.Chrono.HijrahChronology {

    use InteropTime.Chrono.HijrahChronology.HijrahChronology
    use InteropTime.Chrono.HijrahChronology.HijrahChronology.{HijrahChronology}

    use InteropTime.Chrono.HijrahDate.HijrahDate
    use InteropTime.Chrono.HijrahDate.HijrahDate.{HijrahDate}
    use InteropTime.Chrono.HijrahEra.HijrahEra
    use InteropTime.Format.ResolverStyle.ResolverStyle
    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.Temporal.ValueRange.ValueRange
    use InteropTime.Temporal.ValueRange.ValueRange.{ValueRange}
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ClockZ.ClockZ.{ClockZ}
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneId.ZoneId.{ZoneId}

    use InteropLocale.Locale.Locale

    import java.time.chrono.{HijrahChronology => JHijrahChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        HijrahDate => JHijrahDate,
        Era => JEra, 
        HijrahEra => JHijrahEra}
    import java.time.temporal.{ChronoField => JChronoField}

    pub enum HijrahChronology(JHijrahChronology)

    instance ToString[HijrahChronology] {
        pub def toString(x: HijrahChronology): String =
            InteropTime.Chrono.HijrahChronology.toString(x)
    }



    pub def getInstance(): HijrahChronology \ IO =
        HijrahChronology(checked_ecast(JHijrahChronology.INSTANCE))

    pub def date(prolepticYear: {prolepticYear = Int32}, 
                    month: {month = Int32}, 
                    dayOfMonth: {dayOfMonth = Int32},
                    chrono: {chrono = HijrahChronology}): HijrahDate =
        let HijrahChronology(chrono1) = chrono#chrono;
        HijrahDate(unsafe IO { chrono1.date(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth) })

    pub def dateWithEra(era: {era = HijrahEra}, 
                        yearOfEra: {yearOfEra = Int32}, 
                        month: {month = Int32}, 
                        dayOfMonth: {dayOfMonth = Int32},
                        x: HijrahChronology): HijrahDate =
        let HijrahChronology(x1) = x;
        let era1 = InteropTime.Chrono.HijrahEra.marshalHijrahEra(era#era);
        let d1 = unsafe IO { x1.date(era1, yearOfEra#yearOfEra, month#month, dayOfMonth#dayOfMonth) };
        let ans = unchecked_cast(d1 as JHijrahDate);
        HijrahDate(ans)


    pub def dateNow(x: HijrahChronology): HijrahDate \ IO = 
        let HijrahChronology(x1) = x;
        let d1 = x1.dateNow();
        let ans = unchecked_cast(d1 as JHijrahDate);
        HijrahDate(ans)

    pub def dateNowWithClock(x: HijrahChronology, clock: ClockZ): HijrahDate \ IO =
        let HijrahChronology(x1) = x;
        let ClockZ(clock1) = clock;
        let d1 = x1.dateNow(clock1);
        let ans = unchecked_cast(d1 as JHijrahDate);
        HijrahDate(ans)

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: HijrahChronology, zone: ZoneId): HijrahDate \ IO =
        let HijrahChronology(x1) = x;
        let ZoneId(zone1) = zone;
        let d1 = x1.dateNow(zone1);
        let ans = unchecked_cast(d1 as JHijrahDate);
        HijrahDate(ans)

    pub def dateEpochDay(x: HijrahChronology, epochDay: Int64): Result[String, HijrahDate] =
        Result.tryCatch(_ -> {
            let HijrahChronology(x1) = x;
            let d1 = unsafe IO { x1.dateEpochDay(epochDay) };
            let ans = unchecked_cast(d1 as JHijrahDate);
            HijrahDate(ans)
        })

    pub def toString(x: HijrahChronology): String =
        let HijrahChronology(x1) = x;
        unsafe IO { x1.toString() }
            

    pub def getDisplayName(style: TextStyle, loc: Locale, x: HijrahChronology): String =
        let HijrahChronology(x1) = x;
        let s1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
        let Locale.Locale(loc1) = loc;
        unsafe IO { x1.getDisplayName(s1, loc1) }


    pub def getCalendarType(x: HijrahChronology): String =
        let HijrahChronology(x1) = x;
        unsafe IO { x1.getCalendarType() }

    pub def eraOf(x: HijrahChronology, i: Int32): HijrahEra =
        let HijrahChronology(x1) = x;
        let e1 = unsafe IO { x1.eraOf(i) };
        let ans = unchecked_cast(e1 as JHijrahEra);
        InteropTime.Chrono.HijrahEra.unmarshalHijrahEra(ans)

    pub def eras(x: HijrahChronology): List[HijrahEra] \ IO =
        let HijrahChronology(x1) = x;
        let xs = x1.eras();
        let xs1: List[JHijrahEra] = Adaptor.fromList(xs);
        List.map(InteropTime.Chrono.HijrahEra.unmarshalHijrahEra, xs1)


    pub def getId(x: HijrahChronology): String =
        let HijrahChronology(x1) = x;
        unsafe IO { x1.getId() }
        
    pub def isLeapYear(prolepticYear: Int64, x: HijrahChronology): Bool =
        let HijrahChronology(x1) = x;
        unsafe IO { x1.isLeapYear(prolepticYear) }

    
    pub def prolepticYear(era: HijrahEra, yearOfEra: Int32, x: HijrahChronology): Int32 =
        let HijrahChronology(x1) = x;
        let era1 = InteropTime.Chrono.HijrahEra.marshalHijrahEra(era);
        unsafe IO { x1.prolepticYear(era1, yearOfEra) }

    pub def rangeYear(x: HijrahChronology): ValueRange =
        let HijrahChronology(x1) = x;
        let f1 = unsafe IO { JChronoField.YEAR };
        let vr1 = unsafe IO { x1.range(f1) };
        ValueRange(vr1)


    // pub def resolveDate(fieldValues: List[(a, Int64)], resolverStyle: ResolverStyle, x: HijrahChronology): HijrahDate with TemporalField[a] =
    //     import java.time.chrono.HijrahChronology.resolveDate(##java.util.Map, ##java.time.format.ResolverStyle): ##java.time.chrono.HijrahDate \ {};
    //     let x1 = getHijrahChronology(x);
    //     let resolverStyle1 = InteropTime.Format.ResolverStyle.marshal(resolverStyle);
    //     let upcastKey = field -> InteropTime.Temporal.TemporalField.marshalToNativeTemporalField(field) as ##java.lang.Object;
    //     let upcastVal = i -> Interop.Collections/... /Marshal.marshalInt64(i) as ##java.lang.Object;
    //     let fieldValues1 = Interop.Collections/... /Marshal.marshalAssocListToMap(upcastKey, upcastVal, fieldValues);
    //     HijrahDate(resolveDate(x1, fieldValues1, resolverStyle1))

}
