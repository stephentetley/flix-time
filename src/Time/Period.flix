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


    ///
    /// A wrapper around a Java Period.
    ///
    pub opaque type Period = ##java.time.Period

    instance ToString[Period] {
        pub def toString(x: Period): String =
            import java.time.Period.toString(): String & Pure;
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
            import static java.time.Period.parse(##java.lang.CharSequence): ##java.time.Period & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(Period(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[Period] {
        pub def eq(x: Period, y: Period): Bool = Time/Period.equals(x, y)
    }


    instance Hash[Period] {
        pub def hash(x: Period): Int32 = Time/Period.hashCode(x)
    }

    instance Add[Period] {
        pub def add(x: Period, y: Period): Period = Time/Period.plus(x, y)
    }

    instance Sub[Period] {
        pub def sub(x: Period, y: Period): Period = Time/Period.minus(x, y)
    }

    instance Neg[Period] {
        pub def neg(x: Period): Period = Time/Period.negate(x)
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
    
    pub def getPeriod(x: Period): ##java.time.Period = 
        let Period(x1) = x;
        x1

    

    pub def period(r: {years :: Int32, months :: Int32, days :: Int32}): Period =
        import static java.time.Period.of(Int32, Int32, Int32): ##java.time.Period & Pure;
        Period(of(r.years, r.months, r.days))

    ///
    /// The period of zero.
    ///
    pub def zero(): Period =
        import static get java.time.Period.ZERO: ##java.time.Period & Pure as getZERO;
        Period(getZERO())

    pub def fromYears(years: Int32): Period =
        import static java.time.Period.ofYears(Int32): ##java.time.Period & Pure;
        Period(ofYears(years))

    pub def fromMonths(months: Int32): Period =
        import static java.time.Period.ofMonths(Int32): ##java.time.Period & Pure;
        Period(ofMonths(months))

    pub def fromWeeks(weeks: Int32): Period =
        import static java.time.Period.ofWeeks(Int32): ##java.time.Period & Pure;
        Period(ofWeeks(weeks))

    pub def fromDays(days: Int32): Period =
        import static java.time.Period.ofDays(Int32): ##java.time.Period & Pure;
        Period(ofDays(days))

    pub def toTotalMonths(x: Period): Int64 =
        import java.time.Period.toTotalMonths(): Int64 & Pure;
        let Period(x1) = x;
        toTotalMonths(x1)

    pub def equals(x: Period, y: Period): Bool =
        import java.time.Period.equals(##java.lang.Object): Bool & Pure;
        let Period(x1) = x;
        let Period(y1) = y;
        equals(x1, y1 as ##java.lang.Object)


    pub def hashCode(x: Period): Int32 =
        import java.time.Period.hashCode(): Int32 & Pure;
        let Period(x1) = x;
        hashCode(x1)


     pub def normalize(x: Period): Period =
        import java.time.Period.normalized(): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(normalized(x1))


    pub def negate(x: Period): Period =
        import java.time.Period.negated(): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(negated(x1))

    // `compareTo` not implemented in Java 13.


    pub def isZero(x: Period): Bool =
        import java.time.Period.isZero(): Bool & Pure;
        let Period(x1) = x;
        isZero(x1)

    pub def isPositive(x: Period): Bool =
        not isNegative(x)

    pub def isNegative(x: Period): Bool =
        import java.time.Period.isNegative(): Bool & Pure;
        let Period(x1) = x;
        isNegative(x1)


    pub def plusYears(x: Period, years: Int64): Period =
        import java.time.Period.plusYears(Int64): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(plusYears(x1, years))

    pub def minusYears(x: Period, years: Int64): Period =
        import java.time.Period.minusYears(Int64): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(minusYears(x1, years))

    pub def plusMonths(x: Period, months: Int64): Period =
        import java.time.Period.plusMonths(Int64): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(plusMonths(x1, months))

    pub def minusMonths(x: Period, months: Int64): Period =
        import java.time.Period.minusMonths(Int64): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(minusMonths(x1, months))

    pub def plusDays(x: Period, days: Int64): Period =
        import java.time.Period.plusDays(Int64): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(plusDays(x1, days))

    pub def minusDays(x: Period, days: Int64): Period =
        import java.time.Period.minusDays(Int64): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(minusDays(x1, days))

    /// Get/Set...


    pub def getYears(x: Period): Int32 =
        import java.time.Period.getYears(): Int32 & Pure;
        let Period(x1) = x;
        getYears(x1)

    pub def setYears(years: Int32, x: Period): Period =
        import java.time.Period.withYears(Int32): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(withYears(x1, years))

    pub def getMonths(x: Period): Int32 =
        import java.time.Period.getMonths(): Int32 & Pure;
        let Period(x1) = x;
        getMonths(x1)

    pub def setMonths(months: Int32, x: Period): Period =
        import java.time.Period.withMonths(Int32): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(withMonths(x1, months))

    pub def getDays(x: Period): Int32 =
        import java.time.Period.getDays(): Int32 & Pure;
        let Period(x1) = x;
        getDays(x1)

    pub def setDays(days: Int32, x: Period): Period =
        import java.time.Period.withDays(Int32): ##java.time.Period & Pure;
        let Period(x1) = x;
        Period(withDays(x1, days))



    pub def between(r: {start :: LocalDate, end :: LocalDate}): Period =
        import static java.time.Period.between(##java.time.LocalDate, ##java.time.LocalDate): ##java.time.Period & Pure;
        let LocalDate(b1) = r.start;
        let LocalDate(e1) = r.end;
        Period(between(b1, e1))


    /// Generic
    
    /// # `from<TemporalAmount>` specialized - only supported amount is Period which is identity

    /// # `get` specialized - supported units are YEARS, MONTHS, DAYS
    /// These are already covered in the non generic API
    
    /// # `plus<TemporalAmount>` specialized

    pub def plus(x: Period, a: Period): Period =
        import java.time.Period.plus(##java.time.temporal.TemporalAmount): ##java.time.Period & Pure;
        let x1 = getPeriod(x);
        let a1 = getPeriod(a) as ##java.time.temporal.TemporalAmount;
        Period(plus(x1, a1))

    /// # `minus<TemporalAmount>` specialized

    pub def minus(x: Period, a: Period): Period =
        import java.time.Period.minus(##java.time.temporal.TemporalAmount): ##java.time.Period & Pure;
        let x1 = getPeriod(x);
        let a1 = getPeriod(a) as ##java.time.temporal.TemporalAmount;
        Period(minus(x1, a1))


    /// # `addTo`  and `subtractFrom` specialized - these become `plusPeriod` and `minusPeriod` their respective modules:
    /// Instant
    /// LocalDate
    /// LocalDateTime
    /// OffsetDateTime
    /// ZonedDateTime


}
