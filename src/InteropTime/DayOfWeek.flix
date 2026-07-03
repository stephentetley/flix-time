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



pub mod InteropTime.DayOfWeek {

    use InteropTime.DayOfWeek.DayOfWeek
    use InteropTime.DayOfWeek.DayOfWeek.{Monday, Tuesday,
        Wednesday, Thursday, Friday, Saturday, Sunday}

    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDate.LocalDate.{LocalDate}
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.LocalDateTime.LocalDateTime.{LocalDateTime}
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetDateTime.OffsetDateTime.{OffsetDateTime}
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZonedDateTime.ZonedDateTime.{ZonedDateTime}

    use InteropLocale.Locale.Locale

    import java.time.{DayOfWeek => JDayOfWeek}
    import java.lang.{Enum => JEnum}


    ///
    /// A day of the week.
    ///
    /// Days are reprepresented as an enum from Monday to Sunday.
    ///
    pub enum DayOfWeek with Eq, Order, ToString, Hash {
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        case Sunday
    }

    instance FromString[DayOfWeek] {
        pub def fromString(x: String): Option[DayOfWeek] = match x {
            case "Monday"    => Some(Monday)
            case "Tuesday"   => Some(Tuesday)
            case "Wednesday" => Some(Wednesday)
            case "Thursday"  => Some(Thursday)
            case "Friday"    => Some(Friday)
            case "Saturday"  => Some(Saturday)
            case "Sunday"    => Some(Sunday)
            case _           => None
        }
    }

    
    instance ToJava[DayOfWeek] {
        type Out = JDayOfWeek
        pub def toJava(x: DayOfWeek): JDayOfWeek = match x {
            case DayOfWeek.Monday       => unsafe IO { JDayOfWeek.MONDAY }
            case DayOfWeek.Tuesday      => unsafe IO { JDayOfWeek.TUESDAY }
            case DayOfWeek.Wednesday    => unsafe IO { JDayOfWeek.WEDNESDAY }
            case DayOfWeek.Thursday     => unsafe IO { JDayOfWeek.THURSDAY }
            case DayOfWeek.Friday       => unsafe IO { JDayOfWeek.FRIDAY }
            case DayOfWeek.Saturday     => unsafe IO { JDayOfWeek.SATURDAY }
            case DayOfWeek.Sunday       => unsafe IO { JDayOfWeek.SUNDAY }
        }
    }

    instance ToFlix[DayOfWeek] {
        type In = JDayOfWeek
        pub def toFlix(x: JDayOfWeek): DayOfWeek = unsafe IO {
            if (x.equals(JDayOfWeek.MONDAY))            DayOfWeek.Monday
            else if (x.equals(JDayOfWeek.TUESDAY))      DayOfWeek.Tuesday
            else if (x.equals(JDayOfWeek.WEDNESDAY))    DayOfWeek.Wednesday
            else if (x.equals(JDayOfWeek.THURSDAY))     DayOfWeek.Thursday
            else if (x.equals(JDayOfWeek.FRIDAY))       DayOfWeek.Friday
            else if (x.equals(JDayOfWeek.SATURDAY))     DayOfWeek.Saturday
            else if (x.equals(JDayOfWeek.SUNDAY))       DayOfWeek.Sunday
            else bug!("toFlix[DayOfWeek]")
        }
    }


    /// 1 (Monday) to 7 (Sunday)
    pub def dayOfWeek(i: Int32): Option[DayOfWeek] = match i {
        case 1 => Some(Monday)
        case 2 => Some(Tuesday)
        case 3 => Some(Wednesday)
        case 4 => Some(Thursday)
        case 5 => Some(Friday)
        case 6 => Some(Saturday)
        case 7 => Some(Sunday)
        case _ => None
    }

    // `from` functions

    // `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): DayOfWeek =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromLocalDateTime(x: LocalDateTime): DayOfWeek =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): DayOfWeek =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        ToFlix.toFlix(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): DayOfWeek =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        ToFlix.toFlix(ans)
    

    /// DayOfWeek functions

    pub def getDisplayName(style: TextStyle, locale: Locale, x: DayOfWeek): String =
        let x1 = ToJava.toJava(x);
        let s1 = ToJava.toJava(style);
        let Locale.Locale(locale1) = locale;
        unsafe IO { x1.getDisplayName(s1, locale1) }


    pub def getValue(x: DayOfWeek): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getValue() }


    /// plus / minus functions

    pub def plus(x: DayOfWeek, days: Int64): DayOfWeek =
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.plus(days) };
        ToFlix.toFlix(ans)

    pub def minus(x:DayOfWeek, days: Int64): DayOfWeek = 
        let x1 = ToJava.toJava(x);
        let ans = unsafe IO { x1.minus(days) };
        ToFlix.toFlix(ans)


}
