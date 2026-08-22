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

    use JavaInterop.AdaptorExtras

    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.LocalDate.LocalDate
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.ZonedDateTime.ZonedDateTime

    use InteropLocale.Locale.Locale

    import java.time.{DayOfWeek => JDayOfWeek}
    import java.lang.{Enum => JEnum}


    ///
    /// A day of the week.
    ///
    /// Days are reprepresented as an enum from Monday to Sunday.
    ///
    pub enum DayOfWeek with Eq, Order, ToString {
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

    
    instance Hash[DayOfWeek] {
        pub def hash(x: DayOfWeek): Int32 = match x {
            case DayOfWeek.Monday       => unsafe IO { let x1 = JDayOfWeek.MONDAY; x1.hashCode() }
            case DayOfWeek.Tuesday      => unsafe IO { let x1 = JDayOfWeek.TUESDAY; x1.hashCode() }
            case DayOfWeek.Wednesday    => unsafe IO { let x1 = JDayOfWeek.WEDNESDAY; x1.hashCode() }
            case DayOfWeek.Thursday     => unsafe IO { let x1 = JDayOfWeek.THURSDAY; x1.hashCode() }
            case DayOfWeek.Friday       => unsafe IO { let x1 = JDayOfWeek.FRIDAY; x1.hashCode() }
            case DayOfWeek.Saturday     => unsafe IO { let x1 = JDayOfWeek.SATURDAY; x1.hashCode() }
            case DayOfWeek.Sunday       => unsafe IO { let x1 = JDayOfWeek.SUNDAY; x1.hashCode() }
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


    

    /// DayOfWeek functions

    pub def getDisplayName(style: TextStyle, locale: Locale, x: DayOfWeek): String =
        AdaptorExtras.extract3(style, locale, x, (style1, locale1, x1) -> 
            unsafe IO { x1.getDisplayName(style1, locale1) }
        )


    pub def getValue(x: DayOfWeek): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getValue() })


    /// plus / minus functions

    pub def plusDays(x: DayOfWeek, days: Int64): DayOfWeek =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.plus(days) })

    pub def minusDays(x:DayOfWeek, days: Int64): DayOfWeek = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.minus(days) })

}

