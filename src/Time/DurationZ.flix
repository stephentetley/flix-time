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



mod Time {

    use Time.DurationZ
    use Time.DurationZ.{DurationZ}

    import java.time.{Duration => JDuration}
    import java.lang.{Object, CharSequence}

    ///
    /// A measure of time represented internally as seconds and a nanoseconds adjustment.
    ///
    /// This is a wrapper around java.time.Duration.
    ///
    pub enum DurationZ(JDuration)

    ///
    /// The format of the output string is in ISO-8601 duration format.
    ///
    instance ToString[DurationZ] {
        pub def toString(x: DurationZ): String =
            let DurationZ(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as a Duration, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 duration format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[DurationZ] {
        pub def fromString(s: String): Option[DurationZ] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs  = (checked_cast(s1) : CharSequence);
                DurationZ(unsafe JDuration.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[DurationZ] {
        pub def eq(x: DurationZ, y: DurationZ): Bool =
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }

    instance Hash[DurationZ] {
        pub def hash(x: DurationZ): Int32 =
            let DurationZ(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[DurationZ] {
        pub def compare(x: DurationZ, y: DurationZ): Comparison = 
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }

    instance Add[DurationZ] {
        pub def add(x: DurationZ, y: DurationZ): DurationZ =
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            DurationZ(unsafe x1.plus(y1))
    }

    instance Sub[DurationZ] {
        pub def sub(x: DurationZ, y: DurationZ): DurationZ =
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            DurationZ(unsafe x1.minus(y1))
    }

    instance Neg[DurationZ] {
        pub def neg(x: DurationZ): DurationZ =
            let DurationZ(x1) = x;
            DurationZ(unsafe x1.negated())
    }

    /// `combine` is addition
    instance SemiGroup[DurationZ] {
        pub def combine(x: DurationZ, y: DurationZ): DurationZ = Add.add(x, y)
    }

    /// Monoid is addition
    instance Monoid[DurationZ] {
        pub def empty(): DurationZ = Time.DurationZ.zero()
    }


}

mod Time.DurationZ {

    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    
    use Time.Temporal.TemporalUnit
    use Time.Temporal.TemporalUnit.{TemporalUnit}

    import java.time.{Duration => JDuration}
    import java.lang.{Object, CharSequence}
    
    /// Unwrap

    pub def getDuration(x: DurationZ): JDuration = 
        let DurationZ(x1) = x;
        x1


    /// Constructors

    ///
    /// Return a new duration.
    ///
    pub def duration(r: {seconds = Int64, nanos = Int64}): DurationZ =
        DurationZ(unsafe JDuration.ofSeconds(r#seconds, r#nanos))

    /// "abstract constructors" (e.g. `zero`)

    ///
    /// Construct a zero length Duration.
    ///
    pub def zero(): DurationZ = DurationZ(unsafe JDuration.ZERO)


    /// `of` functions

    ///
    /// Construct a Duration from the supplied number of nanoseconds.
    ///
    pub def ofNanos(nanos: Int64): DurationZ =
        DurationZ(unsafe JDuration.ofNanos(nanos))


    ///
    /// Construct a Duration from the supplied number of milliseconds.
    ///
    pub def ofMillis(millis: Int64): DurationZ =
        DurationZ(unsafe JDuration.ofMillis(millis))


    ///
    /// Construct a Duration from the supplied number of seconds.
    ///
    pub def ofSeconds(seconds: Int64): DurationZ =
        DurationZ(unsafe JDuration.ofSeconds(seconds))

    ///
    /// Construct a Duration from the supplied number of minutes.
    ///
    pub def ofMinutes(minutes: Int64): DurationZ =
        DurationZ(unsafe JDuration.ofMinutes(minutes))

    ///
    /// Construct a Duration from the supplied number of hours.
    ///
    pub def ofHours(hours: Int64): DurationZ =
        DurationZ(unsafe JDuration.ofHours(hours))

    ///
    /// Construct a Duration from the supplied number of days.
    ///
    pub def ofDays(days: Int64): DurationZ =
        DurationZ(unsafe JDuration.ofDays(days))

    // `of` specialized - except for HalfDays we already have a `from_` function for the other supported ChronoUnits

    // def ofTemporalUnit(amount: Int64, tu: TemporalUnit): DurationZ =
    //     import static java.time.Duration.of(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration \ {};         
    //     try {
    //          let TemporalUnit(tu1) = tu;
    //          DurationZ(of(amount, tu1))
    //     } catch { 
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }

    // pub def ofHalfDays(i: Int64): DurationZ = 
    //     Time.Temporal.ChronoUnit.HalfDays 
    //         |> Time.Temporal.ChronoUnit.asTemporalUnit
    //         |> ofTemporalUnit(i)


    /// `to` functions

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def toNanos(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.toNanos()

    ///
    /// Get the total length of Duration `x` in milliseconds.
    ///
    pub def toMillis(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.toMillis()


    ///
    /// Return the number of seconds in Duration `x`.
    ///
    pub def toSeconds(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.toSeconds()


    ///
    /// Return the number of minutes in Duration `x`.
    ///
    pub def toMinutes(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.toMinutes()


    ///
    /// Return the number of hours in Duration `x`.
    ///
    pub def toHours(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.toHours()

    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDays(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.toDays()

    ///
    /// Do we want `toDays` and `toDaysPart` ?
    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDaysPart(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.toDaysPart()

    /// `parse` / `format` functions

    pub def parse(s: String): Result[String, DurationZ] =
        Result.tryCatch(_ -> {
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            DurationZ(unsafe JDuration.parse(cs))
        })

    /// Note - alias of `toString`
    pub def format(x: DurationZ): String =
        let DurationZ(x1) = x;
        unsafe x1.toString()


    /// predicates / comparisons

    pub def isZero(x: DurationZ): Bool =
        let DurationZ(x1) = x;
        unsafe x1.isZero()

    pub def isPositive(x: DurationZ): Bool =
        not isNegative(x)

    pub def isNegative(x: DurationZ): Bool =
        let DurationZ(x1) = x;
        unsafe x1.isNegative()

    /// Duration functions

    ///
    /// Returns the absolute value of `x`.
    ///
    pub def abs(x: DurationZ): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.abs())


    /// Getters and Setters

    ///
    /// Get the nanosecond part of the duration `x`.
    ///
    pub def getNano(x: DurationZ): Int32 =
        let DurationZ(x1) = x;
        unsafe x1.getNano()

    ///
    /// Set the nano part of the duration `x` to `seconds``.
    ///
    pub def withNanos(nanos: Int32, x: DurationZ): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.withNanos(nanos))

    ///
    /// Get the second part of the duration `x`.
    ///
    pub def getSeconds(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe x1.getSeconds()

    ///
    /// Set the seconds part of the duration `x` to `seconds``.
    ///
    pub def withSeconds(seconds: Int64, x: DurationZ): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.withSeconds(seconds))

    /// #truncate functions

    // def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: DurationZ): DurationZ = 
    //     let DurationZ(x1) = x;
    //     DurationZ(unsafe x1.truncatedTo(u))
    
    // pub def truncatedToNanos(x: DurationZ): DurationZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
    //     truncatedToHelper(unchecked_cast(get_NANOS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToMicros(x: DurationZ): DurationZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
    //     truncatedToHelper(unchecked_cast(get_MICROS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToMillis(x: DurationZ): DurationZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
    //     truncatedToHelper(unchecked_cast(get_MILLIS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToSeconds(x: DurationZ): DurationZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
    //     truncatedToHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToMinutes(x: DurationZ): DurationZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
    //     truncatedToHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToHours(x: DurationZ): DurationZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
    //     truncatedToHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToHalfDays(x: DurationZ): DurationZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
    //     truncatedToHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), x)


    /// ## plus / minus functions


    pub def plusDays(x: DurationZ, days: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.plusDays(days))

    pub def minusDays(x: DurationZ, days: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.minusDays(days))

    pub def plusHours(x: DurationZ, hours: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.plusHours(hours))

    pub def minusHours(x: DurationZ, hours: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.minusHours(hours))

    pub def plusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.plusMinutes(minutes))

    pub def minusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.minusMinutes(minutes))

    pub def plusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.plusSeconds(seconds))

    pub def minusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.minusSeconds(seconds))

    pub def plusMillis(x: DurationZ, millis: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.plusMillis(millis))

    pub def minusMillis(x: DurationZ, millis: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.minusMillis(millis))

    pub def plusNanos(x: DurationZ, nanos: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.plusNanos(nanos))

    pub def minusNanos(x: DurationZ, nanos: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.minusNanos(nanos))


    // pub def plusHalfDays(x: DurationZ, i: Int64): DurationZ = 
    //     Time.Temporal.ChronoUnit.HalfDays
    //         |> Time.Temporal.ChronoUnit.asTemporalUnit
    //         |> plusHelper(x, i)

    // pub def minusHalfDays(x: DurationZ, i: Int64): DurationZ = 
    //     Time.Temporal.ChronoUnit.HalfDays
    //         |> Time.Temporal.ChronoUnit.asTemporalUnit
    //         |> minusHelper(x, i)

    /// multiply / divide functions

    pub def multipliedBy(x: DurationZ, y: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.multipliedBy(y))

    pub def dividedBy(x: DurationZ, y: Int64): DurationZ =
        let DurationZ(x1) = x;
        DurationZ(unsafe x1.dividedBy(y))

    // generic helper functions
    
    // `plus` specialized - except for HalfDays we already have a `plus_` function for the other supported ChronoUnits

    // def plusHelper(x: DurationZ, amount: Int64, tu: TemporalUnit): DurationZ =
    //     import java.time.Duration.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration \ {};         
    //     try {
    //         let DurationZ(x1) = x;
    //         let TemporalUnit(tu1) = tu;
    //         plus(x1, amount, tu1) |> DurationZ
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }
    

    // `minus` specialized - except for HalfDays we already have a `minus_` function for the other supported ChronoUnits

    // def minusHelper(x: DurationZ, amount: Int64, tu: TemporalUnit): DurationZ =
    //     import java.time.Duration.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration \ {};         
    //     try {
    //         let DurationZ(x1) = x;
    //         let TemporalUnit(tu1) = tu;
    //         DurationZ(minus(x1, amount, tu1))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }
    


}
