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

    pub enum ThaiBuddhistEra with Eq, Order, ToString {
        case BEFORE_BE
        case BE
    }   


    instance Hash[ThaiBuddhistEra] {
        pub def hash(x: ThaiBuddhistEra): Int32 = Time/Chrono/ThaiBuddhistEra.hashCode(x)
    }    

}

namespace Time/Chrono/ThaiBuddhistEra {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Chrono.ThaiBuddhistEra;
    use Time/Chrono.ThaiBuddhistEra.{BEFORE_BE, BE};
    use Time/Format.TextStyle;
    use Time/Temporal.ChronoField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def marshal(x: ThaiBuddhistEra): ##java.time.chrono.ThaiBuddhistEra = 
        import static get java.time.chrono.ThaiBuddhistEra.BEFORE_BE: ##java.time.chrono.ThaiBuddhistEra & Pure as getBEFORE_BE;
        import static get java.time.chrono.ThaiBuddhistEra.BE: ##java.time.chrono.ThaiBuddhistEra & Pure as getBE;
        match x {
            case BEFORE_BE  => getBEFORE_BE()
            case BE         => getBE() 
        }

    def primEquals(x: ##java.time.chrono.ThaiBuddhistEra, y: ##java.time.chrono.ThaiBuddhistEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.ThaiBuddhistEra): ThaiBuddhistEra =
        import static get java.time.chrono.ThaiBuddhistEra.BEFORE_BE: ##java.time.chrono.ThaiBuddhistEra & Pure as getBEFORE_BE;
        import static get java.time.chrono.ThaiBuddhistEra.BE: ##java.time.chrono.ThaiBuddhistEra & Pure as getBE;
        match x {
            case x1 if primEquals(x1, getBEFORE_BE())  => BEFORE_BE
            case x1 if primEquals(x1, getBE())         => BE
        }

    pub def getValue(x: ThaiBuddhistEra): Int32 = 
        import java.time.chrono.ThaiBuddhistEra.getValue(): Int32 & Pure;
        let x1 = marshal(x);
        getValue(x1)


    pub def hashCode(x: ThaiBuddhistEra): Int32 =
        import java.lang.Enum.hashCode(): Int32 & Pure;
        let en1 = marshal(x) as ##java.lang.Enum;
        hashCode(en1)


    /// 
    pub def getDisplayName(x: ThaiBuddhistEra, style: TextStyle, locale: Locale): String = 
        import java.time.chrono.ThaiBuddhistEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1)
        
    /// pub def range(x: ThaiBuddhistEra, field: ChronoField): ValueRange = 
    ///     import java.time.chrono.Era.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;
    ///     let x1 = marshal(x) as ##java.time.chrono.Era;
    ///     let field1 = Time/Temporal/ChronoField.marshal(field) as ##java.time.temporal.TemporalField;
    ///     ValueRange(range(x1, field1))

}
