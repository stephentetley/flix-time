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

    pub enum ThaiBuddhistEra {
        case BEFORE_BE
        case BE
    }   

    instance ToString[ThaiBuddhistEra] {
        def toString(x: ThaiBuddhistEra): String = match x {
            case BEFORE_BE  => "BEFORE_BE"
            case BE         => "BE"
        }
    }

    instance Eq[ThaiBuddhistEra] {
        def eq(x: ThaiBuddhistEra, y: ThaiBuddhistEra): Bool = match (x, y) {
            case (BEFORE_BE, BEFORE_BE) => true
            case (BE, BE) => true
            case (_, _) => false
        }

        def neq(x: ThaiBuddhistEra, y: ThaiBuddhistEra): Bool = not (x == y)
    }

    instance Hash[ThaiBuddhistEra] {
        def hash(x: ThaiBuddhistEra): Int = Time/Chrono/ThaiBuddhistEra.hashCode(x)
    }    

}

namespace Time/Chrono/ThaiBuddhistEra {

    use I18n.Locale;
    use I18n.Locale.{Locale};

    use Time/Chrono.ThaiBuddhistEra;
    use Time/Chrono.ThaiBuddhistEra.{BEFORE_BE, BE};
    use Time/Format.TextStyle;
    use Time/Temporal.ChronoField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def marshal(x: ThaiBuddhistEra): ##java.time.chrono.ThaiBuddhistEra = 
        import get java.time.chrono.ThaiBuddhistEra:BEFORE_BE     as getBEFORE_BE;
        import get java.time.chrono.ThaiBuddhistEra:BE            as getBE;
        match x {
            case BEFORE_BE  => getBEFORE_BE()
            case BE         => getBE() 
        } as & Pure

    def primEquals(x: ##java.time.chrono.ThaiBuddhistEra, y: ##java.time.chrono.ThaiBuddhistEra): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def unmarshal(x: ##java.time.chrono.ThaiBuddhistEra): ThaiBuddhistEra =
        import get java.time.chrono.ThaiBuddhistEra:BEFORE_BE     as getBEFORE_BE;
        import get java.time.chrono.ThaiBuddhistEra:BE            as getBE;
        match x {
            case x1 if primEquals(x1, getBEFORE_BE())  => BEFORE_BE
            case x1 if primEquals(x1, getBE())         => BE
        } as & Pure

    pub def getValue(x: ThaiBuddhistEra): Int32 = 
        import java.time.chrono.ThaiBuddhistEra.getValue();
        let x1 = marshal(x);
        getValue(x1) as & Pure 


    pub def hashCode(x: ThaiBuddhistEra): Int32 =
        import java.lang.Enum.hashCode();
        let en1 = marshal(x) as ##java.lang.Enum;
        hashCode(en1) as & Pure


    /// 
    pub def getDisplayName(x: ThaiBuddhistEra, style: TextStyle, locale: Locale): String = 
        import java.time.chrono.ThaiBuddhistEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1) as & Pure
        
    pub def range(x: ThaiBuddhistEra, field: ChronoField): ValueRange = 
        import java.time.chrono.Era.range(##java.time.temporal.TemporalField);
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
        ValueRange(range(x1, field1) as & Pure)

}
