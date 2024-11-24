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

    use Time.LocalDate
    use Time.LocalDate.{LocalDate}

    import java.time.{LocalDate => JLocalDate}
    import java.time.chrono.{ChronoLocalDate}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around a Java LocalDate.
    ///
    pub enum LocalDate(JLocalDate)

    ///
    /// Returns the given date `x` as a string using the Java builtin toString method.
    ///
    instance ToString[LocalDate] {
        pub def toString(x: LocalDate): String =
            let LocalDate(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDate] {
        pub def fromString(s: String): Option[LocalDate] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs: CharSequence = checked_cast(s1);
                LocalDate(unsafe JLocalDate.parse(cs))
            }) |> Result.toOption
    }

    instance Eq[LocalDate] {
        pub def eq(x: LocalDate, y: LocalDate): Bool =
            let LocalDate(x1) = x;
            let LocalDate(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }

    instance Hash[LocalDate] {
        pub def hash(x: LocalDate): Int32 =
            let LocalDate(x1) = x;
            unsafe x1.hashCode()
    }


    instance Order[LocalDate] {
        pub def compare(x: LocalDate, y: LocalDate): Comparison =
            let LocalDate(x1) = x;
            let LocalDate(y1) = y;
            let cy1 = (checked_cast(y1) : ChronoLocalDate);
            unsafe x1.compareTo(cy1) |> Comparison.fromInt32
    }

}

