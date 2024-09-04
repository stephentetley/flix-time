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
                let cs  = (checked_cast(s1) : CharSequence);
                InstantZ(unsafe JInstant.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[InstantZ] {
        pub def eq(x: InstantZ, y: InstantZ): Bool =
            let InstantZ(x1) = x;
            let InstantZ(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
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
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}

    import java.time.{Instant => JInstant}
    import java.lang.{Object, CharSequence}

    /// Unwrap

    pub def getInstant(x: InstantZ): JInstant = 
        let InstantZ(x1) = x;
        x1

    /// Constructors

    pub def instant(r: {epochSecond = Int64, nano = Int64}): InstantZ =
        InstantZ(unsafe JInstant.ofEpochSecond(r#epochSecond, r#nano))

    /// `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): InstantZ \ IO = InstantZ(JInstant.now())

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
        OffsetDateTime(unsafe x1.atOffset(offset1))

    pub def atZone(x: InstantZ, zone: ZoneId): ZonedDateTime =
        let InstantZ(x1) = x;
        let ZoneId(zone1) = zone;
        ZonedDateTime(unsafe x1.atZone(zone1))

    /// `of` functions

    pub def ofEpochSecond(epochSecond: Int64): InstantZ =
        InstantZ(unsafe JInstant.ofEpochSecond(epochSecond))


    pub def ofEpochMilli(epochMilli: Int64): InstantZ =
        InstantZ(unsafe JInstant.ofEpochMilli(epochMilli))


    // `fromTemporalAccessor` specialized
    // def fromTemporalAccessor(x: TemporalAccessor): InstantZ = 
    //     import static java.time.Instant.from(##java.time.temporal.TemporalAccessor): ##java.time.Instant \ {} as fromTA;
    //     try {
    //         let TemporalAccessor(x1) = x;
    //         InstantZ(fromTA(x1))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }


    // pub def fromOffsetDateTime(x: OffsetDateTime): InstantZ = 
    //     Time.OffsetDateTime.asTemporalAccessor(x)
    //         |> fromTemporalAccessor

    // pub def fromZonedDateTime(x: ZonedDateTime): InstantZ = 
    //     Time.ZonedDateTime.asTemporalAccessor(x)
    //         |> fromTemporalAccessor

    /// `to` functions

    pub def toEpochMilli(x: InstantZ): Int64 =
        let InstantZ(x1) = x;
        unsafe x1.toEpochMilli()

    /// `parse` / `format` functions

    pub def parse(s: String): Result[String, InstantZ] =
        Result.tryCatch(_ -> {
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            InstantZ(unsafe JInstant.parse(cs))
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


    // pub def getNanoOfSecond(x: InstantZ): Int64 =
    //     import static java_get_field java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_SECOND;
    //     getLongHelper(unchecked_cast(get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField), x)

    // pub def withNanoOfSecond(i: Int64, x: InstantZ): InstantZ =
    //     import static java_get_field java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_SECOND;
    //     withTemporalFieldHelper(unchecked_cast(get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField), i, x)

    // pub def getMicroOfSecond(x: InstantZ): Int64 =
    //     import static java_get_field java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_SECOND;
    //     getLongHelper(unchecked_cast(get_MICRO_OF_SECOND() as ##java.time.temporal.TemporalField), x)

    // pub def withMicroOfSecond(i: Int64, x: InstantZ): InstantZ =
    //     import static java_get_field java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_SECOND;
    //     withTemporalFieldHelper(unchecked_cast(get_MICRO_OF_SECOND() as ##java.time.temporal.TemporalField), i, x)

    // pub def getMilliOfSecond(x: InstantZ): Int64 =
    //     import static java_get_field java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_SECOND;
    //     getLongHelper(unchecked_cast(get_MILLI_OF_SECOND() as ##java.time.temporal.TemporalField), x)

    // pub def withMilliOfSecond(i: Int64, x: InstantZ): InstantZ =
    //     import static java_get_field java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_SECOND;
    //     withTemporalFieldHelper(unchecked_cast(get_MILLI_OF_SECOND() as ##java.time.temporal.TemporalField), i, x)

    // pub def getInstantSeconds(x: InstantZ): Int64 =
    //     import static java_get_field java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField \ {} as get_INSTANT_SECONDS;
    //     getLongHelper(unchecked_cast(get_INSTANT_SECONDS() as ##java.time.temporal.TemporalField), x)

    // pub def withInstantSeconds(i: Int64, x: InstantZ): InstantZ =
    //     import static java_get_field java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField \ {} as get_INSTANT_SECONDS;
    //     withTemporalFieldHelper(unchecked_cast(get_INSTANT_SECONDS() as ##java.time.temporal.TemporalField), i, x)


    // `truncatedTo` specialized

    // def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: InstantZ): InstantZ = 
    //     import java.time.Instant.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.Instant \ {};
    //     let InstantZ(x1) = x;
    //     InstantZ(truncatedTo(x1, u))
    
    // pub def truncatedToNanos(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
    //     truncatedToHelper(unchecked_cast(get_NANOS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToMicros(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
    //     truncatedToHelper(unchecked_cast(get_MICROS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToMillis(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
    //     truncatedToHelper(unchecked_cast(get_MILLIS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToSeconds(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
    //     truncatedToHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToMinutes(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
    //     truncatedToHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToHours(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
    //     truncatedToHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), x)

    // pub def truncatedToHalfDays(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
    //     truncatedToHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), x)


    // pub def truncatedToDays(x: InstantZ): InstantZ = 
    //     import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
    //     truncatedToHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), x)

    // plus / minus functions

    pub def plusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        let InstantZ(x1) = x;
        InstantZ(unsafe x1.plusSeconds(seconds))

    pub def minusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        let InstantZ(x1) = x;
        InstantZ(unsafe x1.minusSeconds(seconds))

    pub def plusMillis(x: InstantZ, millis: Int64): InstantZ =
        let InstantZ(x1) = x;
        InstantZ(unsafe x1.plusMillis(millis))

    pub def minusMillis(x: InstantZ, millis: Int64): InstantZ =
        let InstantZ(x1) = x;
        InstantZ(unsafe x1.minusMillis(millis))

    pub def plusNanos(x: InstantZ, nanos: Int64): InstantZ =
        let InstantZ(x1) = x;
        InstantZ(unsafe x1.plusNanos(nanos))


    // pub def plusDuration(i: InstantZ, x: DurationZ): InstantZ =
    //     import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let DurationZ(x1) = x;
    //     let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
    //     InstantZ(unchecked_cast(addTo(x1, i1) as ##java.time.Instant))
    
    // pub def minusDuration(i: InstantZ, x: DurationZ): InstantZ =
    //     import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let DurationZ(x1) = x;
    //     let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
    //     InstantZ(unchecked_cast(subtractFrom(x1, i1) as ##java.time.Instant))

    // Period methods

    // pub def plusPeriod(i: InstantZ, x: Period): InstantZ =
    //     import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.Period.getPeriod(x);
    //     let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
    //     InstantZ(unchecked_cast(addTo(x1, i1) as ##java.time.Instant))
    
    // pub def minusPeriod(i: InstantZ, x: Period): InstantZ =
    //     import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.Period.getPeriod(x);
    //     let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
    //     InstantZ(unchecked_cast(subtractFrom(x1, i1) as ##java.time.Instant))


    // between / until functions

    // pub def between(r: {start = InstantZ, end = InstantZ}): DurationZ =
    //     import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
    //     let s1 = unchecked_cast(getInstant(r#start) as ##java.time.temporal.Temporal);
    //     let e1 = unchecked_cast(getInstant(r#end) as ##java.time.temporal.Temporal);
    //     DurationZ(between(s1, e1))


    // `until` specialized

    // def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import java.time.Instant.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
    //     let b1 = getInstant(r#start);
    //     let e1 = unchecked_cast(getInstant(r#end) as ##java.time.temporal.Temporal);
    //     until(b1, e1, u)


    // pub def nanosUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
    //     untilHelper(unchecked_cast(get_NANOS() as ##java.time.temporal.TemporalUnit), r)

    // pub def microsUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
    //     untilHelper(unchecked_cast(get_MICROS() as ##java.time.temporal.TemporalUnit), r)

    // pub def millisUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
    //     untilHelper(unchecked_cast(get_MILLIS() as ##java.time.temporal.TemporalUnit), r)

    // pub def secondsUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
    //     untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    // pub def minutesUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
    //     untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    // pub def hoursUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
    //     untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)

    // pub def halfDaysUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
    //     untilHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), r)

    // pub def daysUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
    //     untilHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), r)

    // generic helper functions

    // def getLongHelper(field: ##java.time.temporal.TemporalField, x: InstantZ): Int64 =
    //     import java.time.Instant.getLong(##java.time.temporal.TemporalField): Int64 \ {};
    //     try {
    //         let InstantZ(x1) = x;
    //         getLong(x1, field)
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }


    // def withTemporalFieldHelper(field: ##java.time.temporal.TemporalField, i: Int64, x: InstantZ): InstantZ =
    //     import java.time.Instant.with(##java.time.temporal.TemporalField, Int64): ##java.time.Instant \ {} as withTF;                   
    //     try {
    //         let InstantZ(x1) = x;
    //         InstantZ(withTF(x1, field, i))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }


}
