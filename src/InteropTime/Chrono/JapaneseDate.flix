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


    use EffectExtras.Fail.Fail
    use JavaInterop.AdaptorChecked
    use JavaInterop.AdaptorUnchecked

    use InteropTime.Chrono.HijrahDate.HijrahDate
    use InteropTime.Chrono.MinguoDate.MinguoDate
    use InteropTime.Chrono.ThaiBuddhistDate.ThaiBuddhistDate
    use InteropTime.Chrono.JapaneseChronology.JapaneseChronology
    use InteropTime.Chrono.JapaneseEra.JapaneseEra
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    
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
            let JapaneseDate.JapaneseDate(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[JapaneseDate] {
        pub def eq(x: JapaneseDate, y: JapaneseDate): Bool =
            let JapaneseDate.JapaneseDate(x1) = x;
            let JapaneseDate.JapaneseDate(y1) = y;
            unsafe IO { x1.equals(y1) }

    }

    instance Hash[JapaneseDate] {
        pub def hash(x: JapaneseDate): Int32 =
            let JapaneseDate.JapaneseDate(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance ToJava[JapaneseDate] {
        type Out = JJapaneseDate
        pub def toJava(x: JapaneseDate): JJapaneseDate = 
            let JapaneseDate.JapaneseDate(x1) = x;
            x1
    }

    instance ToFlix[JapaneseDate] {
        type In = JJapaneseDate
        pub def toFlix(x: JJapaneseDate): JapaneseDate = 
            JapaneseDate.JapaneseDate(x)
    }


    ///
    /// Returns ___
    ///
    pub def newJapaneseDate(prolepticYear: {prolepticYear = Int32}, 
                            month: {month = Int32}, 
                            dayOfMonth: {dayOfMonth = Int32}): JapaneseDate \ Fail =
        AdaptorChecked.of(() -> unsafe IO { JJapaneseDate.of(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth) })

    pub def newJapaneseDateWithJapaneseEra(era: JapaneseEra, 
                                            yearOfEra: {yearOfEra = Int32}, 
                                            month: {month = Int32}, 
                                            dayOfMonth: {dayOfMonth = Int32}): JapaneseDate \ Fail =
        
        AdaptorChecked.op(era, era1 -> 
            unsafe IO { JJapaneseDate.of(era1, yearOfEra#yearOfEra, month#month, dayOfMonth#dayOfMonth) }
        )

    pub def newWithLocalDate(x: LocalDate): JapaneseDate = 
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JJapaneseDate.$from(x1) })

    pub def newWithLocalDateTime(x: LocalDateTime): JapaneseDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JJapaneseDate.$from(x1) })



    //
    // Returns ___
    //
    pub def now(): JapaneseDate \ IO =
        AdaptorUnchecked.of(() -> { JJapaneseDate.now() })



    pub def toEpochDay(x: JapaneseDate): Int64 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.toEpochDay() })

    pub def toLocalDate(x: JapaneseDate): LocalDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JLocalDate.$from(x1) })


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


    pub def getEra(x: JapaneseDate): JapaneseEra = 
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getEra() })

    pub def lengthOfMonth(x: JapaneseDate): Int32 = 
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.lengthOfMonth() })
    
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
    ///     try {
    ///         import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    ///         let JapaneseDate(x1) = x;
    ///         let field1 = InteropTime.Temporal.ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    ///         get(x1 as ##java.time.temporal.TemporalAccessor, field1) |> Ok
    ///     } catch {
    ///          case e: JException => Err(e.getMessage())
    ///     }
        


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: JapaneseDate, y: JapaneseDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: JapaneseDate, y: JapaneseDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

}
