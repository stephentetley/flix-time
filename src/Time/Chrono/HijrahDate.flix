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

    use Time.Chrono.HijrahDate
    use Time.Chrono.HijrahDate.{HijrahDate}

    import java.time.chrono.{HijrahDate => JHijrahDate}

    ///
    /// A wrapper around java.time.chrono.HijrahDate.
    ///
    pub enum HijrahDate(JHijrahDate)
    
    ///
    /// Returns the given HijrahDate `x` as a String.
    ///
    instance ToString[HijrahDate] {
        pub def toString(x: HijrahDate): String =
            let HijrahDate(x1) = x;
            unsafe x1.toString()
    }

    instance Eq[HijrahDate] {
        pub def eq(x: HijrahDate, y: HijrahDate): Bool = Time.Chrono.HijrahDate.equals(x, y)
    }
    
    instance Order[HijrahDate] {
        pub def compare(x: HijrahDate, y: HijrahDate): Comparison = 
            Time.Chrono.HijrahDate.compareTo(x, y) |> Comparison.fromInt32
    }

    instance Hash[HijrahDate] {
        pub def hash(x: HijrahDate): Int32 = Time.Chrono.HijrahDate.hashCode(x)
    }  

}

mod Time.Chrono.HijrahDate {


    use Time.Chrono.HijrahDate
    use Time.Chrono.HijrahDate.{HijrahDate}
    use Time.Chrono.HijrahChronology
    use Time.Chrono.HijrahChronology.{HijrahChronology}
    use Time.Chrono.HijrahEra
    use Time.Temporal.ChronoUnit
    use Time.Temporal.ChronoUnit.{Days, Months, Years, Centuries, Millennia, Eras}
    use Time.Clock
    use Time.Clock.{Clock}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.Period
    use Time.Period.{Period}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    import java.time.{LocalDate => JLocalDate}
    import java.time.chrono.{HijrahDate => JHijrahDate}
    import java.time.chrono.{ChronoLocalDate => JChronoLocalDate,
        HijrahEra => JHijrahEra}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalUnit => JTemporalUnit}
    import java.lang.{Object}

    pub def getHijrahDate(x: HijrahDate): JHijrahDate = 
        let HijrahDate(x1) = x;
        x1


    pub def hijrahDate(r: {prolepticYear = Int32, month = Int32, dayOfMonth = Int32}): HijrahDate =
        HijrahDate(unsafe JHijrahDate.of(r#prolepticYear, r#month, r#dayOfMonth))


    ///
    /// Returns ___
    ///
    pub def now(): HijrahDate \ IO =
        HijrahDate(JHijrahDate.now())

    pub def nowWithClock(x: Clock): HijrahDate \ IO =
        let Clock(x1) = x;
        HijrahDate(JHijrahDate.now(x1))

    pub def nowWithZoneId(x: ZoneId): HijrahDate \ IO =
        let ZoneId(x1) = x;
        HijrahDate(JHijrahDate.now(x1))


    pub def equals(x: HijrahDate, y: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        unsafe x1.equals(y1)

    pub def hashCode(x: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        unsafe x1.hashCode()


    pub def isEqual(x: HijrahDate, y: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        unsafe x1.isEqual(y1)

    pub def compareTo(x: HijrahDate, y: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        unsafe x1.compareTo(y1)

    pub def isAfter(x: HijrahDate, y: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        unsafe x1.isAfter(y1)

    pub def isBefore(x: HijrahDate, y: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        unsafe x1.isBefore(y1)


    pub def toEpochDay(x: HijrahDate): Int64 = 
        let HijrahDate(x1) = x;
        unsafe x1.toEpochDay()

    pub def toLocalDate(x: HijrahDate): LocalDate =
        let HijrahDate(x1) = x;
        let ans = unsafe JLocalDate.from(x1);
        LocalDate(ans)

    pub def getChronology(x: HijrahDate): HijrahChronology = 
        let HijrahDate(x1) = x;
        HijrahChronology(unsafe x1.getChronology())

    pub def getEra(x: HijrahDate): HijrahEra = 
        let HijrahDate(x1) = x;
        let e1 = unsafe x1.getEra();
        let ans = unchecked_cast(e1 as JHijrahEra);
        Time.Chrono.HijrahEra.unmarshalHijrahEra(ans)


    pub def isLeapYear(x: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        unsafe x1.isLeapYear()

    pub def lengthOfMonth(x: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        unsafe x1.lengthOfMonth()

    pub def lengthOfYear(x: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        unsafe x1.lengthOfYear()


    pub def plusPeriod(x: HijrahDate, p: Period): HijrahDate = 
        let HijrahDate(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe p1.addTo(x1);
        let ans = unchecked_cast(t1 as JHijrahDate);
        HijrahDate(ans)

    pub def minusPeriod(x: HijrahDate, p: Period): HijrahDate = 
        let HijrahDate(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe p1.subtractFrom(x1);
        let ans = unchecked_cast(t1 as JHijrahDate);
        HijrahDate(ans)

    pub def plusChrono(x: HijrahDate, i: Int64, cu: ChronoUnit[<Days, Months, Years, Centuries, Millennia>]): HijrahDate = 
        let HijrahDate(x1) = x;
        let cu1 = Time.Temporal.ChronoUnit.marshalChronoUnit(cu);
        let ans = unsafe x1.plus(i, cu1);
        HijrahDate(ans)

    pub def minusChrono(x: HijrahDate, i: Int64, cu: ChronoUnit[<Days, Months, Years, Centuries, Millennia>]): HijrahDate = 
        let HijrahDate(x1) = x;
        let cu1 = Time.Temporal.ChronoUnit.marshalChronoUnit(cu);
        let ans = unsafe x1.minus(i, cu1);
        HijrahDate(ans)



    pub def until(begin: {begin = HijrahDate}, end: {end = HijrahDate}, cu: ChronoUnit[<Days, Months, Years, Centuries, Millennia, Eras>]): Int64 = 
        let HijrahDate(b1) = begin#begin;
        let HijrahDate(e1) = end#end;
        let te1: JTemporal = unchecked_cast(e1 as JTemporal);
        let cu1 = Time.Temporal.ChronoUnit.marshalChronoUnit(cu);
        let tu1: JTemporalUnit = unchecked_cast(cu1 as JTemporalUnit);
        unsafe b1.until(te1, tu1)



}
