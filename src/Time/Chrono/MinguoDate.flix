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

mod Time.Chrono {

    use Time.Chrono.MinguoDate
    use Time.Chrono.MinguoDate.{MinguoDate}

    import java.time.chrono.{MinguoDate => JMinguoDate}

    ///
    /// A wrapper around java.time.chrono.MinguoDate.
    ///
    pub enum MinguoDate(JMinguoDate)
    
    ///
    /// Returns the given MinguoDate `x` as a String.
    ///
    instance ToString[MinguoDate] {
        pub def toString(x: MinguoDate): String =
            import java.time.chrono.MinguoDate.toString(): String \ {};
            let MinguoDate(x1) = x;
            toString(x1)
    }

    instance Eq[MinguoDate] {
        pub def eq(x: MinguoDate, y: MinguoDate): Bool = Time.Chrono.MinguoDate.equals(x, y)
    }
    
    instance Hash[MinguoDate] {
        pub def hash(x: MinguoDate): Int32 = Time.Chrono.MinguoDate.hashCode(x)
    } 
}

mod Time.Chrono.MinguoDate {


    use Time.Chrono.MinguoDate
    use Time.Chrono.MinguoDate.{MinguoDate}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}

    import java.time.chrono.{MinguoDate => JMinguoDate}
    import java.lang.{Object, CharSequence}

    ///
    /// Returns ___
    ///
    pub def now(): MinguoDate \ IO = MinguoDate(JMinguoDate.now())


    pub def equals(x: MinguoDate, y: MinguoDate): Bool = 
        let MinguoDate(x1) = x;
        let MinguoDate(y1) = y;
        let obj = (checked_cast(y1) : Object);
        unsafe x1.equals(obj)

    pub def hashCode(x: MinguoDate): Int32 = 
        let MinguoDate(x1) = x;
        unsafe x1.hashCode()



    // pub def toLocalDate(x: MinguoDate): LocalDate =
    //     import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromDate;
    //     let MinguoDate(x1) = x;
    //     LocalDate(fromDate(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor)))

    // pub def getDayOfWeek(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, Time.Temporal.ChronoField.DayOfWeek)
    //         |> Result.getWithDefault(-1)
        
    // pub def getDayOfMonth(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, Time.Temporal.ChronoField.DayOfMonth)
    //         |> Result.getWithDefault(-1)
    
    // pub def getDayOfYear(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, Time.Temporal.ChronoField.DayOfYear)
    //         |> Result.getWithDefault(-1)

    // pub def getMonthOfYear(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, Time.Temporal.ChronoField.MonthOfYear)
    //         |> Result.getWithDefault(-1)

    // pub def getYear(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, Time.Temporal.ChronoField.Year)
    //         |> Result.getWithDefault(-1)

    // pub def getYearOfEra(x: MinguoDate): Int32 = 
    //     getChronoFieldHelper(x, Time.Temporal.ChronoField.YearOfEra)
    //         |> Result.getWithDefault(-1)


    // def getChronoFieldHelper(x: MinguoDate, field: ChronoField): Result[String, Int32] =
    //     import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField): Int32 \ {};
    //     try {
    //         let MinguoDate(x1) = x;
    //         let field1 = Time.Temporal.ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    //         Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1))
    //     } catch {
    //         case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field}')")
    //     }

}
