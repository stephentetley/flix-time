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
    use Time.Internal.Chrono.ChronoLocalDate
    use Time.Internal.Chrono.ChronoLocalDate.{ChronoLocalDate}
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}
    use Time.Chrono.HijrahChronology
    use Time.Chrono.HijrahChronology.{HijrahChronology}
    use Time.Chrono.HijrahEra
    use Time.Clock
    use Time.Clock.{Clock}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.Period
    use Time.Period.{Period}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    import java.time.chrono.{HijrahDate => JHijrahDate}
    import java.time.chrono.{ChronoLocalDate => JChronoLocalDate,
        HijrahEra => JHijrahEra}
    import java.lang.{Object}

    pub def getHijrahDate(x: HijrahDate): JHijrahDate = 
        let HijrahDate(x1) = x;
        x1

    // pub def asTemporalAccessor(x: HijrahDate): TemporalAccessor = 
    //     let HijrahDate(x1) = x;
    //     TemporalAccessor(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor))

    // pub def asChronoLocalDate(x: HijrahDate): ChronoLocalDate = 
    //     let HijrahDate(x1) = x;
    //     ChronoLocalDate(unchecked_cast(x1 as ##java.time.chrono.ChronoLocalDate))

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
        let obj = (checked_cast(y1) : Object);
        unsafe x1.equals(obj)

    pub def hashCode(x: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        unsafe x1.hashCode()


    pub def isEqual(x: HijrahDate, y: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let cy1 = (checked_cast(y1) : JChronoLocalDate);
        unsafe cx1.isEqual(cy1)

    pub def compareTo(x: HijrahDate, y: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let cy1 = (checked_cast(y1) : JChronoLocalDate);
        unsafe cx1.compareTo(cy1)

    pub def isAfter(x: HijrahDate, y: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let cy1 = (checked_cast(y1) : JChronoLocalDate);
        unsafe cx1.isAfter(cy1)

    pub def isBefore(x: HijrahDate, y: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let cy1 = (checked_cast(y1) : JChronoLocalDate);
        unsafe cx1.isBefore(cy1)


    pub def toEpochDay(x: HijrahDate): Int64 = 
        let HijrahDate(x1) = x;
        unsafe x1.toEpochDay()

    // pub def toLocalDate(x: HijrahDate): LocalDate =
    //     import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromDate;
    //     let HijrahDate(x1) = x;
    //     LocalDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))

    // pub def getChronology(x: HijrahDate): HijrahChronology = 
    //     import java.time.chrono.HijrahDate.getChronology(): ##java.time.chrono.HijrahChronology \ {};
    //     let HijrahDate(x1) = x;
    //     HijrahChronology(getChronology(x1))

    pub def getEra(x: HijrahDate): HijrahEra = 
        let HijrahDate(x1) = x;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let ans = unsafe cx1.getEra();
        let ans1 = unchecked_cast(ans as JHijrahEra);
        Time.Chrono.HijrahEra.unmarshalHijrahEra(ans1)


    pub def isLeapYear(x: HijrahDate): Bool = 
        let HijrahDate(x1) = x;
        unsafe x1.isLeapYear()

    pub def lengthOfMonth(x: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        unsafe x1.lengthOfMonth()

    pub def lengthOfYear(x: HijrahDate): Int32 = 
        let HijrahDate(x1) = x;
        unsafe x1.lengthOfYear()


    // pub def plusPeriod(x: HijrahDate, amount: Period): HijrahDate = 
    //     import java.time.chrono.HijrahDate.plus(##java.time.temporal.TemporalAmount): ##java.time.chrono.HijrahDate \ {};
    //     let HijrahDate(x1) = x;
    //     let Period(amount1) = amount;
    //     let tamount1 = unchecked_cast(amount1 as ##java.time.temporal.TemporalAmount);
    //     HijrahDate(plus(x1, tamount1))

    // pub def minusPeriod(x: HijrahDate, amount: Period): HijrahDate = 
    //     import java.time.chrono.HijrahDate.minus(##java.time.temporal.TemporalAmount): ##java.time.chrono.HijrahDate \ {};
    //     let HijrahDate(x1) = x;
    //     let Period(amount1) = amount;
    //     let tamount1 = unchecked_cast(amount1 as ##java.time.temporal.TemporalAmount);
    //     HijrahDate(minus(x1, tamount1))



    // pub def withVariant(x: HijrahDate, chronology: HijrahChronology): HijrahDate = 
    //     import java.time.chrono.HijrahDate.withVariant(##java.time.chrono.HijrahChronology): ##java.time.chrono.HijrahDate \ {};
    //     let HijrahDate(x1) = x;
    //     let HijrahChronology(chronology1) = chronology;
    //     HijrahDate(withVariant(x1, chronology1))


}
