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
        pub def toString(x: Month): String = match x {
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
        pub def fromString(x: String): Option[Month] = match x {
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

    instance Eq[Month] {
        pub def eq(x: Month, y: Month): Bool = match (x,y) {
            case (January, January) => true
            case (February, February) => true
            case (March, March) => true
            case (April, April) => true
            case (May, May) => true
            case (June, June) => true
            case (July, July) => true
            case (August, August) => true
            case (September, September) => true
            case (October, October) => true
            case (November, November) => true
            case (December, December) => true
            case (_, _) => false
        }
    }

    instance Hash[Month] {
        pub def hash(x: Month): Int32 = Time/Month.hashCode(x)
    }

    instance Order[Month] {
        pub def compare(x: Month, y: Month): Comparison =
            Time/Month.compareTo(x,y) |> Comparison.fromInt32
    }

    instance Boxable[Month]
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

    pub def fromInt32(n: Int32): Month = match (n `Mod.mod` 12) {
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

    pub def toNative(x: Month): ##java.time.Month =
        import static get java.time.Month.JANUARY: ##java.time.Month & Pure as getJANUARY;
        import static get java.time.Month.FEBRUARY: ##java.time.Month & Pure as getFEBRUARY;
        import static get java.time.Month.MARCH: ##java.time.Month & Pure as getMARCH;
        import static get java.time.Month.APRIL: ##java.time.Month & Pure as getAPRIL;
        import static get java.time.Month.MAY: ##java.time.Month & Pure as getMAY;
        import static get java.time.Month.JUNE: ##java.time.Month & Pure as getJUNE;
        import static get java.time.Month.JULY: ##java.time.Month & Pure as getJULY;
        import static get java.time.Month.AUGUST: ##java.time.Month & Pure as getAUGUST;
        import static get java.time.Month.SEPTEMBER: ##java.time.Month & Pure as getSEPTEMBER;
        import static get java.time.Month.OCTOBER: ##java.time.Month & Pure as getOCTOBER;
        import static get java.time.Month.NOVEMBER: ##java.time.Month & Pure as getNOVEMBER;
        import static get java.time.Month.DECEMBER: ##java.time.Month & Pure as getDECEMBER;
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
        }

    def primEquals(x: ##java.time.Month, y: ##java.time.Month): Bool =
        import java.lang.Object.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def fromNative(x: ##java.time.Month): Month =
        import static get java.time.Month.JANUARY: ##java.time.Month & Pure as getJANUARY;
        import static get java.time.Month.FEBRUARY: ##java.time.Month & Pure as getFEBRUARY;
        import static get java.time.Month.MARCH: ##java.time.Month & Pure as getMARCH;
        import static get java.time.Month.APRIL: ##java.time.Month & Pure as getAPRIL;
        import static get java.time.Month.MAY: ##java.time.Month & Pure as getMAY;
        import static get java.time.Month.JUNE: ##java.time.Month & Pure as getJUNE;
        import static get java.time.Month.JULY: ##java.time.Month & Pure as getJULY;
        import static get java.time.Month.AUGUST: ##java.time.Month & Pure as getAUGUST;
        import static get java.time.Month.SEPTEMBER: ##java.time.Month & Pure as getSEPTEMBER;
        import static get java.time.Month.OCTOBER: ##java.time.Month & Pure as getOCTOBER;
        import static get java.time.Month.NOVEMBER: ##java.time.Month & Pure as getNOVEMBER;
        import static get java.time.Month.DECEMBER: ##java.time.Month & Pure as getDECEMBER;
        match x {
            case x1 if primEquals(x1, getJANUARY())     => January
            case x1 if primEquals(x1, getFEBRUARY())    => February
            case x1 if primEquals(x1, getMARCH())       => March
            case x1 if primEquals(x1, getAPRIL())       => April
            case x1 if primEquals(x1, getMAY())         => May
            case x1 if primEquals(x1, getJUNE())        => June
            case x1 if primEquals(x1, getJULY())        => July
            case x1 if primEquals(x1, getAUGUST())      => August
            case x1 if primEquals(x1, getSEPTEMBER())   => September
            case x1 if primEquals(x1, getOCTOBER())     => October
            case x1 if primEquals(x1, getNOVEMBER())    => November
            case x1 if primEquals(x1, getDECEMBER())    => December
        }


    pub def getDisplayName(x: Month, style: TextStyle, locale: I18n.Locale): String =
        import java.time.Month.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = toNative(x);
        let s1 = Time/Format/TextStyle.toNative(style);
        let Locale(l1) = locale;
        getDisplayName(x1, s1, l1)

    pub def getName(x: Month): String =
        import java.lang.Enum.name(): String & Pure;
        let en1 = toNative(x) as ##java.lang.Enum;
        name(en1)


    pub def hashCode(x: Month): Int32 =
        import java.lang.Enum.hashCode(): Int32 & Pure;
        let en1 = toNative(x) as ##java.lang.Enum;
        hashCode(en1)

    pub def compareTo(x: Month, y: Month): Int32 =
        import java.lang.Enum.compareTo(##java.lang.Enum): Int32 & Pure;
        let x1 = toNative(x) as ##java.lang.Enum;
        let y1 = toNative(y) as ##java.lang.Enum;
        compareTo(x1, y1)


    pub def plus(x:Month, y: Int64): Month =
        import java.time.Month.plus(Int64): ##java.time.Month & Pure;
        let x1 = toNative(x);
        let x2 = plus(x1, y);
        fromNative(x2)

    pub def minus(x:Month, y: Int64): Month =
        import java.time.Month.minus(Int64): ##java.time.Month & Pure;
        let x1 = toNative(x);
        let x2 = minus(x1, y);
        fromNative(x2)

}