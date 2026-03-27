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

pub mod InteropTime.Chrono.JapaneseDate {


    use InteropTime.Chrono.JapaneseDate.JapaneseDate
    use InteropTime.Chrono.JapaneseDate.JapaneseDate.{JapaneseDate}

    use InteropTime.Chrono.HijrahDate.HijrahDate
    use InteropTime.Chrono.HijrahDate.HijrahDate.{HijrahDate}
    use InteropTime.Chrono.MinguoDate.MinguoDate
    use InteropTime.Chrono.MinguoDate.MinguoDate.{MinguoDate}
    use InteropTime.Chrono.ThaiBuddhistDate.ThaiBuddhistDate
    use InteropTime.Chrono.ThaiBuddhistDate.ThaiBuddhistDate.{ThaiBuddhistDate}
    use InteropTime.Chrono.JapaneseChronology.JapaneseChronology
    use InteropTime.Chrono.JapaneseChronology.JapaneseChronology.{JapaneseChronology}
    use InteropTime.Chrono.JapaneseEra.JapaneseEra
    use InteropTime.Chrono.JapaneseEra.JapaneseEra.{JapaneseEra}
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDate.LocalDate.{LocalDate}
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalDateTime.LocalDateTime.{LocalDateTime}
    
    import java.time.chrono.{JapaneseDate => JJapaneseDate}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        JapaneseEra => JJapaneseEra, 
        JapaneseChronology => JJapaneseChronology}
    import java.time.{LocalDate => JLocalDate}
    import java.lang.{Object }


    ///
    /// A wrapper around java.time.chrono.JapaneseDate.
    ///
    pub enum JapaneseDate(JJapaneseDate)

    ///
    /// Returns the given JapaneseDate `x` as a String.
    ///
    instance ToString[JapaneseDate] {
        pub def toString(x: JapaneseDate): String =
            let JapaneseDate(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[JapaneseDate] {
        pub def eq(x: JapaneseDate, y: JapaneseDate): Bool = InteropTime.Chrono.JapaneseDate.equals(x, y)
    }

    instance Hash[JapaneseDate] {
        pub def hash(x: JapaneseDate): Int32 = InteropTime.Chrono.JapaneseDate.hashCode(x)
    }


    ///
    /// Returns ___
    ///
    pub def japaneseDate(prolepticYear: {prolepticYear = Int32}, 
                            month: {month = Int32}, 
                            dayOfMonth: {dayOfMonth = Int32}): JapaneseDate  =
        JapaneseDate(unsafe IO { JJapaneseDate.of(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth) })

    pub def japaneseDateWithJapaneseEra(era: JapaneseEra, 
                                        yearOfEra: {yearOfEra = Int32}, 
                                        month: {month = Int32}, 
                                        dayOfMonth: {dayOfMonth = Int32}): JapaneseDate  =
        let JapaneseEra(era1) = era;
        JapaneseDate(unsafe IO { JJapaneseDate.of(era1, yearOfEra#yearOfEra, month#month, dayOfMonth#dayOfMonth) })


    //
    // Returns ___
    //
    pub def now(): JapaneseDate \ IO =
        JapaneseDate(JJapaneseDate.now())

    pub def equals(x: JapaneseDate, y: JapaneseDate): Bool = 
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        unsafe IO { x1.equals(y1) }

    pub def hashCode(x: JapaneseDate): Int32 = 
        let JapaneseDate(x1) = x;
        unsafe IO { x1.hashCode() }
        
    pub def toLocalDate(x: JapaneseDate): LocalDate =
        let JapaneseDate(x1) = x;
        let ans = unsafe IO { JLocalDate.$from(x1) };
        LocalDate(ans)

    pub def fromLocalDate(x: LocalDate): JapaneseDate = 
        let LocalDate(x1) = x;
        let ans = unsafe IO { JJapaneseDate.$from(x1) };
        JapaneseDate(ans)

    pub def fromLocalDateTime(x: LocalDateTime): JapaneseDate =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { JJapaneseDate.$from(x1) };
        JapaneseDate(ans)


    // pub def fromHijrahDate(x: HijrahDate): JapaneseDate = 
    //     import static java.time.chrono.JapaneseDate.$from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
    //     let HijrahDate(x1) = x;
    //     JapaneseDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))

    // pub def fromMinguoDate(x: MinguoDate): JapaneseDate = 
    //     import static java.time.chrono.JapaneseDate.$from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
    //     let MinguoDate(x1) = x;
    //     JapaneseDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))

    // pub def fromThaiBuddhistDate(x: ThaiBuddhistDate): JapaneseDate = 
    //     import static java.time.chrono.JapaneseDate.$from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
    //     let ThaiBuddhistDate(x1) = x;
    //     JapaneseDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))



    pub def getChronology(x: JapaneseDate): JapaneseChronology = 
        let JapaneseDate(x1) = x;
        let ans = unsafe IO { x1.getChronology() };
        JapaneseChronology(ans)


    pub def getEra(x: JapaneseDate): JapaneseEra = 
        let JapaneseDate(x1) = x;
        let ans = unsafe IO { x1.getEra() };
        JapaneseEra(ans)

    pub def lengthOfMonth(x: JapaneseDate): Int32 = 
        let JapaneseDate(x1) = x;
        unsafe IO { x1.lengthOfMonth() }
    
    /// pub def getDayOfWeek(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfWeek)
    ///         |> Result.getWithDefault(-1)
        
    /// pub def getDayOfMonth(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfMonth)
    ///         |> Result.getWithDefault(-1)

    /// pub def getDayOfYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getMonthOfYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.MonthOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.Year)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYearOfEra(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.YearOfEra)
    ///         |> Result.getWithDefault(-1)

    /// def getChronoFieldHelper(x: JapaneseDate, field: ChronoField): Result[String, Int32] =
    ///     Result.tryCatch(_ -> {
    ///         import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    ///         let JapaneseDate(x1) = x;
    ///         let field1 = InteropTime.Temporal.ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    ///         get(x1 as ##java.time.temporal.TemporalAccessor, field1)
    ///     })
        


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: JapaneseDate, y: JapaneseDate): Bool =
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        unsafe IO { x1.isBefore(y1) }

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: JapaneseDate, y: JapaneseDate): Bool =
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        unsafe IO { x1.isAfter(y1) }

}
