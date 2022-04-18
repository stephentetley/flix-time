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

namespace Time/Chrono {

    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;

    pub enum HijrahEra with Eq, Order, ToString, Boxable, Hash {
        case AH
    }   
 

    instance TemporalAccessor[HijrahEra] {
        pub def marshalToNativeTemporalAccessor(x: HijrahEra): ##java.time.temporal.TemporalAccessor =         
            Time/Chrono/HijrahEra.marshal(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): HijrahEra = 
            Time/Chrono/HijrahEra.unmarshal(x as ##java.time.chrono.HijrahEra)
    }

    instance TemporalAdjuster[HijrahEra] {
        pub def marshalToNativeTemporalAdjuster(x: HijrahEra): ##java.time.temporal.TemporalAdjuster =         
            Time/Chrono/HijrahEra.marshal(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): HijrahEra = 
            Time/Chrono/HijrahEra.unmarshal(x as ##java.time.chrono.HijrahEra)
    }

}

namespace Time/Chrono/HijrahEra {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Chrono.HijrahEra;
    use Time/Chrono.HijrahEra.{AH};
    use Time/Format.TextStyle;
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def marshal(x: HijrahEra): ##java.time.chrono.HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra & Pure as getAH;
        match x {
            case AH         => getAH()            
        }

    def primEquals(x: ##java.time.chrono.HijrahEra, y: ##java.time.chrono.HijrahEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.HijrahEra): HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra & Pure as getAH;
        match x {
            case x1 if primEquals(x1, getAH())     => AH
        }

    pub def getValue(x: HijrahEra): Int32 = 
        import java.time.chrono.HijrahEra.getValue(): Int32 & Pure;
        let x1 = marshal(x);
        getValue(x1)



    /// 

        
    /// NOTE - maybe this should return Option [/ Result] ?
    pub def adjustInto(t: a, x: HijrahEra): a with Temporal[a] = 
        import java.time.chrono.Era.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))

    pub def getDisplayName(style: TextStyle, locale: Locale, x: HijrahEra): String = 
        import java.time.chrono.HijrahEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1)
        
    pub def range(field: a, x: HijrahEra): ValueRange with TemporalField[a] =
        import java.time.chrono.Era.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
        ValueRange(range(x1, field1))

    pub def get(t: a, x: HijrahEra): Int32 with TemporalField[a] = 
        import java.time.chrono.Era.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: HijrahEra): Int64 with TemporalField[a] = 
        import java.time.chrono.Era.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

}
