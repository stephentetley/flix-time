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

    use Time.LocalTime
    use Time.LocalTime.{LocalTime}

    import java.time.{LocalTime => JLocalTime}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around a Java LocalTime.
    ///
    pub enum LocalTime(JLocalTime)

    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[LocalTime] {
        pub def toString(x: LocalTime): String =
            let LocalTime(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[LocalTime] {
        pub def fromString(s: String): Option[LocalTime] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs  = (checked_cast(s1) : CharSequence);
                LocalTime(unsafe JLocalTime.parse(cs))
            }) |> Result.toOption
    }


    instance Eq[LocalTime] {
        pub def eq(x: LocalTime, y: LocalTime): Bool =
            let LocalTime(x1) = x;
            let LocalTime(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }
    
    instance Hash[LocalTime] {
        pub def hash(x: LocalTime): Int32 =
            let LocalTime(x1) = x;
            unsafe x1.hashCode()

    }

    instance Order[LocalTime] {
        pub def compare(x: LocalTime, y: LocalTime): Comparison = 
            let LocalTime(x1) = x;
            let LocalTime(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }

}

mod Time.LocalTime {

    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
        
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Format.TimeFormat
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.{LocalTime => JLocalTime}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}

    // Unwrap

    pub def getLocalTime(x: LocalTime): JLocalTime = 
        let LocalTime(x1) = x;
        x1


    // Constructors

    pub def localTime(r: {hour = Int32, minute = Int32}): LocalTime =
        LocalTime(unsafe JLocalTime.of(r#hour, r#minute))

    pub def localTimeWithSecond(r: {hour = Int32, minute = Int32, second = Int32}): LocalTime =
        LocalTime(unsafe JLocalTime.of(r#hour, r#minute, r#second))

    pub def localTimeWithSecondAndNano(r: {hour = Int32, minute = Int32, second = Int32, nanoSecond = Int32}): LocalTime =
        LocalTime(unsafe JLocalTime.of(r#hour, r#minute, r#second, r#nanoSecond))


    /// `now` and "abstract constructors" (e.g. `midnight`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalTime \ IO = LocalTime(JLocalTime.now())


    ///
    /// ___
    ///
    pub def midnight(): LocalTime = LocalTime(unsafe JLocalTime.MIDNIGHT)

    ///
    /// ___
    ///
    pub def noon(): LocalTime = LocalTime(unsafe JLocalTime.NOON)


    // `from` functions

    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): LocalTime =
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone#zone;
        LocalTime(unsafe JLocalTime.ofInstant(x1, z1))


    pub def ofNanoOfDay(nanoOfDay: Int64): LocalTime =
        LocalTime(unsafe JLocalTime.ofNanoOfDay(nanoOfDay))

    pub def ofSecondOfDay(secondOfDay: Int64): LocalTime =
        LocalTime(unsafe JLocalTime.ofSecondOfDay(secondOfDay))

    /// `fromTemporalAccessor` specialized

    pub def fromLocalDateTime(x: LocalDateTime): LocalTime = 
        let LocalDateTime(x1) = x;
        let ans = unsafe JLocalTime.from(x1);
        LocalTime(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): LocalTime = 
        let OffsetDateTime(x1) = x;
        let ans = unsafe JLocalTime.from(x1);
        LocalTime(ans)

    pub def fromOffsetTime(x: OffsetTime): LocalTime = 
        let OffsetTime(x1) = x;
        let ans = unsafe JLocalTime.from(x1);
        LocalTime(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): LocalTime = 
        let ZonedDateTime(x1) = x;
        let ans = unsafe JLocalTime.from(x1);
        LocalTime(ans)

    /// `to` functions

    pub def toSecondOfDay(time: LocalTime): Int32 =
        let LocalTime(x1) = time;
        unsafe x1.toSecondOfDay()

    pub def toNanoOfDay(time: LocalTime): Int64 =
        let LocalTime(x1) = time;
        unsafe x1.toNanoOfDay()

    /// `parse` / `format` functions

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[TimeFormat], s: String): Result[String, LocalTime] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            LocalTime(unsafe JLocalTime.parse(cs, fmtr))
        })

    ///
    /// Returns the given LocalTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[TimeFormat], x: LocalTime): String =
        let LocalTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalTime, y: LocalTime): Bool =
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalTime, y: LocalTime): Bool =
        let LocalTime(x1) = x;
        let LocalTime(y1) = y;
        unsafe x1.isAfter(y1)


    pub def isAmOfDay(x: LocalTime): Bool = 
        let LocalTime(x1) = x;
        let tf1 = unsafe JChronoField.AMPM_OF_DAY;
        unsafe x1.get(tf1) == 0


    pub def isPmOfDay(x: LocalTime): Bool = 
        let LocalTime(x1) = x;
        let tf1 = unsafe JChronoField.AMPM_OF_DAY;
        unsafe x1.get(tf1) == 1

    // Getters and Setters

    pub def getHour(x: LocalTime): Int32 =
        let LocalTime(x1) = x;
        unsafe x1.getHour()

    pub def withHour(hour: Int32, x: LocalTime): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.withHour(hour))

    pub def getMinute(x: LocalTime): Int32 =
        let LocalTime(x1) = x;
        unsafe x1.getMinute()

    pub def withMinute(minute: Int32, x: LocalTime): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.withMinute(minute))

    pub def getSecond(x: LocalTime): Int32 =
        let LocalTime(x1) = x;
        unsafe x1.getSecond()

    pub def withSecond(second: Int32, x: LocalTime): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.withSecond(second))

    pub def getNano(x: LocalTime): Int32 =
        let LocalTime(x1) = x;
        unsafe x1.getNano()

    pub def withNano(nano: Int32, x: LocalTime): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.withNano(nano))

    // truncate functions


    pub def truncatedToHours(x: LocalTime): LocalTime = 
        let LocalTime(x1) = x;
        let u1 = unsafe JChronoUnit.HOURS;
        let ans = unsafe x1.truncatedTo(u1);
        LocalTime(ans)

    // plus / minus functions

    pub def plusHours(x: LocalTime, hours: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.plusHours(hours))

    pub def minusHours(x: LocalTime, hours: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.minusHours(hours))

    pub def plusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.plusMinutes(minutes))

    pub def minusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.minusMinutes(minutes))

    pub def plusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.plusSeconds(seconds))

    pub def minusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.minusSeconds(seconds))

    pub def plusNanos(x: LocalTime, nanos: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.plusNanos(nanos))

    pub def minusNanos(x: LocalTime, nanos: Int64): LocalTime =
        let LocalTime(x1) = x;
        LocalTime(unsafe x1.minusNanos(nanos))


    
    pub def plusDuration(x: LocalTime, d: DurationZ): LocalTime =
        let LocalTime(x1) = x;
        let DurationZ(d1) = d;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe d1.addTo(t1);
        let ans = unchecked_cast(t2 as JLocalTime);
        LocalTime(ans)
    
    pub def minusDuration(x: LocalTime, d: DurationZ): LocalTime =
        let LocalTime(x1) = x;
        let DurationZ(d1) = d;
        let t1: JTemporal = checked_cast(x1);
        let t2 = unsafe d1.subtractFrom(t1);
        let ans = unchecked_cast(t2 as JLocalTime);
        LocalTime(ans)


    // between / until functions

    pub def between(begin: {begin = LocalTime}, end: {end = LocalTime}): DurationZ =
        let LocalTime(b1) = begin#begin;
        let LocalTime(e1) = end#end;
        let tb1: JTemporal = checked_cast(b1);
        let te1: JTemporal = checked_cast(e1);
        let ans = unsafe JDuration.between(tb1, te1);
        DurationZ(ans)



    pub def secondsUntil(begin: {begin = LocalTime}, end: {end = LocalTime}): Int64 = 
        let LocalTime(b1) = begin#begin;
        let LocalTime(e1) = end#end;
        let u1 = unsafe JChronoUnit.SECONDS;
        unsafe b1.until(e1, u1)


    pub def minutesUntil(begin: {begin = LocalTime}, end: {end = LocalTime}): Int64 = 
        let LocalTime(b1) = begin#begin;
        let LocalTime(e1) = end#end;
        let u1 = unsafe JChronoUnit.MINUTES;
        unsafe b1.until(e1, u1)

    pub def hoursUntil(begin: {begin = LocalTime}, end: {end = LocalTime}): Int64 = 
        let LocalTime(b1) = begin#begin;
        let LocalTime(e1) = end#end;
        let u1 = unsafe JChronoUnit.HOURS;
        unsafe b1.until(e1, u1)


}
