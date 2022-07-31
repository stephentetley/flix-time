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
    /// A wrapper around a Java OffsetTime.
    ///
    pub enum OffsetTime(##java.time.OffsetTime)


    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[OffsetTime] {
        pub def toString(x: OffsetTime): String =
            import java.time.OffsetTime.toString(): String & Pure;
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
            import static java.time.OffsetTime.parse(##java.lang.CharSequence): ##java.time.OffsetTime & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(OffsetTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[OffsetTime] {
        pub def eq(x: OffsetTime, y: OffsetTime): Bool =
            import java.time.OffsetTime.equals(##java.lang.Object): Bool & Pure;
            let OffsetTime(x1) = x;
            let OffsetTime(y1) = y;
            equals(x1, y1 as ##java.lang.Object)

    }

    instance Hash[OffsetTime] {
        pub def hash(x: OffsetTime): Int32 =
            import java.time.OffsetTime.hashCode(): Int32 & Pure;
            let OffsetTime(x1) = x;
            hashCode(x1)
    }

    instance Order[OffsetTime] {
        pub def compare(x: OffsetTime, y: OffsetTime): Comparison =
            import java.time.OffsetTime.compareTo(##java.time.OffsetTime): Int32 & Pure;
            let OffsetTime(x1) = x;
            let OffsetTime(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }


    instance Boxable[OffsetTime]

    instance Interop/Collections.Marshal[OffsetTime] {
        pub def toJavaObject(x: OffsetTime): ##java.lang.Object =
            let OffsetTime(x1) = x;
            x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): OffsetTime = 
            OffsetTime(o as ##java.time.OffsetTime)
    }

}

namespace Time/OffsetTime {

    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time/Temporal.ChronoUnit;
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.TimeFormat;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.ZDuration;
    use Time.ZDuration.{ZDuration};
    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.OffsetDateTime;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZonedDateTime;
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    /// ## Unwrap

    pub def getOffsetTime(x: OffsetTime): ##java.time.OffsetTime = 
        let OffsetTime(x1) = x;
        x1

    /// ## Constructors

    pub def offsetTime(r: { hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32, offset :: ZoneOffset}): OffsetTime =
        import static java.time.OffsetTime.of(Int32, Int32, Int32, Int32, ##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        OffsetTime(of(r.hour, r.minute, r.second, r.nanoSecond, Time/ZoneOffset.getZoneOffset(r.offset)))

    /// ## `now` and "abstract constructors" if any

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): OffsetTime & Impure =
        import static java.time.OffsetTime.now(): ##java.time.OffsetTime & Impure;
        OffsetTime(now())

    ///
    /// Returns the current time from the system clock.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetTime & Impure =
        import static java.time.OffsetTime.now(##java.time.ZoneId): ##java.time.OffsetTime & Impure;
        let ZoneId(z1) = zone;
        OffsetTime(now(z1))

    /// ## `from` functions

    pub def fromLocalTime(offset: {offset :: ZoneOffset}, x: LocalTime): OffsetTime =
        import static java.time.OffsetTime.of(##java.time.LocalTime, ##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let LocalTime(x1) = x;
        let ZoneOffset(o1) = offset.offset;
        OffsetTime(of(x1, o1))


    pub def fromInstant(zone: {zone :: ZoneId}, x: ZInstant): OffsetTime =
        import static java.time.OffsetTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.OffsetTime & Pure;
        let ZInstant(x1) = x;
        let ZoneId(z1) = zone.zone;
        OffsetTime(ofInstant(x1, z1))



    /// # `fromTemporalAccessor` specialized

    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): OffsetTime = 
        import static java.time.OffsetTime.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetTime & Pure as fromTA;
        try {
            OffsetTime(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & Pure;
                bug!(getMessage(ex))
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): OffsetTime = 
        fromTemporalAccessorHelper(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromZonedDateTime(x: ZonedDateTime): OffsetTime = 
        fromTemporalAccessorHelper(Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)

    /// ## `parse` / `format` functions        

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[TimeFormat], s: String): Result[OffsetTime, String] =
        import static java.time.OffsetTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.OffsetTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Ok(OffsetTime(parse(cs, fmtr)))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }

    ///
    /// Returns OffsetTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[TimeFormat], x: OffsetTime): String =
        import java.time.OffsetTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let OffsetTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isBefore(##java.time.OffsetTime): Bool & Pure;
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isAfter(##java.time.OffsetTime): Bool & Pure;
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isAfter(x1, y1)

    pub def isInstantEqual(x: OffsetTime, y: OffsetTime): Bool =
        import java.time.OffsetTime.isEqual(##java.time.OffsetTime): Bool & Pure;
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        isEqual(x1, y1)

    pub def isAmOfDay(x: OffsetTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_AMPM_OF_DAY;        
        getHelper(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField, x) == 0

    pub def isPmOfDay(x: OffsetTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_AMPM_OF_DAY;        
        getHelper(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField, x) == 1

    /// ## Getters and Setters

    pub def getHour(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getHour(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getHour(x1)

    pub def setHour(hour: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withHour(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withHour(x1, hour))

    pub def getMinute(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getMinute(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getMinute(x1)

    pub def setMinute(minute: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withMinute(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withMinute(x1, minute))

    pub def getSecond(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getSecond(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getSecond(x1)

    pub def setSecond(second: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withSecond(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withSecond(x1, second))

    pub def getNano(x: OffsetTime): Int32 =
        import java.time.OffsetTime.getNano(): Int32 & Pure;
        let OffsetTime(x1) = x;
        getNano(x1)

    pub def setNano(nano: Int32, x: OffsetTime): OffsetTime =
        import java.time.OffsetTime.withNano(Int32): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(withNano(x1, nano))

    pub def getOffset(x: OffsetTime): ZoneOffset =
        import java.time.OffsetTime.getOffset(): ##java.time.ZoneOffset & Pure;
        let OffsetTime(x1) = x;
        ZoneOffset(getOffset(x1))

    pub def setOffsetSameInstant(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameInstant(##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameInstant(x1, o1))

    pub def setOffsetSameLocal(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        import java.time.OffsetTime.withOffsetSameLocal(##java.time.ZoneOffset): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(withOffsetSameLocal(x1, o1))

    pub def setLocalTime(x: LocalTime, dt: OffsetTime): OffsetTime = 
        import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/LocalTime.getLocalTime(x);
        let dt1 = getOffsetTime(dt) as ##java.time.temporal.Temporal;
        OffsetTime(adjustInto(x1, dt1) as ##java.time.OffsetTime)

    /// ## truncate functions

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: OffsetTime): OffsetTime = 
        import java.time.OffsetTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(truncatedTo(x1, u))

    pub def truncatedToHours(x: OffsetTime): OffsetTime = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
        truncatedToHelper(get_HOURS() as ##java.time.temporal.TemporalUnit, x)

    /// ## plus / minus functions

    pub def plusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.plusHours(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusHours(x1, hours))

    pub def minusHours(x: OffsetTime, hours: Int64): OffsetTime =
        import java.time.OffsetTime.minusHours(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusHours(x1, hours))

    pub def plusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.plusMinutes(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        import java.time.OffsetTime.minusMinutes(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.plusSeconds(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        import java.time.OffsetTime.minusSeconds(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.plusNanos(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(plusNanos(x1, nanos))

    pub def minusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        import java.time.OffsetTime.minusNanos(Int64): ##java.time.OffsetTime & Pure;
        let OffsetTime(x1) = x;
        OffsetTime(minusNanos(x1, nanos))


    pub def plusDuration(i: OffsetTime, x: ZDuration): OffsetTime =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let i1 = getOffsetTime(i) as ##java.time.temporal.Temporal;
        let ZDuration(x1) = x;
        OffsetTime(addTo(x1, i1) as ##java.time.OffsetTime)
    
    pub def minusDuration(i: OffsetTime, x: ZDuration): OffsetTime =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let i1 = getOffsetTime(i) as ##java.time.temporal.Temporal;
        let ZDuration(x1) = x;
        OffsetTime(subtractFrom(x1, i1) as ##java.time.OffsetTime)


    /// ## between / until functions
    
    pub def between(r: {start :: OffsetTime, end :: OffsetTime}): ZDuration =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration & Pure;
        let s1 = getOffsetTime(r.start) as ##java.time.temporal.Temporal;
        let e1 = getOffsetTime(r.end) as ##java.time.temporal.Temporal;
        ZDuration(between(s1, e1))


    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start :: OffsetTime, end :: OffsetTime}): Int64 = 
        import java.time.OffsetTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getOffsetTime(r.start);
        let e1 = getOffsetTime(r.end) as ##java.time.temporal.Temporal;
        until(b1, e1, u)


    pub def secondsUntil(r: {start :: OffsetTime, end :: OffsetTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as get_SECONDS;
        untilHelper(get_SECONDS() as ##java.time.temporal.TemporalUnit, r)

    pub def minutesUntil(r: {start :: OffsetTime, end :: OffsetTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as get_MINUTES;
        untilHelper(get_MINUTES() as ##java.time.temporal.TemporalUnit, r)

    pub def hoursUntil(r: {start :: OffsetTime, end :: OffsetTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
        untilHelper(get_HOURS() as ##java.time.temporal.TemporalUnit, r)


    /// ## generic helper functions

    def getHelper(t: ##java.time.temporal.TemporalField, x: OffsetTime): Int32 = 
        import java.time.OffsetTime.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getOffsetTime(x);
        get(x1, t)

}
