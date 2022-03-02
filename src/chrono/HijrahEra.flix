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

    pub enum HijrahEra with Eq, Order, ToString {
        case AH
    }   

    instance Hash[HijrahEra] {
        pub def hash(x: HijrahEra): Int32 = Time/Chrono/HijrahEra.hashCode(x)
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

    pub def toNative(x: HijrahEra): ##java.time.chrono.HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra & Pure as getAH;
        match x {
            case AH         => getAH()            
        }

    def primEquals(x: ##java.time.chrono.HijrahEra, y: ##java.time.chrono.HijrahEra): Bool =
        import java.lang.Object.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def fromNative(x: ##java.time.chrono.HijrahEra): HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra & Pure as getAH;
        match x {
            case x1 if primEquals(x1, getAH())     => AH
        }

    pub def getValue(x: HijrahEra): Int32 = 
        import java.time.chrono.HijrahEra.getValue(): Int32 & Pure;
        let x1 = toNative(x);
        getValue(x1)


    pub def hashCode(x: HijrahEra): Int32 =
        import java.lang.Enum.hashCode(): Int32 & Pure;
        let en1 = toNative(x) as ##java.lang.Enum;
        hashCode(en1)


    /// 
    pub def getDisplayName(x: HijrahEra, style: TextStyle, locale: Locale): String = 
        import java.time.chrono.HijrahEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = toNative(x);
        let style1 = Time/Format/TextStyle.toNative(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1)
        
    pub def range(x: HijrahEra, field: ChronoField): ValueRange = 
        import java.time.chrono.HijrahEra.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;
        let x1 = toNative(x);
        let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
        ValueRange(range(x1, field1))

}
