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

/// Notes - implements ChronoLocalDate

namespace Time/Chrono {
    
    ///
    /// A wrapper around java.time.chrono.JapaneseDate.
    ///
    pub opaque type JapaneseDate = ##java.time.chrono.JapaneseDate
    
    ///
    /// Returns the given JapaneseDate `x` as a String.
    ///
    instance ToString[JapaneseDate] {
        pub def toString(x: JapaneseDate): String =
            import java.time.chrono.JapaneseDate.toString();
            let JapaneseDate(x1) = x;
            toString(x1) as & Pure
    }

    instance Eq[JapaneseDate] {
        pub def eq(x: JapaneseDate, y: JapaneseDate): Bool = Time/Chrono/JapaneseDate.equals(x, y)
    }
    
    instance Hash[JapaneseDate] {
        pub def hash(x: JapaneseDate): Int = Time/Chrono/JapaneseDate.hashCode(x)
    }  

}

namespace Time/Chrono/JapaneseDate {


    use Time/Chrono.JapaneseDate;
    use Time/Chrono.JapaneseDate.{JapaneseDate};
    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.MinguoDate;
    use Time/Chrono.MinguoDate.{MinguoDate};
    use Time/Chrono.ThaiBuddhistDate;
    use Time/Chrono.ThaiBuddhistDate.{ThaiBuddhistDate};
    use Time/Chrono.JapaneseChronology;
    use Time/Chrono.JapaneseChronology.{JapaneseChronology};
    use Time/Chrono.JapaneseEra;
    use Time/Chrono.JapaneseEra.{JapaneseEra};
    use Time/Temporal.ChronoField;
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    
    ///
    /// Returns ___
    ///
    pub def new(x: {prolepticYear: Int32, month: Int32, dayOfMonth: Int32}): JapaneseDate  =
        import java.time.chrono.JapaneseDate:of(Int32, Int32, Int32);
        JapaneseDate(of(x.prolepticYear, x.month, x.dayOfMonth)) as & Pure

    pub def newWithJapaneseEra(x: {era: JapaneseEra, yearOfEra: Int32, month: Int32, dayOfMonth: Int32}): JapaneseDate  =
        import java.time.chrono.JapaneseDate:of(##java.time.chrono.JapaneseEra, Int32, Int32, Int32);
        let JapaneseEra(era1) = x.era;
        JapaneseDate(of(era1, x.yearOfEra, x.month, x.dayOfMonth)) as & Pure


    ///
    /// Returns ___
    ///
    pub def now(): JapaneseDate & Impure =
        import java.time.chrono.JapaneseDate:now();
        JapaneseDate(now())

    pub def ofLocalDate(x: LocalDate): JapaneseDate = 
        import java.time.chrono.JapaneseDate:from(##java.time.temporal.TemporalAccessor);
        let LocalDate(x1) = x;
        JapaneseDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def ofHijrahDate(x: HijrahDate): JapaneseDate = 
        import java.time.chrono.JapaneseDate:from(##java.time.temporal.TemporalAccessor);
        let HijrahDate(x1) = x;
        JapaneseDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def ofMinguoDate(x: MinguoDate): JapaneseDate = 
        import java.time.chrono.JapaneseDate:from(##java.time.temporal.TemporalAccessor);
        let MinguoDate(x1) = x;
        JapaneseDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def ofThaiBuddhistDate(x: ThaiBuddhistDate): JapaneseDate = 
        import java.time.chrono.JapaneseDate:from(##java.time.temporal.TemporalAccessor);
        let ThaiBuddhistDate(x1) = x;
        JapaneseDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def equals(x: JapaneseDate, y: JapaneseDate): Bool = 
        import java.time.chrono.JapaneseDate.equals(##java.lang.Object);
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: JapaneseDate): Int32 = 
        import java.time.chrono.JapaneseDate.hashCode();
        let JapaneseDate(x1) = x;
        hashCode(x1) as & Pure


    pub def getChronology(x: JapaneseDate): JapaneseChronology = 
        import java.time.chrono.JapaneseDate.getChronology();
        let JapaneseDate(x1) = x;
        JapaneseChronology(getChronology(x1)) as & Pure


    pub def getEra(x: JapaneseDate): JapaneseEra = 
        import java.time.chrono.JapaneseDate.getEra();
        let JapaneseDate(x1) = x;
        JapaneseEra(getEra(x1)) as & Pure

    pub def lengthOfMonth(x: JapaneseDate): Int32 = 
        import java.time.chrono.JapaneseDate.lengthOfMonth();
        let JapaneseDate(x1) = x;
        lengthOfMonth(x1) as & Pure
    
    pub def getDayOfWeek(x: JapaneseDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfWeek), -1)
        
    pub def getDayOfMonth(x: JapaneseDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfMonth), -1)
    
    pub def getDayOfYear(x: JapaneseDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfYear), -1)

    pub def getMonthOfYear(x: JapaneseDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.MonthOfYear), -1)

    pub def getYear(x: JapaneseDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.Year), -1)

    pub def getYearOfEra(x: JapaneseDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.YearOfEra), -1)


    def getChronoFieldHelper(x: JapaneseDate, field: ChronoField): Result[Int32, String] =
        import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField);
        try {
            let JapaneseDate(x1) = x;
            let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
            Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1)) as & Pure
        } catch {
            case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field}')")
        }
        


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: JapaneseDate, y: JapaneseDate): Bool =
        import java.time.chrono.ChronoLocalDate.isBefore(##java.time.chrono.ChronoLocalDate);
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        isBefore(x1 as ##java.time.chrono.ChronoLocalDate,  y1 as ##java.time.chrono.ChronoLocalDate) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: JapaneseDate, y: JapaneseDate): Bool =
        import java.time.chrono.ChronoLocalDate.isAfter(##java.time.chrono.ChronoLocalDate);
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        isAfter(x1 as ##java.time.chrono.ChronoLocalDate, y1 as ##java.time.chrono.ChronoLocalDate) as & Pure

}
