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

    pub enum HijrahEra {
        case AH
    }   

    instance ToString[HijrahEra] {
        def toString(x: HijrahEra): String = match x {
            case AH => "AH"
        }
    }

    instance Eq[HijrahEra] {
        def eq(x: HijrahEra, y: HijrahEra): Bool = match (x, y) {
            case (AH, AH) => true
        }

        def neq(x: HijrahEra, y: HijrahEra): Bool = not (x == y)
    }

    instance Hash[HijrahEra] {
        def hash(x: HijrahEra): Int = Time/Chrono/HijrahEra.hashCode(x)
    }    

}

namespace Time/Chrono/HijrahEra {

    use I18n.Locale;
    use I18n.Locale.{Locale};

    use Time/Chrono.HijrahEra;
    use Time/Chrono.HijrahEra.{AH};
    use Time/Format.TextStyle;
    use Time/Temporal.ChronoField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def marshal(x: HijrahEra): ##java.time.chrono.HijrahEra = 
        import get java.time.chrono.HijrahEra:AH      as getAH;
        match x {
            case AH         => getAH()            
        } as & Pure

    def primEquals(x: ##java.time.chrono.HijrahEra, y: ##java.time.chrono.HijrahEra): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def unmarshal(x: ##java.time.chrono.HijrahEra): HijrahEra = 
        import get java.time.chrono.HijrahEra:AH as getAH;
        match x {
            case x1 if primEquals(x1, getAH())     => AH
        } as & Pure

    pub def getValue(x: HijrahEra): Int32 = 
        import java.time.chrono.HijrahEra.getValue();
        let x1 = marshal(x);
        getValue(x1) as & Pure 


    pub def hashCode(x: HijrahEra): Int32 =
        import java.lang.Enum.hashCode();
        let en1 = marshal(x) as ##java.lang.Enum;
        hashCode(en1) as & Pure


    /// 
    pub def getDisplayName(x: HijrahEra, style: TextStyle, locale: Locale): String = 
        import java.time.chrono.HijrahEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1) as & Pure
        
    pub def range(x: HijrahEra, field: ChronoField): ValueRange = 
        import java.time.chrono.HijrahEra.range(##java.time.temporal.TemporalField);
        let x1 = marshal(x);
        let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
        ValueRange(range(x1, field1) as & Pure)

}
