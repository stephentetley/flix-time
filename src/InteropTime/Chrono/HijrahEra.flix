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


pub mod InteropTime.Chrono.HijrahEra {
    
    use InteropLocale.Locale.Locale
    
    use InteropTime.Internal.AdaptorExtras
    use InteropTime.Format.TextStyle.TextStyle

    

    import java.time.chrono.{HijrahEra => JHijrahEra}
    import java.time.chrono.{Era => JEra}
    import java.lang.{Enum => JEnum}


    ///
    /// Enum / Java Enum
    ///
    pub enum HijrahEra with Eq, Order, ToString {
        case AH
    }

    
    instance Hash[HijrahEra] {
        pub def hash(x: HijrahEra): Int32 = match x {
            case HijrahEra.AH   => unsafe IO { let x1 = JHijrahEra.AH; x1.hashCode() }
        }
    }


    instance ToJava[HijrahEra] {
        type Out = JHijrahEra
        pub def toJava(x: HijrahEra): JHijrahEra = match x {
            case HijrahEra.AH   => unsafe IO { JHijrahEra.AH }
        }
    }

    instance ToFlix[HijrahEra] {
        type In = JHijrahEra
        pub def toFlix(x: JHijrahEra): HijrahEra = unsafe IO {
            if (x.equals(JHijrahEra.AH))            HijrahEra.AH
            else bug!("toFlix[HijrahEra]")
        }
    }

    pub def getValue(x: HijrahEra): Int32 =
        let x1 = ToJava.toJava(x);
        unsafe IO { x1.getValue() }



    /// 


    // pub def asEra(x: HijrahEra): Era = 
    //     let x1 = ToJava.toJava(x);
    //     let ans = (checked_cast(x1) : JEra);
    //     Era(ans)


    pub def getDisplayName(style: TextStyle, locale: Locale, x: HijrahEra): String =
        AdaptorExtras.extract3(style, locale, x, (style1, locale1, x1) ->
            unsafe IO { x1.getDisplayName(style1, locale1) }
        )
        
 
}
