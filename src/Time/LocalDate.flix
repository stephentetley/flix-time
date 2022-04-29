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
            import java.time.LocalDate.toString(): String & Pure;
            let LocalDate(x1) = x;
            toString(x1)
    }

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDate] {
        pub def fromString(s: String): Option[LocalDate] =
            import static java.time.LocalDate.parse(##java.lang.CharSequence): ##java.time.LocalDate & Pure;
            try {
                let cs = String.trim(s) as ##java.lang.CharSequence;
                Some(LocalDate(parse(cs)))
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    instance Eq[LocalDate] {
        pub def eq(x: LocalDate, y: LocalDate): Bool = Time/LocalDate.equals(x, y)
    }

    instance Hash[LocalDate] {
        pub def hash(x: LocalDate): Int32 = Time/LocalDate.hashCode(x)
    }


    instance Order[LocalDate] {
        pub def compare(x: LocalDate, y: LocalDate): Comparison =
            Time/LocalDate.compareTo(x,y) |> Comparison.fromInt32
    }


    instance Boxable[LocalDate]


}

namespace Time/LocalDate {

    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};
    use Time/Format.DateFormat;
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time.DayOfWeek;
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.Month;
    use Time.MonthDay;
    use Time.OffsetDateTime;
    use Time.OffsetDateTime.{OffsetDateTime};
    use Time.OffsetTime;
    use Time.OffsetTime.{OffsetTime};
    use Time.Period;
    use Time.YearMonth;
    use Time.ZonedDateTime;
    use Time.ZonedDateTime.{ZonedDateTime};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZInstant;
    use Time.ZInstant.{ZInstant};


    pub def getLocalDate(x: LocalDate): ##java.time.LocalDate = 
        let LocalDate(x1) = x;
        x1


    pub def localDate(r: {year :: Int32, month :: Int32, dayOfMonth :: Int32}): LocalDate =
        import static java.time.LocalDate.of(Int32, Int32, Int32): ##java.time.LocalDate & Pure;
        LocalDate(of(r.year, r.month, r.dayOfMonth))

    pub def localDateWithMonth(r: {year :: Int32, month :: Month, dayOfMonth :: Int32}): LocalDate =
        import static java.time.LocalDate.of(Int32, ##java.time.Month, Int32): ##java.time.LocalDate & Pure;
        let m1 = Time/Month.marshal(r.month);
        LocalDate(of(r.year, m1, r.dayOfMonth))



    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate & Impure =
        import static java.time.LocalDate.now(): ##java.time.LocalDate & Impure;
        LocalDate(now())

    ///
    /// Returns the current date from the system clock using zoneId.
    ///
    pub def nowWithZoneId(zoneId: ZoneId): LocalDate & Impure =
        import static java.time.LocalDate.now(##java.time.ZoneId): ##java.time.LocalDate & Impure;
        let ZoneId(z1) = zoneId;
        LocalDate(now(z1))


    ///
    /// ___
    ///
    pub def epoch(): LocalDate =
        import static get java.time.LocalDate.EPOCH: ##java.time.LocalDate & Pure as getEPOCH;
        LocalDate(getEPOCH())



    pub def atStartOfDay(x: LocalDate): LocalDateTime =
        import java.time.LocalDate.atStartOfDay(): ##java.time.LocalDateTime & Pure;
        let LocalDate(x1) = x;
        LocalDateTime(atStartOfDay(x1))

    pub def atStartOfDayWithZoneId(x: LocalDate, zoneId: ZoneId): ZonedDateTime =
        import java.time.LocalDate.atStartOfDay(##java.time.ZoneId): ##java.time.ZonedDateTime & Pure;
        let LocalDate(x1) = x;
        let ZoneId(z1) = zoneId;
        ZonedDateTime(atStartOfDay(x1, z1))

    pub def atTimeWithLocalTime(x: LocalDate, t: LocalTime): LocalDateTime =
        import java.time.LocalDate.atTime(##java.time.LocalTime): ##java.time.LocalDateTime & Pure;
        let LocalDate(x1) = x;
        let LocalTime(t1) = t;
        LocalDateTime(atTime(x1, t1))

    pub def atTimeWithOffsetTime(x: LocalDate, t: OffsetTime): OffsetDateTime =
        import java.time.LocalDate.atTime(##java.time.OffsetTime): ##java.time.OffsetDateTime & Pure;
        let LocalDate(x1) = x;
        let OffsetTime(t1) = t;
        OffsetDateTime(atTime(x1, t1))


    pub def fromInstant(zone: {zone :: ZoneId}, x: ZInstant): LocalDate =
        import static java.time.LocalDate.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalDate & Pure;
        let ZInstant(x1) = x;
        let ZoneId(z1) = zone.zone;
        LocalDate(ofInstant(x1, z1))

    pub def fromEpochDay(x: Int64): LocalDate =
        import static java.time.LocalDate.ofEpochDay(Int64): ##java.time.LocalDate & Pure;
        LocalDate(ofEpochDay(x))

    pub def toEpochDay(x: LocalDate): Int64 =
        import java.time.chrono.ChronoLocalDate.toEpochDay(): Int64 & Pure;
        let LocalDate(x1) = x;
        toEpochDay(x1 as ##java.time.chrono.ChronoLocalDate)


    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Option[LocalDate] =
        import static java.time.LocalDate.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalDate & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(LocalDate(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    ///
    /// Returns LocalDate `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: LocalDate): String =
        import java.time.LocalDate.format(##java.time.format.DateTimeFormatter): String & Pure;
        let LocalDate(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    pub def equals(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.equals(##java.lang.Object): Bool & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object)


    pub def hashCode(x: LocalDate): Int32 =
        import java.time.LocalDate.hashCode(): Int32 & Pure;
        let LocalDate(x1) = x;
        hashCode(x1)


    ///
    /// Returns `true` if `x` == `y`.
    ///
    pub def compareTo(x: LocalDate, y: LocalDate): Int32 =
        import java.time.LocalDate.compareTo(##java.time.chrono.ChronoLocalDate): Int32 & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        compareTo(x1, y1 as ##java.time.chrono.ChronoLocalDate)


    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isBefore(##java.time.chrono.ChronoLocalDate): Bool & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        isBefore(x1, y1 as ##java.time.chrono.ChronoLocalDate)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isAfter(##java.time.chrono.ChronoLocalDate): Bool & Pure;
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        isAfter(x1, y1 as ##java.time.chrono.ChronoLocalDate)


    pub def plusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.plusYears(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusYears(x1, years))

    pub def minusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.minusYears(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusYears(x1, years))

    pub def plusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.plusMonths(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusMonths(x1, months))

    pub def minusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.minusMonths(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusMonths(x1, months))

    pub def plusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.plusWeeks(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusWeeks(x1, weeks))

    pub def minusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.minusWeeks(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusWeeks(x1, weeks))

    pub def plusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.plusDays(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(plusDays(x1, days))

    pub def minusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.minusDays(Int64): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(minusDays(x1, days))

    /// Get/Set

    pub def getDayOfWeek(x: LocalDate): DayOfWeek =
        use Time/DayOfWeek.{unmarshal};
        import java.time.LocalDate.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let LocalDate(x1) = x;
        unmarshal(getDayOfWeek(x1))

    pub def getDayOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfMonth(): Int32 & Pure;
        let LocalDate(x1) = x;
        getDayOfMonth(x1)

    pub def setDayOfMonth(dayOfMonth: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withDayOfMonth(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withDayOfMonth(x1, dayOfMonth))

    pub def getDayOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfYear(): Int32 & Pure;
        let LocalDate(x1) = x;
        getDayOfYear(x1)

    pub def setDayOfYear(dayOfYear: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withDayOfYear(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withDayOfYear(x1, dayOfYear))

    pub def getMonth(x: LocalDate): Month =
        import java.time.LocalDate.getMonth(): ##java.time.Month & Pure;
        let LocalDate(x1) = x;
        Time/Month.unmarshal(getMonth(x1))


    pub def getMonthValue(x: LocalDate): Int32 =
        import java.time.LocalDate.getMonth(): ##java.time.Month & Pure;
        import java.time.Month.getValue(): Int32 & Pure;
        let LocalDate(x1) = x;
        getValue(getMonth(x1))

    pub def setMonth(month: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withMonth(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withMonth(x1, month))

    pub def getYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getYear(): Int32 & Pure;
        let LocalDate(x1) = x;
        getYear(x1)

    pub def setYear(year: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withYear(Int32): ##java.time.LocalDate & Pure;
        let LocalDate(x1) = x;
        LocalDate(withYear(x1, year))


    /// Get/Set Iso

    pub def getDayOfQuarter(x: LocalDate): Int32 = 
        import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.TemporalField & Pure as get_DAY_OF_QUARTER;
        getHelper(get_DAY_OF_QUARTER(), x)

    pub def setDayOfQuarter(d: Int32, x: LocalDate): LocalDate =
        import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.TemporalField & Pure as get_DAY_OF_QUARTER;
        withTemporalFieldHelper(get_DAY_OF_QUARTER(), Int32.toInt64(d), x)

    pub def getQuarterOfYear(x: LocalDate): Int32 = 
        import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.TemporalField & Pure as get_QUARTER_OF_YEAR;
        getHelper(get_QUARTER_OF_YEAR(), x)

    pub def setQuarterOfYear(d: Int32, x: LocalDate): LocalDate =
        import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.TemporalField & Pure as get_QUARTER_OF_YEAR;
        withTemporalFieldHelper(get_QUARTER_OF_YEAR(), Int32.toInt64(d), x)


    def getISOWeekFields(): ##java.time.temporal.WeekFields = 
        import static get java.time.temporal.WeekFields.ISO: ##java.time.temporal.WeekFields & Pure as get_ISO;
        get_ISO()

    pub def getWeekOfYear(x: LocalDate): Int32 = 
        import java.time.temporal.WeekFields.weekBasedYear(): ##java.time.temporal.TemporalField & Pure;
        getHelper(getISOWeekFields() |> weekBasedYear, x)

    pub def setWeekOfYear(d: Int32, x: LocalDate): LocalDate =
        import java.time.temporal.WeekFields.weekBasedYear(): ##java.time.temporal.TemporalField & Pure;
        withTemporalFieldHelper(getISOWeekFields() |> weekBasedYear, Int32.toInt64(d), x)
        

    pub def isLeapYear(x: LocalDate): Bool =
        import java.time.LocalDate.isLeapYear(): Bool & Pure;
        let LocalDate(x1) = x;
        isLeapYear(x1)

    pub def lengthOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfMonth(): Int32 & Pure;
        let LocalDate(x1) = x;
        lengthOfMonth(x1)

    pub def lengthOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfYear(): Int32 & Pure;
        let LocalDate(x1) = x;
        lengthOfYear(x1)

    /// Generic

    /// # `fromTemporalAccessor` specialized
    def fromHelper(x: ##java.time.temporal.TemporalAccessor): LocalDate = 
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate & Pure as fromTA;
        try {
            LocalDate(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromLocalDateTime(x: LocalDateTime): LocalDate = 
        fromHelper(Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetDateTime(x: OffsetDateTime): LocalDate = 
        fromHelper(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromZonedDateTime(x: ZonedDateTime): LocalDate = 
        fromHelper(Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)



    /// # `adjustInto` specialized - synonymous with `adjustLocalDate` in the respective modules:
    /// LocalDateTime
    /// OffsetDateTime
    /// ZonedDateTime

    /// # `get` specialized

    def getHelper(field: ##java.time.temporal.TemporalField, x: LocalDate): Int32 = 
        import java.time.LocalDate.getLong(##java.time.temporal.TemporalField): Int32 & Pure;
        try {
            let LocalDate(x1) = x;
            getLong(x1, field)
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }



    /// TODO other ChronoFields...

    pub def getAlignedDayOfWeekInMonth(x: LocalDate): Int32 =
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_DAY_OF_WEEK_IN_MONTH;
        getHelper(get_ALIGNED_DAY_OF_WEEK_IN_MONTH() as ##java.time.temporal.TemporalField, x)
    
    pub def getAlignedDayOfWeekInYear(x: LocalDate): Int32 =
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_DAY_OF_WEEK_IN_YEAR;
        getHelper(get_ALIGNED_DAY_OF_WEEK_IN_YEAR() as ##java.time.temporal.TemporalField, x)

    pub def getAlignedWeekOfMonth(x: LocalDate): Int32 =
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_WEEK_OF_MONTH;
        getHelper(get_ALIGNED_WEEK_OF_MONTH() as ##java.time.temporal.TemporalField, x)

    pub def getAlignedWeekOfYear(x: LocalDate): Int32 =
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_YEAR: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_WEEK_OF_YEAR;
        getHelper(get_ALIGNED_WEEK_OF_YEAR() as ##java.time.temporal.TemporalField, x)


    pub def getEra(x: LocalDate): Int32 =
        import static get java.time.temporal.ChronoField.ERA: ##java.time.temporal.ChronoField & Pure as get_ERA;
        getHelper(get_ERA() as ##java.time.temporal.TemporalField, x)



    def plusHelper(x: LocalDate, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalDate =
        import java.time.LocalDate.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate & Pure;         
        try {
            let LocalDate(x1) = x;
            LocalDate(plus(x1, amount, temporalUnit))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def plusDecades(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit & Pure as get_DECADES;
        plusHelper(x, i, get_DECADES() as ##java.time.temporal.TemporalUnit)

    pub def plusCenturies(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit & Pure as get_CENTURIES;
        plusHelper(x, i, get_CENTURIES() as ##java.time.temporal.TemporalUnit)

    pub def plusMillenia(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit & Pure as get_MILLENNIA;
        plusHelper(x, i, get_MILLENNIA() as ##java.time.temporal.TemporalUnit)


    def minusHelper(x: LocalDate, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalDate =
        import java.time.LocalDate.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate & Pure;         
        try {
            let LocalDate(x1) = x;
            LocalDate(minus(x1, amount, temporalUnit))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def minusDecades(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.DECADES:##java.time.temporal.ChronoUnit & Pure as get_DECADES;
        minusHelper(x, i, get_DECADES() as ##java.time.temporal.TemporalUnit)


    pub def minusCenturies(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit & Pure as get_CENTURIES;
        minusHelper(x, i, get_CENTURIES() as ##java.time.temporal.TemporalUnit)

    pub def minusMillenia(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit & Pure as get_MILLENNIA;
        minusHelper(x, i, get_MILLENNIA() as ##java.time.temporal.TemporalUnit)



    /// pub def plusTemporalAmountHelper(x: LocalDate, amount: ##java.time.temporal.TemporalAmount): LocalDate =
    ///     import java.time.LocalDate.plus(##java.time.temporal.TemporalAmount): ##java.time.LocalDate & Pure;         
    ///     try {
    ///         let LocalDate(x1) = x;
    ///         LocalDate(plus(x1, amount))
    ///     } catch {
    ///         case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
    ///     }

    /// pub def minusTemporalAmountHelper(x: LocalDate, amount: ##java.time.temporal.TemporalAmount): LocalDate =
    ///     import java.time.LocalDate.minus(##java.time.temporal.TemporalAmount): ##java.time.LocalDate & Pure;         
    ///     try {
    ///         let LocalDate(x1) = x;
    ///         LocalDate(minus(x1, amount))
    ///     } catch {
    ///         case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
    ///     }


    /// # `range` specialized
    def rangeHelper(f: ##java.time.temporal.TemporalField, x: LocalDate): ValueRange =
        import java.time.LocalDate.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let LocalDate(x1) = x;
            ValueRange(range(x1, f))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    /// TODO other ChronoFields...

    pub def rangeDayOfWeek(z: LocalDate): ValueRange =       
        import static get java.time.temporal.ChronoField.DAY_OF_WEEK: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_WEEK;            
        rangeHelper(get_DAY_OF_WEEK() as ##java.time.temporal.TemporalField, z)

    pub def rangeDayOfMonth(z: LocalDate): ValueRange =       
        import static get java.time.temporal.ChronoField.DAY_OF_MONTH: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_MONTH;            
        rangeHelper(get_DAY_OF_MONTH() as ##java.time.temporal.TemporalField, z)

   /// # `until` specialized

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start :: LocalDate, end :: LocalDate}): Int64 = 
        import java.time.LocalDate.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 & Pure;
        let b1 = getLocalDate(r.start);
        let e1 = getLocalDate(r.end) as ##java.time.temporal.Temporal;
        until(b1, e1, u)


    pub def daysUntil(r: {start :: LocalDate, end :: LocalDate}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit & Pure as get_MONTHS;
        untilHelper(get_MONTHS() as ##java.time.temporal.TemporalUnit, r)


    /// TODO other ChronoUnits...

    /// # `with<TemporalAdjuster>` specialized

    def withTemporalAdjusterHelper(adj: ##java.time.temporal.TemporalAdjuster, x: LocalDate): LocalDate =
        import java.time.LocalDate.with(##java.time.temporal.TemporalAdjuster): ##java.time.LocalDate & Pure as withTA;         
        try {
            let LocalDate(x1) = x;
            LocalDate(withTA(x1, adj))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withMonthDay(i: MonthDay, x: LocalDate): LocalDate =
        let i1 = Time/MonthDay.getMonthDay(i) as ##java.time.temporal.TemporalAdjuster;
        withTemporalAdjusterHelper(i1, x)

    pub def withYearMonth(i: YearMonth, x: LocalDate): LocalDate =
        let i1 = Time/YearMonth.getYearMonth(i) as ##java.time.temporal.TemporalAdjuster;
        withTemporalAdjusterHelper(i1, x)

    /// TODO other TemporalAdjusters...



    /// # `withTemporalField` specialized

    def withTemporalFieldHelper(field: ##java.time.temporal.TemporalField, i: Int64, x: LocalDate): LocalDate =
        import java.time.LocalDate.with(##java.time.temporal.TemporalField, Int64): ##java.time.LocalDate & Pure as withTF;                   
        try {
            let LocalDate(x1) = x;
            LocalDate(withTF(x1, field, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def withEpochDay(i: Int64, x: LocalDate): LocalDate =
        import static get java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField & Pure as get_EPOCH_DAY;
        withTemporalFieldHelper(get_EPOCH_DAY() as ##java.time.temporal.TemporalField, i, x)


    /// Period methods

    pub def plusPeriod(i: LocalDate, x: Period): LocalDate =
        import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/Period.getPeriod(x);
        let i1 = getLocalDate(i) as ##java.time.temporal.Temporal;
        LocalDate(addTo(x1, i1) as ##java.time.LocalDate)
    
    pub def minusPeriod(i: LocalDate, x: Period): LocalDate =
        import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/Period.getPeriod(x);
        let i1 = getLocalDate(i) as ##java.time.temporal.Temporal;
        LocalDate(subtractFrom(x1, i1) as ##java.time.LocalDate)

    /// DayOfWeek methods

    pub def adjustDayOfWeek(x: DayOfWeek, d: LocalDate): LocalDate = 
        import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/DayOfWeek.marshal(x);
        let d1 = getLocalDate(d) as ##java.time.temporal.Temporal;
        LocalDate(adjustInto(x1, d1) as ##java.time.LocalDate)

    /// MonthDay methods

    pub def adjustMonthDay(x: MonthDay, d: LocalDate): LocalDate = 
        import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/MonthDay.getMonthDay(x);
        let d1 = getLocalDate(d) as ##java.time.temporal.Temporal;
        LocalDate(adjustInto(x1, d1) as ##java.time.LocalDate)

    /// YearMonth methods

    pub def adjustYearMonth(x: YearMonth, d: LocalDate): LocalDate = 
        import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = Time/YearMonth.getYearMonth(x);
        let d1 = getLocalDate(d) as ##java.time.temporal.Temporal;
        LocalDate(adjustInto(x1, d1) as ##java.time.LocalDate)

    /// java.time.termporal.TemporalAdjusters methods

    pub def withFirstDayOfMonth(x: LocalDate): LocalDate = 
        import static java.time.temporal.TemporalAdjusters.firstDayOfMonth(): ##java.time.temporal.TemporalAdjuster & Pure;
        withTemporalAdjusterHelper(firstDayOfMonth(), x)

    pub def withFirstDayOfNextMonth(x: LocalDate): LocalDate = 
        import static java.time.temporal.TemporalAdjusters.firstDayOfNextMonth(): ##java.time.temporal.TemporalAdjuster & Pure;
        withTemporalAdjusterHelper(firstDayOfNextMonth(), x)

    pub def withFirstDayOfNextYear(x: LocalDate): LocalDate = 
        import static java.time.temporal.TemporalAdjusters.firstDayOfNextYear(): ##java.time.temporal.TemporalAdjuster & Pure;
        withTemporalAdjusterHelper(firstDayOfNextYear(), x)

    pub def withLastDayOfMonth(x: LocalDate): LocalDate =  
        import static java.time.temporal.TemporalAdjusters.lastDayOfMonth(): ##java.time.temporal.TemporalAdjuster & Pure;
        withTemporalAdjusterHelper(lastDayOfMonth(), x)

    pub def withLastDayOfYear(x: LocalDate): LocalDate =  
        import static java.time.temporal.TemporalAdjusters.lastDayOfYear(): ##java.time.temporal.TemporalAdjuster & Pure;
        withTemporalAdjusterHelper(lastDayOfYear(), x)

    /// TODO other methods...
}
