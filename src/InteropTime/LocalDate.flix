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


pub mod InteropTime.LocalDate {


    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.DateFormatter
    use InteropTime.DayOfWeek.DayOfWeek
    use InteropTime.InstantZ.InstantZ
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalTime.LocalTime
    use InteropTime.Month.Month
    use InteropTime.MonthDay.MonthDay
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetTime.OffsetTime
    use InteropTime.Period.Period
    use InteropTime.YearMonth.YearMonth
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId

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

    ///
    /// A wrapper around a Java LocalDate
    ///
    pub enum LocalDate(JLocalDate)

    ///
    /// Returns the given date `x` as a string using the Java builtin toString method.
    ///
    instance ToString[LocalDate] {
        pub def toString(x: LocalDate): String =
            let LocalDate.LocalDate(x1) = x;
            unsafe IO { x1.toString() }
    }

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should be ____.
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    instance FromString[LocalDate] {
        pub def fromString(s: String): Option[LocalDate] =
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JLocalDate.parse(s1) };
                Some(LocalDate.LocalDate(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[LocalDate] {
        pub def eq(x: LocalDate, y: LocalDate): Bool =
            let LocalDate.LocalDate(x1) = x;
            let LocalDate.LocalDate(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[LocalDate] {
        pub def hash(x: LocalDate): Int32 =
            let LocalDate.LocalDate(x1) = x;
            unsafe IO { x1.hashCode() }
    }


    instance Order[LocalDate] {
        pub def compare(x: LocalDate, y: LocalDate): Comparison =
            let LocalDate.LocalDate(x1) = x;
            let LocalDate.LocalDate(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }


    instance ToJava[LocalDate] {
        type Out = JLocalDate
        pub def toJava(x: LocalDate): JLocalDate = 
            let LocalDate.LocalDate(x1) = x;
            x1
    }

    instance ToFlix[LocalDate] {
        type In = JLocalDate
        pub def toFlix(x: JLocalDate): LocalDate = 
            LocalDate.LocalDate(x)
    }


    // Constructors

    pub def localDate(year: {year = Int32}, 
                        month: {month = Int32}, 
                        dayOfMonth: {dayOfMonth = Int32}): LocalDate =
        let ans = unsafe IO { JLocalDate.of(year#year, month#month, dayOfMonth#dayOfMonth) };
        ToFlix.toFlix(ans)

    pub def localDateWithMonth(year: {year = Int32}, 
                                month: {month = Month}, 
                                dayOfMonth: {dayOfMonth = Int32}): LocalDate =
        
        AdaptorExtras.op(month#month, month1 -> 
            unsafe IO { JLocalDate.of(year#year, month1, dayOfMonth#dayOfMonth) }
        )

    // `now` and "abstract constructors" (e.g. `epoch`)

    ///
    /// Returns the current date from the system clock.
    ///
    pub def now(): LocalDate \ IO = LocalDate(JLocalDate.now())

    ///
    /// Returns the current date from the system clock using zoneId.
    ///
    pub def nowWithZoneId(zone: ZoneId): LocalDate \ IO =
        AdaptorExtras.op(zone, zone1 -> JLocalDate.now(zone1))

    ///
    /// ___
    ///
    pub def epoch(): LocalDate = LocalDate(unsafe IO { JLocalDate.EPOCH } )

    /// `at` functions

    pub def atStartOfDay(x: LocalDate): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.atStartOfDay() })

    pub def atStartOfDayWithZoneId(x: LocalDate, zone: ZoneId): ZonedDateTime =
        AdaptorExtras.op2(x, zone, (x1, zone1) -> unsafe IO { x1.atStartOfDay(zone1) })

    pub def atTimeWithLocalTime(x: LocalDate, t: LocalTime): LocalDateTime =
        AdaptorExtras.op2(x, t, (x1, t1) -> unsafe IO { x1.atTime(t1) })

    pub def atTimeWithOffsetTime(x: LocalDate, t: OffsetTime): OffsetDateTime =
        AdaptorExtras.op2(x, t, (x1, t1) -> unsafe IO { x1.atTime(t1) })

    /// ## `from` functions

    pub def ofInstant(zone: ZoneId, x: InstantZ): LocalDate =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> unsafe IO { JLocalDate.ofInstant(x1, zone1) })

    pub def ofEpochDay(x: Int64): LocalDate =
        AdaptorExtras.of(() -> unsafe IO { JLocalDate.ofEpochDay(x) })


    ///  `fromTemporalAccessor` specialized

    /// TODO - idiomatic Flix is `toSomeDatatype` in the respective module rather than `fromSomeDatatype`
    pub def fromLocalDateTime(x: LocalDateTime): LocalDate = 
        AdaptorExtras.op(x, x1 -> unsafe IO { JLocalDate.$from(x1) })

    /// `to` functions

    pub def toEpochDay(x: LocalDate): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toEpochDay() })


    /// `parse` / `format` functions

    ///
    /// Parse the string `s` as a LocalDate, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateFormatter, s: String): Result[String, LocalDate] = 
        AdaptorExtras.opWithResult(formatter, formatter1 -> {
            let s1 = String.trim(s);
            unsafe IO { JLocalDate.parse(s1, formatter1) }
        })

    ///
    /// Returns LocalDate `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateFormatter, x: LocalDate): String =
        AdaptorExtras.extract2(formatter, x, (formatter1, x1) -> unsafe IO { x1.format(formatter1) })



    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: LocalDate, y: LocalDate): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: LocalDate, y: LocalDate): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })


