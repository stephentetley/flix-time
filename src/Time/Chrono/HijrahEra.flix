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

    ///
    /// Enum / Java Enum
    ///
    pub enum HijrahEra with Eq, Order, ToString, Boxable, Hash {
        case AH
    }   
 
    instance Interop/Flix.Marshal[HijrahEra] {
        pub def toJavaObject(x: HijrahEra): ##java.lang.Object =
            let x1 = Time/Chrono/HijrahEra.marshal(x);
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): HijrahEra = 
            let x1 = unsafe_cast o as ##java.time.chrono.HijrahEra;
            Time/Chrono/HijrahEra.unmarshal(x1)
    }


}

namespace Time/Chrono/HijrahEra {

    use Interop/Util.Locale;

    use Time/Chrono.HijrahEra;
    use Time/Chrono.HijrahEra.{AH};
    use Time/Format.TextStyle;

    pub def marshal(x: HijrahEra): ##java.time.chrono.HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra \ {} as getAH;
        match x {
            case AH         => getAH()            
        }

    def primEquals(x: ##java.time.chrono.HijrahEra, y: ##java.time.chrono.HijrahEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unsafe_cast x as ##java.lang.Enum;
        let y1 = unsafe_cast y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.HijrahEra): HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra \ {} as getAH;
        match x {
            case x1 if primEquals(x1, getAH())     => AH
        }

    pub def getValue(x: HijrahEra): Int32 = 
        import java.time.chrono.HijrahEra.getValue(): Int32 \ {};
        let x1 = marshal(x);
        getValue(x1)



    /// 


    pub def getDisplayName(style: TextStyle, locale: Locale, x: HijrahEra): String = 
        import java.time.chrono.HijrahEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let locale1 = Interop/Util/Locale.getHH(locale);
        getDisplayName(x1, style1, locale1)
        
 
}
