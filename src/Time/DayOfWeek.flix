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

    use Time.DayOfWeek
    use Time.DayOfWeek.{Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}
    use Interop/Time/Temporal.TemporalAccessor
    use Interop/Time/Temporal.TemporalAccessor.TemporalAccessor

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

    instance Interop/Flix.Marshal[DayOfWeek] {
        pub def toJavaObject(x: DayOfWeek): ##java.lang.Object =
            let x1 = Time/DayOfWeek.marshal(x);
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): DayOfWeek = 
            let x1 = unchecked_cast(o as ##java.time.DayOfWeek);
            Time/DayOfWeek.unmarshal(x1)
    }

}

namespace Time/DayOfWeek {


    use Time.DayOfWeek
    use Time.DayOfWeek.{Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}

    use Time/Format.TextStyle
    use Time.LocalDate
    use Time.LocalDateTime
    use Time.OffsetDateTime
    use Time.ZonedDateTime

    use Interop/Time/Temporal.TemporalAccessor
    use Interop/Util.Locale

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
        import static get java.time.DayOfWeek.MONDAY: ##java.time.DayOfWeek \ {} as get_MONDAY;
        import static get java.time.DayOfWeek.TUESDAY: ##java.time.DayOfWeek \ {} as get_TUESDAY;
        import static get java.time.DayOfWeek.WEDNESDAY: ##java.time.DayOfWeek \ {} as get_WEDNESDAY;
        import static get java.time.DayOfWeek.THURSDAY: ##java.time.DayOfWeek \ {} as get_THURSDAY;
        import static get java.time.DayOfWeek.FRIDAY: ##java.time.DayOfWeek \ {} as get_FRIDAY;
        import static get java.time.DayOfWeek.SATURDAY: ##java.time.DayOfWeek \ {} as get_SATURDAY;
        import static get java.time.DayOfWeek.SUNDAY: ##java.time.DayOfWeek \ {} as get_SUNDAY;
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
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)


    pub def unmarshal(x: ##java.time.DayOfWeek): Time.DayOfWeek =
        import static get java.time.DayOfWeek.MONDAY: ##java.time.DayOfWeek \ {} as get_MONDAY;
        import static get java.time.DayOfWeek.TUESDAY: ##java.time.DayOfWeek \ {} as get_TUESDAY;
        import static get java.time.DayOfWeek.WEDNESDAY: ##java.time.DayOfWeek \ {} as get_WEDNESDAY;
        import static get java.time.DayOfWeek.THURSDAY: ##java.time.DayOfWeek \ {} as get_THURSDAY;
        import static get java.time.DayOfWeek.FRIDAY: ##java.time.DayOfWeek \ {}  as get_FRIDAY;
        import static get java.time.DayOfWeek.SATURDAY: ##java.time.DayOfWeek \ {} as get_SATURDAY;
        import static get java.time.DayOfWeek.SUNDAY: ##java.time.DayOfWeek \ {} as get_SUNDAY;
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
    def fromTemporalAccessor(x: TemporalAccessor): DayOfWeek = 
        import static java.time.DayOfWeek.from(##java.time.temporal.TemporalAccessor): ##java.time.DayOfWeek \ {} as fromTA;
        try {
            Interop/Time/Temporal/TemporalAccessor.getHH(x) |> fromTA |> unmarshal
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }
    
    pub def fromLocalDate(x: LocalDate): DayOfWeek = 
        Interop/Time/Temporal/ImpTemporalAccessor.toTemporalAccessor(x)
            |> fromTemporalAccessor

    pub def fromLocalDateTime(x: LocalDateTime): DayOfWeek = 
        Interop/Time/Temporal/ImpTemporalAccessor.toTemporalAccessor(x)
            |> fromTemporalAccessor

    pub def fromOffsetDateTime(x: OffsetDateTime): DayOfWeek = 
        Interop/Time/Temporal/ImpTemporalAccessor.toTemporalAccessor(x)
            |> fromTemporalAccessor

    pub def fromZonedDateTime(x: ZonedDateTime): DayOfWeek = 
        Interop/Time/Temporal/ImpTemporalAccessor.toTemporalAccessor(x)
            |> fromTemporalAccessor


    /// ## DayOfWeek functions

    pub def getDisplayName(style: TextStyle, locale: Locale, x: DayOfWeek): String =
        import java.time.DayOfWeek.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let x1 = marshal(x);
        let s1 = Time/Format/TextStyle.marshal(style);
        let locale1 = Interop/Util/Locale.getHH(locale);
        getDisplayName(x1, s1, locale1)


    pub def getValue(x: DayOfWeek): Int32 =
        import java.time.DayOfWeek.getValue(): Int32 \ {};
        let x1 = marshal(x);
        getValue(x1)


    /// ## plus / minus functions

    pub def plus(x: DayOfWeek, days: Int64): DayOfWeek =
        import java.time.DayOfWeek.plus(Int64): ##java.time.DayOfWeek \ {};
        let x1 = marshal(x);
        let x2 = plus(x1, days);
        unmarshal(x2)

    pub def minus(x:DayOfWeek, days: Int64): DayOfWeek = 
        import java.time.DayOfWeek.minus(Int64): ##java.time.DayOfWeek \ {};
        let x1 = marshal(x);
        let x2 = minus(x1, days);
        unmarshal(x2)


}
