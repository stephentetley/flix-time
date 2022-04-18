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

    instance ToString[HijrahChronology] {
        pub def toString(x: HijrahChronology): String =
            import java.time.chrono.AbstractChronology.toString(): String & Pure;
            let HijrahChronology(x1) = x;
            toString(x1 as ##java.time.chrono.AbstractChronology)
    }


}


namespace Time/Chrono/HijrahChronology {

    use Time/Chrono.HijrahChronology;
    use Time/Chrono.HijrahChronology.{HijrahChronology};
    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.HijrahEra;
    use Time/Format.ResolverStyle;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def getHijrahChronology(x: HijrahChronology): ##java.time.chrono.HijrahChronology = 
        let HijrahChronology(x1) = x;
        x1

    pub def getInstance(): HijrahChronology & Impure =
        import static get java.time.chrono.HijrahChronology.INSTANCE: ##java.time.chrono.HijrahChronology & Impure as getINSTANCE;
        HijrahChronology(getINSTANCE())

    pub def date(x: HijrahChronology, r: {prolepticYear :: Int32, month :: Int32, dayOfMonth :: Int32}): HijrahDate =
        import java.time.chrono.HijrahChronology.date(Int32, Int32, Int32): ##java.time.chrono.HijrahDate & Pure;
        let HijrahChronology(x1) = x;
        HijrahDate(date(x1, r.prolepticYear, r.month, r.dayOfMonth))

    pub def dateWithEra(x: HijrahChronology,
                        r: {era :: HijrahEra, yearOfEra :: Int32, month :: Int32, dayOfMonth :: Int32}): HijrahDate =
        import java.time.chrono.HijrahChronology.date(##java.time.chrono.Era, Int32, Int32, Int32): ##java.time.chrono.HijrahDate & Pure;
        let HijrahChronology(x1) = x;
        let era1 = Time/Chrono/HijrahEra.marshal(r.era) as ##java.time.chrono.Era;
        HijrahDate(date(x1, era1, r.yearOfEra, r.month, r.dayOfMonth))


    pub def dateNow(x: HijrahChronology): HijrahDate & Impure = 
        import java.time.chrono.HijrahChronology.dateNow(): ##java.time.chrono.HijrahDate & Impure;
        let HijrahChronology(x1) = x;
        HijrahDate(dateNow(x1))

    pub def dateNowWithClock(x: HijrahChronology, clock: Clock): HijrahDate & Impure =
        import java.time.chrono.HijrahChronology.dateNow(##java.time.Clock): ##java.time.chrono.HijrahDate & Impure;
        let HijrahChronology(x1) = x;
        let Clock(clock1) = clock;
        HijrahDate(dateNow(x1, clock1))

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: HijrahChronology, zone: ZoneId): HijrahDate & Impure =
        import java.time.chrono.HijrahChronology.dateNow(##java.time.ZoneId): ##java.time.chrono.HijrahDate & Impure;
        let HijrahChronology(x1) = x;
        let ZoneId(zone1) = zone;
        HijrahDate(dateNow(x1, zone1))

    pub def dateEpochDay(x: HijrahChronology, epochDay: Int64): HijrahDate = 
        import java.time.chrono.HijrahChronology.dateEpochDay(Int64): ##java.time.chrono.HijrahDate & Pure;
        let HijrahChronology(x1) = x;
        HijrahDate(dateEpochDay(x1, epochDay))

    pub def getCalendarType(x: HijrahChronology): String = 
        import java.time.chrono.HijrahChronology.getCalendarType(): String & Pure;
        let HijrahChronology(x1) = x;
        getCalendarType(x1)

    pub def eraOf(x: HijrahChronology, i: Int32): HijrahEra = 
        import java.time.chrono.HijrahChronology.eraOf(Int32): ##java.time.chrono.HijrahEra & Pure;
        let HijrahChronology(x1) = x;
        Time/Chrono/HijrahEra.unmarshal(eraOf(x1, i))

    pub def eras(x: HijrahChronology): List[HijrahEra] = 
        import java.time.chrono.HijrahChronology.eras(): ##java.util.List & Pure;
        let HijrahChronology(x1) = x;
        let jxs = eras(x1);
        FlixSandbox/Marshal.unmarshalList(o -> Time/Chrono/HijrahEra.unmarshal(o as ##java.time.chrono.HijrahEra), jxs) as & Pure
        
    pub def getId(x: HijrahChronology): String = 
        import java.time.chrono.HijrahChronology.getId(): String & Pure;
        let HijrahChronology(x1) = x;
        getId(x1)
        
    pub def isLeapYear(prolepticYear: Int64, x: HijrahChronology): Bool = 
        import java.time.chrono.HijrahChronology.isLeapYear(Int64): Bool & Pure;
        let HijrahChronology(x1) = x;
        isLeapYear(x1, prolepticYear)

    pub def prolepticYear(era: HijrahEra, yearOfEra: Int32, x: HijrahChronology): Int32 = 
        import java.time.chrono.HijrahChronology.prolepticYear(##java.time.chrono.Era, Int32): Int32 & Pure;
        let HijrahChronology(x1) = x;
        let era1 = Time/Chrono/HijrahEra.marshal(era) as ##java.time.chrono.Era;
        prolepticYear(x1, era1, yearOfEra)

    /// Warning - extra casting...
    pub def range(field: a, x: HijrahChronology): ValueRange with TemporalField[a] =
        import java.time.chrono.HijrahChronology.range(##java.time.temporal.ChronoField): ##java.time.temporal.ValueRange & Pure;
        let x1 = getHijrahChronology(x);
        let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field) as ##java.time.temporal.ChronoField;
        ValueRange(range(x1, field1))      

    ///
    pub def dateWithTemporalAccessor(temporal: a, x: HijrahChronology): HijrahDate with TemporalAccessor[a] =
        import java.time.chrono.HijrahChronology.date(##java.time.temporal.TemporalAccessor): ##java.time.chrono.HijrahDate & Pure;
        let x1 = getHijrahChronology(x);
        let temporal1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(temporal);
        HijrahDate(date(x1, temporal1))

    /// localDateTime - TODO

    pub def resolveDate(fieldValues: List[(a, Int64)], resolverStyle: ResolverStyle, x: HijrahChronology): HijrahDate with TemporalField[a] =
        import java.time.chrono.HijrahChronology.resolveDate(##java.util.Map, ##java.time.format.ResolverStyle): ##java.time.chrono.HijrahDate & Pure;
        let x1 = getHijrahChronology(x);
        let resolverStyle1 = Time/Format/ResolverStyle.marshal(resolverStyle);
        let upcastKey = field -> Time/Temporal/TemporalField.marshalToNativeTemporalField(field) as ##java.lang.Object;
        let upcastVal = i -> FlixSandbox/Marshal.marshalInt64(i) as ##java.lang.Object;
        let fieldValues1 = FlixSandbox/Marshal.marshalListToMap(upcastKey, upcastVal, fieldValues) as & Pure;
        HijrahDate(resolveDate(x1, fieldValues1, resolverStyle1))

}
