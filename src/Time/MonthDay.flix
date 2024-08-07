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

    use Time.MonthDay
    use Time.MonthDay.{MonthDay}

    ///
    /// A wrapper around java.time.MonthDay.
    ///
    pub enum MonthDay(##java.time.MonthDay)


    instance ToString[MonthDay] {
        pub def toString(x: MonthDay): String =
            import java.time.MonthDay.toString(): String \ {};
            let MonthDay(x1) = x;
            toString(x1)
    }

    ///
    /// Returns the month / day ...
    ///
    instance FromString[MonthDay] {
        pub def fromString(s: String): Option[MonthDay] = 
            Result.tryCatch(_ -> {
            import static java.time.MonthDay.parse(##java.lang.CharSequence): ##java.time.MonthDay \ {};
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            MonthDay(parse(cs))
        }) |> Result.toOption
    }

    instance Eq[MonthDay] {
        pub def eq(x: MonthDay, y: MonthDay): Bool =
            import java.time.MonthDay.equals(##java.lang.Object): Bool \ {};
            let MonthDay(x1) = x;
            let MonthDay(y1) = y;
            equals(x1, checked_cast(y1))

    }

    instance Hash[MonthDay] {
        pub def hash(x: MonthDay): Int32 =
            import java.time.MonthDay.hashCode(): Int32 \ {};
            let MonthDay(x1) = x;
            hashCode(x1)

    }

    instance Order[MonthDay] {
        pub def compare(x: MonthDay, y: MonthDay): Comparison =
            import java.time.MonthDay.compareTo(##java.time.MonthDay): Int32 \ {};
            let MonthDay(x1) = x;
            let MonthDay(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }


}

mod Time.MonthDay {

    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    
    use Time.Format.DateFormat
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.LocalDate
    use Time.LocalDateTime
    use Time.Month
    use Time.OffsetDateTime
    use Time.ZonedDateTime
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    
    /// ## Unwrap

    pub def getMonthDay(x: MonthDay): ##java.time.MonthDay = 
        let MonthDay(x1) = x;
        x1

    /// ## Constructors

    pub def monthDay(r: {month = Int32, dayOfMonth = Int32}): MonthDay =
        import static java.time.MonthDay.of(Int32, Int32): ##java.time.MonthDay \ {};
        MonthDay(of(r#month, r#dayOfMonth))

    pub def monthDayWithMonth(r: {month = Month, dayOfMonth = Int32}): MonthDay =
        import static java.time.MonthDay.of(##java.time.Month, Int32): ##java.time.MonthDay \ {};
        let m1 = Time.Month.marshalMonth(r#month);
        MonthDay(of(m1, r#dayOfMonth))

    /// ## `now` and "abstract constructors" if any

    pub def now(): MonthDay \ IO =
        import static java.time.MonthDay.now(): ##java.time.MonthDay \ IO;
        MonthDay(now())

    pub def nowWithZoneId(x: ZoneId): MonthDay \ IO =
        import static java.time.MonthDay.now(##java.time.ZoneId): ##java.time.MonthDay \ IO;
        let ZoneId(x1) = x;
        MonthDay(now(x1))


    /// `fromTemporalAccessor` specialized

    def fromTemporalAccessorHelper(t: ##java.time.temporal.TemporalAccessor): MonthDay = 
        import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
        try {
            MonthDay(fromTA(t))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(checked_cast(ex)))
        }

    pub def fromLocalDate(x: LocalDate): MonthDay = 
        fromTemporalAccessorHelper(unchecked_cast(Time.LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor))
        
    pub def fromLocalDateTime(x: LocalDateTime): MonthDay = 
        fromTemporalAccessorHelper(unchecked_cast(Time.LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor))
        
    pub def fromOffsetDateTime(x: OffsetDateTime): MonthDay = 
        import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
        try {
            let x1 = unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor);
            MonthDay(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(checked_cast(ex)))
        }

    pub def fromZonedDateTime(x: ZonedDateTime): MonthDay = 
        import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
        try {
            let x1 = unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor);
            MonthDay(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(checked_cast(ex)))
        }

    /// ## `parse` / `format` functions

    ///
    /// Parse the string `s` as a MonthDay, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, MonthDay] =
        Result.tryCatch(_ -> {
            import static java.time.MonthDay.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.MonthDay \ {};
            let DateTimeFormatter(fmtr) = formatter;
            let cs = unchecked_cast(String.trim(s) as ##java.lang.CharSequence);
            MonthDay(parse(cs, fmtr))
        })


    ///
    /// Returns MonthDay `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: MonthDay): String =
        import java.time.MonthDay.format(##java.time.format.DateTimeFormatter): String \ {};
        let MonthDay(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    /// ## predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isBefore(##java.time.MonthDay): Bool \ {};
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isAfter(##java.time.MonthDay): Bool \ {};
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        isAfter(x1, y1)

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(year: Int32, x: MonthDay): Bool =
        import java.time.MonthDay.isValidYear(Int32): Bool \ {};
        let MonthDay(x1) = x;
        isValidYear(x1, year)
        

    /// ## Getters and Setters

    pub def getDayOfMonth(x: MonthDay): Int32 =
        import java.time.MonthDay.getDayOfMonth(): Int32 \ {};
        let MonthDay(x1) = x;
        getDayOfMonth(x1)

    pub def withDayOfMonth(dayOfMonth: Int32, x: MonthDay): MonthDay =
        import java.time.MonthDay.withDayOfMonth(Int32): ##java.time.MonthDay \ {};
        let MonthDay(x1) = x;
        MonthDay(withDayOfMonth(x1, dayOfMonth))

    pub def getMonth(x: MonthDay): Month =
        import java.time.MonthDay.getMonth(): ##java.time.Month \ {};
        let MonthDay(x1) = x;
        Time.Month.unmarshalMonth(getMonth(x1))

    pub def withMonth(month: Month, x: MonthDay): MonthDay =
        import java.time.MonthDay.with(##java.time.Month): ##java.time.MonthDay \ {} as with1;
        let MonthDay(x1) = x;
        let m1 = Time.Month.marshalMonth(month);
        MonthDay(with1(x1, m1))

    pub def getMonthValue(x: MonthDay): Int32 =
        import java.time.MonthDay.getMonthValue(): Int32 \ {};
        let MonthDay(x1) = x;
        getMonthValue(x1)

    pub def withMonthValue(month: Int32, x: MonthDay): MonthDay =
        import java.time.MonthDay.withMonth(Int32): ##java.time.MonthDay \ {};
        let MonthDay(x1) = x;
        MonthDay(withMonth(x1, month))



}
