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

    use Time/Temporal.TemporalAmount;
    ///
    /// A measure of time represented internally as seconds and a nanoseconds adjustment.
    ///
    /// This is a wrapper around java.time.Duration.
    ///
    pub opaque type ZDuration = ##java.time.Duration

    ///
    /// The format of the output string is in ISO-8601 duration format.
    ///
    instance ToString[ZDuration] {
        pub def toString(x: ZDuration): String =
            import java.time.Duration.toString(): String & Pure;
            let ZDuration(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a Duration, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 duration format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[ZDuration] {
        pub def fromString(s: String): Option[ZDuration] =
            import static java.time.Duration.parse(##java.lang.CharSequence): ##java.time.Duration & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(ZDuration(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[ZDuration] {
        pub def eq(x: ZDuration, y: ZDuration): Bool = Time/ZDuration.equals(x, y)
    }

    instance Hash[ZDuration] {
        pub def hash(x: ZDuration): Int32 = Time/ZDuration.hashCode(x)
    }

    instance Order[ZDuration] {
        pub def compare(x: ZDuration, y: ZDuration): Comparison = 
            Time/ZDuration.compareTo(x,y) |> Comparison.fromInt32
    }

    instance Add[ZDuration] {
        pub def add(x: ZDuration, y: ZDuration): ZDuration =
            import java.time.Duration.plus(##java.time.Duration): ##java.time.Duration & Pure;
            let ZDuration(x1) = x;
            let ZDuration(y1) = y;
            ZDuration(plus(x1, y1))
    }

    instance Sub[ZDuration] {
        pub def sub(x: ZDuration, y: ZDuration): ZDuration =
            import java.time.Duration.minus(##java.time.Duration): ##java.time.Duration & Pure;
            let ZDuration(x1) = x;
            let ZDuration(y1) = y;
            ZDuration(minus(x1, y1))
    }

    instance Neg[ZDuration] {
        pub def neg(x: ZDuration): ZDuration =
            import java.time.Duration.negated(): ##java.time.Duration & Pure;
            let ZDuration(x1) = x;
            ZDuration(negated(x1))
    }

    /// `combine` is addition
    instance SemiGroup[ZDuration] {
        pub def combine(x: ZDuration, y: ZDuration): ZDuration = Add.add(x, y)
    }

    /// Monoid is addition
    instance Monoid[ZDuration] {
        pub def empty(): ZDuration = Time/ZDuration.zero()
    }


    instance TemporalAmount[ZDuration] {
        pub def marshalToNativeTemporalAmount(x: ZDuration): ##java.time.temporal.TemporalAmount = 
            Time/ZDuration.getDuration(x) as ##java.time.temporal.TemporalAmount

        pub def unmarshalFromNativeTemporalAmount(x: ##java.time.temporal.TemporalAmount): ZDuration= 
            ZDuration(x as ##java.time.Duration)
    }

}

namespace Time/ZDuration {

    use Time.ZDuration;
    use Time.ZDuration.{ZDuration};
    
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAmount;
    use Time/Temporal.TemporalUnit;

    pub def getDuration(x: ZDuration): ##java.time.Duration = 
        let ZDuration(x1) = x;
        x1

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def fromTemporalAmount(x: a): ZDuration with TemporalAmount[a] = 
        import static java.time.Duration.from(##java.time.temporal.TemporalAmount): ##java.time.Duration & Pure as fromTA;
        let x1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(x);
        ZDuration(fromTA(x1))


    ///
    /// Return a new duration.
    ///
    pub def duration(r: {seconds :: Int64, nanos :: Int64}): ZDuration =
        import static java.time.Duration.ofSeconds(Int64, Int64): ##java.time.Duration & Pure;
        ZDuration(ofSeconds(r.seconds, r.nanos))


    ///
    /// Construct a zero length Duration.
    ///
    pub def zero(): ZDuration =
        import static get java.time.Duration.ZERO: ##java.time.Duration & Pure as get_ZERO;
        ZDuration(get_ZERO())

    ///
    /// Construct a Duration from the supplied number of days.
    ///
    pub def fromDays(days: Int64): ZDuration =
        import static java.time.Duration.ofDays(Int64): ##java.time.Duration & Pure;
        ZDuration(ofDays(days))

    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDays(x: ZDuration): Int64 =
        import java.time.Duration.toDays(): Int64 & Pure;
        let ZDuration(x1) = x;
        toDays(x1)

    ///
    /// Do we want `toDays` and `toDaysPart` ?
    ///
    /// Return the number of days in Duration `x`.
    ///
    pub def toDaysPart(x: ZDuration): Int64 =
        import java.time.Duration.toDaysPart(): Int64 & Pure;
        let ZDuration(x1) = x;
        toDaysPart(x1)

    ///
    /// Construct a Duration from the supplied number of hours.
    ///
    pub def fromHours(hours: Int64): ZDuration =
        import static java.time.Duration.ofHours(Int64): ##java.time.Duration & Pure;
        ZDuration(ofHours(hours))

    ///
    /// Return the number of hours in Duration `x`.
    ///
    pub def toHours(x: ZDuration): Int64 =
        import java.time.Duration.toHours(): Int64 & Pure;
        let ZDuration(x1) = x;
        toHours(x1)

    ///
    /// Construct a Duration from the supplied number of minutes.
    ///
    pub def fromMinutes(minutes: Int64): ZDuration =
        import static java.time.Duration.ofMinutes(Int64): ##java.time.Duration & Pure;
        ZDuration(ofMinutes(minutes))

    ///
    /// Return the number of minutes in Duration `x`.
    ///
    pub def toMinutes(x: ZDuration): Int64 =
        import java.time.Duration.toMinutes(): Int64 & Pure;
        let ZDuration(x1) = x;
        toMinutes(x1)

    ///
    /// Construct a Duration from the supplied number of seconds.
    ///
    pub def fromSeconds(seconds: Int64): ZDuration =
        import static java.time.Duration.ofSeconds(Int64): ##java.time.Duration & Pure;
        ZDuration(ofSeconds(seconds))

    ///
    /// Return the number of seconds in Duration `x`.
    ///
    pub def toSeconds(x: ZDuration): Int64 =
        import java.time.Duration.toSeconds(): Int64 & Pure;
        let ZDuration(x1) = x;
        toSeconds(x1)

    ///
    /// Construct a Duration from the supplied number of milliseconds.
    ///
    pub def fromMillis(millis: Int64): ZDuration =
        import static java.time.Duration.ofMillis(Int64): ##java.time.Duration & Pure;
        ZDuration(ofMillis(millis))


    ///
    /// Get the total length of Duration `x` in milliseconds.
    ///
    pub def toMillis(x: ZDuration): Int64 =
        import java.time.Duration.toMillis(): Int64 & Pure;
        let ZDuration(x1) = x;
        toMillis(x1)

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def fromNanos(nanos: Int64): ZDuration =
        import static java.time.Duration.ofNanos(Int64): ##java.time.Duration & Pure;
        ZDuration(ofNanos(nanos))

    ///
    /// Return the number of nanoseconds in Duration `x`.
    ///
    pub def toNanos(x: ZDuration): Int64 =
        import java.time.Duration.toNanos(): Int64 & Pure;
        let ZDuration(x1) = x;
        toNanos(x1)


    /// pub def durationOfChronoUnit(x: Int64, unit: ChronoUnit): ZDuration =
    ///     import static java.time.Duration.of(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration & Pure;
    ///     let u1 = Time/Temporal/ChronoUnit.marshal(unit);
    ///     let tu1 = u1 as ##java.time.temporal.TemporalUnit;
    ///     ZDuration(of(x, tu1))


    pub def equals(x: ZDuration, y: ZDuration): Bool =
        import java.time.Duration.equals(##java.lang.Object): Bool & Pure;
        let ZDuration(x1) = x;
        let ZDuration(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZDuration): Int32 = 
        import java.time.Duration.hashCode(): Int32 & Pure;
        let ZDuration(x1) = x;
        hashCode(x1)

    ///
    /// Returns 1 if x > y, -1 if x < y, and 0 if x = y.
    ///
    pub def compareTo(x: ZDuration, y: ZDuration): Int32 =
        import java.time.Duration.compareTo(##java.time.Duration): Int32 & Pure;
        let ZDuration(x1) = x;
        let ZDuration(y1) = y;
        compareTo(x1, y1)

    

    pub def isZero(x: ZDuration): Bool =
        import java.time.Duration.isZero(): Bool & Pure;
        let ZDuration(x1) = x;
        isZero(x1)

    pub def isPositive(x: ZDuration): Bool =
        not isNegative(x)

    pub def isNegative(x: ZDuration): Bool =
        import java.time.Duration.isNegative(): Bool & Pure;
        let ZDuration(x1) = x;
        isNegative(x1)

    /// Get/Set...

    ///
    /// Get the nanosecond part of the duration `x`.
    ///
    pub def getNano(x: ZDuration): Int32 =
        import java.time.Duration.getNano(): Int32 & Pure;
        let ZDuration(x1) = x;
        getNano(x1)

    ///
    /// Set the nano part of the duration `x` to `seconds``.
    ///
    pub def setNano(nanos: Int32, x: ZDuration): ZDuration =
        import java.time.Duration.withNanos(Int32): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(withNanos(x1, nanos))

    ///
    /// Get the second part of the duration `x`.
    ///
    pub def getSeconds(x: ZDuration): Int64 =
        import java.time.Duration.getSeconds(): Int64 & Pure;
        let ZDuration(x1) = x;
        getSeconds(x1)

    ///
    /// Set the seconds part of the duration `x` to `seconds``.
    ///
    pub def setSeconds(seconds: Int64, x: ZDuration): ZDuration =
        import java.time.Duration.withSeconds(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(withSeconds(x1, seconds))

    ///
    /// Returns the absolute value of `x`.
    ///
    pub def abs(x: ZDuration): ZDuration =
        import java.time.Duration.abs(): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(abs(x1))


    pub def multipliedBy(x: ZDuration, y: Int64): ZDuration =
        import java.time.Duration.multipliedBy(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(multipliedBy(x1, y))

    pub def dividedBy(x: ZDuration, y: Int64): ZDuration =
        import java.time.Duration.dividedBy(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(dividedBy(x1, y))

    pub def plusDays(x: ZDuration, days: Int64): ZDuration =
        import java.time.Duration.plusDays(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(plusDays(x1, days))

    pub def minusDays(x: ZDuration, days: Int64): ZDuration =
        import java.time.Duration.minusDays(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(minusDays(x1, days))

    pub def plusHours(x: ZDuration, hours: Int64): ZDuration =
        import java.time.Duration.plusHours(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(plusHours(x1, hours))

    pub def minusHours(x: ZDuration, hours: Int64): ZDuration =
        import java.time.Duration.minusHours(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(minusHours(x1, hours))

    pub def plusMinutes(x: ZDuration, minutes: Int64): ZDuration =
        import java.time.Duration.plusMinutes(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(plusMinutes(x1, minutes))

    pub def minusMinutes(x: ZDuration, minutes: Int64): ZDuration =
        import java.time.Duration.minusMinutes(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(minusMinutes(x1, minutes))

    pub def plusSeconds(x: ZDuration, seconds: Int64): ZDuration =
        import java.time.Duration.plusSeconds(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(plusSeconds(x1, seconds))

    pub def minusSeconds(x: ZDuration, seconds: Int64): ZDuration =
        import java.time.Duration.minusSeconds(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(minusSeconds(x1, seconds))

    pub def plusMillis(x: ZDuration, millis: Int64): ZDuration =
        import java.time.Duration.plusMillis(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(plusMillis(x1, millis))

    pub def minusMillis(x: ZDuration, millis: Int64): ZDuration =
        import java.time.Duration.minusMillis(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(minusMillis(x1, millis))

    pub def plusNanos(x: ZDuration, nanos: Int64): ZDuration =
        import java.time.Duration.plusNanos(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(plusNanos(x1, nanos))

    pub def minusNanos(x: ZDuration, nanos: Int64): ZDuration =
        import java.time.Duration.minusNanos(Int64): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        ZDuration(minusNanos(x1, nanos))

    pub def truncatedTo(unit: a, x: ZDuration): ZDuration with TemporalUnit[a] = 
        import java.time.Duration.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.Duration & Pure;
        let ZDuration(x1) = x;
        let unit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(unit);
        ZDuration(truncatedTo(x1, unit1))

    pub def addTo(x: ZDuration, base: a): a with Temporal[a] =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let ZDuration(x1) = x;
        let base1 = Time/Temporal/Temporal.marshalToNativeTemporal(base);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(addTo(x1, base1))

    pub def subtractFrom(x: ZDuration, base: a): a with Temporal[a] =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let ZDuration(x1) = x;
        let base1 = Time/Temporal/Temporal.marshalToNativeTemporal(base);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(subtractFrom(x1, base1))    


    pub def between(r: {start :: a, end :: a}): ZDuration with Temporal[a] =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration & Pure;
        let b1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        ZDuration(between(b1, e1))


    pub def get(t: a, x: ZDuration): Int64 with TemporalUnit[a] = 
        import java.time.Duration.get(##java.time.temporal.TemporalUnit): Int64 & Pure;
        let x1 = getDuration(x);
        let t1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(t);
        get(x1, t1)

    
    pub def plus(x: ZDuration, r: {amount :: Int64, temporalUnit :: a}): ZDuration with TemporalUnit[a] =
        import java.time.Duration.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration & Pure;         
        try {
            let ZDuration(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            ZDuration(plus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minus(x: ZDuration, r: {amount :: Int64, temporalUnit :: a}): ZDuration with TemporalUnit[a] =
        import java.time.Duration.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration & Pure;         
        try {
            let ZDuration(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            ZDuration(minus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def ofAmount(r: {amount :: Int64, temporalUnit :: a}): ZDuration with TemporalUnit[a] =
        import static java.time.Duration.of(Int64, ##java.time.temporal.TemporalUnit): ##java.time.Duration & Pure;         
        try {
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            ZDuration(of(r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }



}
