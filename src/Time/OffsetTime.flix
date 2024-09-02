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


mod Time {


    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}

    import java.time.{OffsetTime => JOffsetTime}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around a Java OffsetTime.
    ///
    pub enum OffsetTime(JOffsetTime)


    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[OffsetTime] {
        pub def toString(x: OffsetTime): String =
            let OffsetTime(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetTime] {
        pub def fromString(s: String): Option[OffsetTime] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs  = (checked_cast(s1) : CharSequence);
                OffsetTime(unsafe JOffsetTime.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[OffsetTime] {
        pub def eq(x: OffsetTime, y: OffsetTime): Bool =
            let OffsetTime(x1) = x;
            let OffsetTime(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)

    }

    instance Hash[OffsetTime] {
        pub def hash(x: OffsetTime): Int32 =
            let OffsetTime(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[OffsetTime] {
        pub def compare(x: OffsetTime, y: OffsetTime): Comparison =
            let OffsetTime(x1) = x;
            let OffsetTime(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }

}

mod Time.OffsetTime {

    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Format.TimeFormat
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

    import java.time.{OffsetTime => JOffsetTime}
    import java.lang.{Object, CharSequence}

    /// Unwrap

    pub def getOffsetTime(x: OffsetTime): JOffsetTime = 
        let OffsetTime(x1) = x;
        x1

    /// Constructors

    pub def offsetTime(r: { hour = Int32, minute = Int32, second = Int32, nanoSecond = Int32, offset = ZoneOffset}): OffsetTime =
        OffsetTime(unsafe JOffsetTime.of(r#hour, r#minute, r#second, r#nanoSecond, Time.ZoneOffset.getZoneOffset(r#offset)))

    /// `now` and "abstract constructors" if any

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): OffsetTime \ IO = OffsetTime(JOffsetTime.now())

    ///
    /// Returns the current time from the system clock.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetTime \ IO =
        let ZoneId(zone1) = zone;
        OffsetTime(JOffsetTime.now(zone1))

    /// `from` functions

    pub def fromLocalTime(offset: {offset = ZoneOffset}, x: LocalTime): OffsetTime =
        let LocalTime(x1) = x;
        let ZoneOffset(o1) = offset#offset;
        OffsetTime(unsafe JOffsetTime.of(x1, o1))


    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): OffsetTime =
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone#zone;
        OffsetTime(unsafe JOffsetTime.ofInstant(x1, z1))



    /// `fromTemporalAccessor` specialized

    // def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): OffsetTime = 
    //     import static java.time.OffsetTime.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetTime \ {} as fromTA;
    //     try {
    //         OffsetTime(fromTA(x))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }

    // pub def fromOffsetDateTime(x: OffsetDateTime): OffsetTime = 
    //     fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    // pub def fromZonedDateTime(x: ZonedDateTime): OffsetTime = 
    //     fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))

    // `parse` / `format` functions        

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[TimeFormat], s: String): Result[String, OffsetTime] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            OffsetTime(unsafe JOffsetTime.parse(cs, fmtr))
        })

    ///
    /// Returns OffsetTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[TimeFormat], x: OffsetTime): String =
        let OffsetTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)

    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetTime, y: OffsetTime): Bool =
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetTime, y: OffsetTime): Bool =
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        unsafe x1.isAfter(y1)

    pub def isInstantEqual(x: OffsetTime, y: OffsetTime): Bool =
        let OffsetTime(x1) = x;
        let OffsetTime(y1) = y;
        unsafe x1.isEqual(y1)

    // pub def isAmOfDay(x: OffsetTime): Bool = 
    //     import static java_get_field java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
    //     getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 0

    // pub def isPmOfDay(x: OffsetTime): Bool = 
    //     import static java_get_field java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
    //     getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 1

    /// Getters and Setters

    pub def getHour(x: OffsetTime): Int32 =
        let OffsetTime(x1) = x;
        unsafe x1.getHour()

    pub def withHour(hour: Int32, x: OffsetTime): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.withHour(hour))

    pub def getMinute(x: OffsetTime): Int32 =
        let OffsetTime(x1) = x;
        unsafe x1.getMinute()

    pub def withMinute(minute: Int32, x: OffsetTime): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.withMinute(minute))

    pub def getSecond(x: OffsetTime): Int32 =
        let OffsetTime(x1) = x;
        unsafe x1.getSecond()

    pub def withSecond(second: Int32, x: OffsetTime): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.withSecond(second))

    pub def getNano(x: OffsetTime): Int32 =
        let OffsetTime(x1) = x;
        unsafe x1.getNano()

    pub def withNano(nano: Int32, x: OffsetTime): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.withNano(nano))

    pub def getOffset(x: OffsetTime): ZoneOffset =
        let OffsetTime(x1) = x;
        ZoneOffset(unsafe x1.getOffset())

    pub def withOffsetSameInstant(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(unsafe x1.withOffsetSameInstant(o1))

    pub def withOffsetSameLocal(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        let OffsetTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetTime(unsafe x1.withOffsetSameLocal(o1))

    // pub def adjustLocalTime(x: LocalTime, dt: OffsetTime): OffsetTime = 
    //     import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = Time.LocalTime.getLocalTime(x);
    //     let dt1 = unchecked_cast(getOffsetTime(dt) as ##java.time.temporal.Temporal);
    //     OffsetTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetTime))

    // truncate functions

    // def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: OffsetTime): OffsetTime = 
    //     import java.time.OffsetTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.OffsetTime \ {};
    //     let OffsetTime(x1) = x;
    //     OffsetTime(truncatedTo(x1, u))

    // pub def truncatedToHours(x: OffsetTime): OffsetTime = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
    //     truncatedToHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), x)

    // plus / minus functions

    pub def plusHours(x: OffsetTime, hours: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.plusHours(hours))

    pub def minusHours(x: OffsetTime, hours: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.minusHours(hours))

    pub def plusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.plusMinutes(minutes))

    pub def minusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.minusMinutes(minutes))

    pub def plusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.plusSeconds(seconds))

    pub def minusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.minusSeconds(seconds))

    pub def plusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.plusNanos(nanos))

    pub def minusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        let OffsetTime(x1) = x;
        OffsetTime(unsafe x1.minusNanos(nanos))


    // pub def plusDuration(i: OffsetTime, x: DurationZ): OffsetTime =
    //     import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let i1 = unchecked_cast(getOffsetTime(i) as ##java.time.temporal.Temporal);
    //     let DurationZ(x1) = x;
    //     OffsetTime(unchecked_cast(addTo(x1, i1) as ##java.time.OffsetTime))
    
    // pub def minusDuration(i: OffsetTime, x: DurationZ): OffsetTime =
    //     import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let i1 = unchecked_cast(getOffsetTime(i) as ##java.time.temporal.Temporal);
    //     let DurationZ(x1) = x;
    //     OffsetTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.OffsetTime))


    // between / until functions
    
    // pub def between(r: {start = OffsetTime, end = OffsetTime}): DurationZ =
    //     import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
    //     let s1 = unchecked_cast(getOffsetTime(r#start) as ##java.time.temporal.Temporal);
    //     let e1 = unchecked_cast(getOffsetTime(r#end) as ##java.time.temporal.Temporal);
    //     DurationZ(between(s1, e1))


    // def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = OffsetTime, end = OffsetTime}): Int64 = 
    //     import java.time.OffsetTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
    //     let b1 = getOffsetTime(r#start);
    //     let e1 = unchecked_cast(getOffsetTime(r#end) as ##java.time.temporal.Temporal);
    //     until(b1, e1, u)


    // pub def secondsUntil(r: {start = OffsetTime, end = OffsetTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
    //     untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    // pub def minutesUntil(r: {start = OffsetTime, end = OffsetTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
    //     untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    // pub def hoursUntil(r: {start = OffsetTime, end = OffsetTime}): Int64 = 
    //     import static java_get_field java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
    //     untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)


    // generic helper functions

    // def getHelper(t: ##java.time.temporal.TemporalField, x: OffsetTime): Int32 = 
    //     import java.time.OffsetTime.get(##java.time.temporal.TemporalField): Int32 \ {};
    //     let x1 = getOffsetTime(x);
    //     get(x1, t)

}
