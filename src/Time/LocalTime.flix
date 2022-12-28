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
    /// A wrapper around a Java LocalTime.
    ///
    pub enum LocalTime(##java.time.LocalTime)

    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[LocalTime] {
        pub def toString(x: LocalTime): String =
            import java.time.LocalTime.toString(): String \ {};
            let LocalTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[LocalTime] {
        pub def fromString(s: String): Option[LocalTime] =
            import static java.time.LocalTime.parse(##java.lang.CharSequence): ##java.time.LocalTime \ {};
            try {
                let cs = unsafe_cast String.trim(s) as ##java.lang.CharSequence;
                Some(LocalTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }


    instance Eq[LocalTime] {
        pub def eq(x: LocalTime, y: LocalTime): Bool =
            import java.time.LocalTime.equals(##java.lang.Object): Bool \ {};
            let LocalTime(x1) = x;
            let LocalTime(y1) = y;
            equals(x1, unsafe_cast y1 as ##java.lang.Object)
    }
    
    instance Hash[LocalTime] {
        pub def hash(x: LocalTime): Int32 =
            import java.time.LocalTime.hashCode(): Int32 \ {};
            let LocalTime(x1) = x;
            hashCode(x1)

    }

    instance Order[LocalTime] {
        pub def compare(x: LocalTime, y: LocalTime): Comparison = 
            import java.time.LocalTime.compareTo(##java.time.LocalTime): Int32 \ {};
            let LocalTime(x1) = x;
            let LocalTime(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }

    instance Boxable[LocalTime]

    instance Interop/Flix.Marshal[LocalTime] {
        pub def toJavaObject(x: LocalTime): ##java.lang.Object =
            let LocalTime(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): LocalTime = 
            LocalTime(unsafe_cast o as ##java.time.LocalTime)
    }

}

namespace Time/LocalTime {

    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.TimeFormat;
    use Time.LocalDateTime;
    use Time.OffsetDateTime;
    use Time.OffsetTime;
    use Time.DurationZ;
    use Time.DurationZ.{DurationZ};
    use Time.InstantZ;
    use Time.InstantZ.{InstantZ};
    use Time.ZonedDateTime;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    /// ## Unwrap

    pub def getLocalTime(x: LocalTime): ##java.time.LocalTime = 
        let LocalTime(x1) = x;
        x1


    /// ## Constructors

    pub def localTime(r: {hour = Int32, minute = Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32): ##java.time.LocalTime \ {};
        LocalTime(of(r.hour, r.minute))

    pub def localTimeWithSecond(r: {hour = Int32, minute = Int32, second = Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32): ##java.time.LocalTime \ {};
        LocalTime(of(r.hour, r.minute, r.second))

    pub def localTimeWithSecondAndNano(r: {hour = Int32, minute = Int32, second = Int32, nanoSecond = Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32, Int32): ##java.time.LocalTime \ {};
        LocalTime(of(r.hour, r.minute, r.second, r.nanoSecond))


    /// ## `now` and "abstract constructors" (e.g. `midnight`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalTime \ IO =
        import static java.time.LocalTime.now(): ##java.time.LocalTime \ IO;
        LocalTime(now())


    ///
    /// ___
    ///
    pub def midnight(): LocalTime =
        import static get java.time.LocalTime.MIDNIGHT: ##java.time.LocalTime \ {} as getMIDNIGHT;
        LocalTime(getMIDNIGHT())

    ///
    /// ___
    ///
    pub def noon(): LocalTime =
        import static get java.time.LocalTime.NOON: ##java.time.LocalTime \ {} as getNOON;
        LocalTime(getNOON())


    /// ## `from` functions

    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): LocalTime =
        import static java.time.LocalTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalTime \ {};
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone.zone;
        LocalTime(ofInstant(x1, z1))


    pub def ofNanoOfDay(nanoOfDay: Int64): LocalTime =
        import static java.time.LocalTime.ofNanoOfDay(Int64): ##java.time.LocalTime \ {};
        LocalTime(ofNanoOfDay(nanoOfDay))

    pub def ofSecondOfDay(secondOfDay: Int64): LocalTime =
        import static java.time.LocalTime.ofSecondOfDay(Int64): ##java.time.LocalTime \ {};
        LocalTime(ofSecondOfDay(secondOfDay))

    /// `fromTemporalAccessor` specialized
    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): LocalTime = 
        import static java.time.LocalTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalTime \ {} as fromTA;
        try {
            LocalTime(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromLocalDateTime(x: LocalDateTime): LocalTime = 
        fromTemporalAccessorHelper(unsafe_cast Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetDateTime(x: OffsetDateTime): LocalTime = 
        fromTemporalAccessorHelper(unsafe_cast Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetTime(x: OffsetTime): LocalTime = 
        fromTemporalAccessorHelper(unsafe_cast Time/OffsetTime.getOffsetTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromZonedDateTime(x: ZonedDateTime): LocalTime = 
        fromTemporalAccessorHelper(unsafe_cast Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)


    /// ## `to` functions

    pub def toSecondOfDay(time: LocalTime): Int32 =
        import java.time.LocalTime.toSecondOfDay(): Int32 \ {};
        let LocalTime(x1) = time;
        toSecondOfDay(x1)

    pub def toNanoOfDay(time: LocalTime): Int64 =
        import java.time.LocalTime.toNanoOfDay(): Int64 \ {};
        let LocalTime(x1) = time;
        toNanoOfDay(x1)

    /// ## `parse` / `format` functions

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[TimeFormat], s: String): Result[String, LocalTime] =
        import static java.time.LocalTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalTime \ {};
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unsafe_cast String.trim(s) as ##java.lang.CharSequence;
            Ok(LocalTime(parse(cs, fmtr)))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    ///
    /// Returns the given LocalTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[TimeFormat], x: LocalTime): String =
        import java.time.LocalTime.format(##java.time.format.DateTimeFormatter): String \ {};
        let LocalTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)


    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isBefore(##java.time.LocalTime): Bool \ {};
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isAfter(##java.time.LocalTime): Bool \ {};
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        isAfter(x1, y1)


    pub def isAmOfDay(x: LocalTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
        getHelper(unsafe_cast get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField, x) == 0

    pub def isPmOfDay(x: LocalTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
        getHelper(unsafe_cast get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField, x) == 1

    /// ## Getters and Setters

    pub def getHour(x: LocalTime): Int32 =
        import java.time.LocalTime.getHour(): Int32 \ {};
        let LocalTime(x1) = x;
        getHour(x1)

    pub def withHour(hour: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withHour(Int32): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(withHour(x1, hour))

    pub def getMinute(x: LocalTime): Int32 =
        import java.time.LocalTime.getMinute(): Int32 \ {};
        let LocalTime(x1) = x;
        getMinute(x1)

    pub def withMinute(minute: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withMinute(Int32): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(withMinute(x1, minute))

    pub def getSecond(x: LocalTime): Int32 =
        import java.time.LocalTime.getSecond(): Int32 \ {};
        let LocalTime(x1) = x;
        getSecond(x1)

    pub def withSecond(second: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withSecond(Int32): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(withSecond(x1, second))

    pub def getNano(x: LocalTime): Int32 =
        import java.time.LocalTime.getNano(): Int32 \ {};
        let LocalTime(x1) = x;
        getNano(x1)

    pub def withNano(nano: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withNano(Int32): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(withNano(x1, nano))

    /// ## truncate functions

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: LocalTime): LocalTime = 
        import java.time.LocalTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(truncatedTo(x1, u))

    pub def truncatedToHours(x: LocalTime): LocalTime = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        truncatedToHelper(unsafe_cast get_HOURS() as ##java.time.temporal.TemporalUnit, x)

    /// ## plus / minus functions

    pub def plusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.plusHours(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(plusHours(x1, hours))

    pub def minusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.minusHours(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(minusHours(x1, hours))

    pub def plusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.plusMinutes(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.minusMinutes(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.plusSeconds(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.minusSeconds(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.plusNanos(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(plusNanos(x1, nanos))

    pub def minusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.minusNanos(Int64): ##java.time.LocalTime \ {};
        let LocalTime(x1) = x;
        LocalTime(minusNanos(x1, nanos))


    
    pub def plusDuration(i: LocalTime, x: DurationZ): LocalTime =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let i1 = unsafe_cast getLocalTime(i) as ##java.time.temporal.Temporal;
        let DurationZ(x1) = x;
        LocalTime(unsafe_cast addTo(x1, i1) as ##java.time.LocalTime)
    
    pub def minusDuration(i: LocalTime, x: DurationZ): LocalTime =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let i1 = unsafe_cast getLocalTime(i) as ##java.time.temporal.Temporal;
        let DurationZ(x1) = x;
        LocalTime(unsafe_cast subtractFrom(x1, i1) as ##java.time.LocalTime)

    /// ## between / until functions

    pub def between(r: {start = LocalTime, end = LocalTime}): DurationZ =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
        let s1 = unsafe_cast getLocalTime(r.start) as ##java.time.temporal.Temporal;
        let e1 = unsafe_cast getLocalTime(r.end) as ##java.time.temporal.Temporal;
        DurationZ(between(s1, e1)) 


    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = LocalTime, end = LocalTime}): Int64 = 
        import java.time.LocalTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getLocalTime(r.start);
        let e1 = unsafe_cast getLocalTime(r.end) as ##java.time.temporal.Temporal;
        until(b1, e1, u)


    pub def secondsUntil(r: {start = LocalTime, end = LocalTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        untilHelper(unsafe_cast get_SECONDS() as ##java.time.temporal.TemporalUnit, r)

    pub def minutesUntil(r: {start = LocalTime, end = LocalTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        untilHelper(unsafe_cast get_MINUTES() as ##java.time.temporal.TemporalUnit, r)

    pub def hoursUntil(r: {start = LocalTime, end = LocalTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        untilHelper(unsafe_cast get_HOURS() as ##java.time.temporal.TemporalUnit, r)

    
    /// ## generic helper functions

    def getHelper(t: ##java.time.temporal.TemporalField, x: LocalTime): Int32 = 
        import java.time.LocalTime.get(##java.time.temporal.TemporalField): Int32 \ {};
        let x1 = getLocalTime(x);
        get(x1, t)

}
