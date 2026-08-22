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


pub mod InteropTime.Period {

    use JavaInterop.AdaptorExtras

    use InteropTime.LocalDate.LocalDate
    
    import java.time.{Period => JPeriod }
    import java.time.chrono.{ChronoPeriod }
    import java.lang.{Object, CharSequence }
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java Period.
    ///
    pub enum Period(JPeriod)

    instance ToString[Period] {
        pub def toString(x: Period): String =
            let Period.Period(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as a Period, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[Period] {
        pub def fromString(s: String): Option[Period] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JPeriod.parse(s1) };
                Some(Period.Period(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[Period] {
        pub def eq(x: Period, y: Period): Bool =
            let Period.Period(x1) = x;
            let Period.Period(y1) = y;
            unsafe IO { x1.equals(y1) }
    }


    instance Hash[Period] {
        pub def hash(x: Period): Int32 =
            let Period.Period(x1) = x;
            unsafe IO { x1.hashCode() }
    }


    instance Add[Period] {
        pub def add(x: Period, y: Period): Period =
            let Period.Period(x1) = x;
            let Period.Period(y1) = y;
            let ans = unsafe IO { x1.plus(y1) };
            Period(ans)
    }

    instance Sub[Period] {
        pub def sub(x: Period, y: Period): Period =
            let Period.Period(x1) = x;
            let Period.Period(y1) = y;
            let ans = unsafe IO { x1.minus(y1) };
            Period(ans)
    }


    instance Neg[Period] {
        pub def neg(x: Period): Period =
            let Period.Period(x1) = x;
            let ans = unsafe IO { x1.negated() };
            Period.Period(ans)
    }

    /// `combine` is addition
    instance SemiGroup[Period] {
        pub def combine(x: Period, y: Period): Period = 
            Add.add(x, y)
    }

    /// Addition
    instance Monoid[Period] {
        pub def empty(): Period = 
            Period.Period(unsafe IO { JPeriod.ZERO })
    }



    instance ToJava[Period] {
        type Out = JPeriod
        pub def toJava(x: Period): JPeriod = 
            let Period.Period(x1) = x;
            x1
    }

    instance ToFlix[Period] {
        type In = JPeriod
        pub def toFlix(x: JPeriod): Period = 
            Period.Period(x)
    }


    /// Constructors

    pub def period(years: {years = Int32}, 
                    months: {months = Int32}, 
                    days: {days = Int32}): Period =
        let ans = unsafe IO { JPeriod.of(years#years, months#months, days#days) };
        Period(ans)

    /// "abstract constructors" (e.g. `zero`)

    ///
    /// The period of zero.
    ///
    pub def zero(): Period = 
        AdaptorExtras.of(() -> unsafe IO { JPeriod.ZERO })


    /// `of` functions


    pub def ofDays(days: Int32): Period = Period(unsafe IO { JPeriod.ofDays(days) })

    pub def ofWeeks(weeks: Int32): Period = Period(unsafe IO { JPeriod.ofWeeks(weeks) })

    pub def ofMonths(months: Int32): Period = Period(unsafe IO { JPeriod.ofMonths(months) })

    pub def ofYears(years: Int32): Period = Period(unsafe IO { JPeriod.ofYears(years) })




    /// toX functions

    pub def toTotalMonths(x: Period): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toTotalMonths() })

    /// `parse` / `format` functions        

    pub def parse(s: String): Result[String, Period] =
        AdaptorExtras.ofWithResult(() -> {
            let s1 = String.trim(s);
            unsafe IO { JPeriod.parse(s1) }
        })

    /// Note - alias of `toString`
    pub def format(x: Period): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toString() })

    /// predicates / comparisons

    pub def isZero(x: Period): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isZero() })

    pub def isPositive(x: Period): Bool =
        not isNegative(x)

    pub def isNegative(x: Period): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isNegative() })

    /// Period functions
    
    pub def normalized(x: Period): Period =
        AdaptorExtras.op(x, x1 ->  unsafe IO { x1.normalized() })

    /// Getters and Setters

    pub def getYears(x: Period): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getYears() })

    pub def withYears(years: Int32, x: Period): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withYears(years) })

    pub def getMonths(x: Period): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMonths() })

    pub def withMonths(months: Int32, x: Period): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMonths(months) })

    pub def getDays(x: Period): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDays() })

    pub def withDays(days: Int32, x: Period): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDays(days) })


    /// plus / minus functions

    pub def plusYears(x: Period, years: Int64): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusYears(years) })

    pub def minusYears(x: Period, years: Int64): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusYears(years) })

    pub def plusMonths(x: Period, months: Int64): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMonths(months) })

    pub def minusMonths(x: Period, months: Int64): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMonths(months) })

    pub def plusDays(x: Period, days: Int64): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusDays(days) })

    pub def minusDays(x: Period, days: Int64): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusDays(days) })

   /// multiply / divide functions

    pub def multipliedBy(x: Period, y: Int32): Period =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.multipliedBy(y) })

    // No `dividedBy` in java.time.Period

    /// between / until functions

    /// Note returns Period as LocalDate has no time component
    pub def between(begin: {begin = LocalDate}, end: {end = LocalDate}): Period =
        AdaptorExtras.op2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { JPeriod.between(begin1, end1) }
        )


}
