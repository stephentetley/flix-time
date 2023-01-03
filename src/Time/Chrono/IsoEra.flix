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

    use Time/Chrono.Era
    use Time/Chrono.Era.{Era}

    pub enum IsoEra with Eq, Order, ToString, Hash, Boxable {
        case BCE
        case CE
    }   

    instance Interop/Flix.Marshal[IsoEra] {
        pub def toJavaObject(x: IsoEra): ##java.lang.Object =
            let x1 = Time/Chrono/IsoEra.marshal(x);
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): IsoEra = 
            let x1 = unsafe_cast o as ##java.time.chrono.IsoEra;
            Time/Chrono/IsoEra.unmarshal(x1)
    }

    instance Time/Chrono.ImplementsEra[IsoEra] {
        pub def toEra(x: IsoEra): Era = 
            let x1 = Time/Chrono/IsoEra.marshal(x);
            Era(unsafe_cast x1 as ##java.time.chrono.Era)

        pub def fromEra(x: Era): IsoEra = 
            let Era(x1) = x;
            Time/Chrono/IsoEra.unmarshal(unsafe_cast x1 as ##java.time.chrono.IsoEra)

    }

}

namespace Time/Chrono/IsoEra {

    use Interop/Util.Locale;

    use Time/Chrono.IsoEra;
    use Time/Chrono.IsoEra.{BCE, CE};
    use Time/Format.TextStyle;  
    use Time.LocalDate;
    use Time.LocalDate.{LocalDate};

    pub def marshal(x: IsoEra): ##java.time.chrono.IsoEra = 
        import static get java.time.chrono.IsoEra.BCE: ##java.time.chrono.IsoEra \ {} as get_BCE;
        import static get java.time.chrono.IsoEra.CE: ##java.time.chrono.IsoEra \ {} as get_CE;
        match x {
            case BCE        => get_BCE()
            case CE         => get_CE()
        }

    def primEquals(x: ##java.time.chrono.IsoEra, y: ##java.time.chrono.IsoEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unsafe_cast x as ##java.lang.Enum;
        let y1 = unsafe_cast y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.IsoEra): IsoEra = 
        import static get java.time.chrono.IsoEra.BCE: ##java.time.chrono.IsoEra \ {} as get_BCE;
        import static get java.time.chrono.IsoEra.CE: ##java.time.chrono.IsoEra \ {} as get_CE;
        match x {
            case x1 if primEquals(x1, get_BCE())    => BCE
            case x1 if primEquals(x1, get_CE())     => CE
        }

    pub def getValue(x: IsoEra): Int32 = 
        import java.time.chrono.IsoEra.getValue(): Int32 \ {};
        let x1 = marshal(x);
        getValue(x1)


    /// Era interface functions


    pub def getDisplayName(style: TextStyle, locale: Locale, x: IsoEra): String = 
        import java.time.chrono.Era.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let x1 = unsafe_cast marshal(x) as ##java.time.chrono.Era;
        let style1 = Time/Format/TextStyle.marshal(style);
        let locale1 = Interop/Util/Locale.getHH(locale);
        getDisplayName(x1, style1, locale1)
        


}
