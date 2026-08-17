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

    use InteropTime.Internal.AdaptorExtras

    use InteropTime.DurationZ.DurationZ
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.Period.Period
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneOffset.ZoneOffset
    
    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.{Instant => JInstant}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java instant.
    ///
    pub enum InstantZ(JInstant)

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

    pub def instant(epochSecond: {epochSecond = Int64}, 
                    nano: {nano = Int64 }): InstantZ =
        AdaptorExtras.of(() -> unsafe IO { JInstant.ofEpochSecond(epochSecond#epochSecond, nano#nano) })

    /// `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): InstantZ \ IO = InstantZ(JInstant.now())

    ///
    /// Returns the start of epoch instant - 1970-01-01T00:00:00Z
    ///
    pub def epoch(): InstantZ = InstantZ(unsafe IO { JInstant.EPOCH}) 

    pub def min(): InstantZ = InstantZ(unsafe IO { JInstant.MIN}) 
    
    pub def max(): InstantZ = InstantZ(unsafe IO { JInstant.MAX}) 

    /// `at` functions

    pub def atOffset(x: InstantZ, offset: ZoneOffset): OffsetDateTime =
        AdaptorExtras.op2(x, offset, (x1, offset1) -> unsafe IO { x1.atOffset(offset1) })

    pub def atZone(x: InstantZ, zone: ZoneId): ZonedDateTime =
        AdaptorExtras.op2(x, zone, (x1, zone1) -> unsafe IO { x1.atZone(zone1) })

    /// `of` functions

    pub def ofEpochSecond(epochSecond: Int64): InstantZ =
        AdaptorExtras.of(() -> unsafe IO { JInstant.ofEpochSecond(epochSecond) })


    pub def ofEpochMilli(epochMilli: Int64): InstantZ =
        AdaptorExtras.of(() -> unsafe IO { JInstant.ofEpochMilli(epochMilli) })


    pub def fromOffsetDateTime(x: OffsetDateTime): InstantZ = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JInstant.$from(x1) })

    pub def fromZonedDateTime(x: ZonedDateTime): InstantZ = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JInstant.$from(x1) })

    /// `to` functions

    pub def toEpochMilli(x: InstantZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toEpochMilli() })

    /// `parse` / `format` functions

    pub def parse(s: String): Result[String, InstantZ] =
        AdaptorExtras.ofWithResult(() -> {
            let s1 = String.trim(s);
            unsafe IO { JInstant.parse(s1) }
        })

    pub def format(x: InstantZ): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toString() })


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: InstantZ, y: InstantZ): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: InstantZ, y: InstantZ): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    
    /// Getters and Setters

    pub def getEpochSecond(x: InstantZ): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getEpochSecond() })

    pub def getNano(x: InstantZ): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getNano() })


    pub def getNanoOfSecond(x: InstantZ): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let f1 = unsafe IO { JChronoField.NANO_OF_SECOND };
            unsafe IO { x1.getLong(f1) }
        })


    pub def withNanoOfSecond(i: Int64, x: InstantZ): InstantZ =
        AdaptorExtras.op(x, x1 -> {
            let f1 = unsafe IO { JChronoField.NANO_OF_SECOND };
            unsafe IO { x1.$with(f1, i) }
        })

    pub def getMicroOfSecond(x: InstantZ): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let f1 = unsafe IO { JChronoField.MICRO_OF_SECOND };
            unsafe IO { x1.getLong(f1) }
        })

    pub def withMicroOfSecond(i: Int64, x: InstantZ): InstantZ =
        AdaptorExtras.op(x, x1 -> {
            let f1 = unsafe IO { JChronoField.MICRO_OF_SECOND };
            unsafe IO { x1.$with(f1, i) }
        })

    pub def getMilliOfSecond(x: InstantZ): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let f1 = unsafe IO { JChronoField.MILLI_OF_SECOND };
            unsafe IO { x1.getLong(f1) }
        })

    pub def withMilliOfSecond(i: Int64, x: InstantZ): InstantZ =
        AdaptorExtras.op(x, x1 -> {
            let f1 = unsafe IO { JChronoField.MILLI_OF_SECOND };
            unsafe IO { x1.$with(f1, i) }
        })


    pub def getInstantSeconds(x: InstantZ): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let f1 = unsafe IO { JChronoField.INSTANT_SECONDS };
            unsafe IO { x1.getLong(f1) }
        })

    pub def withInstantSeconds(i: Int64, x: InstantZ): InstantZ =
        AdaptorExtras.op(x, x1 -> {
            let f1 = unsafe IO { JChronoField.INSTANT_SECONDS };
            unsafe IO { x1.$with(f1, i) }
        })

    // `truncatedTo` specialized

    pub def truncatedToNanos(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.NANOS };
            unsafe IO { x1.truncatedTo(u1) }
        })


    pub def truncatedToMicros(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.MICROS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToMillis(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.MILLIS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToSeconds(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.SECONDS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToMinutes(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.MINUTES };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToHours(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.HOURS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    pub def truncatedToHalfDays(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.HALF_DAYS };
            unsafe IO { x1.truncatedTo(u1) }
        })


    pub def truncatedToDays(x: InstantZ): InstantZ = 
        AdaptorExtras.op(x, x1 -> {
            let u1 = unsafe IO { JChronoUnit.DAYS };
            unsafe IO { x1.truncatedTo(u1) }
        })

    // plus / minus functions

    pub def plusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusSeconds(seconds) })
            

    pub def minusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusSeconds(seconds) })

    pub def plusMillis(x: InstantZ, millis: Int64): InstantZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMillis(millis) })

    pub def minusMillis(x: InstantZ, millis: Int64): InstantZ =
        AdaptorExtras.op(x, x1 ->  unsafe IO { x1.minusMillis(millis) })

    pub def plusNanos(x: InstantZ, nanos: Int64): InstantZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusNanos(nanos) })


    pub def plusDuration(x: InstantZ, d: DurationZ): InstantZ =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.addTo(x1) };
            unchecked_cast(t1 as JInstant)
        })
    
    pub def minusDuration(x: InstantZ, d: DurationZ): InstantZ =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.subtractFrom(x1) };
            unchecked_cast(t1 as JInstant)
        })

    // Period methods

    pub def plusPeriod(x: InstantZ, p: Period): InstantZ =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.addTo(x1) };
            unchecked_cast(t1 as JInstant)
        })
    
    pub def minusPeriod(x: InstantZ, p: Period): InstantZ =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.subtractFrom(x1) };
            unchecked_cast(t1 as JInstant)
        })


    // between / until functions

    pub def between(begin: {begin = InstantZ }, end: {end = InstantZ }): DurationZ =
        AdaptorExtras.op2(begin#begin, end#end, (begin1, end1) -> {
           unsafe IO { JDuration.between(begin1, end1) }
        })

    // `until` specialized

    pub def nanosUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.NANOS) }
        })

    pub def microsUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MICROS) }
        })
        

    pub def millisUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MILLIS) }
        })

    pub def secondsUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.SECONDS) }
        })
        

    pub def minutesUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.MINUTES) }
        })

    pub def hoursUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.HOURS) }
        })

    pub def halfDaysUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.HALF_DAYS) }
        })

    pub def daysUntil(begin: {begin = InstantZ }, end: {end = InstantZ }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> {
            unsafe IO { begin1.until(end1, JChronoUnit.DAYS) }
        })

}

