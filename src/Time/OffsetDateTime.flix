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
    
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Interop.Time.Temporal.TemporalAccessor
    use Interop.Time.Temporal.TemporalAccessor.TemporalAccessor

    ///
    /// A wrapper around a Java OffsetDateTime.
    ///
    pub enum OffsetDateTime(##java.time.OffsetDateTime)

    ///
    /// Returns the given date-time `x` as a String using ISO-8601 representation.
    ///
    instance ToString[OffsetDateTime] {
        pub def toString(x: OffsetDateTime): String =
            import java.time.OffsetDateTime.toString(): String \ {};
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
            Result.tryCatch(_ -> {
                import static java.time.OffsetDateTime.parse(##java.lang.CharSequence): ##java.time.OffsetDateTime \ {};
                let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
                OffsetDateTime(parse(cs))
            }) |> Result.toOption
    }

    instance Eq[OffsetDateTime] {
        pub def eq(x: OffsetDateTime, y: OffsetDateTime): Bool =
            import java.time.OffsetDateTime.equals(##java.lang.Object): Bool \ {};
            let OffsetDateTime(x1) = x;
            let OffsetDateTime(y1) = y;
            equals(x1, checked_cast(y1))

    }

    instance Hash[OffsetDateTime] {
        pub def hash(x: OffsetDateTime): Int32 =
            import java.time.OffsetDateTime.hashCode(): Int32 \ {};
            let OffsetDateTime(x1) = x;
            hashCode(x1)
    }

    instance Order[OffsetDateTime] {
        pub def compare(x: OffsetDateTime, y: OffsetDateTime): Comparison =
            import java.time.OffsetDateTime.compareTo(##java.time.OffsetDateTime): Int32 \ {};
            let OffsetDateTime(x1) = x;
            let OffsetDateTime(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }

    instance Interop.Flix.Marshal[OffsetDateTime] {
        pub def toJavaObject(x: OffsetDateTime): ##java.lang.Object =
            let OffsetDateTime(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): OffsetDateTime = 
            OffsetDateTime(unchecked_cast(o as ##java.time.OffsetDateTime))
    }

    instance Interop.Time.Temporal.ImpTemporalAccessor[OffsetDateTime] {
        pub def toTemporalAccessor(x: OffsetDateTime): TemporalAccessor =
            let OffsetDateTime(x1) = x;
            TemporalAccessor(unchecked_cast(x1 as ##java.time.temporal.TemporalAccessor))

        pub def fromTemporalAccessor(x: TemporalAccessor): OffsetDateTime = 
            let TemporalAccessor(x1) = x;
            OffsetDateTime(unchecked_cast(x1 as ##java.time.OffsetDateTime))
    }

}

mod Time.OffsetDateTime {

    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.Format.DateTimeFormat
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.DayOfWeek
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.Month
    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time.Period
    use Time.YearMonth
    use Time.YearMonth.{YearMonth}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    /// ## Unwrap

    pub def getOffsetDateTime(x: OffsetDateTime): ##java.time.OffsetDateTime = 
        let OffsetDateTime(x1) = x;
        x1

    /// ## Constructors

    pub def offsetDateTime(r: {year = Int32, month = Int32, dayOfMonth = Int32, hour = Int32, minute = Int32,
                    second = Int32, nanoSecond = Int32, offset = ZoneOffset}): OffsetDateTime =
        import static java.time.OffsetDateTime.of(Int32, Int32, Int32, Int32, Int32, Int32, Int32, ##java.time.ZoneOffset): ##java.time.OffsetDateTime \ {};
        let ZoneOffset(o1) = r.offset;
        OffsetDateTime(of(r.year, r.month, r.dayOfMonth, r.hour, r.minute, r.second, r.nanoSecond, o1))


    /// ## `now` functions

    ///
    /// Returns the current date-time from the system clock using the system zone id.
    ///
    pub def now(): OffsetDateTime \ IO =
        import static java.time.OffsetDateTime.now(): ##java.time.OffsetDateTime \ IO;
        OffsetDateTime(now())

    ///
    /// Returns the current date-time from the system clock in the specified time zone.
    ///
    pub def nowWithZoneId(zone: ZoneId): OffsetDateTime \ IO =
        import static java.time.OffsetDateTime.now(##java.time.ZoneId): ##java.time.OffsetDateTime \ IO;
        let ZoneId(z1) = zone;
        OffsetDateTime(now(z1))

    /// ## `at` functions

    pub def atZoneSameInstant(zone: {zone = ZoneId}, x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.atZoneSameInstant(##java.time.ZoneId): ##java.time.ZonedDateTime \ {};
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone.zone;
        ZonedDateTime(atZoneSameInstant(x1, z1))

    pub def atZoneSimilarLocal(zone: {zone = ZoneId}, x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.atZoneSimilarLocal(##java.time.ZoneId): ##java.time.ZonedDateTime \ {};
        let OffsetDateTime(x1) = x;
        let ZoneId(z1) = zone.zone;
        ZonedDateTime(atZoneSimilarLocal(x1, z1))


    pub def fromLocalDateTime(offset: {offset = ZoneOffset}, dateTime: LocalDateTime): OffsetDateTime =
        import static java.time.OffsetDateTime.of(##java.time.LocalDateTime, ##java.time.ZoneOffset): ##java.time.OffsetDateTime \ {};
        let LocalDateTime(dt1) = dateTime;
        let ZoneOffset(o1) = offset.offset;
        OffsetDateTime(of(dt1, o1))


    /// ## `from` functions

    pub def fromLocalDateLocalTime(offset: {offset = ZoneOffset}, date: LocalDate, time: LocalTime): OffsetDateTime =
        import static java.time.OffsetDateTime.of(##java.time.LocalDate, ##java.time.LocalTime, ##java.time.ZoneOffset): ##java.time.OffsetDateTime \ {};
        let LocalDate(d1) = date;
        let LocalTime(t1) = time;
        let ZoneOffset(o1) = offset.offset;
        OffsetDateTime(of(d1, t1, o1))

    /// `fromTemporalAccessor` specialized

    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): OffsetDateTime = 
        import static java.time.OffsetDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.OffsetDateTime \ {} as fromTA;
        try {
            OffsetDateTime(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromZonedDateTime(x: ZonedDateTime): OffsetDateTime = 
        let x1 = unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor);
        fromTemporalAccessorHelper(x1)

    /// ## `to` functions


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDate(x: OffsetDateTime): LocalDate =
        import java.time.OffsetDateTime.toLocalDate(): ##java.time.LocalDate \ {};
        let OffsetDateTime(x1) = x;
        LocalDate(toLocalDate(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalTime(x: OffsetDateTime): LocalTime =
        import java.time.OffsetDateTime.toLocalTime(): ##java.time.LocalTime \ {};
        let OffsetDateTime(x1) = x;
        LocalTime(toLocalTime(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toLocalDateTime(x: OffsetDateTime): LocalDateTime =
        import java.time.OffsetDateTime.toLocalDateTime(): ##java.time.LocalDateTime \ {};
        let OffsetDateTime(x1) = x;
        LocalDateTime(toLocalDateTime(x1))


    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toOffsetTime(x: OffsetDateTime): OffsetTime =
        import java.time.OffsetDateTime.toOffsetTime(): ##java.time.OffsetTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetTime(toOffsetTime(x1))

    ///
    /// Returns the given date-time `x` as __.
    ///
    pub def toZonedDateTime(x: OffsetDateTime): ZonedDateTime =
        import java.time.OffsetDateTime.toZonedDateTime(): ##java.time.ZonedDateTime \ {};
        let OffsetDateTime(x1) = x;
        ZonedDateTime(toZonedDateTime(x1))


    pub def toInstant(x: OffsetDateTime): InstantZ =
        import java.time.OffsetDateTime.toInstant(): ##java.time.Instant \ {};
        let OffsetDateTime(x1) = x;
        InstantZ(toInstant(x1))

    pub def toEpochSecond(x: OffsetDateTime): Int64 =
        import java.time.OffsetDateTime.toEpochSecond(): Int64 \ {};
        let OffsetDateTime(x1) = x;
        toEpochSecond(x1)

    /// ## `parse` / `format` functions
    
    ///
    /// Parse the string `s` as a OffsetDateTime, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `OK(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateTimeFormat], s: String): Result[String, OffsetDateTime] =
        Result.tryCatch(_ -> {
            import static java.time.OffsetDateTime.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.OffsetDateTime \ {};
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            OffsetDateTime(parse(cs, fmtr))
        })


    ///
    /// Returns OffsetDateTime `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateTimeFormat], x: OffsetDateTime): String =
        import java.time.OffsetDateTime.format(##java.time.format.DateTimeFormatter): String \ {};
        let OffsetDateTime(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isBefore(##java.time.OffsetDateTime): Bool \ {};
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isAfter(##java.time.OffsetDateTime): Bool \ {};
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        isAfter(x1, y1)


    pub def isInstantEqual(x: OffsetDateTime, y: OffsetDateTime): Bool =
        import java.time.OffsetDateTime.isEqual(##java.time.OffsetDateTime): Bool \ {};
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        isEqual(x1, y1)


    pub def isAmOfDay(x: OffsetDateTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
        getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 0

    pub def isPmOfDay(x: OffsetDateTime): Bool = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField \ {} as get_AMPM_OF_DAY;        
        getHelper(unchecked_cast(get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField), x) == 1

    /// ## OffsetDateTime functions

    pub def timeLineOrder(x: OffsetDateTime, y: OffsetDateTime): Comparison =
        import static java.time.OffsetDateTime.timeLineOrder(): ##java.util.Comparator \ {};
        import java.util.Comparator.compare(##java.lang.Object, ##java.lang.Object): Int32 \ {};
        let OffsetDateTime(x1) = x;
        let OffsetDateTime(y1) = y;
        let cmp = timeLineOrder();
        compare(cmp, checked_cast(x1), checked_cast(y1)) |> Comparison.fromInt32

    /// ## Getters and Setters
    /// Get / Set...

    pub def getOffset(x: OffsetDateTime): ZoneOffset =
        import java.time.OffsetDateTime.getOffset(): ##java.time.ZoneOffset \ {};
        let OffsetDateTime(x1) = x;
        ZoneOffset(getOffset(x1))

    pub def withOffsetSameInstant(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withOffsetSameInstant(##java.time.ZoneOffset): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(withOffsetSameInstant(x1, o1))

    pub def withOffsetSameLocal(offset: ZoneOffset, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withOffsetSameLocal(##java.time.ZoneOffset): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        let ZoneOffset(o1) = offset;
        OffsetDateTime(withOffsetSameLocal(x1, o1))


    pub def getNano(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getNano(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getNano(x1)

    pub def withNano(nano: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withNano(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withNano(x1, nano))

    pub def getSecond(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getSecond(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getSecond(x1)

    pub def withSecond(second: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withSecond(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withSecond(x1, second))


    pub def getMinute(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMinute(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getMinute(x1)

    pub def withMinute(minute: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withMinute(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withMinute(x1, minute))


    pub def getHour(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getHour(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getHour(x1)

    pub def withHour(hour: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withHour(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withHour(x1, hour))


    pub def getDayOfWeek(x: OffsetDateTime): DayOfWeek =
        import java.time.OffsetDateTime.getDayOfWeek(): ##java.time.DayOfWeek \ {};
        let OffsetDateTime(x1) = x;
        Time.DayOfWeek.unmarshalDayOfWeek(getDayOfWeek(x1))


    pub def adjustDayOfWeek(x: DayOfWeek, d: OffsetDateTime): OffsetDateTime = 
        import java.time.DayOfWeek.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.DayOfWeek.marshalDayOfWeek(x);
        let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.OffsetDateTime))


    pub def getDayOfMonth(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfMonth(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getDayOfMonth(x1)

    pub def withDayOfMonth(dayOfMonth: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfMonth(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withDayOfMonth(x1, dayOfMonth))


    pub def getDayOfYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getDayOfYear(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getDayOfYear(x1)

    pub def withDayOfYear(dayOfYear: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withDayOfYear(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withDayOfYear(x1, dayOfYear))

    pub def getMonth(x: OffsetDateTime): Month =
        import java.time.OffsetDateTime.getMonth(): ##java.time.Month \ {};
        let OffsetDateTime(x1) = x;
        Time.Month.unmarshalMonth(getMonth(x1))

    pub def getMonthValue(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getMonth(): ##java.time.Month \ {};
        import java.time.Month.getValue(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getValue(getMonth(x1))

    pub def withMonth(month: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withMonth(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withMonth(x1, month))

    pub def getYear(x: OffsetDateTime): Int32 =
        import java.time.OffsetDateTime.getYear(): Int32 \ {};
        let OffsetDateTime(x1) = x;
        getYear(x1)

    pub def withYear(year: Int32, x: OffsetDateTime): OffsetDateTime =
        import java.time.OffsetDateTime.withYear(Int32): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(withYear(x1, year))

    /// MonthDay methods

    pub def getMonthDay(d: OffsetDateTime): MonthDay = 
        import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
        let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
        MonthDay(fromTA(d1))

    pub def adjustMonthDay(x: MonthDay, d: OffsetDateTime): OffsetDateTime = 
        import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.MonthDay.getMonthDay(x);
        let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(adjustInto(x1, d1) as ##java.time.OffsetDateTime))

    /// YearMonth methods

    pub def getYearMonth(d: OffsetDateTime): YearMonth = 
        import static java.time.YearMonth.from(##java.time.temporal.TemporalAccessor): ##java.time.YearMonth \ {} as fromTA;
        let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
        YearMonth(fromTA(d1))

    pub def adjustYearMonth(x: YearMonth, dt: OffsetDateTime): OffsetDateTime = 
        import java.time.YearMonth.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.YearMonth.getYearMonth(x);
        let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    /// LocalDate methods

    pub def getLocalDate(d: OffsetDateTime): LocalDate = 
        import static java.time.LocalDate.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDate \ {} as fromTA;
        let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
        LocalDate(fromTA(d1))


    pub def adjustLocalDate(x: LocalDate, dt: OffsetDateTime): OffsetDateTime = 
        import java.time.LocalDate.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.LocalDate.getLocalDate(x);
        let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    /// LocalDateTime methods

    pub def getLocalDateTime(d: OffsetDateTime): LocalDateTime = 
        import static java.time.LocalDateTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalDateTime \ {} as fromTA;
        let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
        LocalDateTime(fromTA(d1))

    pub def adjustLocalDateTime(x: LocalDateTime, dt: OffsetDateTime): OffsetDateTime = 
        import java.time.LocalDateTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.LocalDateTime.getLocalDateTime(x);
        let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    /// LocalTime methods

    pub def getLocalTime(d: OffsetDateTime): LocalTime = 
        import static java.time.LocalTime.from(##java.time.temporal.TemporalAccessor): ##java.time.LocalTime \ {} as fromTA;
        let d1 = unchecked_cast(getOffsetDateTime(d) as ##java.time.temporal.TemporalAccessor);
        LocalTime(fromTA(d1))


    pub def adjustLocalTime(x: LocalTime, dt: OffsetDateTime): OffsetDateTime = 
        import java.time.LocalTime.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.LocalTime.getLocalTime(x);
        let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(adjustInto(x1, dt1) as ##java.time.OffsetDateTime))

    pub def getEpochDay(x: OffsetDateTime): Int64 = 
        import static get java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField \ {} as get_EPOCH_DAY;        
        getLongHelper(unchecked_cast(get_EPOCH_DAY() as ##java.time.temporal.TemporalField), x)

    /// ZoneOffset methods

    pub def adjustZoneOffset(zo: ZoneOffset, dt: OffsetDateTime): OffsetDateTime = 
        import java.time.ZoneOffset.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let zo1 = Time.ZoneOffset.getZoneOffset(zo);
        let dt1 = unchecked_cast(getOffsetDateTime(dt) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(adjustInto(zo1, dt1) as ##java.time.OffsetDateTime))


    /// ## truncate functions

    def truncatedToHelper(u: ##java.time.temporal.TemporalUnit, x: OffsetDateTime): OffsetDateTime = 
        import java.time.OffsetDateTime.truncatedTo(##java.time.temporal.TemporalUnit): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(truncatedTo(x1, u))

    pub def truncatedToDays(x: OffsetDateTime): OffsetDateTime = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        truncatedToHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), x)

    /// ## plus / minus functions

    pub def plusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusYears(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusYears(x1, years))

    pub def minusYears(x: OffsetDateTime, years: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusYears(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusYears(x1, years))

    pub def plusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMonths(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusMonths(x1, months))

    pub def minusMonths(x: OffsetDateTime, months: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMonths(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusMonths(x1, months))

    pub def plusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusWeeks(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusWeeks(x1, weeks))

    pub def minusWeeks(x: OffsetDateTime, weeks: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusWeeks(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusWeeks(x1, weeks))

    pub def plusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusDays(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusDays(x1, days))

    pub def minusDays(x: OffsetDateTime, days: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusDays(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusDays(x1, days))

    pub def plusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusHours(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusHours(x1, hours))

    pub def minusHours(x: OffsetDateTime, hours: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusHours(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusHours(x1, hours))

    pub def plusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusMinutes(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusMinutes(x1, minutes))

    pub def minusMinutes(x: OffsetDateTime, minutes: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusMinutes(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusMinutes(x1, minutes))

    pub def plusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusSeconds(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusSeconds(x1, seconds))

    pub def minusSeconds(x: OffsetDateTime, seconds: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusSeconds(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusSeconds(x1, seconds))

    pub def plusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.plusNanos(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(plusNanos(x1, nanos))

    pub def minusNanos(x: OffsetDateTime, nanos: Int64): OffsetDateTime =
        import java.time.OffsetDateTime.minusNanos(Int64): ##java.time.OffsetDateTime \ {};
        let OffsetDateTime(x1) = x;
        OffsetDateTime(minusNanos(x1, nanos))


    pub def plusDuration(i: OffsetDateTime, x: DurationZ): OffsetDateTime =
        import java.time.Duration.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let DurationZ(x1) = x;
        let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(addTo(x1, i1) as ##java.time.OffsetDateTime))
    
    pub def minusDuration(i: OffsetDateTime, x: DurationZ): OffsetDateTime =
        import java.time.Duration.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let DurationZ(x1) = x;
        let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.OffsetDateTime))

    /// Period methods

    pub def plusPeriod(i: OffsetDateTime, x: Period): OffsetDateTime =
        import java.time.Period.addTo(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.Period.getPeriod(x);
        let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(addTo(x1, i1) as ##java.time.OffsetDateTime))
    
    pub def minusPeriod(i: OffsetDateTime, x: Period): OffsetDateTime =
        import java.time.Period.subtractFrom(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
        let x1 = Time.Period.getPeriod(x);
        let i1 = unchecked_cast(getOffsetDateTime(i) as ##java.time.temporal.Temporal);
        OffsetDateTime(unchecked_cast(subtractFrom(x1, i1) as ##java.time.OffsetDateTime))



    /// ## between / until functions

    pub def between(r: {start = OffsetDateTime, end = OffsetDateTime}): DurationZ =
        import static java.time.Duration.between(##java.time.temporal.Temporal, ##java.time.temporal.Temporal): ##java.time.Duration \ {};
        let s1 = unchecked_cast(getOffsetDateTime(r.start) as ##java.time.temporal.Temporal);
        let e1 = unchecked_cast(getOffsetDateTime(r.end) as ##java.time.temporal.Temporal);
        DurationZ(between(s1, e1))


    def untilHelper(u: ##java.time.temporal.TemporalUnit, r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import java.time.OffsetDateTime.until(##java.time.temporal.Temporal, ##java.time.temporal.TemporalUnit): Int64 \ {};
        let b1 = getOffsetDateTime(r.start);
        let e1 = unchecked_cast(getOffsetDateTime(r.end) as ##java.time.temporal.Temporal);
        until(b1, e1, u)


    pub def secondsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        untilHelper(unchecked_cast(get_SECONDS() as ##java.time.temporal.TemporalUnit), r)

    pub def minutesUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        untilHelper(unchecked_cast(get_MINUTES() as ##java.time.temporal.TemporalUnit), r)

    pub def hoursUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        untilHelper(unchecked_cast(get_HOURS() as ##java.time.temporal.TemporalUnit), r)

    pub def halfDaysUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        untilHelper(unchecked_cast(get_HALF_DAYS() as ##java.time.temporal.TemporalUnit), r)

    pub def daysUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        untilHelper(unchecked_cast(get_DAYS() as ##java.time.temporal.TemporalUnit), r)

    pub def monthsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
        untilHelper(unchecked_cast(get_MONTHS() as ##java.time.temporal.TemporalUnit), r)

    pub def yearsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
        untilHelper(unchecked_cast(get_YEARS() as ##java.time.temporal.TemporalUnit), r)

    pub def quarterYearsUntil(r: {start = OffsetDateTime, end = OffsetDateTime}): Int64 = 
        import static get java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.TemporalUnit \ {} as get_QUARTER_YEARS;
        untilHelper(get_QUARTER_YEARS(), r)

    /// ## generic helper functions

    def getHelper(t: ##java.time.temporal.TemporalField, x: OffsetDateTime): Int32 = 
        import java.time.OffsetDateTime.get(##java.time.temporal.TemporalField): Int32 \ {};
        let x1 = getOffsetDateTime(x);
        get(x1, t)

    def getLongHelper(t: ##java.time.temporal.TemporalField, x: OffsetDateTime): Int64 = 
        import java.time.OffsetDateTime.getLong(##java.time.temporal.TemporalField): Int64 \ {};
        let x1 = getOffsetDateTime(x);
        getLong(x1, t)


 
}
