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
    /// A wrapper around java.time.chrono.MinguoDate.
    ///
    pub opaque type MinguoDate = ##java.time.chrono.MinguoDate
    
    ///
    /// Returns the given MinguoDate `x` as a String.
    ///
    instance ToString[MinguoDate] {
        pub def toString(x: MinguoDate): String =
            import java.time.chrono.MinguoDate.toString();
            let MinguoDate(x1) = x;
            toString(x1) as & Pure
    }

    instance Eq[MinguoDate] {
        pub def eq(x: MinguoDate, y: MinguoDate): Bool = Time/Chrono/MinguoDate.equals(x, y)
    }
    
    instance Hash[MinguoDate] {
        pub def hash(x: MinguoDate): Int32 = Time/Chrono/MinguoDate.hashCode(x)
    } 
}

namespace Time/Chrono/MinguoDate {


    use Time/Chrono.MinguoDate;
    use Time/Chrono.MinguoDate.{MinguoDate};
    use Time/Temporal.ChronoField;
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    ///
    /// Returns ___
    ///
    pub def now(): MinguoDate & Impure =
        import static java.time.chrono.MinguoDate.now();
        MinguoDate(now())


    pub def equals(x: MinguoDate, y: MinguoDate): Bool = 
        import java.time.chrono.MinguoDate.equals(##java.lang.Object);
        let MinguoDate(x1) = x;
        let MinguoDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: MinguoDate): Int32 = 
        import java.time.chrono.MinguoDate.hashCode();
        let MinguoDate(x1) = x;
        hashCode(x1) as & Pure



    pub def toLocalDate(x: MinguoDate): LocalDate =
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor);
        let MinguoDate(x1) = x;
        LocalDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def getDayOfWeek(x: MinguoDate): Int32 = 
        getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfWeek)
            |> Result.getWithDefault(-1)
        
    pub def getDayOfMonth(x: MinguoDate): Int32 = 
        getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfMonth)
            |> Result.getWithDefault(-1)
    
    pub def getDayOfYear(x: MinguoDate): Int32 = 
        getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfYear)
            |> Result.getWithDefault(-1)

    pub def getMonthOfYear(x: MinguoDate): Int32 = 
        getChronoFieldHelper(x, Time/Temporal/ChronoField.MonthOfYear)
            |> Result.getWithDefault(-1)

    pub def getYear(x: MinguoDate): Int32 = 
        getChronoFieldHelper(x, Time/Temporal/ChronoField.Year)
            |> Result.getWithDefault(-1)

    pub def getYearOfEra(x: MinguoDate): Int32 = 
        getChronoFieldHelper(x, Time/Temporal/ChronoField.YearOfEra)
            |> Result.getWithDefault(-1)


    def getChronoFieldHelper(x: MinguoDate, field: ChronoField): Result[Int32, String] =
        import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField);
        try {
            let MinguoDate(x1) = x;
            let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
            Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1)) as & Pure
        } catch {
            case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field}')")
        }

}
