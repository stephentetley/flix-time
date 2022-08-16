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

    pub enum IsoEra with Eq, Order, ToString, Hash, Boxable {
        case BCE
        case CE
    }   
    

}

namespace Time/Chrono/IsoEra {

    use Basis/I18n.Locale;
    use Basis/I18n.Locale.{Locale};

    use Time/Chrono.IsoEra;
    use Time/Chrono.IsoEra.{BCE, CE};
    use Time/Format.TextStyle;
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


    pub def getDisplayName(style: TextStyle, locale: Locale, x: IsoEra): String = 
        import java.time.chrono.Era.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x) as ##java.time.chrono.Era;
        let style1 = Time/Format/TextStyle.marshal(style);
        let locale1 = Basis/I18n/Locale.getLocale(locale) |> Interop/Util/Locale.getHH;
        getDisplayName(x1, style1, locale1)
        


}
