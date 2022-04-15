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

    pub enum IsoEra with Eq, Order, ToString {
        case BCE
        case CE
    }   
    
    
    instance Hash[IsoEra] {
        pub def hash(x: IsoEra): Int32 = Time/Chrono/IsoEra.hashCode(x)
    }    

}

namespace Time/Chrono/IsoEra {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Chrono.IsoEra;
    use Time/Chrono.IsoEra.{BCE, CE};
    use Time/Format.TextStyle;
    use Time/Temporal.ChronoField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};    
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    pub def marshal(x: IsoEra): ##java.time.chrono.IsoEra = 
        import static get java.time.chrono.IsoEra.BCE: ##java.time.chrono.IsoEra & Pure as getBCE;
        import static get java.time.chrono.IsoEra.CE: ##java.time.chrono.IsoEra & Pure as getCE;
        match x {
            case BCE        => getBCE()
            case CE         => getCE()
        }

    def primEquals(x: ##java.time.chrono.IsoEra, y: ##java.time.chrono.IsoEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.IsoEra): IsoEra = 
        import static get java.time.chrono.IsoEra.BCE: ##java.time.chrono.IsoEra & Pure as getBCE;
        import static get java.time.chrono.IsoEra.CE: ##java.time.chrono.IsoEra & Pure as getCE;
        match x {
            case x1 if primEquals(x1, getBCE())     => BCE
            case x1 if primEquals(x1, getCE())      => CE
        }

    pub def getValue(x: IsoEra): Int32 = 
        import java.time.chrono.IsoEra.getValue(): Int32 & Pure;
        let x1 = marshal(x);
        getValue(x1)


    pub def hashCode(x: IsoEra): Int32 =
        import java.lang.Enum.hashCode(): Int32 & Pure;
        let en1 = marshal(x) as ##java.lang.Enum;
        hashCode(en1)


    /// 
    pub def getDisplayName(x: IsoEra, style: TextStyle, locale: Locale): String = 
        import java.time.chrono.Era.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1 as ##java.time.chrono.Era, style1, locale1)
        
    pub def range(x: IsoEra, field: ChronoField): ValueRange = 
        import java.time.chrono.Era.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;
        let x1 = marshal(x);
        let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
        ValueRange(range(x1 as ##java.time.chrono.Era, field1))

    pub def getEra(x: LocalDate): IsoEra = 
        import java.time.LocalDate.getEra(): ##java.time.chrono.IsoEra & Pure;
        let LocalDate(x1) = x;
        unmarshal(getEra(x1))


}
