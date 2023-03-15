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


    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}

    ///
    /// A wrapper around a Java OffsetTime.
    ///
    pub enum OffsetTime(##java.time.OffsetTime)


    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[OffsetTime] {
        pub def toString(x: OffsetTime): String =
            import java.time.OffsetTime.toString(): String \ {};
            let OffsetTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetTime] {
        pub def fromString(s: String): Option[OffsetTime] =
            Result.tryCatch(_ -> {
                import static java.time.OffsetTime.parse(##java.lang.CharSequence): ##java.time.OffsetTime \ {};
                let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
                OffsetTime(parse(cs))
            }) |> Result.toOption
    }

    instance Eq[OffsetTime] {
        pub def eq(x: OffsetTime, y: OffsetTime): Bool =
            import java.time.OffsetTime.equals(##java.lang.Object): Bool \ {};
            let OffsetTime(x1) = x;
            let OffsetTime(y1) = y;
            equals(x1, checked_cast(y1))

    }

    instance Hash[OffsetTime] {
        pub def hash(x: OffsetTime): Int32 =
            import java.time.OffsetTime.hashCode(): Int32 \ {};
            let OffsetTime(x1) = x;
            hashCode(x1)
    }

    instance Order[OffsetTime] {
        pub def compare(x: OffsetTime, y: OffsetTime): Comparison =
            import java.time.OffsetTime.compareTo(##java.time.OffsetTime): Int32 \ {};
            let OffsetTime(x1) = x;
            let OffsetTime(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }


    instance Boxable[OffsetTime]

    instance Interop/Flix.Marshal[OffsetTime] {
        pub def toJavaObject(x: OffsetTime): ##java.lang.Object =
            let OffsetTime(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): OffsetTime = 
            OffsetTime(unchecked_cast(o as ##java.time.OffsetTime))
    }

}

namespace Time/OffsetTime {

    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time/Format.DateTimeFormatter
    use Time/Format.DateTimeFormatter.{DateTimeFormatter}
    use Time/Format.TimeFormat
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.OffsetDateTime
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZonedDateTime
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    /// ## Unwrap

    pub def getOffsetTime(x: OffsetTime): ##java.time.OffsetTime = 
        let OffsetTime(x1) = x;
        x1

    /// ## Constructors

    pub def offsetTime(r: { hour = Int32, minute = Int32, second = Int32, nanoSecond = Int32, offset = ZoneOffset}): OffsetTime =
        import static java.time.OffsetTime.of(Int32, Int32, Int32, Int32, ##java.time.ZoneOffset): ##java.time.OffsetTime \ {};
        OffsetTime(of(r.hour, r.minute, r.second, r.nanoSecond, Time/ZoneOffset.getZoneOffset(r.offset)))

    /// ## `now` and "abstract constructors" if any

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): OffsetTime \ IO =
        import static java.time.OffsetTime.now(): ##java.time.OffsetTime \ IO;
        OffsetTime(now())

    ///
    /// Returns the current time from the system clock.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetTime \ IO =
        import static java.time.OffsetTime.now(##java.time.ZoneId): ##java.time.OffsetTime \ IO;
        let ZoneId(z1) = zone;
        OffsetTime(now(z1))

    /// ## `from` functions

    pub def fromLocalTime(offset: {offset = ZoneOffset}, x: LocalTime): OffsetTime =
        import static java.time.OffsetTime.of(##java.time.LocalTime, ##java.time.ZoneOffset): ##java.time.OffsetTime \ {};
        let LocalTime(x1) = x;
        let ZoneOffset(o1) = offset.offset;
        OffsetTime(of(x1, o1))


    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): OffsetTime =
        import static java.time.OffsetTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.OffsetTime \ {};
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone.zone;
        OffsetTime(ofInstant(x1, z1))



    /// # `fromTemporalAccessor` specialized

    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): OffsetTime = 
        import static java.time.OffsetTime.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetTime \ {} as fromTA;
        try {
            OffsetTime(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): OffsetTime = 
        fromTemporalAccessorHelper(unchecked_cast(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromZonedDateTime(x: ZonedDateTime): OffsetTime = 
        fromTemporalAccessorHelper(unchecked_cast(Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))

    /// ## `parse` / `format` functions        

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[TimeFormat], s: String): Result[String, OffsetTime] =
        Result.tryCatch(_ -> {
            import static java.time.OffsetTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.OffsetTime \ {};
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            OffsetTime(parse(cs, fmtr))
        })

    ///
    /// Returns OffsetTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[TimeFormat], x: OffsetTime): String =
        import java.time.OffsetTime.format(##java.time.format.DateTimeFormatter): String \ {};
        let OffsetTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isBefore(##java.time.OffsetTime): Bool \ {};
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isAfter(##java.time.OffsetTime): Bool \ {};
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isAfter(x1, y1)

    pub def isInstantEqual(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isEqual(##java.time.OffsetTime): Bool \ {};
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isEqual(x1, y1)

    pub def isAmOfDay(x: OffsetTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
        getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 0

    pub def isPmOfDay(x: OffsetTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
        getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 1

    /// ## Getters and Setters

    pub def getHour(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getHour(): Int32 \ {};
        let OffsetTime(x1) = x;
        getHour(x1)

    pub def withHour(hour: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withHour(Int32): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(withHour(x1, hour))

    pub def getMinute(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getMinute(): Int32 \ {};
        let OffsetTime(x1) = x;
        getMinute(x1)

    pub def withMinute(minute: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withMinute(Int32): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(withMinute(x1, minute))

    pub def getSecond(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getSecond(): Int32 \ {};
        let OffsetTime(x1) = x;
        getSecond(x1)

    pub def withSecond(second: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withSecond(Int32): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(withSecond(x1, second))

    pub def getNano(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getNano(): Int32 \ {};
        let OffsetTime(x1) = x;
        getNano(x1)

    pub def withNano(nano: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withNano(Int32): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(withNano(x1, nano))

    pub def getOffset(x: OffsetTime): ZoneOffset =
        import java.time.OffsetTime.getOffset(): ##java.time.ZoneOffset \ {};
        let OffsetTime(x1) = x;
        ZoneOffset(getOffset(x1))

    pub def withOffsetSameInstant(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameInstant(##java.time.ZoneOffset): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameInstant(x1, o1))

    pub def withOffsetSameLocal(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameLocal(##java.time.ZoneOffset): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameLocal(x1, o1))

    pub def adjustLocalTime(x: LocalTime, dt: OffsetTime): OffsetTime = 
        import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time/LocalTime.getLocalTime(x);
        let dt1 = unchecked_cast(getOffsetTime(dt) as ##java.time.temporal.Temporal);
        OffsetTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetTime))

    /// ## truncate functions

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: OffsetTime): OffsetTime = 
        import java.time.OffsetTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(truncatedTo(x1, u))

    pub def truncatedToHours(x: OffsetTime): OffsetTime = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        truncatedToHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), x)

    /// ## plus / minus functions

    pub def plusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.plusHours(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(plusHours(x1, hours))

    pub def minusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.minusHours(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(minusHours(x1, hours))

    pub def plusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.plusMinutes(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.minusMinutes(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.plusSeconds(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.minusSeconds(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.plusNanos(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(plusNanos(x1, nanos))

    pub def minusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.minusNanos(Int64): ##java.time.OffsetTime \ {};
        let OffsetTime(x1) = x;
        OffsetTime(minusNanos(x1, nanos))


    pub def plusDuration(i: OffsetTime, x: DurationZ): OffsetTime =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let i1 = unchecked_cast(getOffsetTime(i) as ##java.time.temporal.Temporal);
        let DurationZ(x1) = x;
        OffsetTime(unchecked_cast(addTo(x1, i1) as ##java.time.OffsetTime))
    
    pub def minusDuration(i: OffsetTime, x: DurationZ): OffsetTime =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let i1 = unchecked_cast(getOffsetTime(i) as ##java.time.temporal.Temporal);
        let DurationZ(x1) = x;
        OffsetTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.OffsetTime))


    /// ## between / until functions
    
    pub def between(r: {start = OffsetTime, end = OffsetTime}): DurationZ =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
        let s1 = unchecked_cast(getOffsetTime(r.start) as ##java.time.temporal.Temporal);
        let e1 = unchecked_cast(getOffsetTime(r.end) as ##java.time.temporal.Temporal);
        DurationZ(between(s1, e1))


    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = OffsetTime, end = OffsetTime}): Int64 = 
        import java.time.OffsetTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getOffsetTime(r.start);
        let e1 = unchecked_cast(getOffsetTime(r.end) as ##java.time.temporal.Temporal);
        until(b1, e1, u)


    pub def secondsUntil(r: {start = OffsetTime, end = OffsetTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    pub def minutesUntil(r: {start = OffsetTime, end = OffsetTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    pub def hoursUntil(r: {start = OffsetTime, end = OffsetTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)


    /// ## generic helper functions

    def getHelper(t: ##java.time.temporal.TemporalField, x: OffsetTime): Int32 = 
        import java.time.OffsetTime.get(##java.time.temporal.TemporalField): Int32 \ {};
        let x1 = getOffsetTime(x);
        get(x1, t)

}
