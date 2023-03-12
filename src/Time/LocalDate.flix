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

    use Interop/Time/Temporal.TemporalAccessor
    use Interop/Time/Temporal.TemporalAccessor.{TemporalAccessor}

    ///
    /// A wrapper around a Java LocalDate.
    ///
    pub enum LocalDate(##java.time.LocalDate)

    ///
    /// Returns the given date `x` as a string using the Java builtin toString method.
    ///
    instance ToString[LocalDate] {
        pub def toString(x: LocalDate): String =
            import java.time.LocalDate.toString(): String \ {};
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
            Result.tryCatch(_ -> {
                import static java.time.LocalDate.parse(##java.lang.CharSequence): ##java.time.LocalDate \ {};
                let cs = unsafe_cast String.trim(s) as ##java.lang.CharSequence;
                LocalDate(parse(cs))
            }) |> Result.toOption
    }

    instance Eq[LocalDate] {
        pub def eq(x: LocalDate, y: LocalDate): Bool =
            import java.time.LocalDate.equals(##java.lang.Object): Bool \ {};
            let LocalDate(x1) = x;
            let LocalDate(y1) = y;
            equals(x1, unsafe_cast y1 as ##java.lang.Object)
    }

    instance Hash[LocalDate] {
        pub def hash(x: LocalDate): Int32 =
            import java.time.LocalDate.hashCode(): Int32 \ {};
            let LocalDate(x1) = x;
            hashCode(x1)
    }


    instance Order[LocalDate] {
        pub def compare(x: LocalDate, y: LocalDate): Comparison =
            import java.time.LocalDate.compareTo(##java.time.chrono.ChronoLocalDate): Int32 \ {};
            let LocalDate(x1) = x;
            let LocalDate(y1) = y;
            compareTo(x1, unsafe_cast y1 as ##java.time.chrono.ChronoLocalDate) |> Comparison.fromInt32
    }


    instance Boxable[LocalDate]

    instance Interop/Flix.Marshal[LocalDate] {
        pub def toJavaObject(x: LocalDate): ##java.lang.Object =
            let LocalDate(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): LocalDate = 
            LocalDate(unsafe_cast o as ##java.time.LocalDate)
    }

    instance Interop/Time/Temporal.ImpTemporalAccessor[LocalDate] {
        pub def toTemporalAccessor(x: LocalDate): TemporalAccessor = 
            let LocalDate(x1) = x;
            TemporalAccessor(unsafe_cast x1 as ##java.time.temporal.TemporalAccessor)

        pub def fromTemporalAccessor(x: TemporalAccessor): LocalDate = 
            let TemporalAccessor(x1) = x;
            LocalDate(unsafe_cast x1 as ##java.time.LocalDate)
    }
}

namespace Time/LocalDate {

    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time/Format.DateFormat
    use Time/Format.DateTimeFormatter
    use Time/Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.DayOfWeek
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.Month
    use Time.MonthDay
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time.Period
    use Time.YearMonth
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Interop/Time/Temporal.TemporalAccessor
    use Interop/Time/Temporal.TemporalAccessor.{TemporalAccessor}

    /// ## Unwrap

    pub def getLocalDate(x: LocalDate): ##java.time.LocalDate = 
        let LocalDate(x1) = x;
        x1

    /// ## Constructors

    pub def localDate(r: {year = Int32, month = Int32, dayOfMonth = Int32}): LocalDate =
        import static java.time.LocalDate.of(Int32, Int32, Int32): ##java.time.LocalDate \ {};
        LocalDate(of(r.year, r.month, r.dayOfMonth))

    pub def localDateWithMonth(r: {year = Int32, month = Month, dayOfMonth = Int32}): LocalDate =
        import static java.time.LocalDate.of(Int32, ##java.time.Month, Int32): ##java.time.LocalDate \ {};
        let m1 = Time/Month.marshal(r.month);
        LocalDate(of(r.year, m1, r.dayOfMonth))

    /// ## `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate \ IO =
        import static java.time.LocalDate.now(): ##java.time.LocalDate \ IO;
        LocalDate(now())

    ///
    /// Returns the current date from the system clock using zoneId.
    ///
    pub def nowWithZoneId(zoneId: ZoneId): LocalDate \ IO =
        import static java.time.LocalDate.now(##java.time.ZoneId): ##java.time.LocalDate \ IO;
        let ZoneId(z1) = zoneId;
        LocalDate(now(z1))

    ///
    /// ___
    ///
    pub def epoch(): LocalDate =
        import static get java.time.LocalDate.EPOCH: ##java.time.LocalDate \ {} as getEPOCH;
        LocalDate(getEPOCH())

    /// ## `at` functions

    pub def atStartOfDay(x: LocalDate): LocalDateTime =
        import java.time.LocalDate.atStartOfDay(): ##java.time.LocalDateTime \ {};
        let LocalDate(x1) = x;
        LocalDateTime(atStartOfDay(x1))

    pub def atStartOfDayWithZoneId(x: LocalDate, zoneId: ZoneId): ZonedDateTime =
        import java.time.LocalDate.atStartOfDay(##java.time.ZoneId): ##java.time.ZonedDateTime \ {};
        let LocalDate(x1) = x;
        let ZoneId(z1) = zoneId;
        ZonedDateTime(atStartOfDay(x1, z1))

    pub def atTimeWithLocalTime(x: LocalDate, t: LocalTime): LocalDateTime =
        import java.time.LocalDate.atTime(##java.time.LocalTime): ##java.time.LocalDateTime \ {};
        let LocalDate(x1) = x;
        let LocalTime(t1) = t;
        LocalDateTime(atTime(x1, t1))

    pub def atTimeWithOffsetTime(x: LocalDate, t: OffsetTime): OffsetDateTime =
        import java.time.LocalDate.atTime(##java.time.OffsetTime): ##java.time.OffsetDateTime \ {};
        let LocalDate(x1) = x;
        let OffsetTime(t1) = t;
        OffsetDateTime(atTime(x1, t1))

    /// ## `from` functions

    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): LocalDate =
        import static java.time.LocalDate.ofInstant(##java.time.Instant, ##java.time.ZoneId): ##java.time.LocalDate \ {};
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone.zone;
        LocalDate(ofInstant(x1, z1))

    pub def ofEpochDay(x: Int64): LocalDate =
        import static java.time.LocalDate.ofEpochDay(Int64): ##java.time.LocalDate \ {};
        LocalDate(ofEpochDay(x))


    ///  `fromTemporalAccessor` specialized
    pub def fromTemporalAccessor(x: TemporalAccessor): LocalDate = 
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromTemporalAccessor;
        try {
            let TemporalAccessor(x1) = x;
            fromTemporalAccessor(x1) |> LocalDate
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    /// TODO - idiomatic Flix is `toSomeDatatype` in the respective module rather than `fromSomeDatatype`
    pub def fromLocalDateTime(x: LocalDateTime): LocalDate = 
        Interop/Time/Temporal.ImpTemporalAccessor.toTemporalAccessor(x) 
            |> fromTemporalAccessor

    // pub def fromOffsetDateTime(x: OffsetDateTime): LocalDate = 
    //     fromTemporalAccessorHelper(unsafe_cast Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    // pub def fromZonedDateTime(x: ZonedDateTime): LocalDate = 
    //     fromTemporalAccessorHelper(unsafe_cast Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)

    /// ## `to` functions

    pub def toEpochDay(x: LocalDate): Int64 =
        import java.time.chrono.ChronoLocalDate.toEpochDay(): Int64 \ {};
        let LocalDate(x1) = x;
        toEpochDay(unsafe_cast x1 as ##java.time.chrono.ChronoLocalDate)


    /// ## `parse` / `format` functions

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, LocalDate] = 
        Result.tryCatch(_ -> {
            import static java.time.LocalDate.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.LocalDate \ {};
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unsafe_cast String.trim(s) as ##java.lang.CharSequence;
            LocalDate(parse(cs, fmtr))
        })

    ///
    /// Returns LocalDate `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: LocalDate): String =
        import java.time.LocalDate.format(##java.time.format.DateTimeFormatter): String \ {};
        let LocalDate(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)



    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isBefore(##java.time.chrono.ChronoLocalDate): Bool \ {};
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        isBefore(x1, unsafe_cast y1 as ##java.time.chrono.ChronoLocalDate)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDate, y: LocalDate): Bool =
        import java.time.LocalDate.isAfter(##java.time.chrono.ChronoLocalDate): Bool \ {};
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        isAfter(x1, unsafe_cast y1 as ##java.time.chrono.ChronoLocalDate)


    pub def isLeapYear(x: LocalDate): Bool =
        import java.time.LocalDate.isLeapYear(): Bool \ {};
        let LocalDate(x1) = x;
        isLeapYear(x1)

    /// ## LocalDate functions

    pub def lengthOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfMonth(): Int32 \ {};
        let LocalDate(x1) = x;
        lengthOfMonth(x1)

    pub def lengthOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.lengthOfYear(): Int32 \ {};
        let LocalDate(x1) = x;
        lengthOfYear(x1)


    pub def datesUntil(r: Region[r], s: LocalDate, e: LocalDate): Iterator[LocalDate, r, r] \ Read(r) = 
        import java.time.LocalDate.datesUntil(##java.time.LocalDate): ##java.util.stream.Stream \ r;
        let LocalDate(s1) = s;
        let LocalDate(e1) = e;
        let strm = datesUntil(s1, e1);
        Interop/Util/Stream/Stream.wrapHH(r, strm) |> Interop/Util/Stream/Stream.iterator(r)

    pub def datesUntilWithStep(r: Region[r], s: LocalDate, e: LocalDate, step: Period): Iterator[LocalDate, r, r] \ Read(r) = 
        import java.time.LocalDate.datesUntil(##java.time.LocalDate, ##java.time.Period): ##java.util.stream.Stream \ r;
        let LocalDate(s1) = s;
        let LocalDate(e1) = e;
        let step1 = Time/Period.getPeriod(step);
        let strm = datesUntil(s1, e1, step1);
        Interop/Util/Stream/Stream.wrapHH(r, strm) |> Interop/Util/Stream/Stream.iterator(r)

    /// ## Getters and Setters

    pub def getDayOfMonth(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfMonth(): Int32 \ {};
        let LocalDate(x1) = x;
        getDayOfMonth(x1)

    pub def withDayOfMonth(dayOfMonth: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withDayOfMonth(Int32): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(withDayOfMonth(x1, dayOfMonth))


    pub def getDayOfYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getDayOfYear(): Int32 \ {};
        let LocalDate(x1) = x;
        getDayOfYear(x1)

    pub def withDayOfYear(dayOfYear: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withDayOfYear(Int32): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(withDayOfYear(x1, dayOfYear))


    pub def withMonth(month: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withMonth(Int32): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(withMonth(x1, month))

    pub def getYear(x: LocalDate): Int32 =
        import java.time.LocalDate.getYear(): Int32 \ {};
        let LocalDate(x1) = x;
        getYear(x1)

    pub def withYear(year: Int32, x: LocalDate): LocalDate =
        import java.time.LocalDate.withYear(Int32): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(withYear(x1, year))


    pub def getDayOfWeek(x: LocalDate): DayOfWeek =
        use Time/DayOfWeek.{unmarshal};
        import java.time.LocalDate.getDayOfWeek(): ##java.time.DayOfWeek \ {};
        let LocalDate(x1) = x;
        unmarshal(getDayOfWeek(x1))


    pub def getMonth(x: LocalDate): Month =
        import java.time.LocalDate.getMonth(): ##java.time.Month \ {};
        let LocalDate(x1) = x;
        Time/Month.unmarshal(getMonth(x1))


    pub def getMonthValue(x: LocalDate): Int32 =
        import java.time.LocalDate.getMonth(): ##java.time.Month \ {};
        import java.time.Month.getValue(): Int32 \ {};
        let LocalDate(x1) = x;
        getValue(getMonth(x1))



    /// Get/Set Iso

    pub def getDayOfQuarter(x: LocalDate): Int64 = 
        import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.TemporalField \ {} as get_DAY_OF_QUARTER;
        getHelper(get_DAY_OF_QUARTER(), x)

    pub def withDayOfQuarter(d: Int32, x: LocalDate): LocalDate =
        import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.TemporalField \ {} as get_DAY_OF_QUARTER;
        withTemporalFieldHelper(get_DAY_OF_QUARTER(), Int32.toInt64(d), x)

    pub def getQuarterOfYear(x: LocalDate): Int64 = 
        import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.TemporalField \ {} as get_QUARTER_OF_YEAR;
        getHelper(get_QUARTER_OF_YEAR(), x)

    pub def withQuarterOfYear(d: Int32, x: LocalDate): LocalDate =
        import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.TemporalField \ {} as get_QUARTER_OF_YEAR;
        withTemporalFieldHelper(get_QUARTER_OF_YEAR(), Int32.toInt64(d), x)


    def getISOWeekFields(): ##java.time.temporal.WeekFields = 
        import static get java.time.temporal.WeekFields.ISO: ##java.time.temporal.WeekFields \ {} as get_ISO;
        get_ISO()

    pub def getWeekOfYear(x: LocalDate): Int64 = 
        import java.time.temporal.WeekFields.weekBasedYear(): ##java.time.temporal.TemporalField \ {};
        getHelper(getISOWeekFields() |> weekBasedYear, x)

    pub def withWeekOfYear(d: Int32, x: LocalDate): LocalDate =
        import java.time.temporal.WeekFields.weekBasedYear(): ##java.time.temporal.TemporalField \ {};
        withTemporalFieldHelper(getISOWeekFields() |> weekBasedYear, Int32.toInt64(d), x)
        

    pub def getAlignedDayOfWeekInMonth(x: LocalDate): Int64 =
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_DAY_OF_WEEK_IN_MONTH;
        getHelper(unsafe_cast get_ALIGNED_DAY_OF_WEEK_IN_MONTH() as ##java.time.temporal.TemporalField, x)
    
    pub def getAlignedDayOfWeekInYear(x: LocalDate): Int64 =
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_DAY_OF_WEEK_IN_YEAR;
        getHelper(unsafe_cast get_ALIGNED_DAY_OF_WEEK_IN_YEAR() as ##java.time.temporal.TemporalField, x)

    pub def getAlignedWeekOfMonth(x: LocalDate): Int64 =
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_WEEK_OF_MONTH;
        getHelper(unsafe_cast get_ALIGNED_WEEK_OF_MONTH() as ##java.time.temporal.TemporalField, x)

    pub def getAlignedWeekOfYear(x: LocalDate): Int64 =
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_YEAR: ##java.time.temporal.ChronoField \ {} as get_ALIGNED_WEEK_OF_YEAR;
        getHelper(unsafe_cast get_ALIGNED_WEEK_OF_YEAR() as ##java.time.temporal.TemporalField, x)


    pub def getEra(x: LocalDate): Int64 =
        import static get java.time.temporal.ChronoField.ERA: ##java.time.temporal.ChronoField \ {} as get_ERA;
        getHelper(unsafe_cast get_ERA() as ##java.time.temporal.TemporalField, x)

    pub def adjustMonthDay(i: MonthDay, x: LocalDate): LocalDate =
        let i1 = unsafe_cast Time/MonthDay.getMonthDay(i) as ##java.time.temporal.TemporalAdjuster;
        withTemporalAdjusterHelper(i1, x)

    pub def adjustYearMonth(i: YearMonth, x: LocalDate): LocalDate =
        let i1 = unsafe_cast Time/YearMonth.getYearMonth(i) as ##java.time.temporal.TemporalAdjuster;
        withTemporalAdjusterHelper(i1, x)


    pub def withEpochDay(i: Int64, x: LocalDate): LocalDate =
        import static get java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField \ {} as get_EPOCH_DAY;
        withTemporalFieldHelper(unsafe_cast get_EPOCH_DAY() as ##java.time.temporal.TemporalField, i, x)

    /// DayOfWeek methods

    pub def adjustDayOfWeek(x: DayOfWeek, d: LocalDate): LocalDate = 
        import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time/DayOfWeek.marshal(x);
        let d1 = unsafe_cast getLocalDate(d) as ##java.time.temporal.Temporal;
        LocalDate(unsafe_cast adjustInto(x1, d1) as ##java.time.LocalDate)

    
    pub def adjustToFirstDayOfMonth(x: LocalDate): LocalDate = 
        import static java.time.temporal.TemporalAdjusters.firstDayOfMonth(): ##java.time.temporal.TemporalAdjuster \ {};
        withTemporalAdjusterHelper(firstDayOfMonth(), x)

    pub def adjustToFirstDayOfNextMonth(x: LocalDate): LocalDate = 
        import static java.time.temporal.TemporalAdjusters.firstDayOfNextMonth(): ##java.time.temporal.TemporalAdjuster \ {};
        withTemporalAdjusterHelper(firstDayOfNextMonth(), x)

    pub def adjustToFirstDayOfNextYear(x: LocalDate): LocalDate = 
        import static java.time.temporal.TemporalAdjusters.firstDayOfNextYear(): ##java.time.temporal.TemporalAdjuster \ {};
        withTemporalAdjusterHelper(firstDayOfNextYear(), x)

    pub def adjustToLastDayOfMonth(x: LocalDate): LocalDate =  
        import static java.time.temporal.TemporalAdjusters.lastDayOfMonth(): ##java.time.temporal.TemporalAdjuster \ {};
        withTemporalAdjusterHelper(lastDayOfMonth(), x)

    pub def adjustToLastDayOfYear(x: LocalDate): LocalDate =  
        import static java.time.temporal.TemporalAdjusters.lastDayOfYear(): ##java.time.temporal.TemporalAdjuster \ {};
        withTemporalAdjusterHelper(lastDayOfYear(), x)


    /// ## plus / minus functions

    pub def plusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.plusYears(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(plusYears(x1, years))

    pub def minusYears(x: LocalDate, years: Int64): LocalDate =
        import java.time.LocalDate.minusYears(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(minusYears(x1, years))

    pub def plusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.plusMonths(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(plusMonths(x1, months))

    pub def minusMonths(x: LocalDate, months: Int64): LocalDate =
        import java.time.LocalDate.minusMonths(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(minusMonths(x1, months))

    pub def plusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.plusWeeks(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(plusWeeks(x1, weeks))

    pub def minusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        import java.time.LocalDate.minusWeeks(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(minusWeeks(x1, weeks))

    pub def plusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.plusDays(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(plusDays(x1, days))

    pub def minusDays(x: LocalDate, days: Int64): LocalDate =
        import java.time.LocalDate.minusDays(Int64): ##java.time.LocalDate \ {};
        let LocalDate(x1) = x;
        LocalDate(minusDays(x1, days))


    pub def plusDecades(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit \ {} as get_DECADES;
        plusHelper(x, i, unsafe_cast get_DECADES() as ##java.time.temporal.TemporalUnit)

    pub def minusDecades(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.DECADES:##java.time.temporal.ChronoUnit \ {} as get_DECADES;
        minusHelper(x, i, unsafe_cast get_DECADES() as ##java.time.temporal.TemporalUnit)

    pub def plusCenturies(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit \ {} as get_CENTURIES;
        plusHelper(x, i, unsafe_cast get_CENTURIES() as ##java.time.temporal.TemporalUnit)

    pub def minusCenturies(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit \ {} as get_CENTURIES;
        minusHelper(x, i, unsafe_cast get_CENTURIES() as ##java.time.temporal.TemporalUnit)

    pub def plusMillenia(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit \ {} as get_MILLENNIA;
        plusHelper(x, i, unsafe_cast get_MILLENNIA() as ##java.time.temporal.TemporalUnit)

    pub def minusMillenia(x: LocalDate, i: Int64): LocalDate = 
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit \ {} as get_MILLENNIA;
        minusHelper(x, i, unsafe_cast get_MILLENNIA() as ##java.time.temporal.TemporalUnit)


    /// Period methods

    pub def plusPeriod(i: LocalDate, x: Period): LocalDate =
        import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time/Period.getPeriod(x);
        let i1 = unsafe_cast getLocalDate(i) as ##java.time.temporal.Temporal;
        LocalDate(unsafe_cast addTo(x1, i1) as ##java.time.LocalDate)
    
    pub def minusPeriod(i: LocalDate, x: Period): LocalDate =
        import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time/Period.getPeriod(x);
        let i1 = unsafe_cast getLocalDate(i) as ##java.time.temporal.Temporal;
        LocalDate(unsafe_cast subtractFrom(x1, i1) as ##java.time.LocalDate)


    /// ## between / until functions

    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = LocalDate, end = LocalDate}): Int64 = 
        import java.time.LocalDate.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getLocalDate(r.start);
        let e1 = unsafe_cast getLocalDate(r.end) as ##java.time.temporal.Temporal;
        until(b1, e1, u)


    pub def daysUntil(r: {start = LocalDate, end = LocalDate}): Int64 = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        untilHelper(unsafe_cast get_DAYS() as ##java.time.temporal.TemporalUnit, r)

    pub def monthsUntil(r: {start = LocalDate, end = LocalDate}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
        untilHelper(unsafe_cast get_MONTHS() as ##java.time.temporal.TemporalUnit, r)

    pub def yearsUntil(r: {start = LocalDate, end = LocalDate}): Int64 = 
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
        untilHelper(unsafe_cast get_YEARS() as ##java.time.temporal.TemporalUnit, r)

    pub def quarterYearsUntil(r: {start = LocalDate, end = LocalDate}): Int64 = 
        import static get java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.TemporalUnit \ {} as get_QUARTER_YEARS;
        untilHelper(get_QUARTER_YEARS(), r)

    /// ## generic helper functions

    def getHelper(field: ##java.time.temporal.TemporalField, x: LocalDate): Int64 = 
        import java.time.LocalDate.getLong(##java.time.temporal.TemporalField): Int64 \ {};
        try {
            let LocalDate(x1) = x;
            getLong(x1, field)
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }


    def plusHelper(x: LocalDate, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalDate =
        import java.time.LocalDate.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate \ {};         
        try {
            let LocalDate(x1) = x;
            LocalDate(plus(x1, amount, temporalUnit))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }



    def minusHelper(x: LocalDate, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalDate =
        import java.time.LocalDate.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate \ {};         
        try {
            let LocalDate(x1) = x;
            LocalDate(minus(x1, amount, temporalUnit))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }



    def withTemporalAdjusterHelper(adj: ##java.time.temporal.TemporalAdjuster, x: LocalDate): LocalDate =
        import java.time.LocalDate.with(##java.time.temporal.TemporalAdjuster): ##java.time.LocalDate \ {} as withTA;         
        try {
            let LocalDate(x1) = x;
            LocalDate(withTA(x1, adj))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }


    def withTemporalFieldHelper(field: ##java.time.temporal.TemporalField, i: Int64, x: LocalDate): LocalDate =
        import java.time.LocalDate.with(##java.time.temporal.TemporalField, Int64): ##java.time.LocalDate \ {} as with1;
        try {
            let LocalDate(x1) = x;
            LocalDate(with1(x1, field, i))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }




}
