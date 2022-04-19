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

    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;

    ///
    /// A wrapper around java.time.chrono.HijrahDate.
    ///
    pub opaque type HijrahDate = ##java.time.chrono.HijrahDate
    
    ///
    /// Returns the given HijrahDate `x` as a String.
    ///
    instance ToString[HijrahDate] {
        pub def toString(x: HijrahDate): String =
            import java.time.chrono.HijrahDate.toString(): String & Pure;
            let HijrahDate(x1) = x;
            toString(x1)
    }

    instance Eq[HijrahDate] {
        pub def eq(x: HijrahDate, y: HijrahDate): Bool = Time/Chrono/HijrahDate.equals(x, y)
    }
    
    instance Hash[HijrahDate] {
        pub def hash(x: HijrahDate): Int32 = Time/Chrono/HijrahDate.hashCode(x)
    }  

    instance TemporalAccessor[HijrahDate] {
        pub def marshalToNativeTemporalAccessor(x: HijrahDate): ##java.time.temporal.TemporalAccessor =         
            Time/Chrono/HijrahDate.getHijrahDate(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): HijrahDate = 
            HijrahDate(x as ##java.time.chrono.HijrahDate)
    }

    instance Temporal[HijrahDate] {
        pub def marshalToNativeTemporal(x: HijrahDate): ##java.time.temporal.Temporal =         
            Time/Chrono/HijrahDate.getHijrahDate(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): HijrahDate = 
            HijrahDate(x as ##java.time.chrono.HijrahDate)
    }

    instance TemporalAdjuster[HijrahDate] {
        pub def marshalToNativeTemporalAdjuster(x: HijrahDate): ##java.time.temporal.TemporalAdjuster =         
            Time/Chrono/HijrahDate.getHijrahDate(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): HijrahDate = 
            HijrahDate(x as ##java.time.chrono.HijrahDate)
    }
}

namespace Time/Chrono/HijrahDate {


    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.HijrahChronology;
    use Time/Chrono.HijrahChronology.{HijrahChronology};
    use Time/Chrono.HijrahEra;
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;
    use Time/Temporal.TemporalAmount;
    use Time/Temporal.TemporalField;
    use Time/Temporal.TemporalUnit;
    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.Period;    
    use Time.Period.{Period};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def getHijrahDate(x: HijrahDate): ##java.time.chrono.HijrahDate = 
        let HijrahDate(x1) = x;
        x1

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def fromTemporalAccessor(x: a): HijrahDate with TemporalAccessor[a] = 
        import static java.time.chrono.HijrahDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.HijrahDate & Pure as fromTA;
        let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
        HijrahDate(fromTA(x1))


    pub def of(r: {prolepticYear :: Int32, month :: Int32, dayOfMonth :: Int32}): HijrahDate =
        import static java.time.chrono.HijrahDate.of(Int32, Int32, Int32): ##java.time.chrono.HijrahDate & Pure;
        HijrahDate(of(r.prolepticYear, r.month, r.dayOfMonth))


    ///
    /// Returns ___
    ///
    pub def now(): HijrahDate & Impure =
        import static java.time.chrono.HijrahDate.now(): ##java.time.chrono.HijrahDate & Impure;
        HijrahDate(now())

    pub def nowWithClock(x: Clock): HijrahDate & Impure =
        import static java.time.chrono.HijrahDate.now(##java.time.Clock): ##java.time.chrono.HijrahDate & Impure;
        let Clock(x1) = x;
        HijrahDate(now(x1))

    pub def nowWithZoneId(x: ZoneId): HijrahDate & Impure =
        import static java.time.chrono.HijrahDate.now(##java.time.ZoneId): ##java.time.chrono.HijrahDate & Impure;
        let ZoneId(x1) = x;
        HijrahDate(now(x1))


    pub def equals(x: HijrahDate, y: HijrahDate): Bool = 
        import java.time.chrono.HijrahDate.equals(##java.lang.Object): Bool & Pure;
        let HijrahDate(x1) = x;
        let HijrahDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: HijrahDate): Int32 = 
        import java.time.chrono.HijrahDate.hashCode(): Int32 & Pure;
        let HijrahDate(x1) = x;
        hashCode(x1)


    pub def toLocalDate(x: HijrahDate): LocalDate =
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate & Pure as fromDate;
        let HijrahDate(x1) = x;
        LocalDate(fromDate(x1 as ##java.time.temporal.TemporalAccessor))

    pub def getChronology(x: HijrahDate): HijrahChronology = 
        import java.time.chrono.HijrahDate.getChronology(): ##java.time.chrono.HijrahChronology & Pure;
        let HijrahDate(x1) = x;
        HijrahChronology(getChronology(x1))

    pub def getEra(x: HijrahDate): HijrahEra = 
        import java.time.chrono.HijrahDate.getEra(): ##java.time.chrono.HijrahEra & Pure;
        let HijrahDate(x1) = x;
        Time/Chrono/HijrahEra.unmarshal(getEra(x1))

    pub def isLeapYear(x: HijrahDate): Bool = 
        import java.time.chrono.HijrahDate.isLeapYear(): Bool & Pure;
        let HijrahDate(x1) = x;
        isLeapYear(x1)

    pub def lengthOfMonth(x: HijrahDate): Int32 = 
        import java.time.chrono.HijrahDate.lengthOfMonth(): Int32 & Pure;
        let HijrahDate(x1) = x;
        lengthOfMonth(x1)

    pub def lengthOfYear(x: HijrahDate): Int32 = 
        import java.time.chrono.HijrahDate.lengthOfYear(): Int32 & Pure;
        let HijrahDate(x1) = x;
        lengthOfYear(x1)


    pub def plusPeriod(x: HijrahDate, amount: Period): HijrahDate = 
        import java.time.chrono.HijrahDate.plus(##java.time.temporal.TemporalAmount): ##java.time.chrono.HijrahDate & Pure;
        let HijrahDate(x1) = x;
        let Period(amount1) = amount;
        let tamount1 = amount1 as ##java.time.temporal.TemporalAmount;
        HijrahDate(plus(x1, tamount1))

    pub def minusPeriod(x: HijrahDate, amount: Period): HijrahDate = 
        import java.time.chrono.HijrahDate.minus(##java.time.temporal.TemporalAmount): ##java.time.chrono.HijrahDate & Pure;
        let HijrahDate(x1) = x;
        let Period(amount1) = amount;
        let tamount1 = amount1 as ##java.time.temporal.TemporalAmount;
        HijrahDate(minus(x1, tamount1))



    pub def withVariant(x: HijrahDate, chronology: HijrahChronology): HijrahDate = 
        import java.time.chrono.HijrahDate.withVariant(##java.time.chrono.HijrahChronology): ##java.time.chrono.HijrahDate & Pure;
        let HijrahDate(x1) = x;
        let HijrahChronology(chronology1) = chronology;
        HijrahDate(withVariant(x1, chronology1))

    pub def getLong(t: a, x: HijrahDate): Int64 with TemporalField[a] = 
        import java.time.chrono.HijrahDate.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getHijrahDate(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)


    pub def plus(x: HijrahDate, r: {amount :: Int64, temporalUnit :: a}): HijrahDate with TemporalUnit[a] =
        import java.time.chrono.HijrahDate.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.chrono.HijrahDate & Pure;         
        try {
            let HijrahDate(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            HijrahDate(plus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minus(x: HijrahDate, r: {amount :: Int64, temporalUnit :: a}): HijrahDate with TemporalUnit[a] =
        import java.time.chrono.HijrahDate.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.chrono.HijrahDate & Pure;         
        try {
            let HijrahDate(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            HijrahDate(minus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def plusTemporalAmount(x: HijrahDate, amount: a): HijrahDate with TemporalAmount[a] =
        import java.time.chrono.HijrahDate.plus(##java.time.temporal.TemporalAmount): ##java.time.chrono.HijrahDate & Pure;         
        try {
            let HijrahDate(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            HijrahDate(plus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmount(x: HijrahDate, amount: a): HijrahDate with TemporalAmount[a] =
        import java.time.chrono.HijrahDate.minus(##java.time.temporal.TemporalAmount): ##java.time.chrono.HijrahDate & Pure;         
        try {
            let HijrahDate(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            HijrahDate(minus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def until(units: t, r: {start :: HijrahDate, end :: a}): Int64 with TemporalUnit[t], Temporal[a] = 
        import java.time.chrono.HijrahDate.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getHijrahDate(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        let units1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(units);
        until(b1, e1, units1)


    pub def withTemporalAdjuster(adj: a, x: HijrahDate): HijrahDate with TemporalAdjuster[a] =
        import java.time.chrono.HijrahDate.with(##java.time.temporal.TemporalAdjuster): ##java.time.chrono.HijrahDate & Pure as withTA;         
        try {
            let HijrahDate(x1) = x;
            let adj1 = Time/Temporal/TemporalAdjuster.marshalToNativeTemporalAdjuster(adj);
            HijrahDate(withTA(x1, adj1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalField(field: a, i: Int64, x: HijrahDate): HijrahDate with TemporalField[a] =
        import java.time.chrono.HijrahDate.with(##java.time.temporal.TemporalField, Int64): ##java.time.chrono.HijrahDate & Pure as withTF;         
        try {
            let HijrahDate(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            HijrahDate(withTF(x1, field1, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


}
