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


pub mod InteropTime.DurationZ {


    use InteropTime.Internal.AdaptorExtras

    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.lang.{Exception => JException}

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
            let DurationZ.DurationZ(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as a Duration, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 duration format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[DurationZ] {
        pub def fromString(s: String): Option[DurationZ] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JDuration.parse(s1) };
                DurationZ.DurationZ(ans) |> Some
            } catch {
                case _: JException => None
            }
    }

    instance Eq[DurationZ] {
        pub def eq(x: DurationZ, y: DurationZ): Bool =
            let DurationZ.DurationZ(x1) = x;
            let DurationZ.DurationZ(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[DurationZ] {
        pub def hash(x: DurationZ): Int32 =
            let DurationZ.DurationZ(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[DurationZ] {
        pub def compare(x: DurationZ, y: DurationZ): Comparison =
            let DurationZ.DurationZ(x1) = x;
            let DurationZ.DurationZ(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance Add[DurationZ] {
        pub def add(x: DurationZ, y: DurationZ): DurationZ =
            let DurationZ.DurationZ(x1) = x;
            let DurationZ.DurationZ(y1) = y;
            let ans = unsafe IO { x1.plus(y1) };
            DurationZ(ans)
    }

    instance Sub[DurationZ] {
        pub def sub(x: DurationZ, y: DurationZ): DurationZ =
            let DurationZ.DurationZ(x1) = x;
            let DurationZ.DurationZ(y1) = y;
            let ans = unsafe IO { x1.minus(y1) };
            DurationZ.DurationZ(ans)
    }

    instance Neg[DurationZ] {
        pub def neg(x: DurationZ): DurationZ =
            let DurationZ.DurationZ(x1) = x;
            let ans = unsafe IO { x1.negated() };
            DurationZ.DurationZ(ans)
    }

    /// `combine` is addition
    instance SemiGroup[DurationZ] {
        pub def combine(x: DurationZ, y: DurationZ): DurationZ = 
            let DurationZ.DurationZ(x1) = x;
            let DurationZ.DurationZ(y1) = y;
            let ans = unsafe IO { x1.plus(y1) };
            DurationZ.DurationZ(ans)
    }

    /// Monoid is addition
    instance Monoid[DurationZ] {
        pub def empty(): DurationZ = 
            DurationZ.DurationZ(unsafe IO { JDuration.ZERO} )
    }


    instance ToJava[DurationZ] {
        type Out = JDuration
        pub def toJava(x: DurationZ): JDuration = 
            let DurationZ.DurationZ(x1) = x;
            x1
    }

    instance ToFlix[DurationZ] {
        type In = JDuration
        pub def toFlix(x: JDuration): DurationZ = 
            DurationZ.DurationZ(x)
    }
    

    /// Constructors

    ///
    /// Return a new duration.
    ///
    pub def duration(seconds: {seconds = Int64}, 
                        nanos: {nanos = Int64}): DurationZ =
        AdaptorExtras.of(() -> unsafe IO { JDuration.ofSeconds(seconds#seconds, nanos#nanos) })

    /// "abstract constructors" (e.g. `zero`)

    ///
    /// Construct a zero length Duration.
    ///
    pub def zero(): DurationZ = 
        AdaptorExtras.of(() -> unsafe IO { JDuration.ZERO} )


    /// `of` functions

    ///
    /// Construct a Duration from the supplied number of nanoseconds.
    ///
    pub def ofNanos(nanos: Int64): DurationZ =
        AdaptorExtras.of(() -> unsafe IO { JDuration.ofNanos(nanos) })


    ///
    /// Construct a Duration from the supplied number of milliseconds.
    ///
    pub def ofMillis(millis: Int64): DurationZ =
        AdaptorExtras.of(() -> unsafe IO { JDuration.ofMillis(millis) })


    ///
    /// Construct a Duration from the supplied number of seconds.
    ///
    pub def ofSeconds(seconds: Int64): DurationZ =
        AdaptorExtras.of(() -> unsafe IO { JDuration.ofSeconds(seconds) })

    ///
    /// Construct a Duration from the supplied number of minutes.
    ///
    pub def ofMinutes(minutes: Int64): DurationZ =
        AdaptorExtras.of(() -> unsafe IO { JDuration.ofMinutes(minutes) })

    ///
    /// Construct a Duration from the supplied number of hours.
    ///
    pub def ofHours(hours: Int64): DurationZ =
        AdaptorExtras.of(() -> unsafe IO { JDuration.ofHours(hours) })

    ///
    /// Construct a Duration from the supplied number of days.
    ///
    pub def ofDays(days: Int64): DurationZ =
        AdaptorExtras.of(() -> unsafe IO { JDuration.ofDays(days) })

    // `of` specialized - except for HalfDays we already have a `from_` function for the other supported ChronoUnits

    pub def ofHalfDays(i: Int64): DurationZ = 
        AdaptorExtras.of(() -> {
            let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
            unsafe IO {  JDuration.of(i, u1) }
        })


    /// `to` functions

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def toNanos(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toNanos() })

    ///
    /// Get the total length of Duration `x` in milliseconds.
    ///
    pub def toMillis(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toMillis() })


    ///
    /// Return the number of seconds in Duration `x`.
    ///
    pub def toSeconds(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toSeconds() })


    ///
    /// Return the number of minutes in Duration `x`.
    ///
    pub def toMinutes(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toMinutes() })


    ///
    /// Return the number of hours in Duration `x`.
    ///
    pub def toHours(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toHours() })

    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDays(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toDays() })

    ///
    /// Do we want `toDays` and `toDaysPart` ?
    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDaysPart(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toDaysPart() })

    /// `parse` / `format` functions

    pub def parse(s: String): Result[String, DurationZ] =
        AdaptorExtras.ofWithResult(() -> {
            let s1 = String.trim(s);
            unsafe IO { JDuration.parse(s1) }
        })

    /// Note - alias of `toString`
    pub def format(x: DurationZ): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toString() })


    /// predicates / comparisons

    pub def isZero(x: DurationZ): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isZero() })

    pub def isPositive(x: DurationZ): Bool =
        not isNegative(x)

    pub def isNegative(x: DurationZ): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isNegative() })

    /// Duration functions

    ///
    /// Returns the absolute value of `x`.
    ///
    pub def abs(x: DurationZ): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.abs() })


    /// Getters and Setters

    ///
    /// Get the nanosecond part of the duration `x`.
    ///
    pub def getNano(x: DurationZ): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getNano() })

    ///
    /// Set the nano part of the duration `x` to `seconds``.
    ///
    pub def withNanos(nanos: Int32, x: DurationZ): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withNanos(nanos) })

    ///
    /// Get the second part of the duration `x`.
    ///
    pub def getSeconds(x: DurationZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getSeconds() })

    ///
    /// Set the seconds part of the duration `x` to `seconds``.
    ///
    pub def withSeconds(seconds: Int64, x: DurationZ): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withSeconds(seconds) })

    /// #truncate functions
    
    pub def truncatedToNanos(x: DurationZ): DurationZ = 
        AdaptorExtras.op(x, x1 -> { 
            let u1 = unsafe IO { JChronoUnit.NANOS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToMicros(x: DurationZ): DurationZ = 
        AdaptorExtras.op(x, x1 -> { 
            let u1 = unsafe IO { JChronoUnit.MICROS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToMillis(x: DurationZ): DurationZ = 
        AdaptorExtras.op(x, x1 -> { 
            let u1 = unsafe IO { JChronoUnit.MILLIS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToSeconds(x: DurationZ): DurationZ = 
        AdaptorExtras.op(x, x1 -> { 
            let u1 = unsafe IO { JChronoUnit.SECONDS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToMinutes(x: DurationZ): DurationZ = 
        AdaptorExtras.op(x, x1 -> { 
            let u1 = unsafe IO { JChronoUnit.MINUTES };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToHours(x: DurationZ): DurationZ = 
        AdaptorExtras.op(x, x1 -> { 
            let u1 = unsafe IO { JChronoUnit.HOURS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToHalfDays(x: DurationZ): DurationZ = 
        AdaptorExtras.op(x, x1 -> { 
            let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
            unsafe IO { x1.truncatedTo(u1) }
        })


    /// ## plus / minus functions


    pub def plusDays(x: DurationZ, days: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusDays(days) })

    pub def minusDays(x: DurationZ, days: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusDays(days) })

    pub def plusHours(x: DurationZ, hours: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusHours(hours) })

    pub def minusHours(x: DurationZ, hours: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusHours(hours) })

    pub def plusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMinutes(minutes) })

    pub def minusMinutes(x: DurationZ, minutes: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMinutes(minutes) })

    pub def plusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusSeconds(seconds) })

    pub def minusSeconds(x: DurationZ, seconds: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusSeconds(seconds) })

    pub def plusMillis(x: DurationZ, millis: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMillis(millis) })

    pub def minusMillis(x: DurationZ, millis: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMillis(millis) })

    pub def plusNanos(x: DurationZ, nanos: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusNanos(nanos) })

    pub def minusNanos(x: DurationZ, nanos: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusNanos(nanos) })


    pub def plusHalfDays(x: DurationZ, i: Int64): DurationZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
            unsafe IO { x1.plus(i, u1) }
        })

    pub def minusHalfDays(x: DurationZ, i: Int64): DurationZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
            unsafe IO { x1.minus(i, u1) }
        })


    /// multiply / divide functions

    pub def multipliedBy(x: DurationZ, y: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.multipliedBy(y) })

    pub def dividedBy(x: DurationZ, y: Int64): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.dividedBy(y) })


}

