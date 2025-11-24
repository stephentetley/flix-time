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
    use Time.DurationZ.{DurationZ }

    import java.time.{Duration => JDuration }
    import java.lang.{Object, CharSequence }

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
            unsafe IO { x1.toString() }
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
                let ans = unsafe IO { JDuration.parse(s1) };
                DurationZ(ans)
           }) |> Result.toOption
   }

    instance Eq[DurationZ] {
        pub def eq(x: DurationZ, y: DurationZ): Bool =
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            unsafe IO { x1.equals(y1) }
   }

    instance Hash[DurationZ] {
        pub def hash(x: DurationZ): Int32 =
            let DurationZ(x1) = x;
            unsafe IO { x1.hashCode() }
   }

    instance Order[DurationZ] {
        pub def compare(x: DurationZ, y: DurationZ): Comparison = 
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
   }

    instance Add[DurationZ] {
        pub def add(x: DurationZ, y: DurationZ): DurationZ =
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            let ans = unsafe IO { x1.plus(y1) };
            DurationZ(ans)
   }

    instance Sub[DurationZ] {
        pub def sub(x: DurationZ, y: DurationZ): DurationZ =
            let DurationZ(x1) = x;
            let DurationZ(y1) = y;
            let ans = unsafe IO { x1.minus(y1) };
            DurationZ(ans)
   }

    instance Neg[DurationZ] {
        pub def neg(x: DurationZ): DurationZ =
            let DurationZ(x1) = x;
            let ans = unsafe IO { x1.negated() };
            DurationZ(ans)
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
    use Time.DurationZ.{DurationZ }

    import java.lang.{Object, CharSequence }
    import java.time.{Duration => JDuration }
    import java.time.temporal.{ChronoUnit => JChronoUnit }
    
    /// Unwrap

    pub def getDuration(x: DurationZ): JDuration = 
        let DurationZ(x1) = x;
        x1


    /// Constructors

    ///
    /// Return a new duration.
    ///
    pub def duration(r: {seconds = Int64, nanos = Int64 }): DurationZ =
        let ans = unsafe IO { JDuration.ofSeconds(r#seconds, r#nanos) };
        DurationZ(ans)

    /// "abstract constructors" (e.g. `zero`)

    ///
    /// Construct a zero length Duration.
    ///
    pub def zero(): DurationZ = DurationZ(unsafe IO { JDuration.ZERO} ) 


    /// `of` functions

    ///
    /// Construct a Duration from the supplied number of nanoseconds.
    ///
    pub def ofNanos(nanos: Int64): DurationZ =
        let ans = unsafe IO { JDuration.ofNanos(nanos) };
        DurationZ(ans)


    ///
    /// Construct a Duration from the supplied number of milliseconds.
    ///
    pub def ofMillis(millis: Int64): DurationZ =
        let ans = unsafe IO { JDuration.ofMillis(millis) };
        DurationZ(ans)


    ///
    /// Construct a Duration from the supplied number of seconds.
    ///
    pub def ofSeconds(seconds: Int64): DurationZ =
        let ans = unsafe IO { JDuration.ofSeconds(seconds) };
        DurationZ(ans)

    ///
    /// Construct a Duration from the supplied number of minutes.
    ///
    pub def ofMinutes(minutes: Int64): DurationZ =
        let ans = unsafe IO { JDuration.ofMinutes(minutes) };
        DurationZ(ans)

    ///
    /// Construct a Duration from the supplied number of hours.
    ///
    pub def ofHours(hours: Int64): DurationZ =
        let ans = unsafe IO { JDuration.ofHours(hours) };
        DurationZ(ans)

    ///
    /// Construct a Duration from the supplied number of days.
    ///
    pub def ofDays(days: Int64): DurationZ =
        let ans = unsafe IO { JDuration.ofDays(days) };
        DurationZ(ans)

    // `of` specialized - except for HalfDays we already have a `from_` function for the other supported ChronoUnits

    pub def ofHalfDays(i: Int64): DurationZ = 
        let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
        let ans = unsafe IO {  JDuration.of(i, u1) };
        DurationZ(ans)


    /// `to` functions

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def toNanos(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.toNanos() }

    ///
    /// Get the total length of Duration `x` in milliseconds.
    ///
    pub def toMillis(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.toMillis() }


    ///
    /// Return the number of seconds in Duration `x`.
    ///
    pub def toSeconds(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.toSeconds() }


    ///
    /// Return the number of minutes in Duration `x`.
    ///
    pub def toMinutes(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.toMinutes() }


    ///
    /// Return the number of hours in Duration `x`.
    ///
    pub def toHours(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.toHours() }

    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDays(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.toDays() }

    ///
    /// Do we want `toDays` and `toDaysPart` ?
    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDaysPart(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.toDaysPart() }

    /// `parse` / `format` functions

    pub def parse(s: String): Result[String, DurationZ] =
        Result.tryCatch(_ -> {
            let s1 = String.trim(s);
            let ans = unsafe IO { JDuration.parse(s1) };
            DurationZ(ans)
       })

    /// Note - alias of `toString`
    pub def format(x: DurationZ): String =
        let DurationZ(x1) = x;
        unsafe IO { x1.toString() }


    /// predicates / comparisons

    pub def isZero(x: DurationZ): Bool =
        let DurationZ(x1) = x;
        unsafe IO { x1.isZero() }

    pub def isPositive(x: DurationZ): Bool =
        not isNegative(x)

    pub def isNegative(x: DurationZ): Bool =
        let DurationZ(x1) = x;
        unsafe IO { x1.isNegative() }

    /// Duration functions

    ///
    /// Returns the absolute value of `x`.
    ///
    pub def abs(x: DurationZ): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.abs() };
        DurationZ(ans)


    /// Getters and Setters

    ///
    /// Get the nanosecond part of the duration `x`.
    ///
    pub def getNano(x: DurationZ): Int32 =
        let DurationZ(x1) = x;
        unsafe IO { x1.getNano() }

    ///
    /// Set the nano part of the duration `x` to `seconds``.
    ///
    pub def withNanos(nanos: Int32, x: DurationZ): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.$withNanos(nanos) };
        DurationZ(ans)

    ///
    /// Get the second part of the duration `x`.
    ///
    pub def getSeconds(x: DurationZ): Int64 =
        let DurationZ(x1) = x;
        unsafe IO { x1.getSeconds() }

    ///
    /// Set the seconds part of the duration `x` to `seconds``.
    ///
    pub def withSeconds(seconds: Int64, x: DurationZ): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.$withSeconds(seconds) };
        DurationZ(ans)

    /// #truncate functions
    
    pub def truncatedToNanos(x: DurationZ): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.NANOS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        DurationZ(ans)

    pub def truncatedToMicros(x: DurationZ): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.MICROS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        DurationZ(ans)

    pub def truncatedToMillis(x: DurationZ): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.MILLIS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        DurationZ(ans)

    pub def truncatedToSeconds(x: DurationZ): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.SECONDS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        DurationZ(ans)

    pub def truncatedToMinutes(x: DurationZ): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.MINUTES };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        DurationZ(ans)

    pub def truncatedToHours(x: DurationZ): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.HOURS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        DurationZ(ans)

    pub def truncatedToHalfDays(x: DurationZ): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
        let ans = unsafe IO { x1.truncatedTo(u1) };
        DurationZ(ans)


    /// ## plus / minus functions


    pub def plusDays(x: DurationZ, days: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.plusDays(days) };
        DurationZ(ans)

    pub def minusDays(x: DurationZ, days: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.minusDays(days) };
        DurationZ(ans)

    pub def plusHours(x: DurationZ, hours: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.plusHours(hours) };
        DurationZ(ans)

    pub def minusHours(x: DurationZ, hours: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.minusHours(hours) };
        DurationZ(ans)

    pub def plusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.plusMinutes(minutes) };
        DurationZ(ans)

    pub def minusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.minusMinutes(minutes) };
        DurationZ(ans)

    pub def plusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.plusSeconds(seconds) };
        DurationZ(ans)

    pub def minusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.minusSeconds(seconds) };
        DurationZ(ans)

    pub def plusMillis(x: DurationZ, millis: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.plusMillis(millis) };
        DurationZ(ans)

    pub def minusMillis(x: DurationZ, millis: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.minusMillis(millis) };
        DurationZ(ans)

    pub def plusNanos(x: DurationZ, nanos: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.plusNanos(nanos) };
        DurationZ(ans)

    pub def minusNanos(x: DurationZ, nanos: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.minusNanos(nanos) };
        DurationZ(ans)


    pub def plusHalfDays(x: DurationZ, i: Int64): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
        let ans = unsafe IO { x1.plus(i, u1) };
        DurationZ(ans)

    pub def minusHalfDays(x: DurationZ, i: Int64): DurationZ = 
        let DurationZ(x1) = x;
        let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
        let ans = unsafe IO { x1.minus(i, u1) };
        DurationZ(ans)


    /// multiply / divide functions

    pub def multipliedBy(x: DurationZ, y: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.multipliedBy(y) };
        DurationZ(ans)

    pub def dividedBy(x: DurationZ, y: Int64): DurationZ =
        let DurationZ(x1) = x;
        let ans = unsafe IO { x1.dividedBy(y) };
        DurationZ(ans)


}