    pub def isLeapYear(x: LocalDate): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isLeapYear() })

    // LocalDate functions

    pub def lengthOfMonth(x: LocalDate): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.lengthOfMonth() })

    pub def lengthOfYear(x: LocalDate): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.lengthOfYear() })


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
    //     let step1 = InteropTime.Period.getPeriod(step);
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
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfMonth() })

    pub def withDayOfMonth(dayOfMonth: Int32, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfMonth(dayOfMonth) })


    pub def getDayOfYear(x: LocalDate): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfYear() })

    pub def withDayOfYear(dayOfYear: Int32, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withDayOfYear(dayOfYear) })


    pub def withMonth(month: Int32, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMonth(month) })

    pub def getYear(x: LocalDate): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getYear() })

    pub def withYear(year: Int32, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withYear(year) })


    pub def getDayOfWeek(x: LocalDate): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDayOfWeek() })


    pub def getMonth(x: LocalDate): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getMonth() })


    pub def getMonthValue(x: LocalDate): Int32 =
        AdaptorExtras.extract(x, x1 -> {
            let m1 = unsafe IO { x1.getMonth() };
            unsafe IO { m1.getValue() }
        })



    /// Get / Set Iso
    
    pub def getDayOfQuarter(x: LocalDate): Int64 = 
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.getLong(JIsoFields.DAY_OF_QUARTER) }
        )


    pub def withDayOfQuarter(d: Int32, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.$with(JIsoFields.DAY_OF_QUARTER, Int32.toInt64(d)) }
        )

    pub def getQuarterOfYear(x: LocalDate): Int64 =  
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.getLong(JIsoFields.QUARTER_OF_YEAR) }
        )

    pub def withQuarterOfYear(d: Int32, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.$with(JIsoFields.QUARTER_OF_YEAR, Int32.toInt64(d)) }
        )

    pub def getWeekOfYear(x: LocalDate): Int64 = 
        AdaptorExtras.extract(x, x1 -> {
            let weekFields = unsafe IO { JWeekFields.ISO };
            let field: JTemporalField = unsafe IO { weekFields.weekBasedYear() };
            unsafe IO { x1.getLong(field) }
        })


    pub def withWeekOfYear(d: Int32, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> {
            let weekFields = unsafe IO { JWeekFields.ISO };
            let field = unsafe IO { weekFields.weekBasedYear() };
            unsafe IO { x1.$with(field, Int32.toInt64(d)) }
        })


    pub def getAlignedDayOfWeekInMonth(x: LocalDate): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let field = unsafe IO { JChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH };
            let field1: JTemporalField = checked_cast(field);
            unsafe IO { x1.getLong(field1) }
        })
        
    
    pub def getAlignedDayOfWeekInYear(x: LocalDate): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let field = unsafe IO { JChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR };
            let field1: JTemporalField = checked_cast(field);
            unsafe IO { x1.getLong(field1) }
        })


    pub def getAlignedWeekOfMonth(x: LocalDate): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let field = unsafe IO { JChronoField.ALIGNED_WEEK_OF_MONTH };
            let field1: JTemporalField = checked_cast(field);
            unsafe IO { x1.getLong(field1) }
        })


    pub def getAlignedWeekOfYear(x: LocalDate): Int64 =
        AdaptorExtras.extract(x, x1 -> {
            let field = unsafe IO { JChronoField.ALIGNED_WEEK_OF_YEAR };
            let field1: JTemporalField = checked_cast(field);
            unsafe IO { x1.getLong(field1) }
        })


    pub def getEra(x: LocalDate): Int64 =
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { x1.getLong(JChronoField.ERA) }
        )

    pub def adjustMonthDay(md: MonthDay, x: LocalDate): LocalDate =
        AdaptorExtras.op2(md, x, (md1, x1) -> unsafe IO { x1.$with(md1) })


    pub def adjustYearMonth(ym: YearMonth, x: LocalDate): LocalDate =
        AdaptorExtras.op2(ym, x, (ym1, x1) -> unsafe IO { x1.$with(ym1) })


    pub def withEpochDay(i: Int64, x: LocalDate): LocalDate =
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.$with(JChronoField.EPOCH_DAY, i) }
        )

    /// DayOfWeek methods

    pub def adjustDayOfWeek(x: DayOfWeek, ld: LocalDate): LocalDate = 
        AdaptorExtras.op2(x, ld, (x1, ld1) -> {
            let d1 = unsafe IO { x1.adjustInto(ld1) };
            unchecked_cast(d1 as JLocalDate)
        })

    
    pub def adjustToFirstDayOfMonth(x: LocalDate): LocalDate = 
        AdaptorExtras.op(x, x1 -> {
            let d1 = unsafe IO { JTemporalAdjusters.firstDayOfMonth() };
            unsafe IO { x1.$with(d1) }
        })

    pub def adjustToFirstDayOfNextMonth(x: LocalDate): LocalDate = 
        AdaptorExtras.op(x, x1 -> {
            let d1 = unsafe IO { JTemporalAdjusters.firstDayOfNextMonth() };
            unsafe IO { x1.$with(d1) }
        })

    pub def adjustToFirstDayOfNextYear(x: LocalDate): LocalDate = 
        AdaptorExtras.op(x, x1 -> {
            let d1 = unsafe IO { JTemporalAdjusters.firstDayOfNextYear() };
            unsafe IO { x1.$with(d1) }
        })

    pub def adjustToLastDayOfMonth(x: LocalDate): LocalDate =  
        AdaptorExtras.op(x, x1 -> {
            let d1 = unsafe IO { JTemporalAdjusters.lastDayOfMonth() };
            unsafe IO { x1.$with(d1) }
        })


    pub def adjustToLastDayOfYear(x: LocalDate): LocalDate =  
        AdaptorExtras.op(x, x1 -> {
            let d1 = unsafe IO { JTemporalAdjusters.lastDayOfYear() };
            unsafe IO { x1.$with(d1) }
        })


    /// plus / minus functions

    pub def plusYears(x: LocalDate, years: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusYears(years) })

    pub def minusYears(x: LocalDate, years: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusYears(years) })

    pub def plusMonths(x: LocalDate, months: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusMonths(months) })

    pub def minusMonths(x: LocalDate, months: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusMonths(months) })

    pub def plusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusWeeks(weeks) })

    pub def minusWeeks(x: LocalDate, weeks: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusWeeks(weeks) })

    pub def plusDays(x: LocalDate, days: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plusDays(days) })

    pub def minusDays(x: LocalDate, days: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minusDays(days) })


    pub def plusDecades(x: LocalDate, i: Int64): LocalDate =
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.plus(i, JChronoUnit.DECADES) }
        )


    pub def minusDecades(x: LocalDate, i: Int64): LocalDate = 
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.minus(i, JChronoUnit.DECADES) }
        )

    pub def plusCenturies(x: LocalDate, i: Int64): LocalDate = 
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.plus(i, JChronoUnit.CENTURIES) }
        )


    pub def minusCenturies(x: LocalDate, i: Int64): LocalDate = 
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.minus(i, JChronoUnit.CENTURIES) }
        )


    pub def plusMillenia(x: LocalDate, i: Int64): LocalDate = 
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.plus(i, JChronoUnit.MILLENNIA) }
        )

    pub def minusMillenia(x: LocalDate, i: Int64): LocalDate = 
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.minus(i, JChronoUnit.MILLENNIA) }
        )


    // Period methods

    pub def plusPeriod(x: LocalDate, p: Period): LocalDate =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.addTo(x1) };
            unchecked_cast(t1 as JLocalDate)
        })  
    
    pub def minusPeriod(x: LocalDate, p: Period): LocalDate =
        AdaptorExtras.op2(x, p, (x1, p1) -> {
            let t1 = unsafe IO { p1.subtractFrom(x1) };
            unchecked_cast(t1 as JLocalDate)
        })

    // between / until functions

    pub def daysUntil(begin: {begin = LocalDate}, end: {end = LocalDate}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) ->
            unsafe IO { begin1.until(end1, JChronoUnit.DAYS) }
        )

    pub def monthsUntil(begin: {begin = LocalDate}, end: {end = LocalDate}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.MONTHS) }
        )

    pub def yearsUntil(begin: {begin = LocalDate}, end: {end = LocalDate}): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JChronoUnit.YEARS) }
        )

    pub def quarterYearsUntil(begin: {begin = LocalDate }, end: {end = LocalDate }): Int64 = 
        AdaptorExtras.extract2(begin#begin, end#end, (begin1, end1) -> 
            unsafe IO { begin1.until(end1, JIsoFields.QUARTER_YEARS) }
        )


}

