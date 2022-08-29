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
    /// A wrapper around java.time.chrono.ThaiBuddhistDate.
    ///
    pub enum ThaiBuddhistDate(##java.time.chrono.ThaiBuddhistDate)
    
    ///
    /// Returns the given ThaiBuddhistDate `x` as a String.
    ///
    instance ToString[ThaiBuddhistDate] {
        pub def toString(x: ThaiBuddhistDate): String =
            import java.time.chrono.ThaiBuddhistDate.toString(): String \ {};
            let ThaiBuddhistDate(x1) = x;
            toString(x1)
    }

    instance Eq[ThaiBuddhistDate] {
        pub def eq(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool = Time/Chrono/ThaiBuddhistDate.equals(x, y)
    }
    
    instance Hash[ThaiBuddhistDate] {
        pub def hash(x: ThaiBuddhistDate): Int32 = Time/Chrono/ThaiBuddhistDate.hashCode(x)
    } 
}

namespace Time/Chrono/ThaiBuddhistDate {


    use Time/Chrono.ThaiBuddhistDate;
    use Time/Chrono.ThaiBuddhistDate.{ThaiBuddhistDate};
    use Time/Temporal.ChronoField;
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    ///
    /// Returns ___
    ///
    pub def now(): ThaiBuddhistDate \ IO =
        import static java.time.chrono.ThaiBuddhistDate.now(): ##java.time.chrono.ThaiBuddhistDate \ IO;
        ThaiBuddhistDate(now())


    pub def equals(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool = 
        import java.time.chrono.ThaiBuddhistDate.equals(##java.lang.Object): Bool \ {};
        let ThaiBuddhistDate(x1) = x;
        let ThaiBuddhistDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ThaiBuddhistDate): Int32 = 
        import java.time.chrono.ThaiBuddhistDate.hashCode(): Int32 \ {};
        let ThaiBuddhistDate(x1) = x;
        hashCode(x1)


    pub def toLocalDate(x: ThaiBuddhistDate): LocalDate =
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromDate;
        let ThaiBuddhistDate(x1) = x;
        LocalDate(fromDate(x1 as ##java.time.temporal.TemporalAccessor))


    /// pub def getDayOfWeek(x: ThaiBuddhistDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfWeek)
    ///         |> Result.getWithDefault(-1)
        
    /// pub def getDayOfMonth(x: ThaiBuddhistDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfMonth)
    ///         |> Result.getWithDefault(-1)
    
    /// pub def getDayOfYear(x: ThaiBuddhistDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getMonthOfYear(x: ThaiBuddhistDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.MonthOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYear(x: ThaiBuddhistDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.Year)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYearOfEra(x: ThaiBuddhistDate): Int32 = 
    ///     getChronoFieldHelper(x, Time/Temporal/ChronoField.YearOfEra)
    ///         |> Result.getWithDefault(-1)


    /// def getChronoFieldHelper(x: ThaiBuddhistDate, field: ChronoField): Result[Int32, String] =
    ///     import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    ///     try {
    ///         let ThaiBuddhistDate(x1) = x;
    ///         let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    ///         Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1))
    ///     } catch {
    ///         case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field}')")
    ///     }

}
