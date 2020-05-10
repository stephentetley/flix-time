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

    /// 1 indexed.
    pub def toInt32(x: DayOfWeek): Int32 = 
        import java.time.DayOfWeek.getValue();
        x.marshal().getValue() as & Pure

    /// 1 indexed.
    pub def fromInt32(n: Int32): DayOfWeek =
        import java.time.DayOfWeek:of(Int32);
        n.of().unmarshal() as & Pure


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

    pub def getDisplayName(x: DayOfWeek, style: TextStyle, locale: Locale): String = 
        import java.time.DayOfWeek.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = marshal(x);
        let s1 = Time/Format/TextStyle.marshal(style);
        let Locale(l1) = locale;
        x1.getDisplayName(s1, l1) as & Pure


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