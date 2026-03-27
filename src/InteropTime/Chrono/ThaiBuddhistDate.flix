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


pub mod InteropTime.Chrono.ThaiBuddhistDate {


    use InteropTime.Chrono.ThaiBuddhistDate.ThaiBuddhistDate
    use InteropTime.Chrono.ThaiBuddhistDate.ThaiBuddhistDate.{ThaiBuddhistDate}

    use InteropTime.Chrono.ThaiBuddhistChronology.ThaiBuddhistChronology
    use InteropTime.Chrono.ThaiBuddhistChronology.ThaiBuddhistChronology.{ThaiBuddhistChronology}
    use InteropTime.Chrono.ThaiBuddhistEra.ThaiBuddhistEra
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDate.LocalDate.{LocalDate}
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalDateTime.LocalDateTime.{LocalDateTime}

    import java.time.chrono.{ThaiBuddhistDate => JThaiBuddhistDate}
    import java.time.chrono.{ThaiBuddhistChronology => JThaiBuddhistChronology}
    import java.time.chrono.{ThaiBuddhistEra => JThaiBuddhistEra}
    import java.time.{LocalDate => JLocalDate }
    import java.lang.{Object }

    ///
    /// A wrapper around java.time.chrono.ThaiBuddhistDate.
    ///
    pub enum ThaiBuddhistDate(JThaiBuddhistDate)

    ///
    /// Returns the given ThaiBuddhistDate `x` as a String.
    ///
    instance ToString[ThaiBuddhistDate] {
        pub def toString(x: ThaiBuddhistDate): String =
            let ThaiBuddhistDate(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ThaiBuddhistDate] {
        pub def eq(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool = InteropTime.Chrono.ThaiBuddhistDate.equals(x, y)
    }

    instance Hash[ThaiBuddhistDate] {
        pub def hash(x: ThaiBuddhistDate): Int32 = InteropTime.Chrono.ThaiBuddhistDate.hashCode(x)
    }

    ///
    /// Returns ___
    ///
    pub def now(): ThaiBuddhistDate \ IO = ThaiBuddhistDate(JThaiBuddhistDate.now())


    pub def equals(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool = 
        let ThaiBuddhistDate(x1) = x;
        let ThaiBuddhistDate(y1) = y;
        unsafe IO { x1.equals(y1) }

    pub def hashCode(x: ThaiBuddhistDate): Int32 = 
        let ThaiBuddhistDate(x1) = x;
        unsafe IO { x1.hashCode() }


    pub def toLocalDate(x: ThaiBuddhistDate): LocalDate =
        let ThaiBuddhistDate(x1) = x;
        let ans = unsafe IO { JLocalDate.$from(x1) };
        LocalDate(ans)

    pub def fromLocalDate(x: LocalDate): ThaiBuddhistDate = 
        let LocalDate(x1) = x;
        let ans = unsafe IO { JThaiBuddhistDate.$from(x1) };
        ThaiBuddhistDate(ans)

    pub def fromLocalDateTime(x: LocalDateTime): ThaiBuddhistDate =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { JThaiBuddhistDate.$from(x1) };
        ThaiBuddhistDate(ans)

    pub def getChronology(x: ThaiBuddhistDate): ThaiBuddhistChronology = 
        let ThaiBuddhistDate(x1) = x;
        let ans = unsafe IO { x1.getChronology() };
        ThaiBuddhistChronology(ans)

    pub def getEra(x: ThaiBuddhistDate): ThaiBuddhistEra = 
        let ThaiBuddhistDate(x1) = x;
        let ans = unsafe IO { x1.getEra() };
        InteropTime.Chrono.ThaiBuddhistEra.unmarshalThaiBuddhistEra(ans)

    // pub def getDayOfWeek(x: ThaiBuddhistDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfWeek)
    //         |> Result.getWithDefault(-1)
        
    // pub def getDayOfMonth(x: ThaiBuddhistDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfMonth)
    //         |> Result.getWithDefault(-1)
    
    // pub def getDayOfYear(x: ThaiBuddhistDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfYear)
    //         |> Result.getWithDefault(-1)

    // pub def getMonthOfYear(x: ThaiBuddhistDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.MonthOfYear)
    //         |> Result.getWithDefault(-1)

    // pub def getYear(x: ThaiBuddhistDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.Year)
    //         |> Result.getWithDefault(-1)

    // pub def getYearOfEra(x: ThaiBuddhistDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.YearOfEra)
    //         |> Result.getWithDefault(-1)


    // def getChronoFieldHelper(x: ThaiBuddhistDate, field: ChronoField): Result[String, Int32] =
    //     import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    //     try {
    //         let ThaiBuddhistDate(x1) = x;
    //         let field1 = InteropTime.Temporal.ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    //         Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1))
    //     } catch {
    //         case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field }')")
    //     }

}
