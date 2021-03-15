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
    /// A wrapper around a Java LocalDate.
    ///
    pub opaque type LocalDate = ##java.time.LocalDate

    ///
    /// Returns the given date `x` as a string using the Java builtin toString method.
    ///
    instance ToString[LocalDate] {
        pub def toString(x: LocalDate): String =
            import java.time.LocalDate.toString();
            let LocalDate(t) = x;
            t.toString() as & Pure
    }

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDate] {
        pub def fromString(s: String): Option[LocalDate] =
            import java.lang.String.strip();
            import java.time.LocalDate:parse(##java.lang.CharSequence);
            try {        
                let cs = s.strip() as ##java.lang.CharSequence & Pure;
                Some(LocalDate(parse(cs))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[LocalDate] {
        pub def eq(x: LocalDate, y: LocalDate): Bool =
            import java.time.LocalDate.equals(##java.lang.Object);
            let LocalDate(x1) = x;
            let LocalDate(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure

        pub def neq(x: LocalDate, y: LocalDate): Bool = not (x == y)
    }

    instance Hash[LocalDate] {
        pub def hash(x: LocalDate): Int = Time/LocalDate.hashCode(x)
    }


    instance Order[LocalDate] {
        pub def less(x: LocalDate, y: LocalDate): Bool = Time/LocalDate.compareTo(x,y) < 0
        pub def lessEqual(x: LocalDate, y: LocalDate): Bool = Time/LocalDate.compareTo(x,y) < 0 or x == y
        pub def greater(x: LocalDate, y: LocalDate): Bool = Time/LocalDate.compareTo(x,y) > 0
        pub def greaterEqual(x: LocalDate, y: LocalDate): Bool = Time/LocalDate.compareTo(x,y) > 0 or x == y
        pub def compare(x: LocalDate, y: LocalDate): Comparison = match Time/LocalDate.compareTo(x,y) {
            case n if n < 0 => LessThan
            case n if n == 0 => EqualTo
            case _ => GreaterThan
        }
    }

    instance LowerBound[LocalDate] {
        pub def minValue(): LocalDate =
            import get java.time.LocalDate:MIN as getMIN;
            LocalDate(getMIN()) as & Pure
    }

    instance UpperBound[LocalDate] {
        pub def maxValue(): LocalDate =
            import get java.time.LocalDate:MAX as getMAX;
            LocalDate(getMAX()) as & Pure
    }

}

namespace Time/LocalDate {

    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time/Chrono.HijrahDate;
    use Time/Chrono.HijrahDate.{HijrahDate};
    use Time/Chrono.JapaneseDate;
    use Time/Chrono.JapaneseDate.{JapaneseDate};
    use Time/Chrono.MinguoDate;
    use Time/Chrono.MinguoDate.{MinguoDate};
    use Time/Chrono.ThaiBuddhistDate;
    use Time/Chrono.ThaiBuddhistDate.{ThaiBuddhistDate};
    use Time/Chrono.IsoEra;
    use Time/Format.DateFormatter;
    use Time/Format.DateFormatter.{DateFormatter};
    use Time/Temporal.ChronoUnit;
    use Time.DayOfWeek;
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time.OffsetDateTime;
    use Time.OffsetDateTime.{OffsetDateTime};
    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def new(x: {year: Int32, month: Int32, dayOfMonth: Int32}): LocalDate =
        import java.time.LocalDate:of(Int32, Int32, Int32);
        LocalDate(of(x.year, x.month, x.dayOfMonth)) as & Pure

    pub def newWithMonth(x: {year: Int32, month: Month, dayOfMonth: Int32}): LocalDate =
        import java.time.LocalDate:of(Int32, ##java.time.Month, Int32);
        let m1 = Time/Month.marshal(x.month);
        LocalDate(of(x.year, m1, x.dayOfMonth)) as & Pure


    pub def getFields(x: LocalDate): {year: Int32, month: Int32, dayOfMonth: Int32} = 
        {year = x.getYear(), month = x.getMonth(), dayOfMonth = x.getDayOfMonth()}

    


    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate & Impure =
        import java.time.LocalDate:now();
        LocalDate(now())

    ///
    /// Returns the current date from the system clock using zoneId.
    ///
    pub def nowWithZoneId(zoneId: ZoneId): LocalDate & Impure =
        import java.time.LocalDate:now(##java.time.ZoneId);
        let ZoneId(z1) = zoneId;
        LocalDate(now(z1))


    ///
    /// ___
    ///
    pub def epoch(): LocalDate =
        import get java.time.LocalDate:EPOCH as getEPOCH;
        LocalDate(getEPOCH()) as & Pure



    pub def atStartOfDay(x: LocalDate): LocalDateTime = 
        import java.time.LocalDate.atStartOfDay();
        let LocalDate(x1) = x;
        LocalDateTime(x1.atStartOfDay()) as & Pure

    pub def atStartOfDayWithZoneId(x: LocalDate, zoneId: ZoneId): ZonedDateTime = 
        import java.time.LocalDate.atStartOfDay(##java.time.ZoneId);        
        let LocalDate(x1) = x;
        let ZoneId(z1) = zoneId;
        ZonedDateTime(x1.atStartOfDay(z1)) as & Pure

    pub def atTimeWithLocalTime(x: LocalDate, t: LocalTime): LocalDateTime = 
        import java.time.LocalDate.atTime(##java.time.LocalTime);
        let LocalDate(x1) = x;
        let LocalTime(t1) = t;
        LocalDateTime(x1.atTime(t1)) as & Pure

    pub def atTimeWithOffsetTime(x: LocalDate, t: OffsetTime): OffsetDateTime = 
        import java.time.LocalDate.atTime(##java.time.OffsetTime);
        let LocalDate(x1) = x;
        let OffsetTime(t1) = t;
        OffsetDateTime(x1.atTime(t1)) as & Pure


    pub def fromInstant(x: Instant, zoneId: ZoneId): LocalDate =
        import java.time.LocalDate:ofInstant(##java.time.Instant, ##java.time.ZoneId);
        let Instant(x1) = x;
        let ZoneId(z1) = zoneId;
        LocalDate(ofInstant(x1, z1)) as & Pure


    pub def fromHijrahDate(x: HijrahDate): LocalDate =
        import java.time.LocalDate:from(##java.time.temporal.TemporalAccessor);
        let HijrahDate(x1) = x;
        LocalDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def fromJapaneseDate(x: JapaneseDate): LocalDate =
        import java.time.LocalDate:from(##java.time.temporal.TemporalAccessor);
        let JapaneseDate(x1) = x;
        LocalDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def fromMinguoDate(x: MinguoDate): LocalDate =
        import java.time.LocalDate:from(##java.time.temporal.TemporalAccessor);
        let MinguoDate(x1) = x;
        LocalDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    pub def fromThaiBuddhistDate(x: ThaiBuddhistDate): LocalDate =
        import java.time.LocalDate:from(##java.time.temporal.TemporalAccessor);
        let ThaiBuddhistDate(x1) = x;
        LocalDate(from(x1 as ##java.time.temporal.TemporalAccessor)) as & Pure

    /// 
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(s: String, formatter: DateFormatter): Option[LocalDate] =
        import java.lang.String.strip();
        import java.time.LocalDate:parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter);
        try {
            let DateFormatter(fmtr) = formatter;
            let cs = s.strip() as ##java.lang.CharSequence & Pure;
            Some(LocalDate(cs.parse(fmtr))) as & Pure
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    ///
    /// Returns LocalDate `x` as a String using `formatter`.
    ///
    pub def format(x: LocalDate, formatter: DateFormatter): String =
        import java.time.LocalDate.format(##java.time.format.DateTimeFormatter);
        let LocalDate(x1) = x;
        let DateFormatter(fmtr) = formatter;
        x1.format(fmtr) as & Pure


    pub def hashCode(x: LocalDate): Int32 = 
        import java.time.LocalDate.hashCode();
        let LocalDate(x1) = x;
        hashCode(x1) as & Pure
        

    pub def fromEpochDay(x: Int64): LocalDate =
        import java.time.LocalDate:ofEpochDay(Int64);
        LocalDate(ofEpochDay(x)) as & Pure

    pub def toEpochDay(x: LocalDate): Int64 = 
        import java.time.chrono.ChronoLocalDate.toEpochDay();
        let LocalDate(x1) = x;
        toEpochDay(x1 as ##java.time.chrono.ChronoLocalDate) as & Pure



    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def compareTo(x: LocalDate, y: LocalDate): Int32 =
        import java.time.LocalDate.compareTo(##java.time.chrono.ChronoLocalDate);
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        x1.compareTo(y1 as ##java.time.chrono.ChronoLocalDate) as & Pure


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isBefore(##java.time.chrono.ChronoLocalDate);
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        x1.isBefore(y1 as ##java.time.chrono.ChronoLocalDate) as & Pure

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isAfter(##java.time.chrono.ChronoLocalDate);
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        x1.isAfter(y1 as ##java.time.chrono.ChronoLocalDate) as & Pure


    

    pub def plusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.plusDays(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(days)) as & Pure

    pub def minusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.minusDays(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(days)) as & Pure

    pub def plusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.plusWeeks(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(weeks)) as & Pure

    pub def minusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.minusWeeks(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(weeks)) as & Pure

    pub def plusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.plusMonths(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(months)) as & Pure

    pub def minusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.minusMonths(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(months)) as & Pure


    pub def plusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.plusYears(Int64) as plus;
        let LocalDate(x1) = x;
        LocalDate(x1.plus(years)) as & Pure

    pub def minusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.minusYears(Int64) as minus;
        let LocalDate(x1) = x;
        LocalDate(x1.minus(years)) as & Pure

    pub def getDayOfWeek(x: LocalDate): DayOfWeek =
        use Time/DayOfWeek.{unmarshal};
        import java.time.LocalDate.getDayOfWeek();
        let LocalDate(x1) = x;
        x1.getDayOfWeek().unmarshal() as & Pure



    pub def getDayOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfMonth();
        let LocalDate(x1) = x;
        x1.getDayOfMonth() as & Pure

    pub def putDayOfMonth(x: LocalDate, dayOfMonth: Int32): LocalDate =
        import java.time.LocalDate.withDayOfMonth(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withDayOfMonth(dayOfMonth)) as & Pure


    
    pub def getDayOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfYear();
        let LocalDate(x1) = x;
        x1.getDayOfYear() as & Pure

    pub def putDayOfYear(x: LocalDate, dayOfYear: Int32): LocalDate =
        import java.time.LocalDate.withDayOfYear(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withDayOfYear(dayOfYear)) as & Pure

    pub def getMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.getMonth();
        import java.time.Month.getValue();
        let LocalDate(x1) = x;
        x1.getMonth().getValue() as & Pure

    pub def putMonth(x: LocalDate, month: Int32): LocalDate =
        import java.time.LocalDate.withMonth(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withMonth(month)) as & Pure

    pub def getYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getYear();
        let LocalDate(x1) = x;
        x1.getYear() as & Pure

    pub def putYear(x: LocalDate, year: Int32): LocalDate =
        import java.time.LocalDate.withYear(Int32);
        let LocalDate(x1) = x;
        LocalDate(x1.withYear(year)) as & Pure

    pub def until(b: LocalDate, e: LocalDate, unit: ChronoUnit): Int64 = 
        import java.time.LocalDate.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit);
        let LocalDate(b1) = b;
        let LocalDate(e1) = e;
        let u1 = Time/Temporal/ChronoUnit.marshal(unit);
        let te1 = e1 as ##java.time.temporal.Temporal;
        let tu1 = u1 as ##java.time.temporal.TemporalUnit;
        b1.until(te1, tu1) as & Pure

    pub def isLeapYear(x: LocalDate): Bool =
        import java.time.LocalDate.isLeapYear();
        let LocalDate(x1) = x;
        x1.isLeapYear() as & Pure

    pub def lengthOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfMonth();
        let LocalDate(x1) = x;
        x1.lengthOfMonth() as & Pure
    
    pub def lengthOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfYear();
        let LocalDate(x1) = x;
        x1.lengthOfYear() as & Pure

    pub def getIsoEra(x: LocalDate): IsoEra = 
        import java.time.LocalDate.getEra();
        let LocalDate(x1) = x;
        Time/Chrono/IsoEra.unmarshal(getEra(x1) as & Pure)


}
