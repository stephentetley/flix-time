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

    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;

    ///
    /// A wrapper around a Java OffsetDateTime.
    ///
    pub opaque type OffsetDateTime = ##java.time.OffsetDateTime

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[OffsetDateTime] {
        pub def toString(x: OffsetDateTime): String =
            import java.time.OffsetDateTime.toString(): String & Pure;
            let OffsetDateTime(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetDateTime] {
        pub def fromString(s: String): Option[OffsetDateTime] =
            import static java.time.OffsetDateTime.parse(##java.lang.CharSequence): ##java.time.OffsetDateTime & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(OffsetDateTime(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[OffsetDateTime] {
        pub def eq(x: OffsetDateTime, y: OffsetDateTime): Bool = Time/OffsetDateTime.equals(x, y)
    }

    instance Hash[OffsetDateTime] {
        pub def hash(x: OffsetDateTime): Int32 = Time/OffsetDateTime.hashCode(x)
    }

    instance Order[OffsetDateTime] {
        pub def compare(x: OffsetDateTime, y: OffsetDateTime): Comparison =
            Time/OffsetDateTime.compareTo(x,y) |> Comparison.fromInt32
    }

    instance LowerBound[OffsetDateTime] {
        pub def minValue(): OffsetDateTime =
            import static get java.time.OffsetDateTime.MIN: ##java.time.OffsetDateTime & Pure as getMIN;
            OffsetDateTime(getMIN())
    }

    instance UpperBound[OffsetDateTime] {
        pub def maxValue(): OffsetDateTime =
            import static get java.time.OffsetDateTime.MAX: ##java.time.OffsetDateTime & Pure as getMAX;
            OffsetDateTime(getMAX())
    }

    instance Boxable[OffsetDateTime]

    instance TemporalAccessor[OffsetDateTime] {
        pub def marshalToNativeTemporalAccessor(x: OffsetDateTime): ##java.time.temporal.TemporalAccessor =         
            Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): OffsetDateTime = 
            OffsetDateTime(x as ##java.time.OffsetDateTime)
    }

    instance Temporal[OffsetDateTime] {
        pub def marshalToNativeTemporal(x: OffsetDateTime): ##java.time.temporal.Temporal =         
            Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): OffsetDateTime = 
            OffsetDateTime(x as ##java.time.OffsetDateTime)
    }

    instance TemporalAdjuster[OffsetDateTime] {
        pub def marshalToNativeTemporalAdjuster(x: OffsetDateTime): ##java.time.temporal.TemporalAdjuster =         
            Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): OffsetDateTime = 
            OffsetDateTime(x as ##java.time.OffsetDateTime)
    }

}

namespace Time/OffsetDateTime {

    use Time.OffsetDateTime;
    use Time.OffsetDateTime.{OffsetDateTime};
    use Time/Format.DateTimeFormat;
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;
    use Time/Temporal.TemporalAmount;
    use Time/Temporal.TemporalField;
    use Time/Temporal.TemporalUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.DayOfWeek;
    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    
    pub def getOffsetDateTime(x: OffsetDateTime): ##java.time.OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        x1


    /// `fromTemporalAccessor` does not support all TemporalAccessor types
    pub def fromTemporalAccessor(x: a): Result[OffsetDateTime, String] with TemporalAccessor[a] = 
        import static java.time.OffsetDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetDateTime & Pure as fromTA;
        try {
            let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
            OffsetDateTime(fromTA(x1)) |> Ok
        } catch {
            case ex: ##java.lang.Exception => Err(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def offsetDateTime(r: {year :: Int32, month :: Int32, dayOfMonth :: Int32, hour :: Int32, minute :: Int32,
                    second :: Int32, nanoSecond :: Int32, offset :: ZoneOffset}): OffsetDateTime =
        import static java.time.OffsetDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32, Int32, ##java.time.ZoneOffset): ##java.time.OffsetDateTime & Pure;
        let ZoneOffset(o1) = r.offset;
        OffsetDateTime(of(r.year, r.month, r.dayOfMonth, r.hour, r.minute, r.second, r.nanoSecond, o1))




    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): OffsetDateTime & Impure =
        import static java.time.OffsetDateTime.now(): ##java.time.OffsetDateTime & Impure;
        OffsetDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetDateTime & Impure =
        import static java.time.OffsetDateTime.now(##java.time.ZoneId): ##java.time.OffsetDateTime & Impure;
        let ZoneId(z1) = zone;
        OffsetDateTime(now(z1))



    pub def atZoneSameInstant(zone: {zone :: ZoneId}, x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.atZoneSameInstant(##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone.zone;
        ZonedDateTime(atZoneSameInstant(x1, z1))

    pub def atZoneSimilarLocal(zone: {zone :: ZoneId}, x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.atZoneSimilarLocal(##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone.zone;
        ZonedDateTime(atZoneSimilarLocal(x1, z1))


    pub def fromLocalDateTime(offset: {offset :: ZoneOffset}, dateTime: LocalDateTime): OffsetDateTime =
        import static java.time.OffsetDateTime.of(##java.time.LocalDateTime, ##java.time.ZoneOffset): ##java.time.OffsetDateTime & Pure;
        let LocalDateTime(dt1) = dateTime;
        let ZoneOffset(o1) = offset.offset;
        OffsetDateTime(of(dt1, o1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        import java.time.OffsetDateTime.toLocalDateTime(): ##java.time.LocalDateTime & Pure;
        let OffsetDateTime(x1) = x;
        LocalDateTime(toLocalDateTime(x1))


    pub def fromLocalDateLocalTime(offset: {offset :: ZoneOffset}, date: LocalDate, time: LocalTime): OffsetDateTime =
        import static java.time.OffsetDateTime.of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneOffset): ##java.time.OffsetDateTime & Pure;
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneOffset(o1) = offset.offset;
        OffsetDateTime(of(d1, t1, o1))



    pub def toEpochSecond(x: OffsetDateTime): Int64 =
        import java.time.OffsetDateTime.toEpochSecond(): Int64 & Pure;
        let OffsetDateTime(x1) = x;
        toEpochSecond(x1)


    pub def toInstant(x: OffsetDateTime): ZInstant =
        import java.time.OffsetDateTime.toInstant(): ##java.time.Instant & Pure;
        let OffsetDateTime(x1) = x;
        ZInstant(toInstant(x1))


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        import java.time.OffsetDateTime.toLocalDate(): ##java.time.LocalDate & Pure;
        let OffsetDateTime(x1) = x;
        LocalDate(toLocalDate(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        import java.time.OffsetDateTime.toLocalTime(): ##java.time.LocalTime & Pure;
        let OffsetDateTime(x1) = x;
        LocalTime(toLocalTime(x1))


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        import java.time.OffsetDateTime.toOffsetTime(): ##java.time.OffsetTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetTime(toOffsetTime(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.toZonedDateTime(): ##java.time.ZonedDateTime & Pure;
        let OffsetDateTime(x1) = x;
        ZonedDateTime(toZonedDateTime(x1))



    ///
    /// Returns OffsetDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: OffsetDateTime): String =
        import java.time.OffsetDateTime.format(##java.time.format.DateTimeFormatter): String & Pure;
        let OffsetDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Option[OffsetDateTime] =
        import static java.time.OffsetDateTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.OffsetDateTime & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(OffsetDateTime(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.equals(##java.lang.Object): Bool & Pure;
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.hashCode(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        hashCode(x1)

    pub def compareTo(x: OffsetDateTime, y: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.compareTo(##java.time.OffsetDateTime): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        compareTo(x1, y1)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isBefore(##java.time.OffsetDateTime): Bool & Pure;
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isAfter(##java.time.OffsetDateTime): Bool & Pure;
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        isAfter(x1, y1)

    pub def plusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusYears(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusYears(x1, years))

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusYears(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusYears(x1, years))

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMonths(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusMonths(x1, months))

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMonths(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusMonths(x1, months))

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusWeeks(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusWeeks(x1, weeks))

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusWeeks(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusWeeks(x1, weeks))

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusDays(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusDays(x1, days))

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusDays(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusDays(x1, days))

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusHours(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusHours(x1, hours))

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusHours(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusHours(x1, hours))

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMinutes(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMinutes(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusSeconds(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusSeconds(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusNanos(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusNanos(x1, nanos))

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusNanos(Int64): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusNanos(x1, nanos))


    /// Get/Set...

    pub def getYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getYear(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getYear(x1)

    pub def setYear(year: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withYear(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withYear(x1, year))

    pub def getMonth(x: OffsetDateTime): Month =
        import java.time.OffsetDateTime.getMonth(): ##java.time.Month & Pure;
        let OffsetDateTime(x1) = x;
        Time/Month.unmarshal(getMonth(x1))

    pub def getMonthValue(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMonth(): ##java.time.Month & Pure;
        import java.time.Month.getValue(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getValue(getMonth(x1))

    pub def setMonth(month: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withMonth(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withMonth(x1, month))

    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfYear(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getDayOfYear(x1)

    pub def setDayOfYear(dayOfYear: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfYear(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withDayOfYear(x1, dayOfYear))

    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfMonth(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getDayOfMonth(x1)

    pub def setDayOfMonth(dayOfMonth: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfMonth(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfWeek(x: OffsetDateTime): DayOfWeek =
        import java.time.OffsetDateTime.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let OffsetDateTime(x1) = x;
        Time/DayOfWeek.unmarshal(getDayOfWeek(x1))

    pub def getHour(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getHour(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getHour(x1)

    pub def setHour(hour: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withHour(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withHour(x1, hour))

    pub def getMinute(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMinute(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getMinute(x1)

    pub def setMinute(minute: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withMinute(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withMinute(x1, minute))

    pub def getSecond(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getSecond(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getSecond(x1)

    pub def setSecond(second: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withSecond(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withSecond(x1, second))

    pub def getNano(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getNano(): Int32 & Pure;
        let OffsetDateTime(x1) = x;
        getNano(x1)

    pub def setNano(nano: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withNano(Int32): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withNano(x1, nano))

    pub def getOffset(x: OffsetDateTime): ZoneOffset =
        import java.time.OffsetDateTime.getOffset(): ##java.time.ZoneOffset & Pure;
        let OffsetDateTime(x1) = x;
        ZoneOffset(getOffset(x1))

    pub def setOffsetSameInstant(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withOffsetSameInstant(##java.time.ZoneOffset): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(withOffsetSameInstant(x1, o1))

    pub def setOffsetSameLocal(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withOffsetSameLocal(##java.time.ZoneOffset): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(withOffsetSameLocal(x1, o1))

    /// Generic

    pub def get(t: a, x: OffsetDateTime): Int32 with TemporalField[a] = 
        import java.time.OffsetDateTime.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getOffsetDateTime(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: OffsetDateTime): Int64 with TemporalField[a] = 
        import java.time.OffsetDateTime.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getOffsetDateTime(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

    pub def plus(x: OffsetDateTime, r: {amount :: Int64, temporalUnit :: a}): OffsetDateTime with TemporalUnit[a] =
        import java.time.OffsetDateTime.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.OffsetDateTime & Pure;         
        try {
            let OffsetDateTime(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            OffsetDateTime(plus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }
    
    pub def minus(x: OffsetDateTime, r: {amount :: Int64, temporalUnit :: a}): OffsetDateTime with TemporalUnit[a] =
        import java.time.OffsetDateTime.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.OffsetDateTime & Pure;         
        try {
            let OffsetDateTime(x1) = x;
            let temporalUnit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(r.temporalUnit);
            OffsetDateTime(minus(x1, r.amount, temporalUnit1))
        } catch {
            case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def plusTemporalAmount(x: OffsetDateTime, amount: a): OffsetDateTime with TemporalAmount[a] =
        import java.time.OffsetDateTime.plus(##java.time.temporal.TemporalAmount): ##java.time.OffsetDateTime & Pure;         
        try {
            let OffsetDateTime(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            OffsetDateTime(plus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusTemporalAmount(x: OffsetDateTime, amount: a): OffsetDateTime with TemporalAmount[a] =
        import java.time.OffsetDateTime.minus(##java.time.temporal.TemporalAmount): ##java.time.OffsetDateTime & Pure;         
        try {
            let OffsetDateTime(x1) = x;
            let amount1 = Time/Temporal/TemporalAmount.marshalToNativeTemporalAmount(amount);
            OffsetDateTime(minus(x1, amount1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def range(field: a, x: OffsetDateTime): ValueRange with TemporalField[a] =
        import java.time.OffsetDateTime.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let OffsetDateTime(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def truncatedTo(unit: a, x: OffsetDateTime): OffsetDateTime with TemporalUnit[a] = 
        import java.time.OffsetDateTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.OffsetDateTime & Pure;
        let OffsetDateTime(x1) = x;
        let unit1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(unit);
        OffsetDateTime(truncatedTo(x1, unit1))

    pub def until(units: t, r: {start :: OffsetDateTime, end :: a}): Int64 with TemporalUnit[t], Temporal[a] = 
        import java.time.OffsetDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getOffsetDateTime(r.start);
        let e1 = Time/Temporal/Temporal.marshalToNativeTemporal(r.end);
        let units1 = Time/Temporal/TemporalUnit.marshalToNativeTemporalUnit(units);
        until(b1, e1, units1)



    pub def withTemporalAdjuster(adj: a, x: OffsetDateTime): OffsetDateTime with TemporalAdjuster[a] =
        import java.time.OffsetDateTime.with(##java.time.temporal.TemporalAdjuster): ##java.time.OffsetDateTime & Pure as withTA;         
        try {
            let OffsetDateTime(x1) = x;
            let adj1 = Time/Temporal/TemporalAdjuster.marshalToNativeTemporalAdjuster(adj);
            OffsetDateTime(withTA(x1, adj1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withTemporalField(field: a, i: Int64, x: OffsetDateTime): OffsetDateTime with TemporalField[a] =
        import java.time.OffsetDateTime.with(##java.time.temporal.TemporalField, Int64): ##java.time.OffsetDateTime & Pure as withTF;         
        try {
            let OffsetDateTime(x1) = x;
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            OffsetDateTime(withTF(x1, field1, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


}
