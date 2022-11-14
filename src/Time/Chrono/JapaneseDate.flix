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
    pub enum JapaneseDate(##java.time.chrono.JapaneseDate)
    
    ///
    /// Returns the given JapaneseDate `x` as a String.
    ///
    instance ToString[JapaneseDate] {
        pub def toString(x: JapaneseDate): String =
            import java.time.chrono.JapaneseDate.toString(): String \ {};
            let JapaneseDate(x1) = x;
            toString(x1)
    }

    instance Eq[JapaneseDate] {
        pub def eq(x: JapaneseDate, y: JapaneseDate): Bool = Time/Chrono/JapaneseDate.equals(x, y)
    }
    
    instance Hash[JapaneseDate] {
        pub def hash(x: JapaneseDate): Int32 = Time/Chrono/JapaneseDate.hashCode(x)
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
    pub def japaneseDate(r: {prolepticYear = Int32, month = Int32, dayOfMonth = Int32}): JapaneseDate  =
        import static java.time.chrono.JapaneseDate.of(Int32, Int32, Int32): ##java.time.chrono.JapaneseDate \ {};
        JapaneseDate(of(r.prolepticYear, r.month, r.dayOfMonth))

    pub def japaneseDateWithJapaneseEra(r: {era = JapaneseEra, yearOfEra = Int32, month = Int32, dayOfMonth = Int32}): JapaneseDate  =
        import static java.time.chrono.JapaneseDate.of(##java.time.chrono.JapaneseEra, Int32, Int32, Int32): ##java.time.chrono.JapaneseDate \ {};
        let JapaneseEra(era1) = r.era;
        JapaneseDate(of(era1, r.yearOfEra, r.month, r.dayOfMonth))


    ///
    /// Returns ___
    ///
    pub def now(): JapaneseDate \ IO =
        import static java.time.chrono.JapaneseDate.now(): ##java.time.chrono.JapaneseDate \ IO;
        JapaneseDate(now())

    pub def fromLocalDate(x: LocalDate): JapaneseDate = 
        import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {};
        let LocalDate(x1) = x;
        JapaneseDate(from(x1 as ##java.time.temporal.TemporalAccessor))


    pub def toLocalDate(x: JapaneseDate): LocalDate =
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromDate;
        let JapaneseDate(x1) = x;
        LocalDate(fromDate(x1 as ##java.time.temporal.TemporalAccessor))


    pub def fromHijrahDate(x: HijrahDate): JapaneseDate = 
        import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
        let HijrahDate(x1) = x;
        JapaneseDate(fromDate(x1 as ##java.time.temporal.TemporalAccessor))

    pub def fromMinguoDate(x: MinguoDate): JapaneseDate = 
        import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
        let MinguoDate(x1) = x;
        JapaneseDate(fromDate(x1 as ##java.time.temporal.TemporalAccessor))

    pub def fromThaiBuddhistDate(x: ThaiBuddhistDate): JapaneseDate = 
        import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
        let ThaiBuddhistDate(x1) = x;
        JapaneseDate(fromDate(x1 as ##java.time.temporal.TemporalAccessor))

    pub def equals(x: JapaneseDate, y: JapaneseDate): Bool = 
        import java.time.chrono.JapaneseDate.equals(##java.lang.Object): Bool \ {};
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: JapaneseDate): Int32 = 
        import java.time.chrono.JapaneseDate.hashCode(): Int32 \ {};
        let JapaneseDate(x1) = x;
        hashCode(x1)


    pub def getChronology(x: JapaneseDate): JapaneseChronology = 
        import java.time.chrono.JapaneseDate.getChronology(): ##java.time.chrono.JapaneseChronology \ {};
        let JapaneseDate(x1) = x;
        JapaneseChronology(getChronology(x1))


    pub def getEra(x: JapaneseDate): JapaneseEra = 
        import java.time.chrono.JapaneseDate.getEra(): ##java.time.chrono.JapaneseEra \ {};
        let JapaneseDate(x1) = x;
        JapaneseEra(getEra(x1))

    pub def lengthOfMonth(x: JapaneseDate): Int32 = 
        import java.time.chrono.JapaneseDate.lengthOfMonth(): Int32 \ {};
        let JapaneseDate(x1) = x;
        lengthOfMonth(x1)
    
    /// pub def getDayOfWeek(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfWeek)
    ///         |> Result.getWithDefault(-1)
        
    /// pub def getDayOfMonth(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfMonth)
    ///         |> Result.getWithDefault(-1)

    /// pub def getDayOfYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getMonthOfYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.MonthOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.Year)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYearOfEra(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.YearOfEra)
    ///         |> Result.getWithDefault(-1)

    /// def getChronoFieldHelper(x: JapaneseDate, field: ChronoField): Result[Int32, String] =
    ///     import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    ///     try {
    ///         let JapaneseDate(x1) = x;
    ///         let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    ///         Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1))
    ///     } catch {
    ///         case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field}')")
    ///     }
        


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: JapaneseDate, y: JapaneseDate): Bool =
        import java.time.chrono.ChronoLocalDate.isBefore(##java.time.chrono.ChronoLocalDate): Bool \ {};
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        isBefore(x1 as ##java.time.chrono.ChronoLocalDate,  y1 as ##java.time.chrono.ChronoLocalDate)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: JapaneseDate, y: JapaneseDate): Bool =
        import java.time.chrono.ChronoLocalDate.isAfter(##java.time.chrono.ChronoLocalDate): Bool \ {};
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        isAfter(x1 as ##java.time.chrono.ChronoLocalDate, y1 as ##java.time.chrono.ChronoLocalDate)

}
