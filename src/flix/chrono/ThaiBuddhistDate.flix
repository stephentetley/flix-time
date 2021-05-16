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
    pub opaque type ThaiBuddhistDate = ##java.time.chrono.ThaiBuddhistDate
    
    ///
    /// Returns the given ThaiBuddhistDate `x` as a String.
    ///
    instance ToString[ThaiBuddhistDate] {
        pub def toString(x: ThaiBuddhistDate): String =
            import java.time.chrono.ThaiBuddhistDate.toString();
            let ThaiBuddhistDate(x1) = x;
            toString(x1) as & Pure
    }

    instance Eq[ThaiBuddhistDate] {
        pub def eq(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool = Time/Chrono/ThaiBuddhistDate.equals(x, y)
    }
    
    instance Hash[ThaiBuddhistDate] {
        pub def hash(x: ThaiBuddhistDate): Int = Time/Chrono/ThaiBuddhistDate.hashCode(x)
    } 
}

namespace Time/Chrono/ThaiBuddhistDate {


    use Time/Chrono.ThaiBuddhistDate;
    use Time/Chrono.ThaiBuddhistDate.{ThaiBuddhistDate};
    use Time/Temporal.ChronoField;

    ///
    /// Returns ___
    ///
    pub def now(): ThaiBuddhistDate & Impure =
        import java.time.chrono.ThaiBuddhistDate:now();
        ThaiBuddhistDate(now())


    pub def equals(x: ThaiBuddhistDate, y: ThaiBuddhistDate): Bool = 
        import java.time.chrono.ThaiBuddhistDate.equals(##java.lang.Object);
        let ThaiBuddhistDate(x1) = x;
        let ThaiBuddhistDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: ThaiBuddhistDate): Int32 = 
        import java.time.chrono.ThaiBuddhistDate.hashCode();
        let ThaiBuddhistDate(x1) = x;
        hashCode(x1) as & Pure

    pub def getDayOfWeek(x: ThaiBuddhistDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfWeek), -1)
        
    pub def getDayOfMonth(x: ThaiBuddhistDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfMonth), -1)
    
    pub def getDayOfYear(x: ThaiBuddhistDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.DayOfYear), -1)

    pub def getMonthOfYear(x: ThaiBuddhistDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.MonthOfYear), -1)

    pub def getYear(x: ThaiBuddhistDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.Year), -1)

    pub def getYearOfEra(x: ThaiBuddhistDate): Int32 = 
        Result.getWithDefault(getChronoFieldHelper(x, Time/Temporal/ChronoField.YearOfEra), -1)


    def getChronoFieldHelper(x: ThaiBuddhistDate, field: ChronoField): Result[Int32, String] =
        import java.time.temporal.TemporalAccessor.get(##java.time.temporal.TemporalField);
        try {
            let ThaiBuddhistDate(x1) = x;
            let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
            Ok(get(x1 as ##java.time.temporal.TemporalAccessor, field1)) as & Pure
        } catch {
            case _: ##java.lang.Exception => Err("getTemporalFieldHelper('${field}')")
        }

}
