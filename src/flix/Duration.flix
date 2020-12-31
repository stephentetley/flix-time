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
    /// A measure of time represented internally as seconds and a nanoseconds adjustment.
    ///
    /// This is a wrapper around java.time.Duration.
    ///
    pub opaque type Duration = ##java.time.Duration

    ///
    /// The format of the output string is in ISO-8601 duration format.
    ///
    instance ToString[Duration] {
        def toString(x: Duration): String =
            import java.time.Duration.toString();
            let Duration(x1) = x;
            toString(x1) as & Pure
    }

    ///
    /// Parse the string `s` as a Duration, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 duration format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[Duration] {
        def fromString(s: String): Option[Duration] =
            import java.lang.String.strip();
            import java.time.Duration:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(Duration(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[Duration] {

        def eq(x: Duration, y: Duration): Bool =
            import java.time.Duration.equals(##java.lang.Object);
            let Duration(x1) = x;
            let Duration(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure

        def neq(x: Duration, y: Duration): Bool = not (x == y)
    }

    instance Add[Duration] {
        def add(x: Duration, y: Duration): Duration =
            import java.time.Duration.plus(##java.time.Duration);
            let Duration(x1) = x;
            let Duration(y1) = y;
            Duration(x1.plus(y1)) as & Pure
    }

    instance Sub[Duration] {
        def sub(x: Duration, y: Duration): Duration =
            import java.time.Duration.minus(##java.time.Duration);
            let Duration(x1) = x;
            let Duration(y1) = y;
            Duration(x1.minus(y1)) as & Pure
    }

    instance Neg[Duration] {
        def neg(x: Duration): Duration =
            import java.time.Duration.negated();
            let Duration(x1) = x;
            Duration(x1.negated()) as & Pure
    }

    /// Addition
    instance Monoid[Duration] {
        def empty(): Duration = Time/Duration.zero()
        def combine(x: Duration, y: Duration): Duration = Add.add(x, y)
    }
}

namespace Time/Duration {


    use Time.Duration;
    use Time.Duration.{Duration};
    use Time/Temporal.ChronoUnit;

    ///
    /// Return a new duration.
    ///
    pub def new(x: {seconds: Int64, nanos: Int64}): Duration =
        import java.time.Duration:ofSeconds(Int64, Int64);
        Duration(ofSeconds(x.seconds, x.nanos)) as & Pure

    ///
    /// Return the components of Duration `x` as a count of seconds and the
    /// nanoseconds adjustment.
    ///
    pub def getFields(x: Duration): {seconds: Int64, nanos: Int32} =
        {seconds = x.getSeconds(), nanos = x.getNano()}

    ///
    /// Construct a zero length Duration.
    ///
    pub def zero(): Duration =
        import get java.time.Duration:ZERO as get_zero;
        Duration(get_zero()) as & Pure

    ///
    /// Construct a Duration from the supplied number of days.
    ///
    pub def fromDays(days: Int64): Duration =
        import java.time.Duration:ofDays(Int64);
        Duration(ofDays(days)) as & Pure

    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDays(x: Duration): Int64 =
        import java.time.Duration.toDays();
        let Duration(x1) = x;
        x1.toDays() as & Pure

    ///
    /// Construct a Duration from the supplied number of hours.
    ///
    pub def fromHours(hours: Int64): Duration =
        import java.time.Duration:ofHours(Int64);
        Duration(ofHours(hours)) as & Pure

    ///
    /// Return the number of hours in Duration `x`.
    ///
    pub def toHours(x: Duration): Int64 =
        import java.time.Duration.toHours();
        let Duration(x1) = x;
        x1.toHours() as & Pure

    ///
    /// Construct a Duration from the supplied number of minutes.
    ///
    pub def fromMinutes(minutes: Int64): Duration =
        import java.time.Duration:ofMinutes(Int64);
        Duration(ofMinutes(minutes)) as & Pure

    ///
    /// Return the number of minutes in Duration `x`.
    ///
    pub def toMinutes(x: Duration): Int64 =
        import java.time.Duration.toMinutes();
        let Duration(x1) = x;
        x1.toMinutes() as & Pure

    ///
    /// Construct a Duration from the supplied number of seconds.
    ///
    pub def fromSeconds(seconds: Int64): Duration =
        import java.time.Duration:ofSeconds(Int64);
        Duration(ofSeconds(seconds)) as & Pure

    ///
    /// Return the number of seconds in Duration `x`.
    ///
    pub def toSeconds(x: Duration): Int64 =
        import java.time.Duration.toSeconds();
        let Duration(x1) = x;
        x1.toSeconds() as & Pure

    ///
    /// Construct a Duration from the supplied number of milliseconds.
    ///
    pub def fromMillis(millis: Int64): Duration =
        import java.time.Duration:ofMillis(Int64);
        Duration(ofMillis(millis)) as & Pure


    ///
    /// Get the total length of Duration `x` in milliseconds.
    ///
    pub def toMillis(x: Duration): Int64 =
        import java.time.Duration.toMillis();
        let Duration(x1) = x;
        x1.toMillis() as & Pure

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def fromNanos(nanos: Int64): Duration =
        import java.time.Duration:ofNanos(Int64);
        Duration(ofNanos(nanos)) as & Pure

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def toNanos(x: Duration): Int64 =
        import java.time.Duration.toNanos();
        let Duration(x1) = x;
        x1.toNanos() as & Pure


    pub def fromChrono(x: Int64, unit: ChronoUnit): Duration =
        import java.time.Duration:of(Int64, ##java.time.temporal.TemporalUnit);
        let u1 = Time/Temporal/ChronoUnit.marshal(unit);
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        Duration(x.of(tu1)) as & Pure


    ///
    /// Returns 1 if x > y, -1 if x < y, and 0 if x = y.
    ///
    pub def compare(x: Duration, y: Duration): Int32 =
        import java.time.Duration.compareTo(##java.time.Duration);
        let Duration(x1) = x;
        let Duration(y1) = y;
        x1.compareTo(y1) as & Pure

    

    pub def isZero(x: Duration): Bool =
        import java.time.Duration.isZero();
        let Duration(x1) = x;
        x1.isZero() as & Pure

    pub def isPositive(x: Duration): Bool =
        not x.isNegative()

    pub def isNegative(x: Duration): Bool =
        import java.time.Duration.isNegative();
        let Duration(x1) = x;
        x1.isNegative() as & Pure


    ///
    /// Get the nanosecond part of the duration `x`.
    ///
    pub def getNano(x: Duration): Int32 =
        import java.time.Duration.getNano();
        let Duration(x1) = x;
        x1.getNano() as & Pure

    ///
    /// Set the nano part of the duration `x` to `seconds``.
    ///
    pub def putNano(x: Duration, nanos: Int32): Duration =
        import java.time.Duration.withNanos(Int32);
        let Duration(x1) = x;
        Duration(x1.withNanos(nanos)) as & Pure

    ///
    /// Get the second part of the duration `x`.
    ///
    pub def getSeconds(x: Duration): Int64 =
        import java.time.Duration.getSeconds();
        let Duration(x1) = x;
        x1.getSeconds() as & Pure

    ///
    /// Set the seconds part of the duration `x` to `seconds``.
    ///
    pub def putSeconds(x: Duration, seconds: Int64): Duration =
        import java.time.Duration.withSeconds(Int64);
        let Duration(x1) = x;
        Duration(x1.withSeconds(seconds)) as & Pure

    ///
    /// Returns the absolute value of `x`.
    ///
    pub def abs(x: Duration): Duration =
        import java.time.Duration.abs();
        let Duration(x1) = x;
        Duration(x1.abs()) as & Pure


    pub def multipliedBy(x: Duration, y: Int64): Duration =
        import java.time.Duration.multipliedBy(Int64);
        let Duration(x1) = x;
        Duration(x1.multipliedBy(y)) as & Pure

    pub def dividedBy(x: Duration, y: Int64): Duration =
        import java.time.Duration.dividedBy(Int64);
        let Duration(x1) = x;
        Duration(x1.dividedBy(y)) as & Pure

    pub def plusDays(x: Duration, days: Int64): Duration =
        import java.time.Duration.plusDays(Int64);
        let Duration(x1) = x;
        Duration(x1.plusDays(days)) as & Pure

    pub def minusDays(x: Duration, days: Int64): Duration =
        import java.time.Duration.minusDays(Int64);
        let Duration(x1) = x;
        Duration(x1.minusDays(days)) as & Pure

    pub def plusHours(x: Duration, hours: Int64): Duration =
        import java.time.Duration.plusHours(Int64);
        let Duration(x1) = x;
        Duration(x1.plusHours(hours)) as & Pure

    pub def minusHours(x: Duration, hours: Int64): Duration =
        import java.time.Duration.minusHours(Int64);
        let Duration(x1) = x;
        Duration(x1.minusHours(hours)) as & Pure

    pub def plusMinutes(x: Duration, minutes: Int64): Duration =
        import java.time.Duration.plusMinutes(Int64);
        let Duration(x1) = x;
        Duration(x1.plusMinutes(minutes)) as & Pure

    pub def minusMinutes(x: Duration, minutes: Int64): Duration =
        import java.time.Duration.minusMinutes(Int64);
        let Duration(x1) = x;
        Duration(x1.minusMinutes(minutes)) as & Pure

    pub def plusSeconds(x: Duration, seconds: Int64): Duration =
        import java.time.Duration.plusSeconds(Int64);
        let Duration(x1) = x;
        Duration(x1.plusSeconds(seconds)) as & Pure

    pub def minusSeconds(x: Duration, seconds: Int64): Duration =
        import java.time.Duration.minusSeconds(Int64);
        let Duration(x1) = x;
        Duration(x1.minusSeconds(seconds)) as & Pure

    pub def plusMillis(x: Duration, millis: Int64): Duration =
        import java.time.Duration.plusMillis(Int64);
        let Duration(x1) = x;
        Duration(x1.plusMillis(millis)) as & Pure

    pub def minusMillis(x: Duration, millis: Int64): Duration =
        import java.time.Duration.minusMillis(Int64);
        let Duration(x1) = x;
        Duration(x1.minusMillis(millis)) as & Pure

    pub def plusNanos(x: Duration, nanos: Int64): Duration =
        import java.time.Duration.plusNanos(Int64);
        let Duration(x1) = x;
        Duration(x1.plusNanos(nanos)) as & Pure

    pub def minusNanos(x: Duration, nanos: Int64): Duration =
        import java.time.Duration.minusNanos(Int64);
        let Duration(x1) = x;
        Duration(x1.minusNanos(nanos)) as & Pure

}