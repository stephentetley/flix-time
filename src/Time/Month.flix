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

    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;

    pub enum Month with Eq, Order, ToString, Hash, Boxable {
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

    instance TemporalAccessor[Month] {
        pub def marshalToNativeTemporalAccessor(x: Month): ##java.time.temporal.TemporalAccessor =         
            Time/Month.marshal(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): Month = 
            Time/Month.unmarshal(x as ##java.time.Month)
    }

    instance TemporalAdjuster[Month] {
        pub def marshalToNativeTemporalAdjuster(x: Month): ##java.time.temporal.TemporalAdjuster =         
            Time/Month.marshal(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): Month = 
            Time/Month.unmarshal(x as ##java.time.Month)
    }

}

namespace Time/Month {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time.Month;
    use Time.Month.{January, February, March, April, May, June, July, August, September, October, November, December};
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time/Format.TextStyle;

    /// `fromTemporalAccessor` does not support all TemporalAccessor types
    pub def fromTemporalAccessor(x: a): Result[Month, String] with TemporalAccessor[a] = 
        import static java.time.Month.from(##java.time.temporal.TemporalAccessor): ##java.time.Month & Pure as fromTA;
        try {
            let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
            unmarshal(fromTA(x1)) |> Ok
        } catch {
            case ex: ##java.lang.Exception => Err(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def marshal(x: Month): ##java.time.Month =
        import static get java.time.Month.JANUARY: ##java.time.Month & Pure as get_JANUARY;
        import static get java.time.Month.FEBRUARY: ##java.time.Month & Pure as get_FEBRUARY;
        import static get java.time.Month.MARCH: ##java.time.Month & Pure as get_MARCH;
        import static get java.time.Month.APRIL: ##java.time.Month & Pure as get_APRIL;
        import static get java.time.Month.MAY: ##java.time.Month & Pure as get_MAY;
        import static get java.time.Month.JUNE: ##java.time.Month & Pure as get_JUNE;
        import static get java.time.Month.JULY: ##java.time.Month & Pure as get_JULY;
        import static get java.time.Month.AUGUST: ##java.time.Month & Pure as get_AUGUST;
        import static get java.time.Month.SEPTEMBER: ##java.time.Month & Pure as get_SEPTEMBER;
        import static get java.time.Month.OCTOBER: ##java.time.Month & Pure as get_OCTOBER;
        import static get java.time.Month.NOVEMBER: ##java.time.Month & Pure as get_NOVEMBER;
        import static get java.time.Month.DECEMBER: ##java.time.Month & Pure as get_DECEMBER;
        match x {
            case January    => get_JANUARY()
            case February   => get_FEBRUARY()
            case March      => get_MARCH()
            case April      => get_APRIL()
            case May        => get_MAY()
            case June       => get_JUNE()
            case July       => get_JULY()
            case August     => get_AUGUST()
            case September  => get_SEPTEMBER()
            case October    => get_OCTOBER()
            case November   => get_NOVEMBER()
            case December   => get_DECEMBER()
        }

    def primEquals(x: ##java.time.Month, y: ##java.time.Month): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.Month): Month =
        import static get java.time.Month.JANUARY: ##java.time.Month & Pure as get_JANUARY;
        import static get java.time.Month.FEBRUARY: ##java.time.Month & Pure as get_FEBRUARY;
        import static get java.time.Month.MARCH: ##java.time.Month & Pure as get_MARCH;
        import static get java.time.Month.APRIL: ##java.time.Month & Pure as get_APRIL;
        import static get java.time.Month.MAY: ##java.time.Month & Pure as get_MAY;
        import static get java.time.Month.JUNE: ##java.time.Month & Pure as get_JUNE;
        import static get java.time.Month.JULY: ##java.time.Month & Pure as get_JULY;
        import static get java.time.Month.AUGUST: ##java.time.Month & Pure as get_AUGUST;
        import static get java.time.Month.SEPTEMBER: ##java.time.Month & Pure as get_SEPTEMBER;
        import static get java.time.Month.OCTOBER: ##java.time.Month & Pure as get_OCTOBER;
        import static get java.time.Month.NOVEMBER: ##java.time.Month & Pure as get_NOVEMBER;
        import static get java.time.Month.DECEMBER: ##java.time.Month & Pure as get_DECEMBER;
        match x {
            case x1 if primEquals(x1, get_JANUARY())     => January
            case x1 if primEquals(x1, get_FEBRUARY())    => February
            case x1 if primEquals(x1, get_MARCH())       => March
            case x1 if primEquals(x1, get_APRIL())       => April
            case x1 if primEquals(x1, get_MAY())         => May
            case x1 if primEquals(x1, get_JUNE())        => June
            case x1 if primEquals(x1, get_JULY())        => July
            case x1 if primEquals(x1, get_AUGUST())      => August
            case x1 if primEquals(x1, get_SEPTEMBER())   => September
            case x1 if primEquals(x1, get_OCTOBER())     => October
            case x1 if primEquals(x1, get_NOVEMBER())    => November
            case x1 if primEquals(x1, get_DECEMBER())    => December
        }


    pub def getDisplayName(x: Month, style: TextStyle, locale: Locale): String =
        import java.time.Month.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x);
        let s1 = Time/Format/TextStyle.marshal(style);
        let Locale(l1) = locale;
        getDisplayName(x1, s1, l1)

    pub def getName(x: Month): String =
        import java.lang.Enum.name(): String & Pure;
        let en1 = marshal(x) as ##java.lang.Enum;
        name(en1)


    pub def hashCode(x: Month): Int32 =
        import java.lang.Enum.hashCode(): Int32 & Pure;
        let en1 = marshal(x) as ##java.lang.Enum;
        hashCode(en1)

    pub def compareTo(x: Month, y: Month): Int32 =
        import java.lang.Enum.compareTo(##java.lang.Enum): Int32 & Pure;
        let x1 = marshal(x) as ##java.lang.Enum;
        let y1 = marshal(y) as ##java.lang.Enum;
        compareTo(x1, y1)


    pub def plus(x:Month, y: Int64): Month =
        import java.time.Month.plus(Int64): ##java.time.Month & Pure;
        let x1 = marshal(x);
        let x2 = plus(x1, y);
        unmarshal(x2)

    pub def minus(x:Month, y: Int64): Month =
        import java.time.Month.minus(Int64): ##java.time.Month & Pure;
        let x1 = marshal(x);
        let x2 = minus(x1, y);
        unmarshal(x2)

    pub def get(t: a, x: Month): Int32 with TemporalField[a] = 
        import java.time.Month.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = marshal(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: Month): Int64 with TemporalField[a] = 
        import java.time.Month.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = marshal(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)


    pub def range(field: a, x: Month): ValueRange with TemporalField[a] =
        import java.time.Month.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let x1 = marshal(x);
            let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
            ValueRange(range(x1, field1))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def adjustInto(t: a, x: Month): a with Temporal[a] = 
        import java.time.Month.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = marshal(x);
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))

}
