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


pub mod InteropTime.Chrono.IsoEra {
    
    
    use JavaInterop.AdaptorExtras
    
    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.LocalDate.LocalDate
    
    use InteropLocale.Locale.Locale

    import java.time.chrono.{IsoEra => JIsoEra}
    import java.time.chrono.{Era => JEra}
    import java.lang.{Enum => JEnum}


    pub enum IsoEra with Eq, Order, ToString {
        case BCE
        case CE
    }

    instance Hash[IsoEra] {
        pub def hash(x: IsoEra): Int32 = match x {
            case IsoEra.BCE => unsafe IO { let x1 = JIsoEra.BCE; x1.hashCode() }
            case IsoEra.CE  => unsafe IO { let x1 = JIsoEra.CE; x1.hashCode() }
        }
    }

    instance ToJava[IsoEra] {
        type Out = JIsoEra
        pub def toJava(x: IsoEra): JIsoEra = match x {
            case IsoEra.BCE => unsafe IO { JIsoEra.BCE }
            case IsoEra.CE  => unsafe IO { JIsoEra.CE }
        }
    }

    instance ToFlix[IsoEra] {
        type In = JIsoEra
        pub def toFlix(x: JIsoEra): IsoEra = unsafe IO {
            if (x.equals(JIsoEra.BCE))          IsoEra.BCE
            else if (x.equals(JIsoEra.CE))      IsoEra.CE
            else bug!("toFlix[IsoEra]")
        }
    }

    pub def getValue(x: IsoEra): Int32 = 
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getValue() })



    /// Era interface functions


    pub def getDisplayName(style: TextStyle, locale: Locale, x: IsoEra): String =
        AdaptorExtras.extract3(style, locale, x, (style1, locale1, x1) -> 
            unsafe IO { x1.getDisplayName(style1, locale1) }
        )
        


}
