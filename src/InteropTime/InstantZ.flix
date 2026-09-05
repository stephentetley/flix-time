/*
 * Copyright 2019 Magnus Madsen, Stephen Tetley
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




pub mod InteropTime.InstantZ {

    use JavaInterop.AdaptorUnchecked

    use InteropTime.DurationZ.DurationZ
    use InteropTime.LocalDate
    use InteropTime.LocalDateTime
    use InteropTime.LocalTime
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetTime
    use InteropTime.Period.Period
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneOffset.ZoneOffset

    use InteropTime.ClockZ.ReifyClock
    use InteropTime.ClockZ.ClockNow
    
    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.{Clock => JClock}
    import java.time.{Instant => JInstant}
    import java.time.{LocalDate => JLocalDate}
    import java.time.{LocalDateTime => JLocalDateTime}
    import java.time.{LocalTime => JLocalTime}
    import java.time.{OffsetDateTime => JOffsetDateTime}
    import java.time.{OffsetTime => JOffsetTime}
    import java.time.{ZonedDateTime => JZonedDateTime}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.lang.{Exception => JException}
    
    
    ///
    /// A wrapper around a Java instant.
    ///
    pub enum InstantZ(JInstant)

    pub eff InstantNow {
        def now(): InstantZ
    }

    instance ClockNow[InstantZ] {
        pub type E = InstantNow
        pub def now(): InstantZ \ InstantNow = {
           InstantNow.now()
        }
    }


    // `JInstant.now` might not be in IO if we are using a constant clock e.g the 
    // fixed clock
    pub def handle(f: a -> b \ ef): a -> b \ (ef + ReifyClock - InstantNow) = x -> 
        run {
            f(x)
        } with handler InstantNow {
            def now(k) = {
                let clock = ReifyClock.getClock();
                let clock1 = ToJava.toJava(clock);
                let ans = unsafe IO { JInstant.now(clock1) };
                k(ToFlix.toFlix(ans))
            }
        }
        
    pub def runInstantNow(f: Unit -> a \ ef): a \ (ef + ReifyClock - InstantNow) = 
        handle(f)()


    ///
    /// Returns the given instant `x` as a String using ISO-8601 representation.
    ///
    instance ToString[InstantZ] {
        pub def toString(x: InstantZ): String =
            let InstantZ(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as an Instant, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO UTC format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[InstantZ] {
        pub def fromString(s: String): Option[InstantZ] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JInstant.parse(s1) };
                Some(InstantZ(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[InstantZ] {
        pub def eq(x: InstantZ, y: InstantZ): Bool =
            let InstantZ(x1) = x;
            let InstantZ(y1) = y;
            unsafe IO { x1.equals(y1) }
   }

    instance Hash[InstantZ] {
        pub def hash(x: InstantZ): Int32 =
            let InstantZ(x1) = x;
            unsafe IO { x1.hashCode() }
   }


    instance Order[InstantZ] {
        pub def compare(x: InstantZ, y: InstantZ): Comparison =
            let InstantZ(x1) = x;
            let InstantZ(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
   }


    instance ToJava[InstantZ] {
        type Out = JInstant
        pub def toJava(x: InstantZ): JInstant = 
            let InstantZ.InstantZ(x1) = x;
            x1
    }

    instance ToFlix[InstantZ] {
        type In = JInstant
        pub def toFlix(x: JInstant): InstantZ = InstantZ.InstantZ(x)
    }
    

    /// Constructors

    pub def newInstant(epochSecond: {epochSecond = Int64}, 
                        nano: {nano = Int64 }): InstantZ =
        AdaptorUnchecked.of(() -> unsafe IO { JInstant.ofEpochSecond(epochSecond#epochSecond, nano#nano) })




    /// `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): InstantZ \ IO = InstantZ.InstantZ(JInstant.now())

    ///
    /// Returns the start of epoch instant - 1970-01-01T00:00:00Z
    ///
    pub def epoch(): InstantZ = 
        AdaptorUnchecked.of(() -> unsafe IO { JInstant.EPOCH}) 

    pub def min(): InstantZ = InstantZ(unsafe IO { JInstant.MIN}) 
    
    pub def max(): InstantZ = InstantZ(unsafe IO { JInstant.MAX}) 

    /// "of" constructors - "newWithX"

    pub def newWithEpochSecond(epochSecond: Int64): InstantZ =
        AdaptorUnchecked.of(() -> unsafe IO { JInstant.ofEpochSecond(epochSecond) })


    pub def newWithEpochMilli(epochMilli: Int64): InstantZ =
        AdaptorUnchecked.of(() -> unsafe IO { JInstant.ofEpochMilli(epochMilli) })


    /// `at` functions

    pub def atOffset(x: InstantZ, offset: ZoneOffset): OffsetDateTime =
        AdaptorUnchecked.op2(x, offset, (x1, offset1) -> unsafe IO { x1.atOffset(offset1) })

    pub def atZone(x: InstantZ, zone: ZoneId): ZonedDateTime =
        AdaptorUnchecked.op2(x, zone, (x1, zone1) -> unsafe IO { x1.atZone(zone1) })


    /// toX functions

    pub def toEpochMilli(x: InstantZ): Int64 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.toEpochMilli() })


    pub def toLocalDate(zone: ZoneId, x: InstantZ): LocalDate =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JLocalDate.ofInstant(x1, zone1) }
        )

    pub def toLocalDateTime(zone: ZoneId, x: InstantZ): LocalDateTime =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JLocalDateTime.ofInstant(x1, zone1) }
        )
        
    pub def toLocalTime(zone: ZoneId, x: InstantZ): LocalTime =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JLocalTime.ofInstant(x1, zone1) }
        )
    

    pub def toOffsetTime(zone: ZoneId, x: InstantZ): OffsetTime =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JOffsetTime.ofInstant(x1, zone1) }
        )


    pub def toOffsetDateTime(zone: ZoneId, x: InstantZ): OffsetDateTime =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JOffsetDateTime.ofInstant(x1, zone1) }
        )


    pub def toZonedDateTime(zone: ZoneId, x: InstantZ): ZonedDateTime =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JZonedDateTime.ofInstant(x1, zone1) }
        )


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: InstantZ, y: InstantZ): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: InstantZ, y: InstantZ): Bool =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    
    /// Getters and Setters

    pub def getEpochSecond(x: InstantZ): Int64 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.getEpochSecond() })

    pub def getNano(x: InstantZ): Int32 =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.getNano() })


    pub def setNano(i: Int32, x: InstantZ): InstantZ =
        let i1 = Int32.toInt64(i);
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.$with(JChronoField.NANO_OF_SECOND, i1) }
        )

    pub def setEpochSecond(i: Int64, x: InstantZ): InstantZ =
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.$with(JChronoField.INSTANT_SECONDS, i) }
        )

    pub def getMicroOfSecond(x: InstantZ): Int64 =
        AdaptorUnchecked.extract(x, x1 -> 
            unsafe IO { x1.getLong(JChronoField.MICRO_OF_SECOND) }
        )

    pub def withMicroOfSecond(i: Int64, x: InstantZ): InstantZ =
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.$with(JChronoField.MICRO_OF_SECOND, i) }
        )

    pub def getMilliOfSecond(x: InstantZ): Int64 =
        AdaptorUnchecked.extract(x, x1 -> 
            unsafe IO { x1.getLong(JChronoField.MILLI_OF_SECOND) }
        )

    pub def withMilliOfSecond(i: Int64, x: InstantZ): InstantZ =
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.$with(JChronoField.MILLI_OF_SECOND, i) }
        )


    // `truncatedTo` specialized

    pub def truncatedToNanos(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.NANOS) }
        )


    pub def truncatedToMicros(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.MICROS) }
        )

    pub def truncatedToMillis(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.MILLIS) }
        )

    pub def truncatedToSeconds(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.SECONDS) }
        )

    pub def truncatedToMinutes(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.MINUTES) }
        )

    pub def truncatedToHours(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.HOURS) }
        )

    pub def truncatedToHalfDays(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 -> 
            unsafe IO { x1.truncatedTo(JChronoUnit.HALF_DAYS) }
        )


    pub def truncatedToDays(x: InstantZ): InstantZ = 
        AdaptorUnchecked.op(x, x1 ->
            unsafe IO { x1.truncatedTo(JChronoUnit.DAYS) }
        )

    // plus / minus functions

    pub def plusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.plusSeconds(seconds) })
            

    pub def minusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.minusSeconds(seconds) })

    pub def plusMillis(x: InstantZ, millis: Int64): InstantZ =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.plusMillis(millis) })

    pub def minusMillis(x: InstantZ, millis: Int64): InstantZ =
        AdaptorUnchecked.op(x, x1 ->  unsafe IO { x1.minusMillis(millis) })

    pub def plusNanos(x: InstantZ, nanos: Int64): InstantZ =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.plusNanos(nanos) })


    pub def plusDuration(x: InstantZ, d: DurationZ): InstantZ =
        AdaptorUnchecked.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.addTo(x1) };
            unchecked_cast(t1 as JInstant)
        })
    
    pub def minusDuration(x: InstantZ, d: DurationZ): InstantZ =
        AdaptorUnchecked.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.subtractFrom(x1) };
            unchecked_cast(t1 as JInstant)
        })

    // Period methods

    pub def plusPeriod(x: InstantZ, p: Period): InstantZ =
        AdaptorUnchecked.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.addTo(x1) };
            unchecked_cast(t1 as JInstant)
        })
    
    pub def minusPeriod(x: InstantZ, p: Period): InstantZ =
        AdaptorUnchecked.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.subtractFrom(x1) };
            unchecked_cast(t1 as JInstant)
        })


    // between / until functions

    pub def between(begin: {begin = InstantZ }, end: {end = InstantZ }): DurationZ =
        AdaptorUnchecked.op2(begin#begin, end#end, (begin1, end1) -> {
           unsafe IO { JDuration.between(begin1, end1) }
        })

    // `until` specialized

    pub def nanosUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.NANOS) }
        })

    pub def microsUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MICROS) }
        })
        

    pub def millisUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MILLIS) }
        })

    pub def secondsUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.SECONDS) }
        })
        

    pub def minutesUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MINUTES) }
        })

    pub def hoursUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.HOURS) }
        })

    pub def halfDaysUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.HALF_DAYS) }
        })

    pub def daysUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorUnchecked.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.DAYS) }
        })

}

