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



mod Time {


    use Time.InstantZ
    use Time.InstantZ.{InstantZ}

    import java.time.{Instant => JInstant}
    import java.lang.{Object, CharSequence}

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
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as an Instant, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO UTC format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[InstantZ] {
        pub def fromString(s: String): Option[InstantZ] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let ans = unsafe JInstant.parse(s1);
                InstantZ(ans)
            }) |> Result.toOption
    }

    instance Eq[InstantZ] {
        pub def eq(x: InstantZ, y: InstantZ): Bool =
            let InstantZ(x1) = x;
            let InstantZ(y1) = y;
            unsafe x1.equals(y1)
    }

    instance Hash[InstantZ] {
        pub def hash(x: InstantZ): Int32 =
            let InstantZ(x1) = x;
            unsafe x1.hashCode()
    }


    instance Order[InstantZ] {
        pub def compare(x: InstantZ, y: InstantZ): Comparison =
            let InstantZ(x1) = x;
            let InstantZ(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }

}   

mod Time.InstantZ {

    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.Period
    use Time.Period.{Period}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.{Instant => JInstant}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}

    /// Unwrap

    pub def getInstant(x: InstantZ): JInstant = 
        let InstantZ(x1) = x;
        x1

    /// Constructors

    pub def instant(r: {epochSecond = Int64, nano = Int64}): InstantZ =
        let ans = unsafe JInstant.ofEpochSecond(r#epochSecond, r#nano);
        InstantZ(ans)

    /// `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): InstantZ \ IO + NonDet = InstantZ(JInstant.now())

    ///
    /// Returns the start of epoch instant - 1970-01-01T00:00:00Z
    ///
    pub def epoch(): InstantZ = InstantZ(unsafe JInstant.EPOCH)

    pub def min(): InstantZ = InstantZ(unsafe JInstant.MIN)
    
    pub def max(): InstantZ = InstantZ(unsafe JInstant.MAX)

    /// `at` functions

    pub def atOffset(x: InstantZ, offset: ZoneOffset): OffsetDateTime =
        let InstantZ(x1) = x;
        let ZoneOffset(offset1) = offset;
        let ans = unsafe x1.atOffset(offset1);
        OffsetDateTime(ans)

    pub def atZone(x: InstantZ, zone: ZoneId): ZonedDateTime =
        let InstantZ(x1) = x;
        let ZoneId(zone1) = zone;
        let ans = unsafe x1.atZone(zone1);
        ZonedDateTime(ans)

    /// `of` functions

    pub def ofEpochSecond(epochSecond: Int64): InstantZ =
        let ans = unsafe JInstant.ofEpochSecond(epochSecond);
        InstantZ(ans)


    pub def ofEpochMilli(epochMilli: Int64): InstantZ =
        let ans = unsafe JInstant.ofEpochMilli(epochMilli);
        InstantZ(ans)


    pub def fromOffsetDateTime(x: OffsetDateTime): InstantZ = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JInstant.from(x1);
        InstantZ(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): InstantZ = 
        let ZonedDateTime(x1) = x;
        let ans = unsafe JInstant.from(x1);
        InstantZ(ans)

    /// `to` functions

    pub def toEpochMilli(x: InstantZ): Int64 =
        let InstantZ(x1) = x;
        unsafe x1.toEpochMilli()

    /// `parse` / `format` functions

    pub def parse(s: String): Result[String, InstantZ] =
        Result.tryCatch(_ -> {
            let s1 = String.trim(s);
            let ans = unsafe JInstant.parse(s1);
            InstantZ(ans)
        })

    pub def format(x: InstantZ): String =
        let InstantZ(x1) = x;
        unsafe x1.toString()


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: InstantZ, y: InstantZ): Bool =
        let InstantZ(x1) = x;
        let InstantZ(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: InstantZ, y: InstantZ): Bool =
        let InstantZ(x1) = x;
        let InstantZ(y1) = y;
        unsafe x1.isAfter(y1)

    
    /// Getters and Setters

    pub def getEpochSecond(x: InstantZ): Int64 =
        let InstantZ(x1) = x;
        unsafe x1.getEpochSecond()

    pub def getNano(x: InstantZ): Int32 =
        let InstantZ(x1) = x;
        unsafe x1.getNano()


    pub def getNanoOfSecond(x: InstantZ): Int64 =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.NANO_OF_SECOND;
        unsafe x1.getLong(f1)


    pub def withNanoOfSecond(i: Int64, x: InstantZ): InstantZ =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.NANO_OF_SECOND;
        let ans = unsafe x1.with(f1, i);
        InstantZ(ans)

    pub def getMicroOfSecond(x: InstantZ): Int64 =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.MICRO_OF_SECOND;
        unsafe x1.getLong(f1)

    pub def withMicroOfSecond(i: Int64, x: InstantZ): InstantZ =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.MICRO_OF_SECOND;
        let ans = unsafe x1.with(f1, i);
        InstantZ(ans)

    pub def getMilliOfSecond(x: InstantZ): Int64 =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.MILLI_OF_SECOND;
        unsafe x1.getLong(f1)

    pub def withMilliOfSecond(i: Int64, x: InstantZ): InstantZ =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.MILLI_OF_SECOND;
        let ans = unsafe x1.with(f1, i);
        InstantZ(ans)

    pub def getInstantSeconds(x: InstantZ): Int64 =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.INSTANT_SECONDS;
        unsafe x1.getLong(f1)

    pub def withInstantSeconds(i: Int64, x: InstantZ): InstantZ =
        let InstantZ(x1) = x;
        let f1 = unsafe JChronoField.INSTANT_SECONDS;
        let ans = unsafe x1.with(f1, i);
        InstantZ(ans)

    // `truncatedTo` specialized

    pub def truncatedToNanos(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.NANOS;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)


    pub def truncatedToMicros(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.MICROS;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)

    pub def truncatedToMillis(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.MILLIS;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)

    pub def truncatedToSeconds(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.SECONDS;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)

    pub def truncatedToMinutes(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.MINUTES;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)

    pub def truncatedToHours(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.HOURS;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)

    pub def truncatedToHalfDays(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.HALF_DAYS;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)


    pub def truncatedToDays(x: InstantZ): InstantZ = 
        let InstantZ(x1) = x;
        let u1 = unsafe JChronoUnit.DAYS;
        let ans = unsafe x1.truncatedTo(u1);
        InstantZ(ans)

    // plus / minus functions

    pub def plusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        let InstantZ(x1) = x;
        let ans = unsafe x1.plusSeconds(seconds);
        InstantZ(ans)

    pub def minusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        let InstantZ(x1) = x;
        let ans = unsafe x1.minusSeconds(seconds);
        InstantZ(ans)

    pub def plusMillis(x: InstantZ, millis: Int64): InstantZ =
        let InstantZ(x1) = x;
        let ans = unsafe x1.plusMillis(millis);
        InstantZ(ans)

    pub def minusMillis(x: InstantZ, millis: Int64): InstantZ =
        let InstantZ(x1) = x;
        let ans = unsafe x1.minusMillis(millis);
        InstantZ(ans)

    pub def plusNanos(x: InstantZ, nanos: Int64): InstantZ =
        let InstantZ(x1) = x;
        let ans = unsafe x1.plusNanos(nanos);
        InstantZ(ans)


    pub def plusDuration(x: InstantZ, d: DurationZ): InstantZ =
        let InstantZ(x1) = x;
        let DurationZ(d1) = d;
        let t1 = unsafe d1.addTo(x1);
        let ans = unchecked_cast(t1 as JInstant);
        InstantZ(ans)
    
    pub def minusDuration(x: InstantZ, d: DurationZ): InstantZ =
        let InstantZ(x1) = x;
        let DurationZ(d1) = d;
        let t1 = unsafe d1.subtractFrom(x1);
        let ans = unchecked_cast(t1 as JInstant);
        InstantZ(ans)

    // Period methods

    pub def plusPeriod(x: InstantZ, p: Period): InstantZ =
        let InstantZ(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe p1.addTo(x1);
        let ans = unchecked_cast(t1 as JInstant);
        InstantZ(ans)
    
    pub def minusPeriod(x: InstantZ, p: Period): InstantZ =
        let InstantZ(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe p1.subtractFrom(x1);
        let ans = unchecked_cast(t1 as JInstant);
        InstantZ(ans)


    // between / until functions

    pub def between(begin: {begin = InstantZ}, end: {end = InstantZ}): DurationZ =
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let ans = unsafe JDuration.between(b1, e1);
        DurationZ(ans)

    // `until` specialized

    pub def nanosUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.NANOS;
        unsafe b1.until(e1, u1)

    pub def microsUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.MICROS;
        unsafe b1.until(e1, u1)

    pub def millisUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.MILLIS;
        unsafe b1.until(e1, u1) 

    pub def secondsUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.SECONDS;
        unsafe b1.until(e1, u1)

    pub def minutesUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.MINUTES;
        unsafe b1.until(e1, u1)

    pub def hoursUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.HOURS;
        unsafe b1.until(e1, u1)

    pub def halfDaysUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.HALF_DAYS;
        unsafe b1.until(e1, u1)

    pub def daysUntil(begin: {begin = InstantZ}, end: {end = InstantZ}): Int64 = 
        let InstantZ(b1) = begin#begin;
        let InstantZ(e1) = end#end;
        let u1 = unsafe JChronoUnit.DAYS;
        unsafe b1.until(e1, u1)

}
