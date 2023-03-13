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



namespace Time {


    ///
    /// A wrapper around a Java instant.
    ///
    pub enum InstantZ(##java.time.Instant)
    
    ///
    /// Returns the given instant `x` as a String using ISO-8601 representation.
    ///
    instance ToString[InstantZ] {
        pub def toString(x: InstantZ): String =
            import java.time.Instant.toString(): String \ {};
            let InstantZ(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as an Instant, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO UTC format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[InstantZ] {
        pub def fromString(s: String): Option[InstantZ] =
            Result.tryCatch(_ -> {
                import static java.time.Instant.parse(##java.lang.CharSequence): ##java.time.Instant \ {};
                let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
                InstantZ(parse(cs))
            }) |> Result.toOption
    }

    instance Eq[InstantZ] {
        pub def eq(x: InstantZ, y: InstantZ): Bool =
            import java.time.Instant.equals(##java.lang.Object): Bool \ {};
            let InstantZ(x1) = x;
            let InstantZ(y1) = y;
            equals(x1, checked_cast(y1))
    }

    instance Hash[InstantZ] {
        pub def hash(x: InstantZ): Int32 =
            import java.time.Instant.hashCode(): Int32 \ {};
            let InstantZ(x1) = x;
            hashCode(x1)
    }


    instance Order[InstantZ] {
        pub def compare(x: InstantZ, y: InstantZ): Comparison =
            import java.time.Instant.compareTo(##java.time.Instant): Int32 \ {};
            let InstantZ(x1) = x;
            let InstantZ(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }

    instance Boxable[InstantZ]

    instance Interop/Flix.Marshal[InstantZ] {
        pub def toJavaObject(x: InstantZ): ##java.lang.Object =
            let InstantZ(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): InstantZ = 
            InstantZ(unchecked_cast(o as ##java.time.Instant))
    }

}   

namespace Time/InstantZ {

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
    use Interop/Time/Temporal.TemporalAccessor
    use Interop/Time/Temporal.TemporalAccessor.{TemporalAccessor}

    /// ## Unwrap

    pub def getInstant(x: InstantZ): ##java.time.Instant = 
        let InstantZ(x1) = x;
        x1

    /// ## Constructors

    pub def instant(r: {epochSecond = Int64, nano = Int64}): InstantZ =
        import static java.time.Instant.ofEpochSecond(Int64, Int64): ##java.time.Instant \ {};
        InstantZ(ofEpochSecond(r.epochSecond, r.nano))

    /// ## `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): InstantZ \ IO =
        import static java.time.Instant.now(): ##java.time.Instant \ IO;
        InstantZ(now())

    ///
    /// Returns the start of epoch instant - 1970-01-01T00:00:00Z
    ///
    pub def epoch(): InstantZ =
        import static get java.time.Instant.EPOCH: ##java.time.Instant \ {} as get_EPOCH;
        InstantZ(get_EPOCH())

    pub def min(): InstantZ =
        import static get java.time.Instant.MIN: ##java.time.Instant \ {} as get_MIN;
        InstantZ(get_MIN())
    
    pub def max(): InstantZ =
        import static get java.time.Instant.MAX: ##java.time.Instant \ {} as get_MAX;
        InstantZ(get_MAX())

    /// ## `at` functions

    pub def atOffset(x: InstantZ, offset: ZoneOffset): OffsetDateTime =
        import java.time.Instant.atOffset(##java.time.ZoneOffset): ##java.time.OffsetDateTime \ {};
        let InstantZ(x1) = x;
        let ZoneOffset(offset1) = offset;
        OffsetDateTime(atOffset(x1, offset1))

    pub def atZone(x: InstantZ, zone: ZoneId): ZonedDateTime =
        import java.time.Instant.atZone(##java.time.ZoneId): ##java.time.ZonedDateTime \ {};
        let InstantZ(x1) = x;
        let ZoneId(zone1) = zone;
        ZonedDateTime(atZone(x1, zone1))

    /// ## `of` functions

    pub def ofEpochSecond(epochSecond: Int64): InstantZ =
        import static java.time.Instant.ofEpochSecond(Int64): ##java.time.Instant \ {};
        InstantZ(ofEpochSecond(epochSecond))


    pub def ofEpochMilli(epochMilli: Int64): InstantZ =
        import static java.time.Instant.ofEpochMilli(Int64): ##java.time.Instant \ {};
        InstantZ(ofEpochMilli(epochMilli))


    /// # `fromTemporalAccessor` specialized
    def fromTemporalAccessor(x: TemporalAccessor): InstantZ = 
        import static java.time.Instant.from(##java.time.temporal.TemporalAccessor): ##java.time.Instant \ {} as fromTA;
        try {
            Interop/Time/Temporal/TemporalAccessor.getHH(x) 
                |> fromTA
                |> InstantZ
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }


    pub def fromOffsetDateTime(x: OffsetDateTime): InstantZ = 
        Interop/Time/Temporal/ImpTemporalAccessor.toTemporalAccessor(x)
            |> fromTemporalAccessor

    pub def fromZonedDateTime(x: ZonedDateTime): InstantZ = 
        Interop/Time/Temporal/ImpTemporalAccessor.toTemporalAccessor(x)
            |> fromTemporalAccessor

    /// ## `to` functions

    pub def toEpochMilli(x: InstantZ): Int64 =
        import java.time.Instant.toEpochMilli(): Int64 \ {};
        let InstantZ(x1) = x;
        toEpochMilli(x1)

    /// ## `parse` / `format` functions

    pub def parse(s: String): Result[String, InstantZ] =
        Result.tryCatch(_ -> {
            import static java.time.Instant.parse(##java.lang.CharSequence): ##java.time.Instant \ {};
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            InstantZ(parse(cs))
        })

    pub def format(x: InstantZ): String =
        import java.time.Instant.toString(): String \ {};
        let InstantZ(x1) = x;
        toString(x1)


    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: InstantZ, y: InstantZ): Bool =
        import java.time.Instant.isBefore(##java.time.Instant): Bool \ {};
        let InstantZ(x1) = x;
        let InstantZ(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: InstantZ, y: InstantZ): Bool =
        import java.time.Instant.isAfter(##java.time.Instant): Bool \ {};
        let InstantZ(x1) = x;
        let InstantZ(y1) = y;
        isAfter(x1, y1)

    
    /// ## Getters and Setters

    pub def getEpochSecond(x: InstantZ): Int64 =
        import java.time.Instant.getEpochSecond(): Int64 \ {};
        let InstantZ(x1) = x;
        getEpochSecond(x1)

    pub def getNano(x: InstantZ): Int32 =
        import java.time.Instant.getNano(): Int32 \ {};
        let InstantZ(x1) = x;
        getNano(x1)


    pub def getNanoOfSecond(x: InstantZ): Int64 =
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_SECOND;
        getLongHelper(unchecked_cast(get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField), x)

    pub def withNanoOfSecond(i: Int64, x: InstantZ): InstantZ =
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_NANO_OF_SECOND;
        withTemporalFieldHelper(unchecked_cast(get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField), i, x)

    pub def getMicroOfSecond(x: InstantZ): Int64 =
        import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_SECOND;
        getLongHelper(unchecked_cast(get_MICRO_OF_SECOND() as ##java.time.temporal.TemporalField), x)

    pub def withMicroOfSecond(i: Int64, x: InstantZ): InstantZ =
        import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MICRO_OF_SECOND;
        withTemporalFieldHelper(unchecked_cast(get_MICRO_OF_SECOND() as ##java.time.temporal.TemporalField), i, x)

    pub def getMilliOfSecond(x: InstantZ): Int64 =
        import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_SECOND;
        getLongHelper(unchecked_cast(get_MILLI_OF_SECOND() as ##java.time.temporal.TemporalField), x)

    pub def withMilliOfSecond(i: Int64, x: InstantZ): InstantZ =
        import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField \ {} as get_MILLI_OF_SECOND;
        withTemporalFieldHelper(unchecked_cast(get_MILLI_OF_SECOND() as ##java.time.temporal.TemporalField), i, x)

    pub def getInstantSeconds(x: InstantZ): Int64 =
        import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField \ {} as get_INSTANT_SECONDS;
        getLongHelper(unchecked_cast(get_INSTANT_SECONDS() as ##java.time.temporal.TemporalField), x)

    pub def withInstantSeconds(i: Int64, x: InstantZ): InstantZ =
        import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField \ {} as get_INSTANT_SECONDS;
        withTemporalFieldHelper(unchecked_cast(get_INSTANT_SECONDS() as ##java.time.temporal.TemporalField), i, x)


    /// # `truncatedTo` specialized

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: InstantZ): InstantZ = 
        import java.time.Instant.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.Instant \ {};
        let InstantZ(x1) = x;
        InstantZ(truncatedTo(x1, u))
    
    pub def truncatedToNanos(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
        truncatedToHelper(unchecked_cast(get_NANOS() as ##java.time.temporal.TemporalUnit), x)

    pub def truncatedToMicros(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
        truncatedToHelper(unchecked_cast(get_MICROS() as ##java.time.temporal.TemporalUnit), x)

    pub def truncatedToMillis(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
        truncatedToHelper(unchecked_cast(get_MILLIS() as ##java.time.temporal.TemporalUnit), x)

    pub def truncatedToSeconds(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        truncatedToHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), x)

    pub def truncatedToMinutes(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        truncatedToHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), x)

    pub def truncatedToHours(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        truncatedToHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), x)

    pub def truncatedToHalfDays(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        truncatedToHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), x)


    pub def truncatedToDays(x: InstantZ): InstantZ = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        truncatedToHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), x)

    /// ## plus / minus functions

    pub def plusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        import java.time.Instant.plusSeconds(Int64): ##java.time.Instant \ {};
        let InstantZ(x1) = x;
        InstantZ(plusSeconds(x1, seconds))

    pub def minusSeconds(x: InstantZ, seconds: Int64): InstantZ =
        import java.time.Instant.minusSeconds(Int64): ##java.time.Instant \ {};
        let InstantZ(x1) = x;
        InstantZ(minusSeconds(x1, seconds))

    pub def plusMillis(x: InstantZ, millis: Int64): InstantZ =
        import java.time.Instant.plusMillis(Int64): ##java.time.Instant \ {};
        let InstantZ(x1) = x;
        InstantZ(plusMillis(x1, millis))

    pub def minusMillis(x: InstantZ, millis: Int64): InstantZ =
        import java.time.Instant.minusMillis(Int64): ##java.time.Instant \ {};
        let InstantZ(x1) = x;
        InstantZ(minusMillis(x1, millis))

    pub def plusNanos(x: InstantZ, nanos: Int64): InstantZ =
        import java.time.Instant.plusNanos(Int64): ##java.time.Instant \ {};
        let InstantZ(x1) = x;
        InstantZ(plusNanos(x1, nanos))


    pub def plusDuration(i: InstantZ, x: DurationZ): InstantZ =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let DurationZ(x1) = x;
        let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
        InstantZ(unchecked_cast(addTo(x1, i1) as ##java.time.Instant))
    
    pub def minusDuration(i: InstantZ, x: DurationZ): InstantZ =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let DurationZ(x1) = x;
        let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
        InstantZ(unchecked_cast(subtractFrom(x1, i1) as ##java.time.Instant))

    /// Period methods

    pub def plusPeriod(i: InstantZ, x: Period): InstantZ =
        import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time/Period.getPeriod(x);
        let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
        InstantZ(unchecked_cast(addTo(x1, i1) as ##java.time.Instant))
    
    pub def minusPeriod(i: InstantZ, x: Period): InstantZ =
        import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time/Period.getPeriod(x);
        let i1 = unchecked_cast(getInstant(i) as ##java.time.temporal.Temporal);
        InstantZ(unchecked_cast(subtractFrom(x1, i1) as ##java.time.Instant))


    /// ## between / until functions

    pub def between(r: {start = InstantZ, end = InstantZ}): DurationZ =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
        let s1 = unchecked_cast(getInstant(r.start) as ##java.time.temporal.Temporal);
        let e1 = unchecked_cast(getInstant(r.end) as ##java.time.temporal.Temporal);
        DurationZ(between(s1, e1))


    /// `until` specialized

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = InstantZ, end = InstantZ}): Int64 = 
        import java.time.Instant.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getInstant(r.start);
        let e1 = unchecked_cast(getInstant(r.end) as ##java.time.temporal.Temporal);
        until(b1, e1, u)


    pub def nanosUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
        untilHelper(unchecked_cast(get_NANOS() as ##java.time.temporal.TemporalUnit), r)

    pub def microsUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
        untilHelper(unchecked_cast(get_MICROS() as ##java.time.temporal.TemporalUnit), r)

    pub def millisUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
        untilHelper(unchecked_cast(get_MILLIS() as ##java.time.temporal.TemporalUnit), r)

    pub def secondsUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    pub def minutesUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    pub def hoursUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)

    pub def halfDaysUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        untilHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), r)

    pub def daysUntil(r: {start = InstantZ, end = InstantZ}): Int64 = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        untilHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), r)

    /// ## generic helper functions

    def getLongHelper(field: ##java.time.temporal.TemporalField, x: InstantZ): Int64 =
        import java.time.Instant.getLong(##java.time.temporal.TemporalField): Int64 \ {};
        try {
            let InstantZ(x1) = x;
            getLong(x1, field)
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }


    def withTemporalFieldHelper(field: ##java.time.temporal.TemporalField, i: Int64, x: InstantZ): InstantZ =
        import java.time.Instant.with(##java.time.temporal.TemporalField, Int64): ##java.time.Instant \ {} as withTF;                   
        try {
            let InstantZ(x1) = x;
            InstantZ(withTF(x1, field, i))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }


}
