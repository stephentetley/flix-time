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
    
    ///
    /// A wrapper around java.time.chrono.HijrahDate.
    ///
    pub opaque type HijrahDate = ##java.time.chrono.HijrahDate
    
    ///
    /// Returns the given HijrahDate `x` as a String.
    ///
    instance ToString[HijrahDate] {
        def toString(x: HijrahDate): String =
            import java.time.chrono.HijrahDate.toString();
            let HijrahDate(x1) = x;
            toString(x1) as & Pure
    }

    instance Eq[HijrahDate] {
        def eq(x: HijrahDate, y: HijrahDate): Bool = Time/Chrono/HijrahDate.equals(x, y)

        def neq(x: HijrahDate, y: HijrahDate): Bool = not (x == y)
    }
}

namespace Time/Chrono/HijrahDate {


    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.HijrahChronology;
    use Time/Chrono.HijrahChronology.{HijrahChronology};
    use Time/Chrono.HijrahEra;
    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def new(x: {prolepticYear: Int32, month: Int32, dayOfMonth: Int32}): HijrahDate =
        import java.time.chrono.HijrahDate:of(Int32, Int32, Int32);
        HijrahDate(of(x.prolepticYear, x.month, x.dayOfMonth)) as & Pure


    ///
    /// Returns ___
    ///
    pub def now(): HijrahDate & Impure =
        import java.time.chrono.HijrahDate:now();
        HijrahDate(now())

    pub def nowWithClock(x: Clock): HijrahDate & Impure =
        import java.time.chrono.HijrahDate:now(##java.time.Clock);
        let Clock(x1) = x;
        HijrahDate(now(x1))

    pub def nowWithZoneId(x: ZoneId): HijrahDate & Impure =
        import java.time.chrono.HijrahDate:now(##java.time.ZoneId);
        let ZoneId(x1) = x;
        HijrahDate(now(x1))


    pub def equals(x: HijrahDate, y: HijrahDate): Bool = 
        import java.time.chrono.HijrahDate.equals(##java.lang.Object);
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        x1.equals(y1 as ##java.lang.Object) as & Pure

    pub def getChronology(x: HijrahDate): HijrahChronology = 
        import java.time.chrono.HijrahDate.getChronology();
        let HijrahDate(x1) = x;
        HijrahChronology(getChronology(x1) as & Pure)

    pub def getEra(x: HijrahDate): HijrahEra = 
        import java.time.chrono.HijrahDate.getEra();
        let HijrahDate(x1) = x;
        Time/Chrono/HijrahEra.unmarshal(getEra(x1) as & Pure)

    pub def isLeapYear(x: HijrahDate): Bool = 
        import java.time.chrono.HijrahDate.isLeapYear();
        let HijrahDate(x1) = x;
        isLeapYear(x1) as & Pure

    pub def lengthOfMonth(x: HijrahDate): Int32 = 
        import java.time.chrono.HijrahDate.lengthOfMonth();
        let HijrahDate(x1) = x;
        lengthOfMonth(x1) as & Pure

    pub def lengthOfYear(x: HijrahDate): Int32 = 
        import java.time.chrono.HijrahDate.lengthOfYear();
        let HijrahDate(x1) = x;
        lengthOfYear(x1) as & Pure

}
