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

    
    use JavaInterop.AdaptorExtras

    use InteropTime.Chrono.HijrahDate.HijrahDate
    use InteropTime.Chrono.HijrahEra.HijrahEra
    use InteropTime.Format.ResolverStyle.ResolverStyle
    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.Temporal.ValueRange.ValueRange
    use InteropTime.Temporal.ChronoField
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ZoneId.ZoneId

    use InteropLocale.Locale.Locale

    import java.time.chrono.{HijrahChronology => JHijrahChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        HijrahDate => JHijrahDate,
        Era => JEra, 
        HijrahEra => JHijrahEra}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.util.{Iterator => JIterator}
    import java.lang.{Exception => JException}

    pub enum HijrahChronology(JHijrahChronology)

    instance ToString[HijrahChronology] {
        pub def toString(x: HijrahChronology): String =
            InteropTime.Chrono.HijrahChronology.toString(x)
    }

    instance ToJava[HijrahChronology] {
        type Out = JHijrahChronology
        pub def toJava(x: HijrahChronology): JHijrahChronology = 
            let HijrahChronology.HijrahChronology(x1) = x;
            x1
    }

    instance ToFlix[HijrahChronology] {
        type In = JHijrahChronology
        pub def toFlix(x: JHijrahChronology): HijrahChronology = HijrahChronology.HijrahChronology(x)
    }

    pub def getInstance(): HijrahChronology \ IO =
        HijrahChronology(checked_ecast(JHijrahChronology.INSTANCE))

    pub def date(prolepticYear: {prolepticYear = Int32}, 
                    month: {month = Int32}, 
                    dayOfMonth: {dayOfMonth = Int32},
                    chrono: {chrono = HijrahChronology}): HijrahDate =
        AdaptorExtras.op(chrono#chrono, chrono1 ->
            unsafe IO { chrono1.date(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth) }
        )

    pub def dateWithEra(era: {era = HijrahEra}, 
                        yearOfEra: {yearOfEra = Int32}, 
                        month: {month = Int32}, 
                        dayOfMonth: {dayOfMonth = Int32},
                        x: HijrahChronology): HijrahDate =
        AdaptorExtras.op2(x, era#era, (x1, era1) -> {
            let ans: JChronoLocalDate = unsafe IO { x1.date(era1, yearOfEra#yearOfEra, month#month, dayOfMonth#dayOfMonth) };
            unchecked_cast(ans as JHijrahDate)
        })


    pub def dateNow(x: HijrahChronology): HijrahDate \ IO = 
        AdaptorExtras.op(x, x1 -> { x1.dateNow() })

    pub def dateNowWithClock(x: HijrahChronology, clock: ClockZ): HijrahDate \ IO =
        AdaptorExtras.op2(x, clock, (x1, clock1) -> { x1.dateNow(clock1) })

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: HijrahChronology, zone: ZoneId): HijrahDate \ IO =
        AdaptorExtras.op2(x, zone, (x1, zone1) -> { x1.dateNow(zone1) })

    pub def dateEpochDay(x: HijrahChronology, epochDay: Int64): Result[String, HijrahDate] =
        AdaptorExtras.opWithResult(x, x1 -> unsafe IO { x1.dateEpochDay(epochDay) })

    pub def toString(x: HijrahChronology): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toString() })
            

    pub def getDisplayName(style: TextStyle, loc: Locale, x: HijrahChronology): String =
        AdaptorExtras.extract3(style, loc, x, (style1, loc1, x1) -> 
            unsafe IO { x1.getDisplayName(style1, loc1) }
        )


    pub def getCalendarType(x: HijrahChronology): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getCalendarType() })

    pub def eraOf(x: HijrahChronology, i: Int32): HijrahEra =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.eraOf(i) })

    pub def eras(x: HijrahChronology): List[HijrahEra]  =
        AdaptorExtras.extract(x, x1 -> {
            let jiter: JIterator[JEra] = unsafe IO { let xs = x1.eras(); xs.iterator() };
            AdaptorExtras.Collection.toList(jiter, e1 -> unchecked_cast(e1 as JHijrahEra) |> ToFlix.toFlix)
        })
        


    pub def getId(x: HijrahChronology): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getId() })
        
    pub def isLeapYear(prolepticYear: Int64, x: HijrahChronology): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isLeapYear(prolepticYear) })

    
    pub def prolepticYear(era: HijrahEra, yearOfEra: Int32, x: HijrahChronology): Int32 =
        AdaptorExtras.extract2(era, x, (era1, x1) -> unsafe IO { x1.prolepticYear(era1, yearOfEra) })

    pub def rangeYear(x: HijrahChronology): ValueRange =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.range(JChronoField.YEAR) })



}
