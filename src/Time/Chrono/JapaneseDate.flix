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

mod Time.Chrono {

    use Time.Chrono.JapaneseDate
    use Time.Chrono.JapaneseDate.{JapaneseDate}

    import java.time.chrono.{JapaneseDate => JJapaneseDate}

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
            unsafe x1.toString()
    }

    instance Eq[JapaneseDate] {
        pub def eq(x: JapaneseDate, y: JapaneseDate): Bool = Time.Chrono.JapaneseDate.equals(x, y)
    }
    
    instance Hash[JapaneseDate] {
        pub def hash(x: JapaneseDate): Int32 = Time.Chrono.JapaneseDate.hashCode(x)
    }  

}

mod Time.Chrono.JapaneseDate {


    use Time.Chrono.JapaneseDate
    use Time.Chrono.JapaneseDate.{JapaneseDate}
    use Time.Chrono.HijrahDate
    use Time.Chrono.HijrahDate.{HijrahDate}
    use Time.Chrono.MinguoDate
    use Time.Chrono.MinguoDate.{MinguoDate}
    use Time.Chrono.ThaiBuddhistDate
    use Time.Chrono.ThaiBuddhistDate.{ThaiBuddhistDate}
    use Time.Chrono.JapaneseChronology
    use Time.Chrono.JapaneseChronology.{JapaneseChronology}
    use Time.Chrono.JapaneseEra
    use Time.Chrono.JapaneseEra.{JapaneseEra}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    
    import java.time.chrono.{JapaneseDate => JJapaneseDate}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        JapaneseEra => JJapaneseEra, 
        JapaneseChronology => JJapaneseChronology}
    import java.lang.{Object}


    ///
    /// Returns ___
    ///
    pub def japaneseDate(r: {prolepticYear = Int32, month = Int32, dayOfMonth = Int32}): JapaneseDate  =
        JapaneseDate(unsafe JJapaneseDate.of(r#prolepticYear, r#month, r#dayOfMonth))

    pub def japaneseDateWithJapaneseEra(r: {era = JapaneseEra, yearOfEra = Int32, month = Int32, dayOfMonth = Int32}): JapaneseDate  =
        let JapaneseEra(era1) = r#era;
        JapaneseDate(unsafe JJapaneseDate.of(era1, r#yearOfEra, r#month, r#dayOfMonth))


    //
    // Returns ___
    //
    pub def now(): JapaneseDate \ IO =
        JapaneseDate(JJapaneseDate.now())

    // pub def fromLocalDate(x: LocalDate): JapaneseDate = 
    //     import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as from1;
    //     let LocalDate(x1) = x;
    //     JapaneseDate(unsafe JJapaneseDate.from1(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))


    // pub def toLocalDate(x: JapaneseDate): LocalDate =
    //     import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromDate;
    //     let JapaneseDate(x1) = x;
    //     LocalDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))


    // pub def fromHijrahDate(x: HijrahDate): JapaneseDate = 
    //     import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
    //     let HijrahDate(x1) = x;
    //     JapaneseDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))

    // pub def fromMinguoDate(x: MinguoDate): JapaneseDate = 
    //     import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
    //     let MinguoDate(x1) = x;
    //     JapaneseDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))

    // pub def fromThaiBuddhistDate(x: ThaiBuddhistDate): JapaneseDate = 
    //     import static java.time.chrono.JapaneseDate.from(##java.time.temporal.TemporalAccessor): ##java.time.chrono.JapaneseDate \ {} as fromDate;
    //     let ThaiBuddhistDate(x1) = x;
    //     JapaneseDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))

    pub def equals(x: JapaneseDate, y: JapaneseDate): Bool = 
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        let obj = (checked_cast(y1) : Object);
        unsafe x1.equals(obj)

    pub def hashCode(x: JapaneseDate): Int32 = 
        let JapaneseDate(x1) = x;
        unsafe x1.hashCode()


    pub def getChronology(x: JapaneseDate): JapaneseChronology = 
        let JapaneseDate(x1) = x;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let ans = unsafe cx1.getChronology();
        let ans1 = unchecked_cast(ans as JJapaneseChronology);
        JapaneseChronology(ans1)


    pub def getEra(x: JapaneseDate): JapaneseEra = 
        let JapaneseDate(x1) = x;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let ans = unsafe cx1.getEra();
        let ans1 = unchecked_cast(ans as JJapaneseEra);
        JapaneseEra(ans1)

    pub def lengthOfMonth(x: JapaneseDate): Int32 = 
        let JapaneseDate(x1) = x;
        unsafe x1.lengthOfMonth()
    
    /// pub def getDayOfWeek(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time.Temporal.ChronoField.DayOfWeek)
    ///         |> Result.getWithDefault(-1)
        
    /// pub def getDayOfMonth(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time.Temporal.ChronoField.DayOfMonth)
    ///         |> Result.getWithDefault(-1)

    /// pub def getDayOfYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time.Temporal.ChronoField.DayOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getMonthOfYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time.Temporal.ChronoField.MonthOfYear)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYear(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time.Temporal.ChronoField.Year)
    ///         |> Result.getWithDefault(-1)

    /// pub def getYearOfEra(x: JapaneseDate): Int32 = 
    ///     getChronoFieldHelper(x, Time.Temporal.ChronoField.YearOfEra)
    ///         |> Result.getWithDefault(-1)

    /// def getChronoFieldHelper(x: JapaneseDate, field: ChronoField): Result[String, Int32] =
    ///     Result.tryCatch(_ -> {
    ///         import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    ///         let JapaneseDate(x1) = x;
    ///         let field1 = Time.Temporal.ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    ///         get(x1 as ##java.time.temporal.TemporalAccessor, field1)
    ///     })
        


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: JapaneseDate, y: JapaneseDate): Bool =
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let cy1 = (checked_cast(y1) : JChronoLocalDate);
        unsafe cx1.isBefore(cy1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: JapaneseDate, y: JapaneseDate): Bool =
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        let cx1 = (checked_cast(x1) : JChronoLocalDate);
        let cy1 = (checked_cast(y1) : JChronoLocalDate);
        unsafe cx1.isAfter(cy1)

}