mod Time.LocalDate {

    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}
    use Time.Format.DateFormat
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.DayOfWeek
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.Month
    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time.Period
    use Time.Period.{Period}
    use Time.YearMonth
    use Time.YearMonth.{YearMonth}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}

    import java.time.{LocalDate => JLocalDate}
    import java.time.chrono.{ChronoLocalDate => JChronoLocalDate}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{IsoFields => JIsoFields}
    import java.time.temporal.{Temporal => JTemporal}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.time.temporal.{TemporalAdjuster => JTemporalAdjuster}
    import java.time.temporal.{TemporalAdjusters => JTemporalAdjusters}
    import java.time.temporal.{TemporalField => JTemporalField}
    import java.time.temporal.{WeekFields => JWeekFields}
    import java.lang.{Object, CharSequence}
    import java.lang.{Exception => JException}

    /// Unwrap

    pub def getLocalDate(x: LocalDate): JLocalDate = 
        let LocalDate(x1) = x;
        x1


    pub def asTemporalAccessor(x: LocalDate): TemporalAccessor = 
        let LocalDate(x1) = x;
        let cx1: JTemporalAccessor = checked_cast(x1);
        TemporalAccessor(cx1)


    // pub def fromJavaObject(o: ##java.lang.Object): LocalDate = 
    //     LocalDate(unchecked_cast(o as ##java.time.LocalDate))

    // Constructors

    pub def localDate(r: {year = Int32, month = Int32, dayOfMonth = Int32}): LocalDate =
        LocalDate(unsafe JLocalDate.of(r#year, r#month, r#dayOfMonth))

    pub def localDateWithMonth(r: {year = Int32, month = Month, dayOfMonth = Int32}): LocalDate =
        let m1 = Time.Month.marshalMonth(r#month);
        LocalDate(unsafe JLocalDate.of(r#year, m1, r#dayOfMonth))

    // `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate \ IO = LocalDate(JLocalDate.now())

    ///
    /// Returns the current date from the system clock using zoneId.
    ///
    pub def nowWithZoneId(zoneId: ZoneId): LocalDate \ IO =
        let ZoneId(z1) = zoneId;
        LocalDate(JLocalDate.now(z1))

    ///
    /// ___
    ///
    pub def epoch(): LocalDate = LocalDate(unsafe JLocalDate.EPOCH)

    /// `at` functions

    pub def atStartOfDay(x: LocalDate): LocalDateTime =
        let LocalDate(x1) = x;
        LocalDateTime(unsafe x1.atStartOfDay())

    pub def atStartOfDayWithZoneId(x: LocalDate, zoneId: ZoneId): ZonedDateTime =
        let LocalDate(x1) = x;
        let ZoneId(z1) = zoneId;
        ZonedDateTime(unsafe x1.atStartOfDay(z1))

    pub def atTimeWithLocalTime(x: LocalDate, t: LocalTime): LocalDateTime =
        let LocalDate(x1) = x;
        let LocalTime(t1) = t;
        LocalDateTime(unsafe x1.atTime(t1))

    pub def atTimeWithOffsetTime(x: LocalDate, t: OffsetTime): OffsetDateTime =
        let LocalDate(x1) = x;
        let OffsetTime(t1) = t;
        OffsetDateTime(unsafe x1.atTime(t1))

    /// ## `from` functions

    pub def ofInstant(zone: {zone = ZoneId}, x: InstantZ): LocalDate =
        let InstantZ(x1) = x;
        let ZoneId(z1) = zone#zone;
        LocalDate(unsafe JLocalDate.ofInstant(x1, z1))

    pub def ofEpochDay(x: Int64): LocalDate =
        LocalDate(unsafe JLocalDate.ofEpochDay(x))


    ///  `fromTemporalAccessor` specialized
    pub def fromTemporalAccessor(x: TemporalAccessor): LocalDate = 
        try {
            let TemporalAccessor(x1) = x;
            let x2: JLocalDate = unsafe JLocalDate.from(x1);
            LocalDate(x2)
        } catch {
            case ex: JException => 
                bug!(unsafe ex.getMessage())
        }

    /// TODO - idiomatic Flix is `toSomeDatatype` in the respective module rather than `fromSomeDatatype`
    pub def fromLocalDateTime(x: LocalDateTime): LocalDate = 
        Time.LocalDateTime.asTemporalAccessor(x) 
            |> fromTemporalAccessor

    /// `to` functions

    pub def toEpochDay(x: LocalDate): Int64 =
        let LocalDate(x1) = x;
        let x2: JChronoLocalDate = checked_cast(x1);
        unsafe x2.toEpochDay()


    /// `parse` / `format` functions

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, LocalDate] = 
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let cs: CharSequence  = checked_cast(s1);
            LocalDate(unsafe JLocalDate.parse(cs, fmtr))
        })

    ///
    /// Returns LocalDate `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: LocalDate): String =
        let LocalDate(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)



    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDate, y: LocalDate): Bool =
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        let cy1 = (checked_cast(y1) : JChronoLocalDate);
        unsafe x1.isBefore(cy1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDate, y: LocalDate): Bool =
        let LocalDate(x1) = x;
        let LocalDate(y1) = y;
        let cy1: JChronoLocalDate = checked_cast(y1);
        unsafe x1.isAfter(cy1)


    pub def isLeapYear(x: LocalDate): Bool =
        let LocalDate(x1) = x;
        unsafe x1.isLeapYear()

    // LocalDate functions

    pub def lengthOfMonth(x: LocalDate): Int32 =
        let LocalDate(x1) = x;
        unsafe x1.lengthOfMonth()

    pub def lengthOfYear(x: LocalDate): Int32 =
        let LocalDate(x1) = x;
        unsafe x1.lengthOfYear()


    // pub def datesUntil(rc: Region[r], s: LocalDate, e: LocalDate): Iterator[LocalDate, r, r] = 
    //     import java.time.LocalDate.datesUntil(##java.time.LocalDate): ##java.util.stream.Stream \ {};
    //     let LocalDate(s1) = s;
    //     let LocalDate(e1) = e;
    //     let strm = datesUntil(s1, e1);
    //     let proxy: Proxy[##java.time.LocalDate] = Proxy.Proxy;
    //     fromStream(rc, proxy, strm) |> Iterator.map(d -> LocalDate(d))

    // pub def datesUntilWithStep(rc: Region[r], s: LocalDate, e: LocalDate, step: Period): Iterator[LocalDate, r, r]  = 
    //     import java.time.LocalDate.datesUntil(##java.time.LocalDate, ##java.time.Period): ##java.util.stream.Stream \ {};
    //     let LocalDate(s1) = s;
    //     let LocalDate(e1) = e;
    //     let step1 = Time.Period.getPeriod(step);
    //     let strm = datesUntil(s1, e1, step1);
    //     let proxy: Proxy[##java.time.LocalDate] = Proxy.Proxy;
    //     fromStream(rc, proxy, strm) |> Iterator.map(d -> LocalDate(d))

    /// Candidate from Adaptor in stdlib...
    // pub def fromStream(rc: Region[r], proxy: Proxy[a], strm: ##java.util.stream.Stream): Iterator[a, r, r] =
    //     import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ {};
    //     let iter = iterator(unchecked_cast(strm as ##java.util.stream.BaseStream));
    //     Adaptor.fromIterator(rc, proxy, iter)



    // Getters and Setters

    pub def getDayOfMonth(x: LocalDate): Int32 =
        let LocalDate(x1) = x;
        unsafe x1.getDayOfMonth()

    pub def withDayOfMonth(dayOfMonth: Int32, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.withDayOfMonth(dayOfMonth))


    pub def getDayOfYear(x: LocalDate): Int32 =
        let LocalDate(x1) = x;
        unsafe x1.getDayOfYear()

    pub def withDayOfYear(dayOfYear: Int32, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.withDayOfYear(dayOfYear))


    pub def withMonth(month: Int32, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.withMonth(month))

    pub def getYear(x: LocalDate): Int32 =
        let LocalDate(x1) = x;
        unsafe x1.getYear()

    pub def withYear(year: Int32, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.withYear(year))


    pub def getDayOfWeek(x: LocalDate): DayOfWeek =
        let LocalDate(x1) = x;
        Time.DayOfWeek.unmarshalDayOfWeek(unsafe x1.getDayOfWeek())


    pub def getMonth(x: LocalDate): Month =
        let LocalDate(x1) = x;
        Time.Month.unmarshalMonth(unsafe x1.getMonth())


    pub def getMonthValue(x: LocalDate): Int32 =
        let LocalDate(x1) = x;
        let ans = unsafe x1.getMonth();
        unsafe ans.getValue()



    /// Get / Set Iso

    pub def getDayOfQuarter(x: LocalDate): Int64 = 
        let LocalDate(x1) = x;
        let field = unsafe JIsoFields.DAY_OF_QUARTER;
        unsafe x1.getLong(field)

    pub def withDayOfQuarter(d: Int32, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        let tf1 = unsafe JIsoFields.DAY_OF_QUARTER;
        let ans = unsafe x1.with(tf1, Int32.toInt64(d));
        LocalDate(ans)

    pub def getQuarterOfYear(x: LocalDate): Int64 =  
        let LocalDate(x1) = x;
        let field = unsafe JIsoFields.QUARTER_OF_YEAR;
        unsafe x1.getLong(field)

    pub def withQuarterOfYear(d: Int32, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        let tf1 = unsafe JIsoFields.QUARTER_OF_YEAR;
        let ans = unsafe x1.with(tf1, Int32.toInt64(d));
        LocalDate(ans)

    pub def getWeekOfYear(x: LocalDate): Int64 = 
        let LocalDate(x1) = x;
        let weekFields = unsafe JWeekFields.ISO;
        let field: JTemporalField = unsafe weekFields.weekBasedYear();
        unsafe x1.getLong(field)


    pub def withWeekOfYear(d: Int32, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        let wf1 = unsafe JWeekFields.ISO;
        let tf1 = unsafe wf1.weekBasedYear();
        let ans = unsafe x1.with(tf1, Int32.toInt64(d));
        LocalDate(ans)


    pub def getAlignedDayOfWeekInMonth(x: LocalDate): Int64 =
        let LocalDate(x1) = x;
        let field = unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH;
        unsafe x1.getLong(field)
        
    
    pub def getAlignedDayOfWeekInYear(x: LocalDate): Int64 =
        let LocalDate(x1) = x;
        let field = unsafe JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR;
        unsafe x1.getLong(field)


    pub def getAlignedWeekOfMonth(x: LocalDate): Int64 =
        let LocalDate(x1) = x;
        let field = unsafe JChronoField.ALIGNED_WEEK_OF_MONTH;
        unsafe x1.getLong(field)

    pub def getAlignedWeekOfYear(x: LocalDate): Int64 =
        let LocalDate(x1) = x;
        let field = unsafe JChronoField.ALIGNED_WEEK_OF_YEAR;
        unsafe x1.getLong(field)

    pub def getEra(x: LocalDate): Int64 =
        let LocalDate(x1) = x;
        let field = unsafe JChronoField.ERA;
        unsafe x1.getLong(field)

    pub def adjustMonthDay(i: MonthDay, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        let MonthDay(i1) = i;
        let ta1: JTemporalAdjuster = checked_cast(i1);
        let ans = unsafe x1.with(ta1);
        LocalDate(ans)


    pub def adjustYearMonth(i: YearMonth, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        let YearMonth(i1) = i;
        let ta1: JTemporalAdjuster = checked_cast(i1);
        let ans = unsafe x1.with(ta1);
        LocalDate(ans)


    pub def withEpochDay(i: Int64, x: LocalDate): LocalDate =
        let LocalDate(x1) = x;
        let cf1 = unsafe JChronoField.EPOCH_DAY;
        let ans = unsafe x1.with(cf1, i);
        LocalDate(ans)

    /// DayOfWeek methods

    pub def adjustDayOfWeek(x: DayOfWeek, d: LocalDate): LocalDate = 
        let LocalDate(d1) = d;
        let x1 = Time.DayOfWeek.marshalDayOfWeek(x);
        let t1: JTemporal = checked_cast(d1);
        let t2 = unsafe x1.adjustInto(t1);
        let ans = unchecked_cast(t2 as JLocalDate);
        LocalDate(ans)

    
    pub def adjustToFirstDayOfMonth(x: LocalDate): LocalDate = 
        let LocalDate(x1) = x;
        let a1 = unsafe JTemporalAdjusters.firstDayOfMonth();
        let ans = unsafe x1.with(a1);
        LocalDate(ans)

    pub def adjustToFirstDayOfNextMonth(x: LocalDate): LocalDate = 
        let LocalDate(x1) = x;
        let a1 = unsafe JTemporalAdjusters.firstDayOfNextMonth();
        let ans = unsafe x1.with(a1);
        LocalDate(ans)

    pub def adjustToFirstDayOfNextYear(x: LocalDate): LocalDate = 
        let LocalDate(x1) = x;
        let a1 = unsafe JTemporalAdjusters.firstDayOfNextYear();
        let ans = unsafe x1.with(a1);
        LocalDate(ans)

    pub def adjustToLastDayOfMonth(x: LocalDate): LocalDate =  
        let LocalDate(x1) = x;
        let a1 = unsafe JTemporalAdjusters.lastDayOfMonth();
        let ans = unsafe x1.with(a1);
        LocalDate(ans)


    pub def adjustToLastDayOfYear(x: LocalDate): LocalDate =  
        let LocalDate(x1) = x;
        let a1 = unsafe JTemporalAdjusters.lastDayOfYear();
        let ans = unsafe x1.with(a1);
        LocalDate(ans)


    /// plus / minus functions

    pub def plusYears(x: LocalDate, years: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.plusYears(years))

    pub def minusYears(x: LocalDate, years: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.minusYears(years))

    pub def plusMonths(x: LocalDate, months: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.plusMonths(months))

    pub def minusMonths(x: LocalDate, months: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.minusMonths(months))

    pub def plusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.plusWeeks(weeks))

    pub def minusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.minusWeeks(weeks))

    pub def plusDays(x: LocalDate, days: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.plusDays(days))

    pub def minusDays(x: LocalDate, days: Int64): LocalDate =
        let LocalDate(x1) = x;
        LocalDate(unsafe x1.minusDays(days))


    pub def plusDecades(x: LocalDate, i: Int64): LocalDate =
        let LocalDate(x1) = x;
        let u = unsafe JChronoUnit.DECADES;
        let x2 = unsafe x1.plus(i, u);
        LocalDate(x2)


    pub def minusDecades(x: LocalDate, i: Int64): LocalDate = 
        let LocalDate(x1) = x;
        let u = unsafe JChronoUnit.DECADES;
        let x2 = unsafe x1.minus(i, u);
        LocalDate(x2)

    pub def plusCenturies(x: LocalDate, i: Int64): LocalDate = 
        let LocalDate(x1) = x;
        let u = unsafe JChronoUnit.CENTURIES;
        let x2 = unsafe x1.plus(i, u);
        LocalDate(x2)


    pub def minusCenturies(x: LocalDate, i: Int64): LocalDate = 
        let LocalDate(x1) = x;
        let u = unsafe JChronoUnit.CENTURIES;
        let x2 = unsafe x1.minus(i, u);
        LocalDate(x2)


    pub def plusMillenia(x: LocalDate, i: Int64): LocalDate = 
        let LocalDate(x1) = x;
        let u = unsafe JChronoUnit.MILLENNIA;
        let x2 = unsafe x1.plus(i, u);
        LocalDate(x2)

    pub def minusMillenia(x: LocalDate, i: Int64): LocalDate = 
        let LocalDate(x1) = x;
        let u = unsafe JChronoUnit.MILLENNIA;
        let x2 = unsafe x1.minus(i, u);
        LocalDate(x2)


    // Period methods

    pub def plusPeriod(x: LocalDate, p: Period): LocalDate =
        let LocalDate(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe p1.addTo(x1);
        let ans = unchecked_cast(t1 as JLocalDate);
        LocalDate(ans)
    
    pub def minusPeriod(x: LocalDate, p: Period): LocalDate =
        let LocalDate(x1) = x;
        let Period(p1) = p;
        let t1 = unsafe p1.subtractFrom(x1);
        let ans = unchecked_cast(t1 as JLocalDate);
        LocalDate(ans)

    // between / until functions

    pub def daysUntil(begin: {begin = LocalDate}, end: {end = LocalDate}): Int64 = 
        let LocalDate(b1) = begin#begin;
        let LocalDate(e1) = end#end;
        let t1: JTemporal = checked_cast(e1);
        let u1 = unsafe JChronoUnit.DAYS;
        unsafe b1.until(t1, u1)

    pub def monthsUntil(begin: {begin = LocalDate}, end: {end = LocalDate}): Int64 = 
        let LocalDate(b1) = begin#begin;
        let LocalDate(e1) = end#end;
        let t1: JTemporal = checked_cast(e1);
        let u1 = unsafe JChronoUnit.MONTHS;
        unsafe b1.until(t1, u1)

    pub def yearsUntil(begin: {begin = LocalDate}, end: {end = LocalDate}): Int64 = 
        let LocalDate(b1) = begin#begin;
        let LocalDate(e1) = end#end;
        let t1: JTemporal = checked_cast(e1);
        let u1 = unsafe JChronoUnit.YEARS;
        unsafe b1.until(t1, u1)

    pub def quarterYearsUntil(begin: {begin = LocalDate}, end: {end = LocalDate}): Int64 = 
        let LocalDate(b1) = begin#begin;
        let LocalDate(e1) = end#end;
        let t1: JTemporal = checked_cast(e1);
        let u1 = unsafe JIsoFields.QUARTER_YEARS;
        unsafe b1.until(t1, u1)

    // generic helper functions

    // def getHelper(field: ##java.time.temporal.TemporalField, x: LocalDate): Int64 = 
    //     import java.time.LocalDate.getLong(##java.time.temporal.TemporalField): Int64 \ {};
    //     try {
    //         let LocalDate(x1) = x;
    //         getLong(x1, field)
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }


    // def plusHelper(x: LocalDate, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalDate =
    //     import java.time.LocalDate.plus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate \ {};         
    //     try {
    //         let LocalDate(x1) = x;
    //         LocalDate(plus(x1, amount, temporalUnit))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }



    // def minusHelper(x: LocalDate, amount: Int64, temporalUnit: ##java.time.temporal.TemporalUnit): LocalDate =
    //     import java.time.LocalDate.minus(Int64, ##java.time.temporal.TemporalUnit): ##java.time.LocalDate \ {};         
    //     try {
    //         let LocalDate(x1) = x;
    //         LocalDate(minus(x1, amount, temporalUnit))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }



    // def withTemporalAdjusterHelper(adj: ##java.time.temporal.TemporalAdjuster, x: LocalDate): LocalDate =
    //     import java.time.LocalDate.with(##java.time.temporal.TemporalAdjuster): ##java.time.LocalDate \ {} as withTA;         
    //     try {
    //         let LocalDate(x1) = x;
    //         LocalDate(withTA(x1, adj))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }


    // def withTemporalFieldHelper(field: ##java.time.temporal.TemporalField, i: Int64, x: LocalDate): LocalDate =
    //     import java.time.LocalDate.with(##java.time.temporal.TemporalField, Int64): ##java.time.LocalDate \ {} as with1;
    //     try {
    //         let LocalDate(x1) = x;
    //         LocalDate(with1(x1, field, i))
    //     } catch {
    //         // case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
    //         case ex: ##java.lang.Exception => {
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //         }
    //     }

}
