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
    pub opaque type LocalTime = ##java.time.LocalTime

    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[LocalTime] {
        pub def toString(x: LocalTime): String =
            import java.time.LocalTime.toString(): String & Pure;
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
            import static java.time.LocalTime.parse(##java.lang.CharSequence): ##java.time.LocalTime & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(LocalTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }


    instance Eq[LocalTime] {
        pub def eq(x: LocalTime, y: LocalTime): Bool = Time/LocalTime.equals(x, y)
    }
    
    instance Hash[LocalTime] {
        pub def hash(x: LocalTime): Int32 = Time/LocalTime.hashCode(x)
    }

    instance Order[LocalTime] {
        pub def compare(x: LocalTime, y: LocalTime): Comparison = 
            Time/LocalTime.compareTo(x,y) |> Comparison.fromInt32
    }

    instance Boxable[LocalTime]

}

namespace Time/LocalTime {

    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.TimeFormat;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.LocalDateTime;
    use Time.OffsetDateTime;
    use Time.OffsetTime;
    use Time.ZDuration;
    use Time.ZDuration.{ZDuration};
    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};
    use Time.ZonedDateTime;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def getLocalTime(x: LocalTime): ##java.time.LocalTime = 
        let LocalTime(x1) = x;
        x1



    pub def localTime(r: {hour :: Int32, minute :: Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(r.hour, r.minute))

    pub def localTimeWithSecond(r: {hour :: Int32, minute :: Int32, second :: Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(r.hour, r.minute, r.second))

    pub def localTimeWithSecondAndNano(r: {hour :: Int32, minute :: Int32, second :: Int32, nanoSecond :: Int32}): LocalTime =
        import static java.time.LocalTime.of(Int32, Int32, Int32, Int32): ##java.time.LocalTime & Pure;
        LocalTime(of(r.hour, r.minute, r.second, r.nanoSecond))


    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalTime & Impure =
        import static java.time.LocalTime.now(): ##java.time.LocalTime & Impure;
        LocalTime(now())


    ///
    /// ___
    ///
    pub def midnight(): LocalTime =
        import static get java.time.LocalTime.MIDNIGHT: ##java.time.LocalTime & Pure as getMIDNIGHT;
        LocalTime(getMIDNIGHT())

    ///
    /// ___
    ///
    pub def noon(): LocalTime =
        import static get java.time.LocalTime.NOON: ##java.time.LocalTime & Pure as getNOON;
        LocalTime(getNOON())


    pub def fromInstant(zone: {zone :: ZoneId}, x: ZInstant): LocalTime =
        import static java.time.LocalTime.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalTime & Pure;
        let ZInstant(x1) = x;
        let ZoneId(z1) = zone.zone;
        LocalTime(ofInstant(x1, z1))

    pub def fromSecondOfDay(secondOfDay: Int64): LocalTime =
        import static java.time.LocalTime.ofSecondOfDay(Int64): ##java.time.LocalTime & Pure;
        LocalTime(ofSecondOfDay(secondOfDay))

    pub def toSecondOfDay(time: LocalTime): Int32 =
        import java.time.LocalTime.toSecondOfDay(): Int32 & Pure;
        let LocalTime(x1) = time;
        toSecondOfDay(x1)

    pub def fromNanoOfDay(nanoOfDay: Int64): LocalTime =
        import static java.time.LocalTime.ofNanoOfDay(Int64): ##java.time.LocalTime & Pure;
        LocalTime(ofNanoOfDay(nanoOfDay))

    pub def toNanoOfDay(time: LocalTime): Int64 =
        import java.time.LocalTime.toNanoOfDay(): Int64 & Pure;
        let LocalTime(x1) = time;
        toNanoOfDay(x1)


    ///
    /// Returns the given LocalTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[TimeFormat], x: LocalTime): String =
        import java.time.LocalTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let LocalTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    
    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[TimeFormat], s: String): Option[LocalTime] =
        import static java.time.LocalTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(LocalTime(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.equals(##java.lang.Object): Bool & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: LocalTime): Int32 = 
        import java.time.LocalTime.hashCode(): Int32 & Pure;
        let LocalTime(x1) = x;
        hashCode(x1)

    ///
    /// Returns
    ///
    pub def compareTo(x: LocalTime, y: LocalTime): Int32 =
        import java.time.LocalTime.compareTo(##java.time.LocalTime): Int32 & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        compareTo(x1, y1)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isBefore(##java.time.LocalTime): Bool & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalTime, y: LocalTime): Bool =
        import java.time.LocalTime.isAfter(##java.time.LocalTime): Bool & Pure;
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        isAfter(x1, y1)

    pub def plusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.plusHours(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusHours(x1, hours))

    pub def minusHours(x: LocalTime, hours: Int64): LocalTime =
        import java.time.LocalTime.minusHours(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusHours(x1, hours))

    pub def plusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.plusMinutes(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        import java.time.LocalTime.minusMinutes(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.plusSeconds(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        import java.time.LocalTime.minusSeconds(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.plusNanos(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(plusNanos(x1, nanos))

    pub def minusNanos(x: LocalTime, nanos: Int64): LocalTime =
        import java.time.LocalTime.minusNanos(Int64): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(minusNanos(x1, nanos))

    /// Get/Set

    pub def getHour(x: LocalTime): Int32 =
        import java.time.LocalTime.getHour(): Int32 & Pure;
        let LocalTime(x1) = x;
        getHour(x1)

    pub def setHour(hour: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withHour(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withHour(x1, hour))

    pub def getMinute(x: LocalTime): Int32 =
        import java.time.LocalTime.getMinute(): Int32 & Pure;
        let LocalTime(x1) = x;
        getMinute(x1)

    pub def setMinute(minute: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withMinute(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withMinute(x1, minute))

    pub def getSecond(x: LocalTime): Int32 =
        import java.time.LocalTime.getSecond(): Int32 & Pure;
        let LocalTime(x1) = x;
        getSecond(x1)

    pub def setSecond(second: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withSecond(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withSecond(x1, second))

    pub def getNano(x: LocalTime): Int32 =
        import java.time.LocalTime.getNano(): Int32 & Pure;
        let LocalTime(x1) = x;
        getNano(x1)

    pub def setNano(nano: Int32, x: LocalTime): LocalTime =
        import java.time.LocalTime.withNano(Int32): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(withNano(x1, nano))

    /// Generic


    /// # `fromTemporalAccessor` specialized
    def fromHelper(x: ##java.time.temporal.TemporalAccessor): LocalTime = 
        import static java.time.LocalTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalTime & Pure as fromTA;
        try {
            LocalTime(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromLocalDateTime(x: LocalDateTime): LocalTime = 
        fromHelper(Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetDateTime(x: OffsetDateTime): LocalTime = 
        fromHelper(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetTime(x: OffsetTime): LocalTime = 
        fromHelper(Time/OffsetTime.getOffsetTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromZonedDateTime(x: ZonedDateTime): LocalTime = 
        fromHelper(Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)

    /// # `adjustInto` specialized - this become `adjustLocalTime` in the respective modules:
    /// LocalDateTime
    /// OffsetDateTime
    /// OffsetTime
    /// ZonedDateTime



    pub def get(t: ##java.time.temporal.TemporalField, x: LocalTime): Int32 = 
        import java.time.LocalTime.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getLocalTime(x);
        get(x1, t)

    pub def getLongHelper(t: ##java.time.temporal.TemporalField, x: LocalTime): Int64 = 
        import java.time.LocalTime.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getLocalTime(x);
        getLong(x1, t)

    pub def plusHelper(x: LocalTime, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalTime =
        import java.time.LocalTime.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalTime & Pure;         
        try {
            let LocalTime(x1) = x;
            LocalTime(plus(x1, amount, temporalUnit))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minusHelper(x: LocalTime, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalTime =
        import java.time.LocalTime.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalTime & Pure;         
        try {
            let LocalTime(x1) = x;
            LocalTime(minus(x1, amount, temporalUnit))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def plusTemporalAmountHelper(x: LocalTime, amount: ##java.time.temporal.TemporalAmount): LocalTime =
        import java.time.LocalTime.plus(##java.time.temporal.TemporalAmount): ##java.time.LocalTime & Pure;         
        try {
            let LocalTime(x1) = x;
            LocalTime(plus(x1, amount))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmountHelper(x: LocalTime, amount: ##java.time.temporal.TemporalAmount): LocalTime =
        import java.time.LocalTime.minus(##java.time.temporal.TemporalAmount): ##java.time.LocalTime & Pure;         
        try {
            let LocalTime(x1) = x;
            LocalTime(minus(x1, amount))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    /// # `range` specialized

    def rangeHelper(f: ##java.time.temporal.TemporalField, x: LocalTime): ValueRange =
        import java.time.LocalTime.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let LocalTime(x1) = x;
            ValueRange(range(x1, f))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def rangeNanoOfSecond(x: LocalTime): ValueRange = 
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_NANO_OF_SECOND;
        rangeHelper(get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField, x)

    /// # `truncatedTo` specialized

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: LocalTime): LocalTime = 
        import java.time.LocalTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.LocalTime & Pure;
        let LocalTime(x1) = x;
        LocalTime(truncatedTo(x1, u))

    pub def truncatedToHours(x: LocalTime): LocalTime = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
        truncatedToHelper(get_HOURS() as ##java.time.temporal.TemporalUnit, x)
    
   /// # `until` specialized

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start :: LocalTime, end :: LocalTime}): Int64 = 
        import java.time.LocalTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getLocalTime(r.start);
        let e1 = getLocalTime(r.end) as ##java.time.temporal.Temporal;
        until(b1, e1, u)


    pub def hoursUntil(r: {start :: LocalTime, end :: LocalTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
        untilHelper(get_HOURS() as ##java.time.temporal.TemporalUnit, r)


    pub def withTemporalAdjusterHelper(adj: ##java.time.temporal.TemporalAdjuster, x: LocalTime): LocalTime =
        import java.time.LocalTime.with(##java.time.temporal.TemporalAdjuster): ##java.time.LocalTime & Pure as withTA;         
        try {
            let LocalTime(x1) = x;
            LocalTime(withTA(x1, adj))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalFieldHelper(field: ##java.time.temporal.TemporalField, i: Int64, x: LocalTime): LocalTime =
        import java.time.LocalTime.with(##java.time.temporal.TemporalField, Int64): ##java.time.LocalTime & Pure as withTF;         
        try {
            let LocalTime(x1) = x;
            LocalTime(withTF(x1, field, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    /// Duration methods

    pub def between(r: {start :: LocalTime, end :: LocalTime}): ZDuration =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration & Pure;
        ZDuration(between(getLocalTime(r.start) as ##java.time.temporal.Temporal, 
                            getLocalTime(r.end) as ##java.time.temporal.Temporal))

    
    pub def plusDuration(i: LocalTime, x: ZDuration): LocalTime =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let i1 = getLocalTime(i) as ##java.time.temporal.Temporal;
        let ZDuration(x1) = x;
        LocalTime(addTo(x1, i1) as ##java.time.LocalTime)
    
    pub def minusDuration(i: LocalTime, x: ZDuration): LocalTime =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let i1 = getLocalTime(i) as ##java.time.temporal.Temporal;
        let ZDuration(x1) = x;
        LocalTime(subtractFrom(x1, i1) as ##java.time.LocalTime)

}
