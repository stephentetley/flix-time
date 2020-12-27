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

    pub enum Month {
        case January,
        case February,
        case March,
        case April,
        case May,
        case June,
        case July,
        case August,
        case September,
        case October,
        case November,
        case December
    }
    
    instance ToString[Month] {
        def toString(x: Month): String = match x {
            case January => "January"
            case February => "February"
            case March => "March"
            case April => "April"
            case May => "May"
            case June => "June"
            case July => "July"
            case August => "August"
            case September => "September"
            case October => "October"
            case November => "November"
            case December => "December"
        }
    }

    instance FromString[Month] {
        def fromString(x: String): Option[Month] = match x {
            case  "January" => Some(January)
            case  "February" => Some(February)
            case  "March" => Some(March)
            case  "April" => Some(April)
            case  "May" => Some(May)
            case  "June" => Some(June)
            case  "July" => Some(July)
            case  "August" => Some(August)
            case  "September" => Some(September)
            case  "October" => Some(October)
            case  "November" => Some(November)
            case  "December" => Some(December)
            case _ => None
        }
    }

}

namespace Time/Month {

    use I18n.Locale.{Locale};

    use Time.Month;
    use Time.Month.{January, February, March, April, May, June, July, August, September, October, November, December};
    use Time/Format.TextStyle;

    pub def toInt32(x: Month): Int32 = match x {
        case January => 1
        case February => 2
        case March => 3
        case April => 4
        case May => 5
        case June => 6
        case July => 7
        case August => 8
        case September => 9
        case October => 10
        case November => 11
        case December => 12
    }

    pub def fromInt32(n: Int32): Month = match (n % 12) {
        case 1 => January
        case 2 => February
        case 3 => March
        case 4 => April
        case 5 => May
        case 6 => June
        case 7 => July
        case 8 => August
        case 9 => September
        case 10 => October
        case 11 => November
        case _  => December
    }

    pub def marshal(x: Month): ##java.time.Month = 
        import get java.time.Month:JANUARY      as getJANUARY;
        import get java.time.Month:FEBRUARY     as getFEBRUARY;
        import get java.time.Month:MARCH        as getMARCH;
        import get java.time.Month:APRIL        as getAPRIL;
        import get java.time.Month:MAY          as getMAY;
        import get java.time.Month:JUNE         as getJUNE;
        import get java.time.Month:JULY         as getJULY;
        import get java.time.Month:AUGUST       as getAUGUST;
        import get java.time.Month:SEPTEMBER    as getSEPTEMBER;
        import get java.time.Month:OCTOBER      as getOCTOBER;
        import get java.time.Month:NOVEMBER     as getNOVEMBER;
        import get java.time.Month:DECEMBER     as getDECEMBER;
        match x {
            case January    => getJANUARY()
            case February   => getFEBRUARY()
            case March      => getMARCH()
            case April      => getAPRIL()
            case May        => getMAY()
            case June       => getJUNE()
            case July       => getJULY()
            case August     => getAUGUST()
            case September  => getSEPTEMBER()
            case October    => getOCTOBER()
            case November   => getNOVEMBER()
            case December   => getDECEMBER()
        } as & Pure

    pub def unmarshal(x: ##java.time.Month): Month = 
        import get java.time.Month:JANUARY      as getJANUARY;
        import get java.time.Month:FEBRUARY     as getFEBRUARY;
        import get java.time.Month:MARCH        as getMARCH;
        import get java.time.Month:APRIL        as getAPRIL;
        import get java.time.Month:MAY          as getMAY;
        import get java.time.Month:JUNE         as getJUNE;
        import get java.time.Month:JULY         as getJULY;
        import get java.time.Month:AUGUST       as getAUGUST;
        import get java.time.Month:SEPTEMBER    as getSEPTEMBER;
        import get java.time.Month:OCTOBER      as getOCTOBER;
        import get java.time.Month:NOVEMBER     as getNOVEMBER;
        import get java.time.Month:DECEMBER     as getDECEMBER;
        match x {
            case x1 if x1 == getJANUARY()   => January
            case x1 if x1 == getFEBRUARY()  => February
            case x1 if x1 == getMARCH()     => March
            case x1 if x1 == getAPRIL()     => April
            case x1 if x1 == getMAY()       => May
            case x1 if x1 == getJUNE()      => June
            case x1 if x1 == getJULY()      => July
            case x1 if x1 == getAUGUST()    => August
            case x1 if x1 == getSEPTEMBER() => September
            case x1 if x1 == getOCTOBER()   => October
            case x1 if x1 == getNOVEMBER()  => November
            case x1 if x1 == getDECEMBER()  => December
        } as & Pure


    pub def getDisplayName(x: Month, style: TextStyle, locale: I18n.Locale): String =
        import java.time.Month.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = marshal(x);
        let s1 = Time/Format/TextStyle.marshal(style);
        let Locale(l1) = locale;
        x1.getDisplayName(s1, l1) as & Pure

    pub def getName(x: Month): String =
        import java.lang.Enum.name();
        let x1 = marshal(x) as ##java.lang.Enum;
        x1.name() as & Pure

    pub def equals(x: Month, y: Month): Bool = toInt32(x) == toInt32(y)

    pub def compare(x: Month, y: Month): Int32 = Int32.compare(toInt32(x), toInt32(y))


    pub def plus(x:Month, y: Int64): Month = 
        import java.time.Month.plus(Int64);
        let x1 = marshal(x);
        let x2 = plus(x1, y) as & Pure;
        unmarshal(x2)

    pub def minus(x:Month, y: Int64): Month = 
        import java.time.Month.minus(Int64);
        let x1 = marshal(x);
        let x2 = minus(x1, y) as & Pure;
        unmarshal(x2)



}

