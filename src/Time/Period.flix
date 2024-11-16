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


mod Time {


    use Time.Period
    use Time.Period.{Period}

    import java.time.{Period => JPeriod}
    import java.time.chrono.{ChronoPeriod}
    import java.time.temporal.{TemporalAmount}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around a Java Period.
    ///
    pub enum Period(JPeriod)

    instance ToString[Period] {
        pub def toString(x: Period): String =
            let Period(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as a Period, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[Period] {
        pub def fromString(s: String): Option[Period] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs  = (checked_cast(s1) : CharSequence);
                Period(unsafe JPeriod.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[Period] {
        pub def eq(x: Period, y: Period): Bool =
            let Period(x1) = x;
            let Period(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }


    instance Hash[Period] {
        pub def hash(x: Period): Int32 =
            let Period(x1) = x;
            unsafe x1.hashCode()
    }


    instance Add[Period] {
        pub def add(x: Period, y: Period): Period =
            let Period(x1) = x;
            let Period(y1) = y;
            let cx1 = (checked_cast(x1) : ChronoPeriod);
            let cy1 = (checked_cast(y1) : TemporalAmount);
            let ans : ChronoPeriod = unsafe cx1.plus(cy1);
            let ans1 = (unchecked_cast(ans as JPeriod));
            Period(ans1)
    }

    instance Sub[Period] {
        pub def sub(x: Period, y: Period): Period =
            let Period(x1) = x;
            let Period(y1) = y;
            let cx1 = (checked_cast(x1) : ChronoPeriod);
            let cy1 = (checked_cast(y1) : TemporalAmount);
            let ans : ChronoPeriod = unsafe cx1.minus(cy1);
            let ans1 = (unchecked_cast(ans as JPeriod));
            Period(ans1)
    }


    instance Neg[Period] {
        pub def neg(x: Period): Period =
            let Period(x1) = x;
            let cx1 = (checked_cast(x1) : ChronoPeriod);
            let ans : ChronoPeriod = unsafe cx1.negated();
            let ans1 = (unchecked_cast(ans as JPeriod));
            Period(ans1)
    }

    /// `combine` is addition
    instance SemiGroup[Period] {
        pub def combine(x: Period, y: Period): Period = Add.add(x, y)
    }

    /// Addition
    instance Monoid[Period] {
        pub def empty(): Period = Time.Period.zero()
    }

    
}

mod Time.Period {

    use Time.Period
    use Time.Period.{Period}

    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    
    import java.time.{Period => JPeriod}
    import java.time.chrono.{ChronoPeriod}
    import java.lang.{Object, CharSequence}

    /// Unwrap

    pub def getPeriod(x: Period): JPeriod = 
        let Period(x1) = x;
        x1

    
    /// Constructors

    pub def period(r: {years = Int32, months = Int32, days = Int32}): Period =
        Period(unsafe JPeriod.of(r#years, r#months, r#days))

    /// "abstract constructors" (e.g. `zero`)

    ///
    /// The period of zero.
    ///
    pub def zero(): Period = Period(unsafe JPeriod.ZERO)


    /// `of` functions


    pub def ofDays(days: Int32): Period = Period(unsafe JPeriod.ofDays(days))

    pub def ofWeeks(weeks: Int32): Period = Period(unsafe JPeriod.ofWeeks(weeks))

    pub def ofMonths(months: Int32): Period = Period(unsafe JPeriod.ofMonths(months))

    pub def ofYears(years: Int32): Period = Period(unsafe JPeriod.ofYears(years))




    /// `to` functions

    pub def toTotalMonths(x: Period): Int64 =
        let Period(x1) = x;
        unsafe x1.toTotalMonths()

    /// `parse` / `format` functions        

    pub def parse(s: String): Result[String, Period] =
        Result.tryCatch(_ -> {
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            Period(unsafe JPeriod.parse(cs))
        })

    /// Note - alias of `toString`
    pub def format(x: Period): String =
        let Period(x1) = x;
        unsafe x1.toString()

    /// predicates / comparisons

    pub def isZero(x: Period): Bool =
        let Period(x1) = x;
        unsafe x1.isZero()

    pub def isPositive(x: Period): Bool =
        not isNegative(x)

    pub def isNegative(x: Period): Bool =
        let Period(x1) = x;
        unsafe x1.isNegative()

    /// Period functions
    
    pub def normalize(x: Period): Period =
        let Period(x1) = x;
        let cx1 = (checked_cast(x1) : ChronoPeriod);
        let ans : ChronoPeriod = unsafe cx1.normalized();
        let ans1 = (unchecked_cast(ans as JPeriod));
        Period(ans1)

    /// Getters and Setters

    pub def getYears(x: Period): Int32 =
        let Period(x1) = x;
        unsafe x1.getYears()

    pub def withYears(years: Int32, x: Period): Period =
        let Period(x1) = x;
        Period(unsafe x1.withYears(years))

    pub def getMonths(x: Period): Int32 =
        let Period(x1) = x;
        unsafe x1.getMonths()

    pub def withMonths(months: Int32, x: Period): Period =
        let Period(x1) = x;
        Period(unsafe x1.withMonths(months))

    pub def getDays(x: Period): Int32 =
        let Period(x1) = x;
        unsafe x1.getDays()

    pub def withDays(days: Int32, x: Period): Period =
        let Period(x1) = x;
        Period(unsafe x1.withDays(days))


    /// plus / minus functions

    pub def plusYears(x: Period, years: Int64): Period =
        let Period(x1) = x;
        Period(unsafe x1.plusYears(years))

    pub def minusYears(x: Period, years: Int64): Period =
        let Period(x1) = x;
        Period(unsafe x1.minusYears(years))

    pub def plusMonths(x: Period, months: Int64): Period =
        let Period(x1) = x;
        Period(unsafe x1.plusMonths(months))

    pub def minusMonths(x: Period, months: Int64): Period =
        let Period(x1) = x;
        Period(unsafe x1.minusMonths(months))

    pub def plusDays(x: Period, days: Int64): Period =
        let Period(x1) = x;
        Period(unsafe x1.plusDays(days))

    pub def minusDays(x: Period, days: Int64): Period =
        let Period(x1) = x;
        Period(unsafe x1.minusDays(days))

   /// multiply / divide functions

    pub def multipliedBy(x: Period, y: Int32): Period =
        let Period(x1) = x;
        let cx1: ChronoPeriod = checked_cast(x1);
        let ans : ChronoPeriod = unsafe cx1.multipliedBy(y);
        let ans1 = unchecked_cast(ans as JPeriod);
        Period(ans1)

    // No `dividedBy` in java.time.Period

    /// between / until functions

    /// Note returns Period as LocalDate has no time component
    pub def between(r: {start = LocalDate, end = LocalDate}): Period =
        let LocalDate(b1) = r#start;
        let LocalDate(e1) = r#end;
        Period(unsafe JPeriod.between(b1, e1))


}
