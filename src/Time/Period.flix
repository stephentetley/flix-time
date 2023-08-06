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

    ///
    /// A wrapper around a Java Period.
    ///
    pub enum Period(##java.time.Period)

    instance ToString[Period] {
        pub def toString(x: Period): String =
            import java.time.Period.toString(): String \ {};
            let Period(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a Period, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[Period] {
        pub def fromString(s: String): Option[Period] =
            Result.tryCatch(_ -> {
                import static java.time.Period.parse(##java.lang.CharSequence): ##java.time.Period \ {};
                let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
                Period(parse(cs))
            }) |> Result.toOption
    }

    instance Eq[Period] {
        pub def eq(x: Period, y: Period): Bool =
            import java.time.Period.equals(##java.lang.Object): Bool \ {};
            let Period(x1) = x;
            let Period(y1) = y;
            equals(x1, checked_cast(y1))
    }


    instance Hash[Period] {
        pub def hash(x: Period): Int32 =
            import java.time.Period.hashCode(): Int32 \ {};
            let Period(x1) = x;
            hashCode(x1)
    }


    instance Add[Period] {
        pub def add(x: Period, y: Period): Period =
            import java.time.Period.plus(##java.time.temporal.TemporalAmount): ##java.time.Period \ {};
            let Period(x1) = x;
            let Period(y1) = y;
            Period(plus(x1, unchecked_cast(y1 as ##java.time.temporal.TemporalAmount)))
    }

    instance Sub[Period] {
        pub def sub(x: Period, y: Period): Period =
            import java.time.Period.minus(##java.time.temporal.TemporalAmount): ##java.time.Period \ {};
            let Period(x1) = x;
            let Period(y1) = y;
            Period(minus(x1, unchecked_cast(y1 as ##java.time.temporal.TemporalAmount)))
    }


    instance Neg[Period] {
        pub def neg(x: Period): Period =
            import java.time.Period.negated(): ##java.time.Period \ {};
            let Period(x1) = x;
            Period(negated(x1))
    }

    /// `combine` is addition
    instance SemiGroup[Period] {
        pub def combine(x: Period, y: Period): Period = Add.add(x, y)
    }

    /// Addition
    instance Monoid[Period] {
        pub def empty(): Period = Time.Period.zero()
    }


    instance Interop.Flix.GoesToJava[Period] {
        pub def toJavaObject(x: Period): ##java.lang.Object =
            let Period(x1) = x;
            checked_cast(x1)
    }
    
}

mod Time.Period {

    use Time.Period
    use Time.Period.{Period}

    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    

    /// ## Unwrap

    pub def getPeriod(x: Period): ##java.time.Period = 
        let Period(x1) = x;
        x1

    
    /// ## Constructors

    pub def period(r: {years = Int32, months = Int32, days = Int32}): Period =
        import static java.time.Period.of(Int32, Int32, Int32): ##java.time.Period \ {};
        Period(of(r.years, r.months, r.days))

    /// ## "abstract constructors" (e.g. `zero`)

    ///
    /// The period of zero.
    ///
    pub def zero(): Period =
        import static get java.time.Period.ZERO: ##java.time.Period \ {} as getZERO;
        Period(getZERO())


    /// ## `of` functions


    pub def ofDays(days: Int32): Period =
        import static java.time.Period.ofDays(Int32): ##java.time.Period \ {};
        Period(ofDays(days))

    pub def ofWeeks(weeks: Int32): Period =
        import static java.time.Period.ofWeeks(Int32): ##java.time.Period \ {};
        Period(ofWeeks(weeks))

    pub def ofMonths(months: Int32): Period =
        import static java.time.Period.ofMonths(Int32): ##java.time.Period \ {};
        Period(ofMonths(months))

    pub def ofYears(years: Int32): Period =
        import static java.time.Period.ofYears(Int32): ##java.time.Period \ {};
        Period(ofYears(years))




    /// ## `to` functions

    pub def toTotalMonths(x: Period): Int64 =
        import java.time.Period.toTotalMonths(): Int64 \ {};
        let Period(x1) = x;
        toTotalMonths(x1)

    /// ## `parse` / `format` functions        

    pub def parse(s: String): Result[String, Period] =
        Result.tryCatch(_ -> {
            import static java.time.Period.parse(##java.lang.CharSequence): ##java.time.Period \ {};
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            Period(parse(cs))
        })

    /// Note - alias of `toString`
    pub def format(x: Period): String =
        import java.time.Period.toString(): String \ {};
        let Period(x1) = x;
        toString(x1)

    /// ## predicates / comparisons

    pub def isZero(x: Period): Bool =
        import java.time.Period.isZero(): Bool \ {};
        let Period(x1) = x;
        isZero(x1)

    pub def isPositive(x: Period): Bool =
        not isNegative(x)

    pub def isNegative(x: Period): Bool =
        import java.time.Period.isNegative(): Bool \ {};
        let Period(x1) = x;
        isNegative(x1)

    /// ## Period functions
    
    pub def normalize(x: Period): Period =
        import java.time.Period.normalized(): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(normalized(x1))

    /// ## Getters and Setters

    pub def getYears(x: Period): Int32 =
        import java.time.Period.getYears(): Int32 \ {};
        let Period(x1) = x;
        getYears(x1)

    pub def withYears(years: Int32, x: Period): Period =
        import java.time.Period.withYears(Int32): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(withYears(x1, years))

    pub def getMonths(x: Period): Int32 =
        import java.time.Period.getMonths(): Int32 \ {};
        let Period(x1) = x;
        getMonths(x1)

    pub def withMonths(months: Int32, x: Period): Period =
        import java.time.Period.withMonths(Int32): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(withMonths(x1, months))

    pub def getDays(x: Period): Int32 =
        import java.time.Period.getDays(): Int32 \ {};
        let Period(x1) = x;
        getDays(x1)

    pub def withDays(days: Int32, x: Period): Period =
        import java.time.Period.withDays(Int32): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(withDays(x1, days))


    /// ## plus / minus functions

    pub def plusYears(x: Period, years: Int64): Period =
        import java.time.Period.plusYears(Int64): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(plusYears(x1, years))

    pub def minusYears(x: Period, years: Int64): Period =
        import java.time.Period.minusYears(Int64): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(minusYears(x1, years))

    pub def plusMonths(x: Period, months: Int64): Period =
        import java.time.Period.plusMonths(Int64): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(plusMonths(x1, months))

    pub def minusMonths(x: Period, months: Int64): Period =
        import java.time.Period.minusMonths(Int64): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(minusMonths(x1, months))

    pub def plusDays(x: Period, days: Int64): Period =
        import java.time.Period.plusDays(Int64): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(plusDays(x1, days))

    pub def minusDays(x: Period, days: Int64): Period =
        import java.time.Period.minusDays(Int64): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(minusDays(x1, days))

   /// ## multiply / divide functions

    pub def multipliedBy(x: Period, y: Int32): Period =
        import java.time.Period.multipliedBy(Int32): ##java.time.Period \ {};
        let Period(x1) = x;
        Period(multipliedBy(x1, y))

    // No `dividedBy` in ##java.time.Period

    /// ## between / until functions

    /// Note returns Period as LocalDate has no time component
    pub def between(r: {start = LocalDate, end = LocalDate}): Period =
        import static java.time.Period.between(##java.time.LocalDate, ##java.time.LocalDate): ##java.time.Period \ {};
        let LocalDate(b1) = r.start;
        let LocalDate(e1) = r.end;
        Period(between(b1, e1))


}
