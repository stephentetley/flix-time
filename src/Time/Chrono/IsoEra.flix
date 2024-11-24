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

mod Time.Chrono {


    pub enum IsoEra with Eq, Order, ToString, Hash {
        case BCE
        case CE
    }   


}

mod Time.Chrono.IsoEra {
    
    use Locale.{Locale}

    use Time.Chrono.IsoEra
    use Time.Chrono.IsoEra.{BCE, CE}
    use Time.Format.TextStyle
    use Time.LocalDate
    use Time.LocalDate.{LocalDate}

    import java.time.chrono.{IsoEra => JIsoEra}
    import java.time.chrono.{Era => JEra}
    import java.lang.{Enum => JEnum}
    
    pub def marshalIsoEra(x: IsoEra): JIsoEra = 
        match x {
            case BCE        => unsafe JIsoEra.BCE
            case CE         => unsafe JIsoEra.CE
        }

    def primEquals(x: JIsoEra, y: JIsoEra): Bool =
        let x1 = (checked_cast(x) : JEnum);
        let y1 = (checked_cast(y) : JEnum);
        unsafe x1.equals(y1)

    pub def unmarshalIsoEra(x: JIsoEra): IsoEra = 
        match x {
            case x1 if primEquals(x1, unsafe JIsoEra.BCE)    => BCE
            case x1 if primEquals(x1, unsafe JIsoEra.CE)     => CE
            case _                                  => bug!("unmarshalIsoEra")
        }

    pub def getValue(x: IsoEra): Int32 = 
        let x1 = marshalIsoEra(x);
        unsafe x1.getValue()



    /// Era interface functions


    pub def getDisplayName(style: TextStyle, locale: Locale, x: IsoEra): String =
        let x1 = marshalIsoEra(x);
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe x1.getDisplayName(style1, locale1)
        


}
