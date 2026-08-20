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



pub mod InteropTime.OffsetTime {

    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TemporalFormat
    use InteropTime.Format.TemporalParse
    use InteropTime.Format.TimeFormatter
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ
    use InteropTime.LocalTime.LocalTime
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.ZoneId.ZoneId
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneOffset.ZoneOffset
    
    import java.lang.{Object, CharSequence}
    import java.time.{Duration => JDuration}
    import java.time.{OffsetTime => JOffsetTime}
    import java.time.{ZoneId => JZoneId}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java OffsetTime.
    ///
    pub enum OffsetTime(JOffsetTime)


    ///
    /// Returns the given time `x` as a string using __.
    ///
    instance ToString[OffsetTime] {
        pub def toString(x: OffsetTime): String =
            let OffsetTime.OffsetTime(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as a OffsetTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetTime] {
        pub def fromString(s: String): Option[OffsetTime] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JOffsetTime.parse(s1) };
                Some(OffsetTime.OffsetTime(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[OffsetTime] {
        pub def eq(x: OffsetTime, y: OffsetTime): Bool =
            let OffsetTime.OffsetTime(x1) = x;
            let OffsetTime.OffsetTime(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[OffsetTime] {
        pub def hash(x: OffsetTime): Int32 =
            let OffsetTime.OffsetTime(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[OffsetTime] {
        pub def compare(x: OffsetTime, y: OffsetTime): Comparison =
            let OffsetTime.OffsetTime(x1) = x;
            let OffsetTime.OffsetTime(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance ToJava[OffsetTime] {
        type Out = JOffsetTime
        pub def toJava(x: OffsetTime): JOffsetTime = 
            let OffsetTime.OffsetTime(x1) = x;
            x1
    }

    instance ToFlix[OffsetTime] {
        type In = JOffsetTime
        pub def toFlix(x: JOffsetTime): OffsetTime = 
            OffsetTime.OffsetTime(x)
    }
 
    instance TemporalFormat[OffsetTime] {
        type Formatter = TimeFormatter
        type Aef = {}
        pub def format(formatter: TimeFormatter, x: OffsetTime): String =
            let OffsetTime.OffsetTime(x1) = x;
            let formatter1 = ToJava.toJava(formatter);
            unsafe IO { x1.format(formatter1) }
    }

    instance TemporalParse[OffsetTime] {
        type Formatter = TimeFormatter
        type Aef = {}
        pub def parse(formatter: TimeFormatter, s: String): Result[String, OffsetTime] = 
            AdaptorExtras.opWithResult(formatter, formatter1 -> {
                let s1 = String.trim(s);
                unsafe IO { JOffsetTime.parse(s1, formatter1) }
            })
    }

    /// Constructors

    pub def offsetTime(hour: {hour = Int32}, 
                        minute: {minute = Int32}, 
                        second: {second = Int32}, 
                        nanoSecond: {nanoSecond = Int32}, 
                        offset: ZoneOffset): OffsetTime =
        AdaptorExtras.op(offset, offset1 -> 
            unsafe IO { JOffsetTime.of(hour#hour, 
                                        minute#minute, 
                                        second#second, 
                                        nanoSecond#nanoSecond, 
                                        offset1) }
        )

    /// `now` and "abstract constructors" if any

    ///
    /// Returns the current time from the system clock.
    ///
    pub def now(): OffsetTime \ IO = 
        AdaptorExtras.of(() -> JOffsetTime.now())

    ///
    /// Returns the current time from the system clock.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetTime \ IO =
        AdaptorExtras.op(zone, zone1 -> JOffsetTime.now(zone1))

    /// `from` functions

    pub def fromLocalTime(offset: ZoneOffset, x: LocalTime): OffsetTime =
        AdaptorExtras.op2(offset, x, (offset1, x1) -> 
            unsafe IO { JOffsetTime.of(x1, offset1) }
        )


    pub def ofInstant(zone: ZoneId, x: InstantZ): OffsetTime =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> 
            unsafe IO { JOffsetTime.ofInstant(x1, zone1) }
        )



    /// `fromTemporalAccessor` specialized


    pub def fromOffsetDateTime(x: OffsetDateTime): OffsetTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JOffsetTime.$from(x1) })

    pub def fromZonedDateTime(x: ZonedDateTime): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { JOffsetTime.$from(x1) }) 



    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetTime, y: OffsetTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetTime, y: OffsetTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    pub def isInstantEqual(x: OffsetTime, y: OffsetTime): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isEqual(y1) })

    pub def isAmOfDay(x: OffsetTime): Bool = 
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.get(JChronoField.AMPM_OF_DAY) == 0 }
        )


    pub def isPmOfDay(x: OffsetTime): Bool = 
        AdaptorExtras.extract(x, x1 ->
            unsafe IO { x1.get(JChronoField.AMPM_OF_DAY) == 1 }
        )

    /// Getters and Setters

    pub def getZoneId(x: OffsetTime): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })

    pub def getHour(x: OffsetTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getHour() })

    pub def withHour(hour: Int32, x: OffsetTime): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withHour(hour) })

    pub def getMinute(x: OffsetTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMinute() })

    pub def withMinute(minute: Int32, x: OffsetTime): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMinute(minute) })

    pub def getSecond(x: OffsetTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getSecond() })

    pub def withSecond(second: Int32, x: OffsetTime): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withSecond(second) })

    pub def getNano(x: OffsetTime): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getNano() })

    pub def withNano(nano: Int32, x: OffsetTime): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withNano(nano) })

    pub def getOffset(x: OffsetTime): ZoneOffset =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getOffset() })

    pub def withOffsetSameInstant(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        AdaptorExtras.op2(x, offset, (x1, offset1)-> 
            unsafe IO { x1.$withOffsetSameInstant(offset1) }
        )

    pub def withOffsetSameLocal(x: OffsetTime, offset: ZoneOffset): OffsetTime =
        AdaptorExtras.op2(x, offset, (x1, offset1)-> 
            unsafe IO { x1.$withOffsetSameLocal(offset1) }
        )

    pub def adjustLocalTime(lt: LocalTime, x: OffsetTime): OffsetTime = 
        AdaptorExtras.op2(lt, x, (lt1, x1) -> {
            let t1 = unsafe IO { lt1.adjustInto(x1) };
            unchecked_cast(t1 as JOffsetTime)
        })

    // truncate functions

    pub def truncatedToHours(x: OffsetTime): OffsetTime = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.truncatedTo(JChronoUnit.HOURS) })

    // plus / minus functions

    pub def plusHours(x: OffsetTime, hours: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusHours(hours) })

    pub def minusHours(x: OffsetTime, hours: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusHours(hours) })

    pub def plusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMinutes(minutes) })

    pub def minusMinutes(x: OffsetTime, minutes: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMinutes(minutes) })

    pub def plusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusSeconds(seconds) })

    pub def minusSeconds(x: OffsetTime, seconds: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusSeconds(seconds) })

    pub def plusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusNanos(nanos) })

    pub def minusNanos(x: OffsetTime, nanos: Int64): OffsetTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusNanos(nanos) })


    pub def plusDuration(x: OffsetTime, d: DurationZ): OffsetTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.addTo(x1) };
            unchecked_cast(t1 as JOffsetTime)
        })
    
    pub def minusDuration(x: OffsetTime, d: DurationZ): OffsetTime =
        AdaptorExtras.op2(x, d, (x1, d1) -> {
            let t1 = unsafe IO { d1.subtractFrom(x1) };
            unchecked_cast(t1 as JOffsetTime)   
        })


    // between / until functions
    
    pub def between(begin: {begin = OffsetTime}, end: {end = OffsetTime}): DurationZ =
        AdaptorExtras.op2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { JDuration.between(begin1, end1) }
        )


    pub def secondsUntil(begin: {begin = OffsetTime}, end: {end = OffsetTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.SECONDS) }
        )


    pub def minutesUntil(begin: {begin = OffsetTime}, end: {end = OffsetTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MINUTES) }
        )

    pub def hoursUntil(begin: {begin = OffsetTime}, end: {end = OffsetTime}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.HOURS) }
        )

}

