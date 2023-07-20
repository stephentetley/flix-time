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
    use Interop.Time.Chrono.AbstractChronology
    use Interop.Time.Chrono.AbstractChronology.{AbstractChronology}
    use Interop.Time.Chrono.Chronology
    use Interop.Time.Chrono.Chronology.{Chronology}

    pub enum HijrahChronology(##java.time.chrono.HijrahChronology)

    instance ToString[HijrahChronology] {
        pub def toString(x: HijrahChronology): String =
            Time.Chrono.HijrahChronology.toString(x)
    }

    instance Eq[HijrahChronology] {
        pub def eq(x: HijrahChronology, y: HijrahChronology): Bool =
            Time.Chrono.HijrahChronology.equals(x, y)
    }

    instance Order[HijrahChronology] {
        pub def compare(x: HijrahChronology, y: HijrahChronology): Comparison =
            Time.Chrono.HijrahChronology.compare(x, y)
    }


    instance Interop.Flix.Marshal[HijrahChronology] {
        pub def toJavaObject(x: HijrahChronology): ##java.lang.Object =
            let HijrahChronology(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): HijrahChronology = 
            HijrahChronology(unchecked_cast(o as ##java.time.chrono.HijrahChronology))
    }


    instance Interop.Time.Chrono.ImpChronology[HijrahChronology] {
        pub def toChronology(x: HijrahChronology): Chronology = 
            let HijrahChronology(x1) = x;
            Chronology(unchecked_cast(x1 as ##java.time.chrono.Chronology))

        pub def fromChronology(x: Chronology): HijrahChronology = 
            let Chronology(x1) = x;
            HijrahChronology(unchecked_cast(x1 as ##java.time.chrono.HijrahChronology))
    }

    instance Interop.Time.Chrono.SubAbstractChronology[HijrahChronology] {
        pub def toAbstractChronology(x: HijrahChronology): AbstractChronology = 
            let HijrahChronology(x1) = x;
            AbstractChronology(unchecked_cast(x1 as ##java.time.chrono.AbstractChronology))

        pub def fromAbstractChronology(x: AbstractChronology): HijrahChronology = 
            let AbstractChronology(x1) = x;
            HijrahChronology(unchecked_cast(x1 as ##java.time.chrono.HijrahChronology))
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

    
    use Interop.Util.Locale

    pub def getHijrahChronology(x: HijrahChronology): ##java.time.chrono.HijrahChronology = 
        let HijrahChronology(x1) = x;
        x1


    pub def getInstance(): HijrahChronology \ IO =
        import static get java.time.chrono.HijrahChronology.INSTANCE: ##java.time.chrono.HijrahChronology \ IO as getINSTANCE;
        HijrahChronology(getINSTANCE())

    pub def date(r: {prolepticYear = Int32, month = Int32, dayOfMonth = Int32}, 
                 x: HijrahChronology): HijrahDate =
        import java.time.chrono.HijrahChronology.date(Int32, Int32, Int32): ##java.time.chrono.HijrahDate \ {};
        let HijrahChronology(x1) = x;
        HijrahDate(date(x1, r.prolepticYear, r.month, r.dayOfMonth))

    pub def dateWithEra(r: {era = HijrahEra, yearOfEra = Int32, month = Int32, dayOfMonth = Int32}, 
                        x: HijrahChronology): HijrahDate =
        import java.time.chrono.HijrahChronology.date(##java.time.chrono.Era, Int32, Int32, Int32): ##java.time.chrono.HijrahDate \ {};
        let HijrahChronology(x1) = x;
        let era1 = Time.Chrono.ImplementsEra.toEra(r.era) |> Time.Chrono.Era.getHH;
        HijrahDate(date(x1, era1, r.yearOfEra, r.month, r.dayOfMonth))


    pub def dateNow(x: HijrahChronology): HijrahDate \ IO = 
        import java.time.chrono.HijrahChronology.dateNow(): ##java.time.chrono.HijrahDate \ IO;
        let HijrahChronology(x1) = x;
        HijrahDate(dateNow(x1))

    pub def dateNowWithClock(x: HijrahChronology, clock: Clock): HijrahDate \ IO =
        import java.time.chrono.HijrahChronology.dateNow(##java.time.Clock): ##java.time.chrono.HijrahDate \ IO;
        let HijrahChronology(x1) = x;
        let Clock(clock1) = clock;
        HijrahDate(dateNow(x1, clock1))

    ///
    /// Returns the current date from the system clock in the specified time zone.
    ///
    pub def dateNowWithZoneId(x: HijrahChronology, zone: ZoneId): HijrahDate \ IO =
        import java.time.chrono.HijrahChronology.dateNow(##java.time.ZoneId): ##java.time.chrono.HijrahDate \ IO;
        let HijrahChronology(x1) = x;
        let ZoneId(zone1) = zone;
        HijrahDate(dateNow(x1, zone1))

    pub def dateEpochDay(x: HijrahChronology, epochDay: Int64): Result[String, HijrahDate] = 
        Result.tryCatch(_ -> {
            import java.time.chrono.HijrahChronology.dateEpochDay(Int64): ##java.time.chrono.HijrahDate \ {};
            let HijrahChronology(x1) = x;
            HijrahDate(dateEpochDay(x1, epochDay))
        })

    pub def toString(x: HijrahChronology): String =
        Interop.Time.Chrono.SubAbstractChronology.toAbstractChronology(x) 
            |> Interop.Time.Chrono.AbstractChronology.toString
            
    pub def equals(x: HijrahChronology, y: HijrahChronology): Bool =
        let x1 = Interop.Time.Chrono.SubAbstractChronology.toAbstractChronology(x);
        let y1 = Interop.Time.Chrono.SubAbstractChronology.toAbstractChronology(y);
        Interop.Time.Chrono.AbstractChronology.equals(x1, y1)

    pub def compare(x: HijrahChronology, y: HijrahChronology): Comparison =
        let x1 = Interop.Time.Chrono.SubAbstractChronology.toAbstractChronology(x);
        let y1 = Interop.Time.Chrono.SubAbstractChronology.toAbstractChronology(y);
        Interop.Time.Chrono.AbstractChronology.compareTo(x1, y1) |> Comparison.fromInt32


    pub def getDisplayName(sty: TextStyle, loc: Locale, x: HijrahChronology): String = 
        Interop.Time.Chrono.ImpChronology.toChronology(x)
            |> Interop.Time.Chrono.Chronology.getDisplayName(sty, loc)

    pub def getCalendarType(x: HijrahChronology): String = 
        import java.time.chrono.HijrahChronology.getCalendarType(): String \ {};
        let HijrahChronology(x1) = x;
        getCalendarType(x1)

    pub def eraOf(x: HijrahChronology, i: Int32): HijrahEra = 
        import java.time.chrono.HijrahChronology.eraOf(Int32): ##java.time.chrono.HijrahEra \ {};
        let HijrahChronology(x1) = x;
        Time.Chrono.HijrahEra.unmarshalHijrahEra(eraOf(x1, i))

    pub def eras(x: HijrahChronology): List[HijrahEra] = region r {
        import java.time.chrono.HijrahChronology.eras(): ##java.util.List \ {};
        let HijrahChronology(x1) = x;
        eras(x1) |> Interop.Util.ListZ.wrapHH(r) |> Interop.Util.ListZ.toFlixList
    }

    pub def getId(x: HijrahChronology): String = 
        import java.time.chrono.HijrahChronology.getId(): String \ {};
        let HijrahChronology(x1) = x;
        getId(x1)
        
    pub def isLeapYear(prolepticYear: Int64, x: HijrahChronology): Bool = 
        import java.time.chrono.HijrahChronology.isLeapYear(Int64): Bool \ {};
        let HijrahChronology(x1) = x;
        isLeapYear(x1, prolepticYear)

    
    pub def prolepticYear(era: HijrahEra, yearOfEra: Int32, x: HijrahChronology): Int32 = 
        import java.time.chrono.HijrahChronology.prolepticYear(##java.time.chrono.Era, Int32): Int32 \ {};
        let HijrahChronology(x1) = x;
        let Era(era1) = Time.Chrono.ImplementsEra.toEra(era);
        prolepticYear(x1, era1, yearOfEra)


    /// pub def resolveDate(fieldValues: List[(a, Int64)], resolverStyle: ResolverStyle, x: HijrahChronology): HijrahDate with TemporalField[a] =
    ///     import java.time.chrono.HijrahChronology.resolveDate(##java.util.Map, ##java.time.format.ResolverStyle): ##java.time.chrono.HijrahDate \ {};
    ///     let x1 = getHijrahChronology(x);
    ///     let resolverStyle1 = Time.Format.ResolverStyle.marshal(resolverStyle);
    ///     let upcastKey = field -> Time.Temporal.TemporalField.marshalToNativeTemporalField(field) as ##java.lang.Object;
    ///     let upcastVal = i -> Interop.Collections/... /Marshal.marshalInt64(i) as ##java.lang.Object;
    ///     let fieldValues1 = Interop.Collections/... /Marshal.marshalAssocListToMap(upcastKey, upcastVal, fieldValues);
    ///     HijrahDate(resolveDate(x1, fieldValues1, resolverStyle1))

}
