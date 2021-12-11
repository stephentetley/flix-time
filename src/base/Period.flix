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


namespace Time {

    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAmount;

    ///
    /// A wrapper around a Java Period.
    ///
    pub opaque type Period = ##java.time.Period

    instance ToString[Period] {
        pub def toString(x: Period): String =
            import java.time.Period.toString();
            let Period(x1) = x;
            toString(x1) as & Pure
    }

    ///
    /// Parse the string `s` as a Period, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[Period] {
        pub def fromString(s: String): Option[Period] =
            import java.lang.String.strip();
            import static java.time.Period.parse(##java.lang.CharSequence);
            try {
                let cs = strip(s) as ##java.lang.CharSequence & Pure;
                Some(Period(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[Period] {
        pub def eq(x: Period, y: Period): Bool = Time/Period.equals(x, y)
    }


    instance Hash[Period] {
        pub def hash(x: Period): Int = Time/Period.hashCode(x)
    }

    instance Add[Period] {
        pub def add(x: Period, y: Period): Period =
            import java.time.Period.plus(##java.time.temporal.TemporalAmount);
            let Period(x1) = x;
            let Period(y1) = y;
            let ty1 = y1 as ##java.time.temporal.TemporalAmount;
            Period(plus(x1, ty1)) as & Pure
    }

    instance Sub[Period] {
        pub def sub(x: Period, y: Period): Period =
            import java.time.Period.minus(##java.time.temporal.TemporalAmount);
            let Period(x1) = x;
            let Period(y1) = y;
            let ty1 = y1 as ##java.time.temporal.TemporalAmount;
            Period(minus(x1, ty1 as ##java.time.temporal.TemporalAmount)) as & Pure
    }

    instance Neg[Period] {
        pub def neg(x: Period): Period =
            import java.time.Period.negated();
            let Period(x1) = x;
            Period(negated(x1)) as & Pure
    }

    /// `combine` is addition
    instance SemiGroup[Period] {
        pub def combine(x: Period, y: Period): Period = Add.add(x, y)
    }

    /// Addition
    instance Monoid[Period] {
        pub def empty(): Period = Time/Period.zero()
    }

}

namespace Time/Period {

    use Time.Period;
    use Time.Period.{Period};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    pub def new(x: {years :: Int32, months :: Int32, days :: Int32}): Period =
        import static java.time.Period.of(Int32, Int32, Int32);
        Period(of(x.years, x.months, x.days)) as & Pure

    pub def getFields(x: Period): {years :: Int32, months :: Int32, days :: Int32} =
        { years = getYears(x), months = getMonths(x), days = getDays(x) }

    ///
    /// The period of zero.
    ///
    pub def zero(): Period =
        import static get java.time.Period.ZERO as getZERO;
        Period(getZERO()) as & Pure

    pub def ofYears(years: Int32): Period =
        import static java.time.Period.ofYears(Int32);
        Period(ofYears(years)) as & Pure

    pub def ofMonths(months: Int32): Period =
        import static java.time.Period.ofMonths(Int32);
        Period(ofMonths(months)) as & Pure

    pub def ofWeeks(weeks: Int32): Period =
        import static java.time.Period.ofWeeks(Int32);
        Period(ofWeeks(weeks)) as & Pure

    pub def ofDays(days: Int32): Period =
        import static java.time.Period.ofDays(Int32);
        Period(ofDays(days)) as & Pure

    pub def toTotalMonths(x: Period): Int64 = 
        import java.time.Period.toTotalMonths();
        let Period(x1) = x;
        toTotalMonths(x1) as & Pure

    pub def equals(x: Period, y: Period): Bool =
        import java.time.Period.equals(##java.lang.Object);
        let Period(x1) = x;
        let Period(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure


    pub def hashCode(x: Period): Int32 = 
        import java.time.Period.hashCode();
        let Period(x1) = x;
        hashCode(x1) as & Pure


     pub def normalize(x: Period): Period =
        import java.time.Period.normalized();
        let Period(x1) = x;
        Period(normalized(x1)) as & Pure




    // `compareTo` not implemented in Java 13.


    pub def isZero(x: Period): Bool =
        import java.time.Period.isZero();
        let Period(x1) = x;
        isZero(x1) as & Pure

    pub def isPositive(x: Period): Bool =
        not isNegative(x)

    pub def isNegative(x: Period): Bool =
        import java.time.Period.isNegative();
        let Period(x1) = x;
        isNegative(x1) as & Pure


    pub def plusYears(x: Period, years: Int64): Period =
        import java.time.Period.plusYears(Int64) as plus;
        let Period(x1) = x;
        Period(plus(x1, years)) as & Pure

    pub def minusYears(x: Period, years: Int64): Period =
        import java.time.Period.minusYears(Int64) as minus;
        let Period(x1) = x;
        Period(minus(x1, years)) as & Pure

    pub def plusMonths(x: Period, months: Int64): Period =
        import java.time.Period.plusMonths(Int64) as plus;
        let Period(x1) = x;
        Period(plus(x1, months)) as & Pure

    pub def minusMonths(x: Period, months: Int64): Period =
        import java.time.Period.minusMonths(Int64) as minus;
        let Period(x1) = x;
        Period(minus(x1, months)) as & Pure

    pub def plusDays(x: Period, days: Int64): Period =
        import java.time.Period.plusDays(Int64) as plus;
        let Period(x1) = x;
        Period(plus(x1, days)) as & Pure

    pub def minusDays(x: Period, days: Int64): Period =
        import java.time.Period.minusDays(Int64) as minus;
        let Period(x1) = x;
        Period(minus(x1, days)) as & Pure

    pub def getYears(x: Period): Int32 =
        import java.time.Period.getYears();
        let Period(x1) = x;
        getYears(x1) as & Pure

    pub def putYears(x: Period, years: Int32): Period =
        import java.time.Period.withYears(Int32);
        let Period(x1) = x;
        Period(withYears(x1, years)) as & Pure

    pub def getMonths(x: Period): Int32 =
        import java.time.Period.getMonths();
        let Period(x1) = x;
        getMonths(x1) as & Pure

    pub def putMonths(x: Period, months: Int32): Period =
        import java.time.Period.withMonths(Int32);
        let Period(x1) = x;
        Period(withMonths(x1, months)) as & Pure

    pub def getDays(x: Period): Int32 =
        import java.time.Period.getDays();
        let Period(x1) = x;
        getDays(x1) as & Pure

    pub def putDays(x: Period, days: Int32): Period =
        import java.time.Period.withDays(Int32);
        let Period(x1) = x;
        Period(withDays(x1, days)) as & Pure

    pub def between(b: LocalDate, e: LocalDate): Period = 
        import static java.time.Period.between(##java.time.LocalDate, ##java.time.LocalDate);
        let LocalDate(b1) = b;
        let LocalDate(e1) = e;
        Period(between(b1, e1)) as & Pure

}
