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

    import java.time.{MonthDay => JMonthDay}
    import java.lang.{Object, CharSequence}

    ///
    /// A wrapper around java.time.MonthDay.
    ///
    pub enum MonthDay(JMonthDay)


    instance ToString[MonthDay] {
        pub def toString(x: MonthDay): String =
            let MonthDay(x1) = x;
            unsafe x1.toString()
    }

    ///
    /// Returns the month / day ...
    ///
    instance FromString[MonthDay] {
        pub def fromString(s: String): Option[MonthDay] = 
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let cs  = (checked_cast(s1) : CharSequence);
                MonthDay(unsafe JMonthDay.parse(cs))
        }) |> Result.toOption
    }

    instance Eq[MonthDay] {
        pub def eq(x: MonthDay, y: MonthDay): Bool =
            let MonthDay(x1) = x;
            let MonthDay(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }

    instance Hash[MonthDay] {
        pub def hash(x: MonthDay): Int32 =
            let MonthDay(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[MonthDay] {
        pub def compare(x: MonthDay, y: MonthDay): Comparison =
            let MonthDay(x1) = x;
            let MonthDay(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
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
    
    import java.time.{MonthDay => JMonthDay}
    import java.lang.{Object, CharSequence}


    // Unwrap

    pub def getMonthDay(x: MonthDay): JMonthDay = 
        let MonthDay(x1) = x;
        x1

    // Constructors

    pub def monthDay(r: {month = Int32, dayOfMonth = Int32}): MonthDay =
        MonthDay(unsafe JMonthDay.of(r#month, r#dayOfMonth))

    pub def monthDayWithMonth(r: {month = Month, dayOfMonth = Int32}): MonthDay =
        let m1 = Time.Month.marshalMonth(r#month);
        MonthDay(unsafe JMonthDay.of(m1, r#dayOfMonth))

    /// `now` and "abstract constructors" if any

    pub def now(): MonthDay \ IO = MonthDay(JMonthDay.now())

    pub def nowWithZoneId(x: ZoneId): MonthDay \ IO =
        let ZoneId(x1) = x;
        MonthDay(JMonthDay.now(x1))


    // `fromTemporalAccessor` specialized

    // def fromTemporalAccessorHelper(t: ##java.time.temporal.TemporalAccessor): MonthDay = 
    //     import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
    //     try {
    //         MonthDay(fromTA(t))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }

    // pub def fromLocalDate(x: LocalDate): MonthDay = 
    //     fromTemporalAccessorHelper(unchecked_cast(Time.LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor))
        
    // pub def fromLocalDateTime(x: LocalDateTime): MonthDay = 
    //     fromTemporalAccessorHelper(unchecked_cast(Time.LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor))
        
    // pub def fromOffsetDateTime(x: OffsetDateTime): MonthDay = 
    //     import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
    //     try {
    //         let x1 = unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor);
    //         MonthDay(fromTA(x1))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }

    // pub def fromZonedDateTime(x: ZonedDateTime): MonthDay = 
    //     import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay \ {} as fromTA;
    //     try {
    //         let x1 = unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor);
    //         MonthDay(fromTA(x1))
    //     } catch {
    //         case ex: ##java.lang.Exception => 
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             bug!(getMessage(checked_cast(ex)))
    //     }

    // `parse` / `format` functions

    ///
    /// Parse the string `s` as a MonthDay, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Ok(x)`, a parse failure is indicated by `Err(_)`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Result[String, MonthDay] =
        Result.tryCatch(_ -> {
            let DateTimeFormatter(fmtr) = formatter;
            let s1 = String.trim(s);
            let cs  = (checked_cast(s1) : CharSequence);
            MonthDay(unsafe JMonthDay.parse(cs, fmtr))
        })


    ///
    /// Returns MonthDay `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: MonthDay): String =
        let MonthDay(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe x1.format(fmtr)

    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        unsafe x1.isBefore(y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        unsafe x1.isAfter(y1)

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(year: Int32, x: MonthDay): Bool =
        let MonthDay(x1) = x;
        unsafe x1.isValidYear(year)
        

    /// Getters and Setters

    pub def getDayOfMonth(x: MonthDay): Int32 =
        let MonthDay(x1) = x;
        unsafe x1.getDayOfMonth()

    pub def withDayOfMonth(dayOfMonth: Int32, x: MonthDay): MonthDay =
        let MonthDay(x1) = x;
        MonthDay(unsafe x1.withDayOfMonth(dayOfMonth))

    pub def getMonth(x: MonthDay): Month =
        let MonthDay(x1) = x;
        Time.Month.unmarshalMonth(unsafe x1.getMonth())

    pub def withMonth(month: Month, x: MonthDay): MonthDay =
        let MonthDay(x1) = x;
        let m1 = Time.Month.marshalMonth(month);
        MonthDay(unsafe x1.with(m1))

    pub def getMonthValue(x: MonthDay): Int32 =
        let MonthDay(x1) = x;
        unsafe x1.getMonthValue()

    pub def withMonthValue(month: Int32, x: MonthDay): MonthDay =
        let MonthDay(x1) = x;
        MonthDay(unsafe x1.withMonth(month))

}
