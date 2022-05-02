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



namespace Time {


    ///
    /// A day of the week.
    ///
    /// Days are reprepresented as an enum from Monday to Sunday.
    ///
    pub enum DayOfWeek with Eq, Order, ToString, Hash, Boxable {
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

namespace Time/DayOfWeek {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time.DayOfWeek;
    use Time.DayOfWeek.{Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday};

    use Time/Format.TextStyle;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};    
    use Time.LocalDate;
    use Time.LocalDateTime;
    use Time.OffsetDateTime;
    use Time.ZonedDateTime;

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

    pub def marshal(x: DayOfWeek): ##java.time.DayOfWeek =
        import static get java.time.DayOfWeek.MONDAY: ##java.time.DayOfWeek & Pure as get_MONDAY;
        import static get java.time.DayOfWeek.TUESDAY: ##java.time.DayOfWeek & Pure as get_TUESDAY;
        import static get java.time.DayOfWeek.WEDNESDAY: ##java.time.DayOfWeek & Pure as get_WEDNESDAY;
        import static get java.time.DayOfWeek.THURSDAY: ##java.time.DayOfWeek & Pure as get_THURSDAY;
        import static get java.time.DayOfWeek.FRIDAY: ##java.time.DayOfWeek & Pure as get_FRIDAY;
        import static get java.time.DayOfWeek.SATURDAY: ##java.time.DayOfWeek & Pure as get_SATURDAY;
        import static get java.time.DayOfWeek.SUNDAY: ##java.time.DayOfWeek & Pure as get_SUNDAY;
        match x {
            case Monday     => get_MONDAY()
            case Tuesday    => get_TUESDAY()
            case Wednesday  => get_WEDNESDAY()
            case Thursday   => get_THURSDAY()
            case Friday     => get_FRIDAY()
            case Saturday   => get_SATURDAY()
            case Sunday     => get_SUNDAY() 
        }

    def primEquals(x: ##java.time.DayOfWeek, y: ##java.time.DayOfWeek): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)


    pub def unmarshal(x: ##java.time.DayOfWeek): Time.DayOfWeek =
        import static get java.time.DayOfWeek.MONDAY: ##java.time.DayOfWeek & Pure as get_MONDAY;
        import static get java.time.DayOfWeek.TUESDAY: ##java.time.DayOfWeek & Pure as get_TUESDAY;
        import static get java.time.DayOfWeek.WEDNESDAY: ##java.time.DayOfWeek & Pure as get_WEDNESDAY;
        import static get java.time.DayOfWeek.THURSDAY: ##java.time.DayOfWeek & Pure as get_THURSDAY;
        import static get java.time.DayOfWeek.FRIDAY: ##java.time.DayOfWeek & Pure  as get_FRIDAY;
        import static get java.time.DayOfWeek.SATURDAY: ##java.time.DayOfWeek & Pure as get_SATURDAY;
        import static get java.time.DayOfWeek.SUNDAY: ##java.time.DayOfWeek & Pure as get_SUNDAY;
        match x {
            case x1 if primEquals(x1, get_MONDAY())      => Monday
            case x1 if primEquals(x1, get_TUESDAY())     => Tuesday
            case x1 if primEquals(x1, get_WEDNESDAY())   => Wednesday
            case x1 if primEquals(x1, get_THURSDAY())    => Thursday
            case x1 if primEquals(x1, get_FRIDAY())      => Friday
            case x1 if primEquals(x1, get_SATURDAY())    => Saturday
            case x1 if primEquals(x1, get_SUNDAY())      => Sunday
        }

    /// ## `from` functions

    /// `fromTemporalAccessor` specialized
    def fromHelper(x: ##java.time.temporal.TemporalAccessor): DayOfWeek = 
        import static java.time.DayOfWeek.from(##java.time.temporal.TemporalAccessor): ##java.time.DayOfWeek & Pure as fromTA;
        try {
            unmarshal(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromLocalDate(x: LocalDate): DayOfWeek = 
        fromHelper(Time/LocalDate.getLocalDate(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromLocalDateTime(x: LocalDateTime): DayOfWeek = 
        fromHelper(Time/LocalDateTime.getLocalDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetDateTime(x: OffsetDateTime): DayOfWeek = 
        fromHelper(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromZonedDateTime(x: ZonedDateTime): DayOfWeek = 
        fromHelper(Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)


    /// ## DayOfWeek functions

    pub def getDisplayName(style: TextStyle, locale: Locale, x: DayOfWeek): String =
        import java.time.DayOfWeek.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x);
        let s1 = Time/Format/TextStyle.marshal(style);
        let Locale(l1) = locale;
        getDisplayName(x1, s1, l1)


    pub def getValue(x: DayOfWeek): Int32 =
        import java.time.DayOfWeek.getValue(): Int32 & Pure;
        let x1 = marshal(x);
        getValue(x1)


    /// ## plus / minus functions

    pub def plus(x: DayOfWeek, days: Int64): DayOfWeek =
        import java.time.DayOfWeek.plus(Int64): ##java.time.DayOfWeek & Pure;
        let x1 = marshal(x);
        let x2 = plus(x1, days);
        unmarshal(x2)

    pub def minus(x:DayOfWeek, days: Int64): DayOfWeek = 
        import java.time.DayOfWeek.minus(Int64): ##java.time.DayOfWeek & Pure;
        let x1 = marshal(x);
        let x2 = minus(x1, days);
        unmarshal(x2)


}
