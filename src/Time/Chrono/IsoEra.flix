/*
 * Copyright 2021 Stephen Tetley
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

    pub enum IsoEra with Eq, Order, ToString, Hash, Boxable {
        case BCE
        case CE
    }   
    
    instance TemporalAccessor[IsoEra] {
        pub def marshalToNativeTemporalAccessor(x: IsoEra): ##java.time.temporal.TemporalAccessor =         
            Time/Chrono/IsoEra.marshal(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): IsoEra = 
            Time/Chrono/IsoEra.unmarshal(x as ##java.time.chrono.IsoEra)
    }

    instance TemporalAdjuster[IsoEra] {
        pub def marshalToNativeTemporalAdjuster(x: IsoEra): ##java.time.temporal.TemporalAdjuster =         
            Time/Chrono/IsoEra.marshal(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): IsoEra = 
            Time/Chrono/IsoEra.unmarshal(x as ##java.time.chrono.IsoEra)
    }

}

namespace Time/Chrono/IsoEra {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Chrono.IsoEra;
    use Time/Chrono.IsoEra.{BCE, CE};
    use Time/Format.TextStyle;
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};    
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    pub def marshal(x: IsoEra): ##java.time.chrono.IsoEra = 
        import static get java.time.chrono.IsoEra.BCE: ##java.time.chrono.IsoEra & Pure as get_BCE;
        import static get java.time.chrono.IsoEra.CE: ##java.time.chrono.IsoEra & Pure as get_CE;
        match x {
            case BCE        => get_BCE()
            case CE         => get_CE()
        }

    def primEquals(x: ##java.time.chrono.IsoEra, y: ##java.time.chrono.IsoEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.IsoEra): IsoEra = 
        import static get java.time.chrono.IsoEra.BCE: ##java.time.chrono.IsoEra & Pure as get_BCE;
        import static get java.time.chrono.IsoEra.CE: ##java.time.chrono.IsoEra & Pure as get_CE;
        match x {
            case x1 if primEquals(x1, get_BCE())    => BCE
            case x1 if primEquals(x1, get_CE())     => CE
        }

    pub def getValue(x: IsoEra): Int32 = 
        import java.time.chrono.IsoEra.getValue(): Int32 & Pure;
        let x1 = marshal(x);
        getValue(x1)


    /// Era interface functions

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def adjustInto(t: a, x: IsoEra): a with Temporal[a] = 
        import java.time.chrono.Era.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))

    pub def getDisplayName(style: TextStyle, locale: Locale, x: IsoEra): String = 
        import java.time.chrono.Era.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1)
        
    pub def range(field: a, x: IsoEra): ValueRange with TemporalField[a] =
        import java.time.chrono.Era.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let field1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(field);
        ValueRange(range(x1, field1))

    pub def get(t: a, x: IsoEra): Int32 with TemporalField[a] = 
        import java.time.chrono.Era.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: IsoEra): Int64 with TemporalField[a] = 
        import java.time.chrono.Era.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)


}
