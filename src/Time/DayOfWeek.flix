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

    use Time.DayOfWeek
    use Time.DayOfWeek.{Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}


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


}

mod Time.DayOfWeek {

    use Locale.{Locale}
    
    use Time.DayOfWeek
    use Time.DayOfWeek.{Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}

    use Time.Format.TextStyle
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}

    import java.time.{DayOfWeek => JDayOfWeek}
    import java.lang.{Enum => JEnum}

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

    /// Marshal enums

    pub def marshalDayOfWeek(x: DayOfWeek): JDayOfWeek =
        match x {
            case Monday     => unsafe IO { JDayOfWeek.MONDAY }
            case Tuesday    => unsafe IO { JDayOfWeek.TUESDAY }
            case Wednesday  => unsafe IO { JDayOfWeek.WEDNESDAY }
            case Thursday   => unsafe IO { JDayOfWeek.THURSDAY }
            case Friday     => unsafe IO { JDayOfWeek.FRIDAY }
            case Saturday   => unsafe IO { JDayOfWeek.SATURDAY }
            case Sunday     => unsafe IO { JDayOfWeek.SUNDAY } 
        }

    def primEquals(x: JDayOfWeek, y: JDayOfWeek): Bool =
        unsafe IO { x.equals(y) }


    pub def unmarshalDayOfWeek(x: JDayOfWeek): Time.DayOfWeek =
        match x {
            case x1 if primEquals(x1, unsafe IO { JDayOfWeek.MONDAY })     => Monday
            case x1 if primEquals(x1, unsafe IO { JDayOfWeek.TUESDAY })    => Tuesday
            case x1 if primEquals(x1, unsafe IO { JDayOfWeek.WEDNESDAY })  => Wednesday
            case x1 if primEquals(x1, unsafe IO { JDayOfWeek.THURSDAY })   => Thursday
            case x1 if primEquals(x1, unsafe IO { JDayOfWeek.FRIDAY })     => Friday
            case x1 if primEquals(x1, unsafe IO { JDayOfWeek.SATURDAY })   => Saturday
            case x1 if primEquals(x1, unsafe IO { JDayOfWeek.SUNDAY })     => Sunday
            case _                                      => bug!("unmarshalDayOfWeek")
        }

    // `from` functions

    // `fromTemporalAccessor` specialized

    pub def fromLocalDate(x: LocalDate): DayOfWeek =
        let LocalDate(x1) = x;
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        unmarshalDayOfWeek(ans)

    pub def fromLocalDateTime(x: LocalDateTime): DayOfWeek =
        let LocalDateTime(x1) = x;
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        unmarshalDayOfWeek(ans)

    pub def fromOffsetDateTime(x: OffsetDateTime): DayOfWeek =
        let OffsetDateTime(x1) = x;
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        unmarshalDayOfWeek(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): DayOfWeek =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { JDayOfWeek.$from(x1) };
        unmarshalDayOfWeek(ans)
    

    /// DayOfWeek functions

    pub def getDisplayName(style: TextStyle, locale: Locale, x: DayOfWeek): String =
        let x1 = marshalDayOfWeek(x);
        let s1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe IO { x1.getDisplayName(s1, locale1) }


    pub def getValue(x: DayOfWeek): Int32 =
        let x1 = marshalDayOfWeek(x);
        unsafe IO { x1.getValue() }


    /// plus / minus functions

    pub def plus(x: DayOfWeek, days: Int64): DayOfWeek =
        let x1 = marshalDayOfWeek(x);
        let ans = unsafe IO { x1.plus(days) };
        unmarshalDayOfWeek(ans)

    pub def minus(x:DayOfWeek, days: Int64): DayOfWeek = 
        let x1 = marshalDayOfWeek(x);
        let ans = unsafe IO { x1.minus(days) };
        unmarshalDayOfWeek(ans)


}
