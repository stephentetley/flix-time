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
    /// A wrapper around a Java LocalDateTime.
    ///
    pub opaque type LocalDateTime = ##java.time.LocalDateTime

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[LocalDateTime] {
        pub def toString(x: LocalDateTime): String =
            import java.time.LocalDateTime.toString();
            let LocalDateTime(x1) = x;
            x1.toString() as & Pure
    }

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ISO-8601 extended offset date-time format.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDateTime] {
        pub def fromString(s: String): Option[LocalDateTime] =
            import java.lang.String.strip();
            import java.time.LocalDateTime:parse(##java.lang.CharSequence);
            try {
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(LocalDateTime(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[LocalDateTime] {
        pub def eq(x: LocalDateTime, y: LocalDateTime): Bool =
            import java.time.LocalDateTime.equals(##java.lang.Object);
            let LocalDateTime(x1) = x;
            let LocalDateTime(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure
        
        pub def neq(x: LocalDateTime, y: LocalDateTime): Bool = not (x == y)
    }

    instance Hash[LocalDateTime] {
        pub def hash(x: LocalDateTime): Int = Time/LocalDateTime.hashCode(x)
    }

    instance Order[LocalDateTime] {
        pub def less(x: LocalDateTime, y: LocalDateTime): Bool = Time/LocalDateTime.compareTo(x,y) < 0
        pub def lessEqual(x: LocalDateTime, y: LocalDateTime): Bool = Time/LocalDateTime.compareTo(x,y) < 0 or x == y
        pub def greater(x: LocalDateTime, y: LocalDateTime): Bool = Time/LocalDateTime.compareTo(x,y) > 0
        pub def greaterEqual(x: LocalDateTime, y: LocalDateTime): Bool = Time/LocalDateTime.compareTo(x,y) > 0 or x == y
        pub def compare(x: LocalDateTime, y: LocalDateTime): Comparison = match Time/LocalDateTime.compareTo(x,y) {
            case x if x < 0 => LessThan
            case x if x == 0 => EqualTo
            case _ => GreaterThan
        }
    }

    instance LowerBound[LocalDateTime] {
        pub def minValue(): LocalDateTime =
            import get java.time.LocalDateTime:MIN as getMIN;
            LocalDateTime(getMIN()) as & Pure
    }
    
    instance UpperBound[LocalDateTime] {
        pub def maxValue(): LocalDateTime =
            import get java.time.LocalDateTime:MAX as getMAX;
            LocalDateTime(getMAX()) as & Pure
    }

}

namespace Time/LocalDateTime {

    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time/Temporal.ChronoUnit;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(x: {year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32}): LocalDateTime =
        import java.time.LocalDateTime:of(Int32, Int32, Int32, Int32, Int32);
        LocalDateTime(of(x.year, x.month, x.dayOfMonth, x.hour, x.minute)) as & Pure

    pub def newWithSecond(x: {year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32}): LocalDateTime =
        import java.time.LocalDateTime:of(Int32, Int32, Int32, Int32, Int32, Int32);
        LocalDateTime(of(x.year, x.month, x.dayOfMonth, x.hour, x.minute, x.second)) as & Pure

    pub def newWithSecondAndNano(x: {year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32}): LocalDateTime =
        import java.time.LocalDateTime:of(Int32, Int32, Int32, Int32, Int32, Int32, Int32);
        LocalDateTime(of(x.year, x.month, x.dayOfMonth, x.hour, x.minute, x.second, x.nanoSecond)) as & Pure

    pub def getFields(x: LocalDateTime): {year: Int32, month: Int32, dayOfMonth: Int32, hour: Int32, minute: Int32, second: Int32, nanoSecond: Int32} = 
        { year = x.getYear(), month = x.getMonth(), dayOfMonth = x.getDayOfMonth()
        , hour = x.getHour(), minute = x.getMinute(), second = x.getSecond()
        , nanoSecond = x.getNano() }

    ///
    /// Returns the current date-time from the system clock.
    ///
    pub def now(): LocalDateTime & Impure =
        import java.time.LocalDateTime:now();
        LocalDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): LocalDateTime & Impure =
        import java.time.LocalDateTime:now(##java.time.ZoneId);
        let ZoneId(z) = zone;
        LocalDateTime(now(z))



    pub def fromLocalDateLocalTime(d: LocalDate, t: LocalTime): LocalDateTime =
        import java.time.LocalDateTime:of(##java.time.LocalDate, ##java.time.LocalTime);
        let LocalDate(d1) = d;
        let LocalTime(t1) = t;
        LocalDateTime(of(d1, t1)) as & Pure

    pub def fromEpochSecond(epochSecond: Int64, nanoOfSecond: Int32, offset: ZoneOffset): LocalDateTime = 
        import java.time.LocalDateTime:ofEpochSecond(Int64, Int32, ##java.time.ZoneOffset);
        let ZoneOffset(o1) = offset;
        LocalDateTime(ofEpochSecond(epochSecond, nanoOfSecond, o1)) as & Pure

    pub def fromInstant(x: Instant, zoneId: ZoneId): LocalDateTime = 
        import java.time.LocalDateTime:ofInstant(##java.time.Instant, ##java.time.ZoneId);
        let Instant(x1) = x;
        let ZoneId(z1) = zoneId;
        LocalDateTime(x1.ofInstant(z1)) as & Pure


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: LocalDateTime): LocalDate =
        import java.time.LocalDateTime.toLocalDate();
        let LocalDateTime(x1) = x;
        LocalDate(x1.toLocalDate()) as & Pure

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: LocalDateTime): LocalTime =
        import java.time.LocalDateTime.toLocalTime();
        let LocalDateTime(x1) = x;
        LocalTime(x1.toLocalTime()) as & Pure



    ///
    /// Returns LocalDateTime `x` as a String using `formatter`.
    ///
    pub def format(x: LocalDateTime, formatter: DateTimeFormatter): String =
        import java.time.LocalDateTime.format(##java.time.format.DateTimeFormatter);
        let LocalDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure

    ///
    /// Parse the string `s` as a LocalDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(s: String, formatter: DateTimeFormatter): Option[LocalDateTime] =
        import java.lang.String.strip();
        import java.time.LocalDateTime:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(LocalDateTime(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }


    pub def hashCode(x: LocalDateTime): Int32 = 
        import java.time.LocalDateTime.hashCode();
        let LocalDateTime(x1) = x;
        hashCode(x1) as & Pure

    pub def compareTo(x: LocalDateTime, y: LocalDateTime): Int32 =
        import java.time.LocalDateTime.compareTo(##java.time.chrono.ChronoLocalDateTime);
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        let cy1 = y1 as ##java.time.chrono.ChronoLocalDateTime;
        x1.compareTo(cy1) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isBefore(##java.time.chrono.ChronoLocalDateTime);
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        x1.isBefore(y1 as ##java.time.chrono.ChronoLocalDateTime) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDateTime, y: LocalDateTime): Bool =
        import java.time.LocalDateTime.isAfter(##java.time.chrono.ChronoLocalDateTime);
        let LocalDateTime(x1) = x;
        let LocalDateTime(y1) = y;
        x1.isAfter(y1 as ##java.time.chrono.ChronoLocalDateTime) as & Pure

    pub def plusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusYears(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(years)) as & Pure

    pub def minusYears(x: LocalDateTime, years: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusYears(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(years)) as & Pure

    pub def plusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMonths(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(months)) as & Pure

    pub def minusMonths(x: LocalDateTime, months: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMonths(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(months)) as & Pure

    pub def plusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusWeeks(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(weeks)) as & Pure

    pub def minusWeeks(x: LocalDateTime, weeks: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusWeeks(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(weeks)) as & Pure

    pub def plusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusDays(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(days)) as & Pure

    pub def minusDays(x: LocalDateTime, days: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusDays(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(days)) as & Pure

    pub def plusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusHours(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(hours)) as & Pure

    pub def minusHours(x: LocalDateTime, hours: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusHours(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(hours)) as & Pure

    pub def plusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusMinutes(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(minutes)) as & Pure

    pub def minusMinutes(x: LocalDateTime, minutes: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusMinutes(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(minutes)) as & Pure

    pub def plusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusSeconds(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(seconds)) as & Pure

    pub def minusSeconds(x: LocalDateTime, seconds: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusSeconds(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(seconds)) as & Pure

    pub def plusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.plusNanos(Int64) as plus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.plus(nanos)) as & Pure

    pub def minusNanos(x: LocalDateTime, nanos: Int64): LocalDateTime =
        import java.time.LocalDateTime.minusNanos(Int64) as minus;
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.minus(nanos)) as & Pure

    pub def getYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getYear();
        let LocalDateTime(x1) = x;
        x1.getYear() as & Pure

    pub def putYear(x: LocalDateTime, year: Int32): LocalDateTime =
        import java.time.LocalDateTime.withYear(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withYear(year)) as & Pure

    pub def getMonth(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMonth();
        import java.time.Month.getValue();
        let LocalDateTime(x1) = x;
        x1.getMonth().getValue() as & Pure

    pub def putMonth(x: LocalDateTime, month: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMonth(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withMonth(month)) as & Pure

    pub def getDayOfYear(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfYear();
        let LocalDateTime(x1) = x;
        x1.getDayOfYear() as & Pure

    pub def putDayOfYear(x: LocalDateTime, dayOfYear: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfYear(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withDayOfYear(dayOfYear)) as & Pure

    pub def getDayOfMonth(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfMonth();
        let LocalDateTime(x1) = x;
        x1.getDayOfMonth() as & Pure

    pub def putDayOfMonth(x: LocalDateTime, dayOfMonth: Int32): LocalDateTime =
        import java.time.LocalDateTime.withDayOfMonth(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withDayOfMonth(dayOfMonth)) as & Pure

    pub def getDayOfWeek(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getDayOfWeek();
        import java.time.DayOfWeek.getValue();
        let LocalDateTime(x1) = x;
        x1.getDayOfWeek().getValue() as & Pure

    pub def getHour(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getHour();
        let LocalDateTime(x1) = x;
        x1.getHour() as & Pure

    pub def putHour(x: LocalDateTime, hour: Int32): LocalDateTime =
        import java.time.LocalDateTime.withHour(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withHour(hour)) as & Pure

    pub def getMinute(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getMinute();
        let LocalDateTime(x1) = x;
        x1.getMinute() as & Pure

    pub def putMinute(x: LocalDateTime, minute: Int32): LocalDateTime =
        import java.time.LocalDateTime.withMinute(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withMinute(minute)) as & Pure

    pub def getSecond(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getSecond();
        let LocalDateTime(x1) = x;
        x1.getSecond() as & Pure

    pub def putSecond(x: LocalDateTime, second: Int32): LocalDateTime =
        import java.time.LocalDateTime.withSecond(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withSecond(second)) as & Pure

    pub def getNano(x: LocalDateTime): Int32 =
        import java.time.LocalDateTime.getNano();
        let LocalDateTime(x1) = x;
        x1.getNano() as & Pure

    pub def putNano(x: LocalDateTime, nano: Int32): LocalDateTime =
        import java.time.LocalDateTime.withNano(Int32);
        let LocalDateTime(x1) = x;
        LocalDateTime(x1.withNano(nano)) as & Pure

    pub def until(b: LocalDateTime, e: LocalDateTime, unit: ChronoUnit): Int64 = 
        import java.time.LocalDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit);
        let LocalDateTime(b1) = b;
        let LocalDateTime(e1) = e;
        let u1 = Time/Temporal/ChronoUnit.marshal(unit);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        b1.until(te1, tu1) as & Pure

}
