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
            let Period(t) = x;
            t.toString() as & Pure
    }

    ///
    /// Parse the string `s` as a Period, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[Period] {
        pub def fromString(s: String): Option[Period] =
            import java.lang.String.strip();
            import java.time.Period:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(Period(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[Period] {
        pub def eq(x: Period, y: Period): Bool =
            import java.time.Period.equals(##java.lang.Object);
            let Period(x1) = x;
            let Period(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure
        
        pub def neq(x: Period, y: Period): Bool = not (x == y)
    }


    instance Hash[Period] {
        pub def hash(x: Period): Int = Time/Period.hashCode(x)
    }

    instance Add[Period] {
        pub def add(x: Period, y: Period): Period =
            import java.time.Period.plus(##java.time.temporal.TemporalAmount);
            let Period(x1) = x;
            let Period(y1) = y;
            let ta1 = y1 as ##java.time.temporal.TemporalAmount;
            Period(x1.plus(ta1)) as & Pure
    }

    instance Sub[Period] {
        pub def sub(x: Period, y: Period): Period =
            import java.time.Period.minus(##java.time.temporal.TemporalAmount);
            let Period(x1) = x;
            let Period(y1) = y;
            let ta1 = y1 as ##java.time.temporal.TemporalAmount;
            Period(x1.minus(ta1)) as & Pure
    }

    instance Neg[Period] {
        pub def neg(x: Period): Period =
            import java.time.Period.negated();
            let Period(x1) = x;
            Period(x1.negated()) as & Pure
    }


    /// Addition
    instance Monoid[Period] {
        pub def empty(): Period = Time/Period.zero()
        pub def combine(x: Period, y: Period): Period = Add.add(x, y)
    }

}

namespace Time/Period {

    use Time.Period;
    use Time.Period.{Period};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    pub def new(x: {years: Int32, months: Int32, days: Int32}): Period =
        import java.time.Period:of(Int32, Int32, Int32);
        Period(of(x.years, x.months, x.days)) as & Pure

    pub def getFields(x: Period): {years: Int32, months: Int32, days: Int32} = 
        { years = x.getYears(), months = x.getMonths(), days = x.getDays() }

    ///
    /// The period of zero.
    ///
    pub def zero(): Period =
        import get java.time.Period:ZERO as getZERO;
        Period(getZERO()) as & Pure

    pub def fromYears(years: Int32): Period =
        import java.time.Period:ofYears(Int32);
        Period(ofYears(years)) as & Pure

    pub def fromMonths(months: Int32): Period =
        import java.time.Period:ofMonths(Int32);
        Period(ofMonths(months)) as & Pure

    pub def fromWeeks(weeks: Int32): Period =
        import java.time.Period:ofWeeks(Int32);
        Period(ofWeeks(weeks)) as & Pure

    pub def fromDays(days: Int32): Period =
        import java.time.Period:ofDays(Int32);
        Period(ofDays(days)) as & Pure

    pub def toTotalMonths(x: Period): Int64 = 
        import java.time.Period.toTotalMonths();
        let Period(x1) = x;
        toTotalMonths(x1) as & Pure

    pub def hashCode(x: Period): Int32 = 
        import java.time.Period.hashCode();
        let Period(x1) = x;
        hashCode(x1) as & Pure


     pub def normalize(x: Period): Period =
        import java.time.Period.normalized();
        let Period(x1) = x;
        Period(x1.normalized()) as & Pure




    // `compareTo` not implemented in Java 13.


    pub def isZero(x: Period): Bool =
        import java.time.Period.isZero();
        let Period(x1) = x;
        x1.isZero() as & Pure

    pub def isPositive(x: Period): Bool =
        not x.isNegative()

    pub def isNegative(x: Period): Bool =
        import java.time.Period.isNegative();
        let Period(x1) = x;
        x1.isNegative() as & Pure


    pub def plusYears(x: Period, years: Int64): Period =
        import java.time.Period.plusYears(Int64) as plus;
        let Period(x1) = x;
        Period(x1.plus(years)) as & Pure

    pub def minusYears(x: Period, years: Int64): Period =
        import java.time.Period.minusYears(Int64) as minus;
        let Period(x1) = x;
        Period(x1.minus(years)) as & Pure

    pub def plusMonths(x: Period, months: Int64): Period =
        import java.time.Period.plusMonths(Int64) as plus;
        let Period(x1) = x;
        Period(x1.plus(months)) as & Pure

    pub def minusMonths(x: Period, months: Int64): Period =
        import java.time.Period.minusMonths(Int64) as minus;
        let Period(x1) = x;
        Period(x1.minus(months)) as & Pure

    pub def plusDays(x: Period, days: Int64): Period =
        import java.time.Period.plusDays(Int64) as plus;
        let Period(x1) = x;
        Period(x1.plus(days)) as & Pure

    pub def minusDays(x: Period, days: Int64): Period =
        import java.time.Period.minusDays(Int64) as minus;
        let Period(x1) = x;
        Period(x1.minus(days)) as & Pure

    pub def getYears(x: Period): Int32 =
        import java.time.Period.getYears();
        let Period(x1) = x;
        x1.getYears() as & Pure

    pub def putYears(x: Period, years: Int32): Period =
        import java.time.Period.withYears(Int32);
        let Period(x1) = x;
        Period(x1.withYears(years)) as & Pure

    pub def getMonths(x: Period): Int32 =
        import java.time.Period.getMonths();
        let Period(x1) = x;
        x1.getMonths() as & Pure

    pub def putMonths(x: Period, months: Int32): Period =
        import java.time.Period.withMonths(Int32);
        let Period(x1) = x;
        Period(x1.withMonths(months)) as & Pure

    pub def getDays(x: Period): Int32 =
        import java.time.Period.getDays();
        let Period(x1) = x;
        x1.getDays() as & Pure

    pub def putDays(x: Period, days: Int32): Period =
        import java.time.Period.withDays(Int32);
        let Period(x1) = x;
        Period(x1.withDays(days)) as & Pure

    pub def between(b: LocalDate, e: LocalDate): Period = 
        import java.time.Period:between(##java.time.LocalDate, ##java.time.LocalDate);
        let LocalDate(b1) = b;
        let LocalDate(e1) = e;
        Period(between(b1, e1)) as & Pure


}