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



pub mod InteropTime.LocalTime {

    use JavaInterop.AdaptorExtras

    use InteropTime.Format.TemporalFormat
    use InteropTime.Format.TemporalParse
    use InteropTime.Format.TimeFormatter
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetTime.OffsetTime
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZoneOffset
    
    import java.time.{Duration => JDuration}
    import java.time.{LocalTime => JLocalTime}
    import java.time.{OffsetTime => JOffsetTime}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java LocalTime.
    ///
    pub enum LocalTime(JLocalTime)

    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[LocalTime] {
        pub def toString(x: LocalTime): String =
            let LocalTime.LocalTime(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as a LocalTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[LocalTime] {
        pub def fromString(s: String): Option[LocalTime] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JLocalTime.parse(s1) };
                Some(LocalTime.LocalTime(ans))
            } catch {
                case _: JException => None
            }
    }


    instance Eq[LocalTime] {
        pub def eq(x: LocalTime, y: LocalTime): Bool =
            let LocalTime.LocalTime(x1) = x;
            let LocalTime.LocalTime(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[LocalTime] {
        pub def hash(x: LocalTime): Int32 =
            let LocalTime.LocalTime(x1) = x;
            unsafe IO { x1.hashCode() }

    }

    instance Order[LocalTime] {
        pub def compare(x: LocalTime, y: LocalTime): Comparison =
            let LocalTime.LocalTime(x1) = x;
            let LocalTime.LocalTime(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance ToJava[LocalTime] {
        type Out = JLocalTime
        pub def toJava(x: LocalTime): JLocalTime = 
            let LocalTime.LocalTime(x1) = x;
            x1
    }

    instance ToFlix[LocalTime] {
        type In = JLocalTime
        pub def toFlix(x: JLocalTime): LocalTime = 
            LocalTime.LocalTime(x)
    }    

    instance TemporalFormat[LocalTime] {
        type Formatter = TimeFormatter
        type Aef = {}
        pub def format(formatter: TimeFormatter, x: LocalTime): String =
            let LocalTime.LocalTime(x1) = x;
            let formatter1 = ToJava.toJava(formatter);
            unsafe IO { x1.format(formatter1) }
    }

    instance TemporalParse[LocalTime] {
        type Formatter = TimeFormatter
        type Aef = {}
        pub def parse(formatter: TimeFormatter, s: String): Result[String, LocalTime] = 
            AdaptorExtras.opWithResult(formatter, formatter1 -> {
                let s1 = String.trim(s);
                unsafe IO { JLocalTime.parse(s1, formatter1) }
            })
    }

    // Constructors

    pub def localTime(hour: {hour = Int32}, minute: {minute = Int32}): LocalTime =
        let ans = unsafe IO { JLocalTime.of(hour#hour, minute#minute) };
        LocalTime(ans)

    pub def localTimeWithSecond(hour: {hour = Int32}, 
                                minute: {minute = Int32}, 
                                second: {second = Int32}): LocalTime =
        let ans = unsafe IO { JLocalTime.of(hour#hour, minute#minute, second#second) };
        LocalTime(ans)

    pub def localTimeWithSecondAndNano(hour: {hour = Int32}, 
                                        minute: {minute = Int32}, 
                                        second: {second = Int32}, 
                                        nanoSecond: {nanoSecond = Int32}): LocalTime =
        let ans = unsafe IO { JLocalTime.of(hour#hour, minute#minute, second#second, nanoSecond#nanoSecond) };
        LocalTime(ans)


    /// `now` and "abstract constructors" (e.g. `midnight`)

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): LocalTime \ IO = LocalTime(JLocalTime.now())


    ///
    /// ___
    ///
    pub def midnight(): LocalTime = LocalTime(unsafe IO { JLocalTime.MIDNIGHT })

    ///
    /// ___
    ///
    pub def noon(): LocalTime = LocalTime(unsafe IO { JLocalTime.NOON })


    // `from` functions

    pub def ofInstant(zone: ZoneId, x: InstantZ): LocalTime =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JLocalTime.ofInstant(x1, zone1) }
        )


    pub def ofNanoOfDay(nanoOfDay: Int64): LocalTime =
        AdaptorExtras.of(() -> unsafe IO { JLocalTime.ofNanoOfDay(nanoOfDay) })

    pub def ofSecondOfDay(secondOfDay: Int64): LocalTime =
        AdaptorExtras.of(() -> unsafe IO { JLocalTime.ofSecondOfDay(secondOfDay) })


    /// toX functions

    pub def toSecondOfDay(x: LocalTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toSecondOfDay() })

    pub def toNanoOfDay(x: LocalTime): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toNanoOfDay() })

    pub def toOffsetTime(offset: ZoneOffset, x: LocalTime): OffsetTime =
        AdaptorExtras.op2(offset, x, (offset1, x1) -> 
            unsafe IO { JOffsetTime.of(x1, offset1) }
        )

    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalTime, y: LocalTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalTime, y: LocalTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })


    pub def isAmOfDay(x: LocalTime): Bool =
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.get(JChronoField.AMPM_OF_DAY) } == 0
        )


    pub def isPmOfDay(x: LocalTime): Bool =
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.get(JChronoField.AMPM_OF_DAY) } == 1
        )

    // Getters and Setters

    pub def getHour(x: LocalTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getHour() })

    pub def withHour(hour: Int32, x: LocalTime): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withHour(hour) })

    pub def getMinute(x: LocalTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMinute() })

    pub def withMinute(minute: Int32, x: LocalTime): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMinute(minute) })

    pub def getSecond(x: LocalTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getSecond() })

    pub def withSecond(second: Int32, x: LocalTime): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withSecond(second) })

    pub def getNano(x: LocalTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getNano() })

    pub def withNano(nano: Int32, x: LocalTime): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withNano(nano) })

    // truncate functions


    pub def truncatedToHours(x: LocalTime): LocalTime =
        AdaptorExtras.op(x, x1 ->
            unsafe IO { x1.truncatedTo(JChronoUnit.HOURS) }
        )

    // plus / minus functions

    pub def plusHours(x: LocalTime, hours: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusHours(hours) })

    pub def minusHours(x: LocalTime, hours: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusHours(hours) })

    pub def plusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMinutes(minutes) })

    pub def minusMinutes(x: LocalTime, minutes: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMinutes(minutes) })

    pub def plusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusSeconds(seconds) })

    pub def minusSeconds(x: LocalTime, seconds: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusSeconds(seconds) })

    pub def plusNanos(x: LocalTime, nanos: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusNanos(nanos) })
        
    pub def minusNanos(x: LocalTime, nanos: Int64): LocalTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusNanos(nanos) })
    
    pub def plusDuration(x: LocalTime, d: DurationZ): LocalTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.addTo(x1) };
            unchecked_cast(t1 as JLocalTime)
        })

    pub def minusDuration(x: LocalTime, d: DurationZ): LocalTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.subtractFrom(x1) };
            unchecked_cast(t1 as JLocalTime)
        })


    // between / until functions

    pub def between(begin: {begin = LocalTime}, end: {end = LocalTime}): DurationZ =
        AdaptorExtras.op2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { JDuration.between(begin1, end1) }
        )



    pub def secondsUntil(begin: {begin = LocalTime}, end: {end = LocalTime}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.SECONDS) }
        )


    pub def minutesUntil(begin: {begin = LocalTime}, end: {end = LocalTime}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MINUTES) }
        )

    pub def hoursUntil(begin: {begin = LocalTime}, end: {end = LocalTime}): Int64 =
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.HOURS) }
        )


}
