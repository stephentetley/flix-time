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

use Time.DayOfWeek;
use Time.DayOfWeek.{Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday};
use Time/Format.TextStyle;

namespace Time {

    pub enum DayOfWeek {
        case Monday,
        case Tuesday,
        case Wednesday,
        case Thursday,
        case Friday,
        case Saturday,
        case Sunday
    }

}

namespace Time/DayOfWeek {

    pub def toInt32(x: DayOfWeek): Int32 = match x {
        case Monday     => 1
        case Tuesday    => 2
        case Wednesday  => 3
        case Thursday   => 4
        case Friday     => 5
        case Saturday   => 6
        case Sunday     => 7
    }

    pub def fromInt32(n: Int32): DayOfWeek = match (n % 7) {
        case 1 => Monday
        case 2 => Tuesday
        case 3 => Wednesday
        case 4 => Thursday
        case 5 => Friday
        case 6 => Saturday
        case _ => Sunday
    }


    pub def marshal(x: DayOfWeek): ##java.time.DayOfWeek = 
        import get java.time.DayOfWeek:MONDAY as javaMonday;
        import get java.time.DayOfWeek:TUESDAY as javaTuesday;
        import get java.time.DayOfWeek:WEDNESDAY as javaWednesday;
        import get java.time.DayOfWeek:THURSDAY as javaThursday;
        import get java.time.DayOfWeek:FRIDAY as javaFriday;
        import get java.time.DayOfWeek:SATURDAY as javaSaturday;
        import get java.time.DayOfWeek:SUNDAY as javaSunday;
        match x {
            case Monday     => javaMonday()
            case Tuesday    => javaTuesday()
            case Wednesday  => javaWednesday()
            case Thursday   => javaThursday()
            case Friday     => javaFriday()
            case Saturday   => javaSaturday()
            case Sunday     => javaSunday() 
        } as & Pure



    // Wrapping `getDisplayName` a priority so we can experiment with Locale.

    pub def getDisplayName(x: DayOfWeek, style: TextStyle, locale: Locale): String = 
        import java.time.DayOfWeek.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = marshal(x);
        let s1 = Time/Format/TextStyle.marshal(style);
        let Locale(l1) = locale;
        x1.getDisplayName(s1, l1) as & Pure

}