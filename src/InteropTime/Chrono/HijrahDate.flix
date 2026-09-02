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


pub mod InteropTime.Chrono.HijrahDate {

    use EffectExtras.Fail.Fail
    use JavaInterop.AdaptorChecked
    use JavaInterop.AdaptorUnchecked

    use InteropTime.Chrono.HijrahChronology.HijrahChronology
    use InteropTime.Chrono.HijrahChronology.HijrahChronology.{HijrahChronology}
    use InteropTime.Chrono.HijrahEra.HijrahEra
    use InteropTime.Temporal.ChronoUnit.ChronoUnit
    // use InteropTime.Temporal.ChronoUnit.DateChronoUnits
    use InteropTime.Temporal.ChronoField.ChronoField
    use InteropTime.Temporal.ChronoField.ChronoField.{MonthOfYear, Year}
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ClockZ.ClockZ.{ClockZ}
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDate.LocalDate.{LocalDate}
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalDateTime.LocalDateTime.{LocalDateTime}
    use InteropTime.Period.Period
    use InteropTime.Period.Period.{Period}
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneId.ZoneId.{ZoneId}

    import java.time.{LocalDate => JLocalDate}
    import java.time.chrono.{HijrahDate => JHijrahDate}
    import java.time.chrono.{ChronoLocalDate => JChronoLocalDate}
    import java.time.chrono.{HijrahEra => JHijrahEra}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalUnit => JTemporalUnit}
    import java.lang.{Object}

    ///
    /// A wrapper around java.time.chrono.HijrahDate.
    ///
    pub enum HijrahDate(JHijrahDate)

    ///
    /// Returns the given HijrahDate `x` as a String.
    ///
    instance ToString[HijrahDate] {
        pub def toString(x: HijrahDate): String =
            let HijrahDate.HijrahDate(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[HijrahDate] {
        pub def eq(x: HijrahDate, y: HijrahDate): Bool = 
            let HijrahDate.HijrahDate(x1) = x;
            let HijrahDate.HijrahDate(y1) = y;
            unsafe IO { x1.equals(y1) }

    }

    instance Order[HijrahDate] {
        pub def compare(x: HijrahDate, y: HijrahDate): Comparison =
            let HijrahDate.HijrahDate(x1) = x;
            let HijrahDate.HijrahDate(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance Hash[HijrahDate] {
        pub def hash(x: HijrahDate): Int32 = 
            let HijrahDate.HijrahDate(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance ToJava[HijrahDate] {
        type Out = JHijrahDate
        pub def toJava(x: HijrahDate): JHijrahDate = 
            let HijrahDate.HijrahDate(x1) = x;
            x1
    }

    instance ToFlix[HijrahDate] {
        type In = JHijrahDate
        pub def toFlix(x: JHijrahDate): HijrahDate = 
            HijrahDate.HijrahDate(x)
    }
    
    pub def newHijrahDate(prolepticYear: {prolepticYear = Int32}, 
                        month: {month = Int32}, 
                        dayOfMonth: {dayOfMonth = Int32}): HijrahDate \ Fail =
        AdaptorChecked.of(() -> unsafe IO { JHijrahDate.of(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth) })

    pub def newWithLocalDate(x: LocalDate): HijrahDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JHijrahDate.$from(x1) })

    pub def newWithLocalDateTime(x: LocalDateTime): HijrahDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JHijrahDate.$from(x1) })


    ///
    /// Returns ___
    ///
    pub def now(): HijrahDate \ IO =
        AdaptorUnchecked.of(() -> { JHijrahDate.now() })

    pub def nowWithClock(x: ClockZ): HijrahDate \ IO =
        AdaptorUnchecked.op(x, x1 -> { JHijrahDate.now(x1) })

    pub def nowWithZoneId(x: ZoneId): HijrahDate \ IO =
        AdaptorUnchecked.op(x, x1 -> { JHijrahDate.now(x1) })
    


    pub def toEpochDay(x: HijrahDate): Int64 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.toEpochDay() })

    pub def toLocalDate(x: HijrahDate): LocalDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JLocalDate.$from(x1) })


    pub def isEqual(x: HijrahDate, y: HijrahDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isEqual(y1) })

    pub def isAfter(x: HijrahDate, y: HijrahDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    pub def isBefore(x: HijrahDate, y: HijrahDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })




    pub def getChronology(x: HijrahDate): HijrahChronology =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getChronology() })

    pub def getEra(x: HijrahDate): HijrahEra =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getEra() })


    pub def isLeapYear(x: HijrahDate): Bool =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.isLeapYear() })

    pub def lengthOfMonth(x: HijrahDate): Int32 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.lengthOfMonth() })

    pub def lengthOfYear(x: HijrahDate): Int32 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.lengthOfYear() })


    pub def plusPeriod(x: HijrahDate, p: Period): HijrahDate =
        AdaptorUnchecked.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.addTo(x1) };
            unchecked_cast(t1 as JHijrahDate)
        })

    pub def minusPeriod(x: HijrahDate, p: Period): HijrahDate =
        AdaptorUnchecked.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.subtractFrom(x1) };
            unchecked_cast(t1 as JHijrahDate)
        })



    pub def plusChrono(x: HijrahDate, 
                        i: Int64, 
                        cu: ChronoUnit): HijrahDate =
        AdaptorUnchecked.op2(x, cu, (x1, cu1) -> {
            let ans: JChronoLocalDate = unsafe IO { x1.plus(i, cu1) };
            unchecked_cast(ans as JHijrahDate)
        })

    pub def minusChrono(x: HijrahDate, i: Int64, cu: ChronoUnit): HijrahDate =
        AdaptorUnchecked.op2(x, cu, (x1, cu1) -> {
            let ans: JChronoLocalDate = unsafe IO { x1.minus(i, cu1) };
            unchecked_cast(ans as JHijrahDate)
        })



    pub def until(begin: {begin = HijrahDate}, end: {end = HijrahDate}, cu: ChronoUnit): Int64 =
        AdaptorUnchecked.extract3(begin#begin, end#end, cu, (begin1, end1, cu1) -> {
            let tend1: JTemporal = checked_cast(end1);
            let tu1: JTemporalUnit = checked_cast(cu1);
            unsafe IO { begin1.until(tend1, tu1) }
        })

    // // just MonthOfYear / Year...
    // pub def getChrono(x: HijrahDate, cf: ChronoField): Int64 =
    //     AdaptorUnchecked.extract2(x, cf, (x1, cf1) -> unsafe IO { x1.getLong(cf1) })

    // pub def getYear(x: HijrahDate): Int32 =
    //     match getChrono(x, open_variant ChronoField.Year) |> Int64.tryToInt32 {
    //         case Some(i) => i
    //         case None => bug!("HijrahDate.getYear()")
    //     }

    // pub def getMonth(x: HijrahDate): Int32 =
    //     match getChrono(x, open_variant ChronoField.MonthOfYear) |> Int64.tryToInt32 {
    //         case Some(i) => i
    //         case None => bug!("HijrahDate.getMonth()")
    //     }

    // // <MonthOfYear, Year>
    // pub def withChrono(x: HijrahDate, cf: ChronoField, i: Int64): HijrahDate =
    //     AdaptorUnchecked.op2(x, cf, (x1, cf1) -> {
    //         let ans: JChronoLocalDate = unsafe IO { x1.$with(cf1, i) };
    //         unchecked_cast(ans as JHijrahDate)
    //     })

}
