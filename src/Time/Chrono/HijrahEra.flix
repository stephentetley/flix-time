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

mod Time.Chrono {


    ///
    /// Enum / Java Enum
    ///
    pub enum HijrahEra with Eq, Order, ToString, Hash {
        case AH
    }   

}

mod Time.Chrono.HijrahEra {
    
    use Locale.{Locale}

    use Time.Chrono.HijrahEra
    use Time.Chrono.HijrahEra.{AH}
    use Time.Chrono.Era
    use Time.Chrono.Era.{Era}
    use Time.Format.TextStyle

    import java.time.chrono.{HijrahEra => JHijrahEra}
    import java.time.chrono.{Era => JEra}
    import java.lang.{Enum => JEnum}


    // pub def fromJavaObject(o: ##java.lang.Object): HijrahEra = 
    //     unmarshalHijrahEra(unchecked_cast(o as ##java.time.chrono.HijrahEra))


    pub def marshalHijrahEra(x: HijrahEra): JHijrahEra = 
        match x {
            case AH         => unsafe JHijrahEra.AH
        }



    def primEquals(x: JHijrahEra, y: JHijrahEra): Bool =
        let x1 = (checked_cast(x) : JEnum);
        let y1 = (checked_cast(y) : JEnum);
        unsafe x1.equals(y1)

    pub def unmarshalHijrahEra(x: JHijrahEra): HijrahEra = 
        match x {
            case x1 if primEquals(x1, unsafe JHijrahEra.AH)      => AH
            case _                                  => bug!("unmarshalHijrahEra")
        }

    pub def getValue(x: HijrahEra): Int32 = 
        let x1 = marshalHijrahEra(x);
        unsafe x1.getValue()



    /// 


    pub def asEra(x: HijrahEra): Era = 
        let x1 = marshalHijrahEra(x);
        let ans = (checked_cast(x1) : JEra);
        Era(ans)


    pub def getDisplayName(style: TextStyle, locale: Locale, x: HijrahEra): String = 
        let x1 = marshalHijrahEra(x);
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe x1.getDisplayName(style1, locale1)
        
 
}
