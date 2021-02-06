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

    pub enum IsoEra {
        case BCE
        case CE
    }   
    
    instance Eq[IsoEra] {
        def eq(x: IsoEra, y: IsoEra): Bool = match (x, y) {
            case (BCE, BCE) => true
            case (CE, CE) => true
            case (_, _) => true
        }

        def neq(x: IsoEra, y: IsoEra): Bool = not (x == y)
    }

}

namespace Time/Chrono/IsoEra {

    use I18n.Locale;
    use I18n.Locale.{Locale};

    use Time/Chrono.IsoEra;
    use Time/Chrono.IsoEra.{BCE, CE};
    use Time/Format.TextStyle;
    use Time/Temporal.ChronoField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def marshal(x: IsoEra): ##java.time.chrono.IsoEra = 
        import get java.time.chrono.IsoEra:BCE      as getBCE;
        import get java.time.chrono.IsoEra:CE       as getCE;
        match x {
            case BCE        => getBCE()
            case CE         => getCE()
        } as & Pure

    def primEquals(x: ##java.time.chrono.IsoEra, y: ##java.time.chrono.IsoEra): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def unmarshal(x: ##java.time.chrono.IsoEra): IsoEra = 
        import get java.time.chrono.IsoEra:BCE      as getBCE;
        import get java.time.chrono.IsoEra:CE       as getCE;
        match x {
            case x1 if primEquals(x1, getBCE())     => BCE
            case x1 if primEquals(x1, getCE())      => CE
        } as & Pure

    pub def getValue(x: IsoEra): Int32 = 
        import java.time.chrono.IsoEra.getValue();
        let x1 = marshal(x);
        getValue(x1) as & Pure 

    /// 
    pub def getDisplayName(x: IsoEra, style: TextStyle, locale: Locale): String = 
        import java.time.chrono.Era.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1 as ##java.time.chrono.Era, style1, locale1) as & Pure
        
    pub def range(x: IsoEra, field: ChronoField): ValueRange = 
        import java.time.chrono.Era.range(##java.time.temporal.TemporalField);
        let x1 = marshal(x);
        let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
        ValueRange(range(x1 as ##java.time.chrono.Era, field1) as & Pure)

}
