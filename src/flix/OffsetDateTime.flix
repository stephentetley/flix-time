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
    /// A wrapper around a Java OffsetDateTime.
    ///
    pub opaque type OffsetDateTime = ##java.time.OffsetDateTime

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[OffsetDateTime] {
        pub def toString(x: OffsetDateTime): String =
            import java.time.OffsetDateTime.toString();
            let OffsetDateTime(x1) = x;
            toString(x1) as & Pure
    }

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    instance FromString[OffsetDateTime] {
        pub def fromString(s: String): Option[OffsetDateTime] =
            import java.lang.String.strip();
            import java.time.OffsetDateTime:parse(##java.lang.CharSequence);
            try {
                let cs = strip(s) as ##java.lang.CharSequence & Pure;
                Some(OffsetDateTime(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[OffsetDateTime] {
        pub def eq(x: OffsetDateTime, y: OffsetDateTime): Bool = Time/OffsetDateTime.equals(x, y)
    }

    instance Hash[OffsetDateTime] {
        pub def hash(x: OffsetDateTime): Int = Time/OffsetDateTime.hashCode(x)
    }

    instance Order[OffsetDateTime] {
        pub def compare(x: OffsetDateTime, y: OffsetDateTime): Comparison = match Time/OffsetDateTime.compareTo(x,y) {
            case n if n < 0 => LessThan
            case n if n == 0 => EqualTo
            case _ => GreaterThan
        }
    }

    instance LowerBound[OffsetDateTime] {
        pub def minValue(): OffsetDateTime =
            import get java.time.OffsetDateTime:MIN as getMIN;
            OffsetDateTime(getMIN()) as & Pure
    }
    
    instance UpperBound[OffsetDateTime] {
        pub def maxValue(): OffsetDateTime =
            import get java.time.OffsetDateTime:MAX as getMAX;
            OffsetDateTime(getMAX()) as & Pure
    }

    instance Boxable[OffsetDateTime] {
        pub def box(x: OffsetDateTime): Boxed = {
            let OffsetDateTime(x1) = x;
            let value = x1 as ##java.lang.Object;
            let compare = (o1, o2) -> Order.compare(OffsetDateTime(o1 as ##java.time.OffsetDateTime), OffsetDateTime(o2 as ##java.time.OffsetDateTime));
            let toString = o -> ToString.toString(OffsetDateTime(o as ##java.time.OffsetDateTime));
            BoxedObject(value, compare, toString)
        }
        pub def unbox(x: Boxed): OffsetDateTime = match x {
            case BoxedObject(v, _, _) => OffsetDateTime(v as ##java.time.OffsetDateTime)
            case _                    => ?bug
        }
    }

}

namespace Time/OffsetDateTime {

    use Time.OffsetDateTime;
    use Time.OffsetDateTime.{OffsetDateTime};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time/Temporal.ChronoUnit;
    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(x: {year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, 
                    second: Int32, nanoSecond: Int32, offset: ZoneOffset}): OffsetDateTime =
        import java.time.OffsetDateTime:of(Int32, Int32, Int32, Int32, Int32, Int32, Int32, ##java.time.ZoneOffset);
        let ZoneOffset(o1) = x.offset;
        OffsetDateTime(of(x.year, x.month, x.dayOfMonth, x.hour, x.minute, x.second, x.nanoSecond, o1)) as & Pure


    pub def getFields(x: OffsetDateTime): {year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, 
                                            second: Int32, nanoSecond: Int32, offset: ZoneOffset} =
        { year = x.getYear(), month = x.getMonth(), dayOfMonth = x.getDayOfMonth()
        , hour = x.getHour(), minute = x.getMinute(), second = x.getSecond()
        , nanoSecond = x.getNano(), offset = x.getOffset() }
    

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): OffsetDateTime & Impure =
        import java.time.OffsetDateTime:now();
        OffsetDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetDateTime & Impure =
        import java.time.OffsetDateTime:now(##java.time.ZoneId);
        let ZoneId(z1) = zone;
        OffsetDateTime(now(z1))



    pub def atZoneSameInstant(x: OffsetDateTime, zoneId: ZoneId): ZonedDateTime = 
        import java.time.OffsetDateTime.atZoneSameInstant(##java.time.ZoneId);
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zoneId;
        ZonedDateTime(atZoneSameInstant(x1, z1)) as & Pure
    
    pub def atZoneSimilarLocal(x: OffsetDateTime, zoneId: ZoneId): ZonedDateTime = 
        import java.time.OffsetDateTime.atZoneSimilarLocal(##java.time.ZoneId);
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zoneId;
        ZonedDateTime(atZoneSimilarLocal(x1, z1)) as & Pure
    

    pub def ofLocalDateTime(dateTime: LocalDateTime, offset: ZoneOffset): OffsetDateTime =
        import java.time.OffsetDateTime:of(##java.time.LocalDateTime, ##java.time.ZoneOffset);
        let LocalDateTime(dt1) = dateTime;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(of(dt1, o1)) as & Pure

    pub def ofLocalDateLocalTime(date: LocalDate, time: LocalTime, offset: ZoneOffset): OffsetDateTime =
        import java.time.OffsetDateTime:of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneOffset);
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(of(d1, t1, o1)) as & Pure

    pub def toEpochSecond(x: OffsetDateTime): Int64 =
        import java.time.OffsetDateTime.toEpochSecond();
        let OffsetDateTime(x1) = x;
        toEpochSecond(x1) as & Pure

    pub def toInstant(x: OffsetDateTime): Instant =
        import java.time.OffsetDateTime.toInstant();
        let OffsetDateTime(x1) = x;
        Instant(toInstant(x1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        import java.time.OffsetDateTime.toLocalDate();
        let OffsetDateTime(x1) = x;
        LocalDate(toLocalDate(x1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        import java.time.OffsetDateTime.toLocalTime();
        let OffsetDateTime(x1) = x;
        LocalTime(toLocalTime(x1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        import java.time.OffsetDateTime.toLocalDateTime();
        let OffsetDateTime(x1) = x;
        LocalDateTime(toLocalDateTime(x1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        import java.time.OffsetDateTime.toOffsetTime();
        let OffsetDateTime(x1) = x;
        OffsetTime(toOffsetTime(x1)) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.toZonedDateTime();
        let OffsetDateTime(x1) = x;
        ZonedDateTime(toZonedDateTime(x1)) as & Pure



    ///
    /// Returns OffsetDateTime `x` as a String using `formatter`.
    ///
    pub def format(x: OffsetDateTime, formatter: DateTimeFormatter): String =
        import java.time.OffsetDateTime.format(##java.time.format.DateTimeFormatter);
        let OffsetDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr) as & Pure

    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(s: String, formatter: DateTimeFormatter): Option[OffsetDateTime] =
        import java.lang.String.strip();
        import java.time.OffsetDateTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = strip(s) as ##java.lang.CharSequence & Pure;
            Some(OffsetDateTime(parse(cs, fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.equals(##java.lang.Object);
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: OffsetDateTime): Int32 = 
        import java.time.OffsetDateTime.hashCode();
        let OffsetDateTime(x1) = x;
        hashCode(x1) as & Pure

    pub def compareTo(x: OffsetDateTime, y: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.compareTo(##java.time.OffsetDateTime);
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        compareTo(x1, y1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isBefore(##java.time.OffsetDateTime);
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        isBefore(x1, y1) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isAfter(##java.time.OffsetDateTime);
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        isAfter(x1, y1) as & Pure

    pub def plusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusYears(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, years)) as & Pure

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusYears(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, years)) as & Pure

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMonths(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, months)) as & Pure

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMonths(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, months)) as & Pure

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusWeeks(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, weeks)) as & Pure

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusWeeks(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, weeks)) as & Pure

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusDays(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, days)) as & Pure

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusDays(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, days)) as & Pure

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusHours(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, hours)) as & Pure

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusHours(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, hours)) as & Pure

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMinutes(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, minutes)) as & Pure

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMinutes(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, minutes)) as & Pure

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusSeconds(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, seconds)) as & Pure

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusSeconds(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, seconds)) as & Pure

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusNanos(Int64) as plus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plus(x1, nanos)) as & Pure

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusNanos(Int64) as minus;
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minus(x1, nanos)) as & Pure

    pub def getYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getYear();
        let OffsetDateTime(x1) = x;
        getYear(x1) as & Pure

    pub def putYear(x: OffsetDateTime, year: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withYear(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withYear(x1, year)) as & Pure

    /// TODO - probably Month is worth an enum
    /// Current we use 1 (January) - 12 (December)
    pub def getMonth(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMonth();
        import java.time.Month.getValue();
        let OffsetDateTime(x1) = x;
        getValue(getMonth(x1)) as & Pure

    pub def putMonth(x: OffsetDateTime, month: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withMonth(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withMonth(x1, month)) as & Pure

    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfYear();
        let OffsetDateTime(x1) = x;
        getDayOfYear(x1) as & Pure

    pub def putDayOfYear(x: OffsetDateTime, dayOfYear: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfYear(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withDayOfYear(x1, dayOfYear)) as & Pure

    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfMonth();
        let OffsetDateTime(x1) = x;
        getDayOfMonth(x1) as & Pure

    pub def putDayOfMonth(x: OffsetDateTime, dayOfMonth: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfMonth(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withDayOfMonth(x1, dayOfMonth)) as & Pure

    /// TODO - probably should marshal to DayOfWeek
    /// Current we use 1 (Monday) - 7 (Sunday)
    pub def getDayOfWeek(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfWeek();
        import java.time.DayOfWeek.getValue();
        let OffsetDateTime(x1) = x;
        getValue(getDayOfWeek(x1)) as & Pure

    pub def getHour(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getHour();
        let OffsetDateTime(x1) = x;
        getHour(x1) as & Pure

    pub def putHour(x: OffsetDateTime, hour: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withHour(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withHour(x1, hour)) as & Pure

    pub def getMinute(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMinute();
        let OffsetDateTime(x1) = x;
        getMinute(x1) as & Pure

    pub def putMinute(x: OffsetDateTime, minute: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withMinute(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withMinute(x1, minute)) as & Pure

    pub def getSecond(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getSecond();
        let OffsetDateTime(x1) = x;
        getSecond(x1) as & Pure

    pub def putSecond(x: OffsetDateTime, second: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withSecond(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withSecond(x1, second)) as & Pure

    pub def getNano(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getNano();
        let OffsetDateTime(x1) = x;
        getNano(x1) as & Pure

    pub def putNano(x: OffsetDateTime, nano: Int32): OffsetDateTime =
        import java.time.OffsetDateTime.withNano(Int32);
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withNano(x1, nano)) as & Pure

    pub def getOffset(x: OffsetDateTime): ZoneOffset =
        import java.time.OffsetDateTime.getOffset();
        let OffsetDateTime(x1) = x;
        ZoneOffset(getOffset(x1)) as & Pure

    pub def putOffsetSameInstant(x: OffsetDateTime, offset: ZoneOffset): OffsetDateTime = 
        import java.time.OffsetDateTime.withOffsetSameInstant(##java.time.ZoneOffset);
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(withOffsetSameInstant(x1, o1)) as & Pure
    
    pub def putOffsetSameLocal(x: OffsetDateTime, offset: ZoneOffset): OffsetDateTime = 
        import java.time.OffsetDateTime.withOffsetSameLocal(##java.time.ZoneOffset);
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(withOffsetSameLocal(x1, o1)) as & Pure

    pub def until(b: OffsetDateTime, e: OffsetDateTime, unit: ChronoUnit): Int64 = 
        import java.time.OffsetDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit);
        let OffsetDateTime(b1) = b;
        let OffsetDateTime(e1) = e;
        let u1 = Time/Temporal/ChronoUnit.marshal(unit);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        until(b1, te1, tu1) as & Pure


}
