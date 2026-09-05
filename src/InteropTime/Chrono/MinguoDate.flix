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


pub mod InteropTime.Chrono.MinguoDate {

    use EffectExtras.Fail.Fail
    use JavaInterop.AdaptorChecked
    use JavaInterop.AdaptorUnchecked

    use InteropTime.Chrono.MinguoChronology.MinguoChronology
    use InteropTime.Chrono.MinguoEra.MinguoEra
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime

    import java.time.chrono.{MinguoDate => JMinguoDate}
    import java.time.chrono.{MinguoEra => JMinguoEra}
    import java.time.chrono.{MinguoChronology => JMinguoChronology}
    import java.time.{LocalDate => JLocalDate}
    import java.lang.{Object}

    ///
    /// A wrapper around java.time.chrono.MinguoDate.
    ///
    pub enum MinguoDate(JMinguoDate)

    ///
    /// Returns the given MinguoDate `x` as a String.
    ///
    instance ToString[MinguoDate] {
        pub def toString(x: MinguoDate): String =
            let MinguoDate(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[MinguoDate] {
        pub def eq(x: MinguoDate, y: MinguoDate): Bool = 
            let MinguoDate.MinguoDate(x1) = x;
            let MinguoDate.MinguoDate(y1) = y;
            unsafe IO { x1.equals(y1) }

    }

    instance Hash[MinguoDate] {
        pub def hash(x: MinguoDate): Int32 =
            let MinguoDate.MinguoDate(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance ToJava[MinguoDate] {
        type Out = JMinguoDate
        pub def toJava(x: MinguoDate): JMinguoDate = 
            let MinguoDate.MinguoDate(x1) = x;
            x1
    }

    instance ToFlix[MinguoDate] {
        type In = JMinguoDate
        pub def toFlix(x: JMinguoDate): MinguoDate = 
            MinguoDate.MinguoDate(x)
    }

    pub def newMinguoDate(prolepticYear: {prolepticYear = Int32}, 
                        month: {month = Int32}, 
                        dayOfMonth: {dayOfMonth = Int32}): MinguoDate \ Fail =
        AdaptorChecked.of(() -> unsafe IO { JMinguoDate.of(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth) })

    pub def newWithLocalDate(x: LocalDate): MinguoDate = 
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JMinguoDate.$from(x1) })

    pub def newWithLocalDateTime(x: LocalDateTime): MinguoDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JMinguoDate.$from(x1) })

    ///
    /// Returns ___
    ///
    pub def now(): MinguoDate \ IO = 
        MinguoDate(JMinguoDate.now())


    pub def toEpochDay(x: MinguoDate): Int64 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.toEpochDay() })

    pub def toLocalDate(x: MinguoDate): LocalDate =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { JLocalDate.$from(x1) })


    pub def getEra(x: MinguoDate): MinguoEra = 
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getEra() })


    pub def isEqual(x: MinguoDate, y: MinguoDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isEqual(y1) })

    pub def isAfter(x: MinguoDate, y: MinguoDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    pub def isBefore(x: MinguoDate, y: MinguoDate): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })



    // pub def getDayOfWeek(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfWeek)
    //         |> Result.getWithDefault(-1)
        
    // pub def getDayOfMonth(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfMonth)
    //         |> Result.getWithDefault(-1)
    
    // pub def getDayOfYear(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.DayOfYear)
    //         |> Result.getWithDefault(-1)

    // pub def getMonthOfYear(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.MonthOfYear)
    //         |> Result.getWithDefault(-1)

    // pub def getYear(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.Year)
    //         |> Result.getWithDefault(-1)

    // pub def getYearOfEra(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, InteropTime.Temporal.ChronoField.YearOfEra)
    //         |> Result.getWithDefault(-1)


    // def getChronoFieldHelper(x: MinguoDate, field: ChronoField): Result[String, Int32] =
    //     import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    //     try {
    //         let MinguoDate(x1) = x;
    //         let field1 = InteropTime.Temporal.ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    //         Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1))
    //     } catch {
    //         case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field }')")
    //     }

}
