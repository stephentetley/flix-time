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
    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.TemporalAccessor

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
    use Time.LocalDateTime
    use Time.OffsetDateTime
    use Time.ZonedDateTime

    use Time.Internal.Temporal.TemporalAccessor
    import java.time.{DayOfWeek => JDayOfWeek}

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

    /// ## Marshal enums

    pub def marshalDayOfWeek(x: DayOfWeek): ##java.time.DayOfWeek =
        match x {
            case Monday     => unsafe JDayOfWeek.MONDAY
            case Tuesday    => unsafe JDayOfWeek.TUESDAY
            case Wednesday  => unsafe JDayOfWeek.WEDNESDAY
            case Thursday   => unsafe JDayOfWeek.THURSDAY
            case Friday     => unsafe JDayOfWeek.FRIDAY
            case Saturday   => unsafe JDayOfWeek.SATURDAY
            case Sunday     => unsafe JDayOfWeek.SUNDAY 
        }

    def primEquals(x: ##java.time.DayOfWeek, y: ##java.time.DayOfWeek): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)


    pub def unmarshalDayOfWeek(x: ##java.time.DayOfWeek): Time.DayOfWeek =
        match x {
            case x1 if primEquals(x1, unsafe JDayOfWeek.MONDAY)     => Monday
            case x1 if primEquals(x1, unsafe JDayOfWeek.TUESDAY)    => Tuesday
            case x1 if primEquals(x1, unsafe JDayOfWeek.WEDNESDAY)  => Wednesday
            case x1 if primEquals(x1, unsafe JDayOfWeek.THURSDAY)   => Thursday
            case x1 if primEquals(x1, unsafe JDayOfWeek.FRIDAY)     => Friday
            case x1 if primEquals(x1, unsafe JDayOfWeek.SATURDAY)   => Saturday
            case x1 if primEquals(x1, unsafe JDayOfWeek.SUNDAY)     => Sunday
            case _                                      => bug!("unmarshalDayOfWeek")
        }

    /// ## `from` functions

    /// `fromTemporalAccessor` specialized
    def fromTemporalAccessor(x: TemporalAccessor): DayOfWeek = 
        import static java.time.DayOfWeek.from(##java.time.temporal.TemporalAccessor): ##java.time.DayOfWeek \ {} as fromTA;
        try {
            let Time.Internal.Temporal.TemporalAccessor.TemporalAccessor(x1) = x;
            unmarshalDayOfWeek(fromTA(x1))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(checked_cast(ex)))
        }
    
    pub def fromLocalDate(x: LocalDate): DayOfWeek = 
        Time.LocalDate.asTemporalAccessor(x)
            |> fromTemporalAccessor

    pub def fromLocalDateTime(x: LocalDateTime): DayOfWeek = 
        Time.LocalDateTime.asTemporalAccessor(x)
            |> fromTemporalAccessor

    pub def fromOffsetDateTime(x: OffsetDateTime): DayOfWeek = 
        Time.OffsetDateTime.asTemporalAccessor(x)
            |> fromTemporalAccessor

    pub def fromZonedDateTime(x: ZonedDateTime): DayOfWeek = 
        Time.ZonedDateTime.asTemporalAccessor(x)
            |> fromTemporalAccessor


    /// ## DayOfWeek functions

    pub def getDisplayName(style: TextStyle, locale: Locale, x: DayOfWeek): String =
        let x1 = marshalDayOfWeek(x);
        let s1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe x1.getDisplayName(s1, locale1)


    pub def getValue(x: DayOfWeek): Int32 =
        let x1 = marshalDayOfWeek(x);
        unsafe x1.getValue()


    /// ## plus / minus functions

    pub def plus(x: DayOfWeek, days: Int64): DayOfWeek =
        let x1 = marshalDayOfWeek(x);
        let x2 = unsafe x1.plus(days);
        unmarshalDayOfWeek(x2)

    pub def minus(x:DayOfWeek, days: Int64): DayOfWeek = 
        let x1 = marshalDayOfWeek(x);
        let x2 = unsafe x1.minus(days);
        unmarshalDayOfWeek(x2)


}
