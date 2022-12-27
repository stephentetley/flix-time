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

/// The name is temporary due to a clash with Flix stdlib



namespace Time {

    ///
    /// A measure of time represented internally as seconds and a nanoseconds adjustment.
    ///
    /// This is a wrapper around java.time.Duration.
    ///
    pub enum DurationZ(##java.time.Duration)

    ///
    /// The format of the output string is in ISO-8601 duration format.
    ///
    instance ToString[DurationZ] {
        pub def toString(x: DurationZ): String =
            import java.time.Duration.toString(): String \ {};
            let DurationZ(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a Duration, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 duration format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[DurationZ] {
        pub def fromString(s: String): Option[DurationZ] =
            import static java.time.Duration.parse(##java.lang.CharSequence): ##java.time.Duration \ {};
            try {
                let cs = unsafe_cast String.trim(s) as ##java.lang.CharSequence;
                Some(DurationZ(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[DurationZ] {
        pub def eq(x: DurationZ, y: DurationZ): Bool =
            import java.time.Duration.equals(##java.lang.Object): Bool \ {};
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            equals(x1, unsafe_cast y1 as ##java.lang.Object)
    }

    instance Hash[DurationZ] {
        pub def hash(x: DurationZ): Int32 =
            import java.time.Duration.hashCode(): Int32 \ {};
            let DurationZ(x1) = x;
            hashCode(x1)
    }

    instance Order[DurationZ] {
        pub def compare(x: DurationZ, y: DurationZ): Comparison = 
            import java.time.Duration.compareTo(##java.time.Duration): Int32 \ {};
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }

    instance Boxable[DurationZ]

    instance Add[DurationZ] {
        pub def add(x: DurationZ, y: DurationZ): DurationZ =
            import java.time.Duration.plus(##java.time.Duration): ##java.time.Duration \ {};
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            DurationZ(plus(x1, y1))
    }

    instance Sub[DurationZ] {
        pub def sub(x: DurationZ, y: DurationZ): DurationZ =
            import java.time.Duration.minus(##java.time.Duration): ##java.time.Duration \ {};
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            DurationZ(minus(x1, y1))
    }

    instance Neg[DurationZ] {
        pub def neg(x: DurationZ): DurationZ =
            import java.time.Duration.negated(): ##java.time.Duration \ {};
            let DurationZ(x1) = x;
            DurationZ(negated(x1))
    }

    /// `combine` is addition
    instance SemiGroup[DurationZ] {
        pub def combine(x: DurationZ, y: DurationZ): DurationZ = Add.add(x, y)
    }

    /// Monoid is addition
    instance Monoid[DurationZ] {
        pub def empty(): DurationZ = Time/DurationZ.zero()
    }


    instance Interop/Flix.Marshal[DurationZ] {
        pub def toJavaObject(x: DurationZ): ##java.lang.Object =
            let DurationZ(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): DurationZ = 
            DurationZ(unsafe_cast o as ##java.time.Duration)
    }

}

namespace Time/DurationZ {

    use Time.DurationZ;
    use Time.DurationZ.{DurationZ};
    
    /// ## Unwrap

    pub def getDuration(x: DurationZ): ##java.time.Duration = 
        let DurationZ(x1) = x;
        x1


    /// ## Constructors

    ///
    /// Return a new duration.
    ///
    pub def duration(r: {seconds = Int64, nanos = Int64}): DurationZ =
        import static java.time.Duration.ofSeconds(Int64, Int64): ##java.time.Duration \ {};
        DurationZ(ofSeconds(r.seconds, r.nanos))

    /// ## "abstract constructors" (e.g. `zero`)

    ///
    /// Construct a zero length Duration.
    ///
    pub def zero(): DurationZ =
        import static get java.time.Duration.ZERO: ##java.time.Duration \ {} as get_ZERO;
        DurationZ(get_ZERO())


    /// ## `from` functions

    ///
    /// Construct a Duration from the supplied number of nanoseconds.
    ///
    pub def fromNanos(nanos: Int64): DurationZ =
        import static java.time.Duration.ofNanos(Int64): ##java.time.Duration \ {};
        DurationZ(ofNanos(nanos))


    ///
    /// Construct a Duration from the supplied number of milliseconds.
    ///
    pub def fromMillis(millis: Int64): DurationZ =
        import static java.time.Duration.ofMillis(Int64): ##java.time.Duration \ {};
        DurationZ(ofMillis(millis))


    ///
    /// Construct a Duration from the supplied number of seconds.
    ///
    pub def fromSeconds(seconds: Int64): DurationZ =
        import static java.time.Duration.ofSeconds(Int64): ##java.time.Duration \ {};
        DurationZ(ofSeconds(seconds))

    ///
    /// Construct a Duration from the supplied number of minutes.
    ///
    pub def fromMinutes(minutes: Int64): DurationZ =
        import static java.time.Duration.ofMinutes(Int64): ##java.time.Duration \ {};
        DurationZ(ofMinutes(minutes))

    ///
    /// Construct a Duration from the supplied number of hours.
    ///
    pub def fromHours(hours: Int64): DurationZ =
        import static java.time.Duration.ofHours(Int64): ##java.time.Duration \ {};
        DurationZ(ofHours(hours))

    ///
    /// Construct a Duration from the supplied number of days.
    ///
    pub def fromDays(days: Int64): DurationZ =
        import static java.time.Duration.ofDays(Int64): ##java.time.Duration \ {};
        DurationZ(ofDays(days))

    /// # `of` specialized - except for HalfDays we already have a `from_` function for the other supported ChronoUnits

    def ofTemporalUnitHelper(temporalUnit: ##java.time.temporal.TemporalUnit, amount: Int64): DurationZ =
        import static java.time.Duration.of(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration \ {};         
        try {
            DurationZ(of(amount, temporalUnit))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromHalfDays(i: Int64): DurationZ = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        ofTemporalUnitHelper(unsafe_cast get_HALF_DAYS() as ##java.time.temporal.TemporalUnit, i)


    /// ## `to` functions

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def toNanos(x: DurationZ): Int64 =
        import java.time.Duration.toNanos(): Int64 \ {};
        let DurationZ(x1) = x;
        toNanos(x1)

    ///
    /// Get the total length of Duration `x` in milliseconds.
    ///
    pub def toMillis(x: DurationZ): Int64 =
        import java.time.Duration.toMillis(): Int64 \ {};
        let DurationZ(x1) = x;
        toMillis(x1)


    ///
    /// Return the number of seconds in Duration `x`.
    ///
    pub def toSeconds(x: DurationZ): Int64 =
        import java.time.Duration.toSeconds(): Int64 \ {};
        let DurationZ(x1) = x;
        toSeconds(x1)


    ///
    /// Return the number of minutes in Duration `x`.
    ///
    pub def toMinutes(x: DurationZ): Int64 =
        import java.time.Duration.toMinutes(): Int64 \ {};
        let DurationZ(x1) = x;
        toMinutes(x1)


    ///
    /// Return the number of hours in Duration `x`.
    ///
    pub def toHours(x: DurationZ): Int64 =
        import java.time.Duration.toHours(): Int64 \ {};
        let DurationZ(x1) = x;
        toHours(x1)

    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDays(x: DurationZ): Int64 =
        import java.time.Duration.toDays(): Int64 \ {};
        let DurationZ(x1) = x;
        toDays(x1)

    ///
    /// Do we want `toDays` and `toDaysPart` ?
    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDaysPart(x: DurationZ): Int64 =
        import java.time.Duration.toDaysPart(): Int64 \ {};
        let DurationZ(x1) = x;
        toDaysPart(x1)

    /// ## `parse` / `format` functions

    pub def parse(s: String): Result[DurationZ, String] =
        import static java.time.Duration.parse(##java.lang.CharSequence): ##java.time.Duration \ {};
        try {
            let cs = unsafe_cast String.trim(s) as ##java.lang.CharSequence;
            Ok(DurationZ(parse(cs)))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    /// Note - alias of `toString`
    pub def format(x: DurationZ): String =
        import java.time.Duration.toString(): String \ {};
        let DurationZ(x1) = x;
        toString(x1)


    /// ## predicates / comparisons

    pub def isZero(x: DurationZ): Bool =
        import java.time.Duration.isZero(): Bool \ {};
        let DurationZ(x1) = x;
        isZero(x1)

    pub def isPositive(x: DurationZ): Bool =
        not isNegative(x)

    pub def isNegative(x: DurationZ): Bool =
        import java.time.Duration.isNegative(): Bool \ {};
        let DurationZ(x1) = x;
        isNegative(x1)

    /// ## Duration functions

    ///
    /// Returns the absolute value of `x`.
    ///
    pub def abs(x: DurationZ): DurationZ =
        import java.time.Duration.abs(): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(abs(x1))


    /// ## Getters and Setters

    ///
    /// Get the nanosecond part of the duration `x`.
    ///
    pub def getNano(x: DurationZ): Int32 =
        import java.time.Duration.getNano(): Int32 \ {};
        let DurationZ(x1) = x;
        getNano(x1)

    ///
    /// Set the nano part of the duration `x` to `seconds``.
    ///
    pub def withNanos(nanos: Int32, x: DurationZ): DurationZ =
        import java.time.Duration.withNanos(Int32): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(withNanos(x1, nanos))

    ///
    /// Get the second part of the duration `x`.
    ///
    pub def getSeconds(x: DurationZ): Int64 =
        import java.time.Duration.getSeconds(): Int64 \ {};
        let DurationZ(x1) = x;
        getSeconds(x1)

    ///
    /// Set the seconds part of the duration `x` to `seconds``.
    ///
    pub def withSeconds(seconds: Int64, x: DurationZ): DurationZ =
        import java.time.Duration.withSeconds(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(withSeconds(x1, seconds))

    /// ## truncate functions

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: DurationZ): DurationZ = 
        import java.time.Duration.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(truncatedTo(x1, u))
    
    pub def truncatedToNanos(x: DurationZ): DurationZ = 
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
        truncatedToHelper(unsafe_cast get_NANOS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToMicros(x: DurationZ): DurationZ = 
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
        truncatedToHelper(unsafe_cast get_MICROS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToMillis(x: DurationZ): DurationZ = 
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
        truncatedToHelper(unsafe_cast get_MILLIS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToSeconds(x: DurationZ): DurationZ = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        truncatedToHelper(unsafe_cast get_SECONDS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToMinutes(x: DurationZ): DurationZ = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        truncatedToHelper(unsafe_cast get_MINUTES() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToHours(x: DurationZ): DurationZ = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        truncatedToHelper(unsafe_cast get_HOURS() as ##java.time.temporal.TemporalUnit, x)

    pub def truncatedToHalfDays(x: DurationZ): DurationZ = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        truncatedToHelper(unsafe_cast get_HALF_DAYS() as ##java.time.temporal.TemporalUnit, x)


    /// ## plus / minus functions


    pub def plusDays(x: DurationZ, days: Int64): DurationZ =
        import java.time.Duration.plusDays(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(plusDays(x1, days))

    pub def minusDays(x: DurationZ, days: Int64): DurationZ =
        import java.time.Duration.minusDays(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(minusDays(x1, days))

    pub def plusHours(x: DurationZ, hours: Int64): DurationZ =
        import java.time.Duration.plusHours(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(plusHours(x1, hours))

    pub def minusHours(x: DurationZ, hours: Int64): DurationZ =
        import java.time.Duration.minusHours(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(minusHours(x1, hours))

    pub def plusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        import java.time.Duration.plusMinutes(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(plusMinutes(x1, minutes))

    pub def minusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        import java.time.Duration.minusMinutes(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(minusMinutes(x1, minutes))

    pub def plusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        import java.time.Duration.plusSeconds(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(plusSeconds(x1, seconds))

    pub def minusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        import java.time.Duration.minusSeconds(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(minusSeconds(x1, seconds))

    pub def plusMillis(x: DurationZ, millis: Int64): DurationZ =
        import java.time.Duration.plusMillis(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(plusMillis(x1, millis))

    pub def minusMillis(x: DurationZ, millis: Int64): DurationZ =
        import java.time.Duration.minusMillis(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(minusMillis(x1, millis))

    pub def plusNanos(x: DurationZ, nanos: Int64): DurationZ =
        import java.time.Duration.plusNanos(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(plusNanos(x1, nanos))

    pub def minusNanos(x: DurationZ, nanos: Int64): DurationZ =
        import java.time.Duration.minusNanos(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(minusNanos(x1, nanos))


    pub def plusHalfDays(x: DurationZ, i: Int64): DurationZ = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        plusHelper(x, i, unsafe_cast get_HALF_DAYS() as ##java.time.temporal.TemporalUnit)

    pub def minusHalfDays(x: DurationZ, i: Int64): DurationZ = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        minusHelper(x, i, unsafe_cast get_HALF_DAYS() as ##java.time.temporal.TemporalUnit)

    /// ## multiply / divide functions

    pub def multipliedBy(x: DurationZ, y: Int64): DurationZ =
        import java.time.Duration.multipliedBy(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(multipliedBy(x1, y))

    pub def dividedBy(x: DurationZ, y: Int64): DurationZ =
        import java.time.Duration.dividedBy(Int64): ##java.time.Duration \ {};
        let DurationZ(x1) = x;
        DurationZ(dividedBy(x1, y))

    /// ## generic helper functions
    
    /// `plus` specialized - except for HalfDays we already have a `plus_` function for the other supported ChronoUnits

    def plusHelper(x: DurationZ, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): DurationZ =
        import java.time.Duration.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration \ {};         
        try {
            let DurationZ(x1) = x;
            DurationZ(plus(x1, amount, temporalUnit))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }
    

    /// `minus` specialized - except for HalfDays we already have a `minus_` function for the other supported ChronoUnits

    def minusHelper(x: DurationZ, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): DurationZ =
        import java.time.Duration.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration \ {};         
        try {
            let DurationZ(x1) = x;
            DurationZ(minus(x1, amount, temporalUnit))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }
    


}
