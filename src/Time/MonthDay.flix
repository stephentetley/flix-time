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
            unsafe IO { x1.toString() }
    }

    ///
    /// Returns the month / day ...
    ///
    instance FromString[MonthDay] {
        pub def fromString(s: String): Option[MonthDay] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                let ans = unsafe IO { JMonthDay.parse(s1) };
                MonthDay(ans)
        }) |> Result.toOption
    }

    instance Eq[MonthDay] {
        pub def eq(x: MonthDay, y: MonthDay): Bool =
            let MonthDay(x1) = x;
            let MonthDay(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[MonthDay] {
        pub def hash(x: MonthDay): Int32 =
            let MonthDay(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[MonthDay] {
        pub def compare(x: MonthDay, y: MonthDay): Comparison =
            let MonthDay(x1) = x;
            let MonthDay(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }


}

mod Time.MonthDay {

    use Time.MonthDay
    use Time.MonthDay.{MonthDay}
    
    use Time.Format.DateFormat
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.Month
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
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
        let ans = unsafe IO { JMonthDay.of(r#month, r#dayOfMonth) };
        MonthDay(ans)

    pub def monthDayWithMonth(r: {month = Month, dayOfMonth = Int32}): MonthDay =
        let m1 = Time.Month.marshalMonth(r#month);
        let ans = unsafe IO { JMonthDay.of(m1, r#dayOfMonth) };
        MonthDay(ans)

    /// `now` and "abstract constructors" if any

    pub def now(): MonthDay \ IO + NonDet = MonthDay(JMonthDay.now())

    pub def nowWithZoneId(x: ZoneId): MonthDay \ IO + NonDet =
        let ZoneId(x1) = x;
        MonthDay(JMonthDay.now(x1))


    // `fromTemporalAccessor` specialized
    pub def fromLocalDate(x: LocalDate): MonthDay =
        let LocalDate(x1) = x;
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)
        
    pub def fromLocalDateTime(x: LocalDateTime): MonthDay =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): MonthDay =
        let OffsetDateTime(x1) = x;
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): MonthDay =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)

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
            let ans = unsafe IO { JMonthDay.parse(s1, fmtr) };
            MonthDay(ans)
        })


    ///
    /// Returns MonthDay `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: MonthDay): String =
        let MonthDay(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        unsafe IO { x1.format(fmtr) }

    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        unsafe IO { x1.isBefore(y1) }

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        unsafe IO { x1.isAfter(y1) }

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(year: Int32, x: MonthDay): Bool =
        let MonthDay(x1) = x;
        unsafe IO { x1.isValidYear(year) }
        

    /// Getters and Setters

    pub def getDayOfMonth(x: MonthDay): Int32 =
        let MonthDay(x1) = x;
        unsafe IO { x1.getDayOfMonth() }

    pub def withDayOfMonth(dayOfMonth: Int32, x: MonthDay): MonthDay =
        let MonthDay(x1) = x;
        let ans = unsafe IO { x1.$withDayOfMonth(dayOfMonth) };
        MonthDay(ans)

    pub def getMonth(x: MonthDay): Month =
        let MonthDay(x1) = x;
        Time.Month.unmarshalMonth(unsafe IO { x1.getMonth() })

    pub def withMonth(month: Month, x: MonthDay): MonthDay =
        let MonthDay(x1) = x;
        let m1 = Time.Month.marshalMonth(month);
        let ans = unsafe IO { x1.$with(m1) };
        MonthDay(ans)

    pub def getMonthValue(x: MonthDay): Int32 =
        let MonthDay(x1) = x;
        unsafe IO { x1.getMonthValue() }

    pub def withMonthValue(month: Int32, x: MonthDay): MonthDay =
        let MonthDay(x1) = x;
        let ans = unsafe IO { x1.$withMonth(month) };
        MonthDay(ans)

}
