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


    use ee::EffectExtras.Fail.Fail
    use ae::JavaInterop.InteropErr
    use ae::JavaInterop.AdaptorChecked
    use ae::JavaInterop.AdaptorUnchecked

    use InteropTime.Chrono.ThaiBuddhistChronology.ThaiBuddhistChronology
    use InteropTime.Chrono.ThaiBuddhistEra.ThaiBuddhistEra
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime

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
            let ThaiBuddhistDate.ThaiBuddhistDate(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ThaiBuddhistDate] {
        pub def eq(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool = 
            let ThaiBuddhistDate.ThaiBuddhistDate(x1) = x;
            let ThaiBuddhistDate.ThaiBuddhistDate(y1) = y;
            unsafe IO { x1.equals(y1) }

    }

    instance Hash[ThaiBuddhistDate] {
        pub def hash(x: ThaiBuddhistDate): Int32 = 
            let ThaiBuddhistDate.ThaiBuddhistDate(x1) = x;
            unsafe IO { x1.hashCode() }

    }

    instance ToJava[ThaiBuddhistDate] {
        type Out = JThaiBuddhistDate
        pub def toJava(x: ThaiBuddhistDate): JThaiBuddhistDate = 
            let ThaiBuddhistDate.ThaiBuddhistDate(x1) = x;
            x1
    }

    instance ToFlix[ThaiBuddhistDate] {
        type In = JThaiBuddhistDate
        pub def toFlix(x: JThaiBuddhistDate): ThaiBuddhistDate = ThaiBuddhistDate.ThaiBuddhistDate(x)
    }

    pub def newThaiBuddhistDate(prolepticYear: {prolepticYear = Int32}, 
                                month: {month = Int32}, 
                                dayOfMonth: {dayOfMonth = Int32}): ThaiBuddhistDate \ Fail[InteropErr] =
        AdaptorChecked.of(() -> unsafe IO { JThaiBuddhistDate.of(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth) })

    pub def newWithLocalDate(x: LocalDate): ThaiBuddhistDate = 
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JThaiBuddhistDate.$from(x1) })

    pub def newWithLocalDateTime(x: LocalDateTime): ThaiBuddhistDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JThaiBuddhistDate.$from(x1) })

    ///
    /// Returns ___
    ///
    pub def now(): ThaiBuddhistDate \ IO = 
        AdaptorUnchecked.of(() -> { JThaiBuddhistDate.now() })


    pub def toEpochDay(x: ThaiBuddhistDate): Int64 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.toEpochDay() })

    pub def toLocalDate(x: ThaiBuddhistDate): LocalDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JLocalDate.$from(x1) })


    pub def getEra(x: ThaiBuddhistDate): ThaiBuddhistEra = 
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getEra() })

    pub def isEqual(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isEqual(y1) })

    pub def isAfter(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    pub def isBefore(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

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
