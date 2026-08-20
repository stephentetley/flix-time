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


    use InteropTime.Internal.AdaptorExtras
    
    use InteropTime.Format.TemporalFormat
    use InteropTime.Format.TemporalParse
    use InteropTime.Format.DateFormatter
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.Month.Month
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId.ZoneId
    
    import java.time.{Month => JMonth}
    import java.time.{MonthDay => JMonthDay}
    import java.lang.{Object, CharSequence}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around java.time.MonthDay.
    ///
    pub enum MonthDay(JMonthDay)


    instance ToString[MonthDay] {
        pub def toString(x: MonthDay): String =
            let MonthDay.MonthDay(x1) = x;
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
                Some(MonthDay.MonthDay(ans))
            } catch {
                case _: JException => None
            }
    }

    instance Eq[MonthDay] {
        pub def eq(x: MonthDay, y: MonthDay): Bool =
            let MonthDay.MonthDay(x1) = x;
            let MonthDay.MonthDay(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[MonthDay] {
        pub def hash(x: MonthDay): Int32 =
            let MonthDay.MonthDay(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[MonthDay] {
        pub def compare(x: MonthDay, y: MonthDay): Comparison =
            let MonthDay.MonthDay(x1) = x;
            let MonthDay.MonthDay(y1) = y;
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
        pub def toFlix(x: JMonthDay): MonthDay = 
            MonthDay.MonthDay(x)
    }

    instance TemporalFormat[MonthDay] {
        type Formatter = DateFormatter
        type Aef = {}
        pub def format(formatter: DateFormatter, x: MonthDay): String =
            let MonthDay.MonthDay(x1) = x;
            let formatter1 = ToJava.toJava(formatter);
            unsafe IO { x1.format(formatter1) }
    }
    
    instance TemporalParse[MonthDay] {
        type Formatter = DateFormatter
        type Aef = {}
        pub def parse(formatter: DateFormatter, s: String): Result[String, MonthDay] = 
            AdaptorExtras.opWithResult(formatter, formatter1 -> {
                let s1 = String.trim(s);
                unsafe IO { JMonthDay.parse(s1, formatter1) }
            })
    }


    // Constructors

    pub def monthDay(month: {month = Int32}, dayOfMonth: {dayOfMonth = Int32}): MonthDay =
        let ans = unsafe IO { JMonthDay.of(month#month, dayOfMonth#dayOfMonth) };
        MonthDay(ans)

    pub def monthDayWithMonth(month: {month = Month}, 
                                dayOfMonth: {dayOfMonth = Int32}): MonthDay =
        AdaptorExtras.op(month#month, month1 -> 
            unsafe IO { JMonthDay.of(month1, dayOfMonth#dayOfMonth) }
        )

    /// `now` and "abstract constructors" if any

    pub def now(): MonthDay \ IO = MonthDay(JMonthDay.now())

    pub def nowWithZoneId(x: ZoneId): MonthDay \ IO =
        AdaptorExtras.op(x, x1 -> JMonthDay.now(x1))

    pub def toMonth(x: MonthDay): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { JMonth.$from(x1) })


    /// predicates / comparisons

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isBefore(y1) })

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        AdaptorExtras.extract2(x, y, (x1, y1) -> unsafe IO { x1.isAfter(y1) })

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(year: Int32, x: MonthDay): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isValidYear(year) })
        

    /// Getters and Setters

    pub def getDayOfMonth(x: MonthDay): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDayOfMonth() })

    pub def withDayOfMonth(dayOfMonth: Int32, x: MonthDay): MonthDay =
        AdaptorExtras.op(x, x1 -> 
            unsafe IO { x1.$withDayOfMonth(dayOfMonth) }
        )

    pub def getMonth(x: MonthDay): Month =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getMonth() })

    pub def withMonth(month: Month, x: MonthDay): MonthDay =
        AdaptorExtras.op2(month, x, (month1, x1) -> unsafe IO { x1.$with(month1) })

    pub def getMonthValue(x: MonthDay): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getMonthValue() })

    pub def withMonthValue(month: Int32, x: MonthDay): MonthDay =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.$withMonth(month) })

}

