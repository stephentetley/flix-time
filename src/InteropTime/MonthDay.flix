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



pub mod InteropTime.MonthDay {

    use InteropTime.MonthDay.MonthDay
    use InteropTime.MonthDay.MonthDay.{MonthDay}

    use InteropTime.Format.DateTimeFormatter.DateTimeFormatter
    use InteropTime.Format.DateTimeFormatter.DateFormat
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.Month.Month
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId
    
    import java.time.{MonthDay => JMonthDay}
    import java.lang.{Object, CharSequence}
    import java.lang.{Exception => JException}

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
            try {
                let s1 = String.trim(s);
                let ans = unsafe IO { JMonthDay.parse(s1) };
                Some(MonthDay(ans))
            } catch {
                case _: JException => None
            }
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


    instance ToJava[MonthDay] {
        type Out = JMonthDay
        pub def toJava(x: MonthDay): JMonthDay = 
            let MonthDay.MonthDay(x1) = x;
            x1
    }

    instance ToFlix[MonthDay] {
        type In = JMonthDay
        pub def toFlix(x: JMonthDay): MonthDay = MonthDay.MonthDay(x)
    }

    // Constructors

    pub def monthDay(month: {month = Int32}, dayOfMonth: {dayOfMonth = Int32}): MonthDay =
        let ans = unsafe IO { JMonthDay.of(month#month, dayOfMonth#dayOfMonth) };
        MonthDay(ans)

    pub def monthDayWithMonth(month: {month = Month}, 
                                dayOfMonth: {dayOfMonth = Int32}): MonthDay =
        let m1 = ToJava.toJava(month#month);
        let ans = unsafe IO { JMonthDay.of(m1, dayOfMonth#dayOfMonth) };
        MonthDay(ans)

    /// `now` and "abstract constructors" if any

    pub def now(): MonthDay \ IO = MonthDay(JMonthDay.now())

    pub def nowWithZoneId(x: ZoneId): MonthDay \ IO =
        let x1 = ToJava.toJava(x);
        MonthDay(JMonthDay.now(x1))


    // `fromTemporalAccessor` specialized
    pub def fromLocalDate(x: LocalDate): MonthDay =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)
        
    pub def fromLocalDateTime(x: LocalDateTime): MonthDay =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): MonthDay =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JMonthDay.$from(x1) };
        MonthDay(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): MonthDay =
        let x1 = ToJava.toJava(x);
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
        try {
            let fmt1 = ToJava.toJava(formatter);
            let s1 = String.trim(s);
            let ans = unsafe IO { JMonthDay.parse(s1, fmt1) };
            Ok(MonthDay(ans))
        } catch {
            case e: JException => Err(e.getMessage())
        }


    ///
    /// Returns MonthDay `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: MonthDay): String =
        let x1 = ToJava.toJava(x);
        let fmt1 = ToJava.toJava(formatter);
        unsafe IO { x1.format(fmt1) }

    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        unsafe IO { x1.isBefore(y1) }

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        unsafe IO { x1.isAfter(y1) }

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(year: Int32, x: MonthDay): Bool =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.isValidYear(year) }
        

    /// Getters and Setters

    pub def getDayOfMonth(x: MonthDay): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getDayOfMonth() }

    pub def withDayOfMonth(dayOfMonth: Int32, x: MonthDay): MonthDay =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withDayOfMonth(dayOfMonth) };
        MonthDay(ans)

    pub def getMonth(x: MonthDay): Month =
        let x1 = ToJava.toJava(x);
        ToFlix.toFlix(unsafe IO { x1.getMonth() })

    pub def withMonth(month: Month, x: MonthDay): MonthDay =
        let x1 = ToJava.toJava(x);
        let m1 = ToJava.toJava(month);
        let ans = unsafe IO { x1.$with(m1) };
        MonthDay(ans)

    pub def getMonthValue(x: MonthDay): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getMonthValue() }

    pub def withMonthValue(month: Int32, x: MonthDay): MonthDay =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.$withMonth(month) };
        MonthDay(ans)

}

