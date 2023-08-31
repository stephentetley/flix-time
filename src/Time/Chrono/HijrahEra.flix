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

    use Time.Chrono.Era
    use Time.Chrono.Era.{Era}

    ///
    /// Enum / Java Enum
    ///
    pub enum HijrahEra with Eq, Order, ToString, Hash {
        case AH
    }   
    
    instance Time.Chrono.ImplementsEra[HijrahEra] {
        pub def toEra(x: HijrahEra): Era = 
            let x1 = Time.Chrono.HijrahEra.marshalHijrahEra(x);
            Era(unchecked_cast(x1 as ##java.time.chrono.Era))

        pub def fromEra(x: Era): HijrahEra = 
            let Era(x1) = x;
            Time.Chrono.HijrahEra.unmarshalHijrahEra(unchecked_cast(x1 as ##java.time.chrono.HijrahEra))
    }


}

mod Time.Chrono.HijrahEra {
    
    use Locale.{Locale}

    use Time.Chrono.HijrahEra
    use Time.Chrono.HijrahEra.{AH}
    use Time.Format.TextStyle



    pub def fromJavaObject(o: ##java.lang.Object): HijrahEra = 
        unmarshalHijrahEra(unchecked_cast(o as ##java.time.chrono.HijrahEra))


    pub def marshalHijrahEra(x: HijrahEra): ##java.time.chrono.HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra \ {} as getAH;
        match x {
            case AH         => getAH()            
        }



    def primEquals(x: ##java.time.chrono.HijrahEra, y: ##java.time.chrono.HijrahEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)

    pub def unmarshalHijrahEra(x: ##java.time.chrono.HijrahEra): HijrahEra = 
        import static get java.time.chrono.HijrahEra.AH: ##java.time.chrono.HijrahEra \ {} as getAH;
        match x {
            case x1 if primEquals(x1, getAH())      => AH
            case _                                  => bug!("unmarshalHijrahEra")
        }

    pub def getValue(x: HijrahEra): Int32 = 
        import java.time.chrono.HijrahEra.getValue(): Int32 \ {};
        let x1 = marshalHijrahEra(x);
        getValue(x1)



    /// 


    pub def getDisplayName(style: TextStyle, locale: Locale, x: HijrahEra): String = 
        import java.time.chrono.HijrahEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let x1 = marshalHijrahEra(x);
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1)
        
 
}
