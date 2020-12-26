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
    pub enum DayOfWeek {
        case Monday,
        case Tuesday,
        case Wednesday,
        case Thursday,
        case Friday,
        case Saturday,
        case Sunday
    }

    instance ToString[DayOfWeek] {
        def toString(x: DayOfWeek): String = match x {
            case Monday => "Monday"
            case Tuesday => "Tuesday"
            case Wednesday => "Wednesday"
            case Thursday => "Thursday"
            case Friday => "Friday"
            case Saturday => "Saturday"
            case Sunday => "Sunday"
        }
    }

    instance FromString[DayOfWeek] {
        def fromString(x: String): Option[DayOfWeek] = match x {
            case "Monday" => Some(Monday)
            case "Tuesday" => Some(Tuesday)
            case "Wednesday" => Some(Wednesday)
            case "Thursday" => Some(Thursday)
            case "Friday" => Some(Friday)
            case "Saturday" => Some(Saturday)
            case "Sunday" => Some(Sunday)
            case _ => None
        }
    }

    instance LowerBound[DayOfWeek] {
        def minValue(): DayOfWeek = Monday
    }

    instance UpperBound[DayOfWeek] {
        def maxValue(): DayOfWeek = Sunday
    }
}

namespace Time/DayOfWeek {

    use System.Error.{Generic};
    use I18n.Locale.{Locale};

    use Time.DayOfWeek;
    use Time.DayOfWeek.{Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday};
    use Time/Format.TextStyle;


    /// 
    /// Expected to be replaced by a typeclass method...
    ///
    pub def fromEnum(x: DayOfWeek): Int32 = match x {
        case Monday => 0
        case Tuesday => 1
        case Wednesday => 2
        case Thursday => 3
        case Friday => 4
        case Saturday => 5
        case Sunday => 6
    }

    /// 
    /// Expected to be replaced by a typeclass method...
    ///    
    pub def toEnum(x: Int32): Option[DayOfWeek] = match x {
        case 0 => Some(Monday)
        case 1 => Some(Tuesday)
        case 2 => Some(Wednesday)
        case 3 => Some(Thursday)
        case 4 => Some(Friday)
        case 5 => Some(Saturday)
        case 6 => Some(Sunday)
        case _ => None
    }

    pub def marshal(x: DayOfWeek): ##java.time.DayOfWeek = 
        import get java.time.DayOfWeek:MONDAY       as getMONDAY;
        import get java.time.DayOfWeek:TUESDAY      as getTUESDAY;
        import get java.time.DayOfWeek:WEDNESDAY    as getWEDNESDAY;
        import get java.time.DayOfWeek:THURSDAY     as getTHURSDAY;
        import get java.time.DayOfWeek:FRIDAY       as getFRIDAY;
        import get java.time.DayOfWeek:SATURDAY     as getSATURDAY;
        import get java.time.DayOfWeek:SUNDAY       as getSUNDAY;
        match x {
            case Monday     => getMONDAY()
            case Tuesday    => getTUESDAY()
            case Wednesday  => getWEDNESDAY()
            case Thursday   => getTHURSDAY()
            case Friday     => getFRIDAY()
            case Saturday   => getSATURDAY()
            case Sunday     => getSUNDAY() 
        } as & Pure

    pub def unmarshal(x: ##java.time.DayOfWeek): DayOfWeek = 
        import get java.time.DayOfWeek:MONDAY       as getMONDAY;
        import get java.time.DayOfWeek:TUESDAY      as getTUESDAY;
        import get java.time.DayOfWeek:WEDNESDAY    as getWEDNESDAY;
        import get java.time.DayOfWeek:THURSDAY     as getTHURSDAY;
        import get java.time.DayOfWeek:FRIDAY       as getFRIDAY;
        import get java.time.DayOfWeek:SATURDAY     as getSATURDAY;
        import get java.time.DayOfWeek:SUNDAY       as getSUNDAY;
        match x {
            case x1 if x1 == getMONDAY()    => Monday
            case x1 if x1 == getTUESDAY()   => Tuesday
            case x1 if x1 == getWEDNESDAY() => Wednesday
            case x1 if x1 == getTHURSDAY()  => Thursday
            case x1 if x1 == getFRIDAY()    => Friday
            case x1 if x1 == getSATURDAY()  => Saturday
            case x1 if x1 == getSUNDAY()    => Sunday
        } as & Pure

    pub def getDisplayName(x: DayOfWeek, style: TextStyle, locale: I18n.Locale): String =
        import java.time.DayOfWeek.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = marshal(x);
        let s1 = Time/Format/TextStyle.marshal(style);
        let Locale(l1) = locale;
        x1.getDisplayName(s1, l1) as & Pure

    pub def getName(x: DayOfWeek): String =
        import java.lang.Enum.name();
        let x1 = marshal(x) as ##java.lang.Enum;
        x1.name() as & Pure

    pub def __eq(x: DayOfWeek, y: DayOfWeek): Bool = match (x, y) {
        case (Monday, Monday) => true
        case (Tuesday, Tuesday) => true
        case (Wednesday, Wednesday) => true
        case (Thursday, Thursday) => true
        case (Friday, Friday) => true
        case (Saturday, Saturday) => true
        case (Sunday, Sunday) => true
        case (_, _) => false
    }

    pub def compare(x: DayOfWeek, y: DayOfWeek): Int32 = Int32.compare(fromEnum(x), fromEnum(y))

    pub def plus(x:DayOfWeek, y: Int64): DayOfWeek =
        import java.time.DayOfWeek.plus(Int64);
        let x1 = marshal(x);
        let x2 = plus(x1, y) as & Pure;
        unmarshal(x2)

    pub def minus(x:DayOfWeek, y: Int64): DayOfWeek = 
        import java.time.DayOfWeek.minus(Int64);
        let x1 = marshal(x);
        let x2 = minus(x1, y) as & Pure;
        unmarshal(x2)


}