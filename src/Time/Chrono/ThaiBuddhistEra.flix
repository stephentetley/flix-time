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


    pub enum ThaiBuddhistEra with Eq, Order, ToString, Hash {
        case BEFORE_BE
        case BE
    }   
 

}

mod Time.Chrono.ThaiBuddhistEra {

    use Locale.{Locale}

    use Time.Chrono.ThaiBuddhistEra
    use Time.Chrono.ThaiBuddhistEra.{BEFORE_BE, BE}
    use Time.Format.TextStyle
    use Time.Temporal.ChronoField
    use Time.Temporal.ChronoField.{Era}
    use Time.Temporal.ValueRange
    use Time.Temporal.ValueRange.{ValueRange}

    import java.time.chrono.{ThaiBuddhistEra => JThaiBuddhistEra}
    import java.lang.{Enum => JEnum}

    pub def marshalThaiBuddhistEra(x: ThaiBuddhistEra): JThaiBuddhistEra = 
        match x {
            case BEFORE_BE  => unsafe JThaiBuddhistEra.BEFORE_BE
            case BE         => unsafe JThaiBuddhistEra.BE
        }

    def primEquals(x: JThaiBuddhistEra, y: JThaiBuddhistEra): Bool =
        unsafe x.equals(y)

    pub def unmarshalThaiBuddhistEra(x: JThaiBuddhistEra): ThaiBuddhistEra =
        match x {
            case x1 if primEquals(x1, unsafe JThaiBuddhistEra.BEFORE_BE)  => BEFORE_BE
            case x1 if primEquals(x1, unsafe JThaiBuddhistEra.BE)         => BE
            case _                                      => bug!("unmarshalThaiBuddhistEra")
        }

    pub def getValue(x: ThaiBuddhistEra): Int32 = 
        let x1 = marshalThaiBuddhistEra(x);
        unsafe x1.getValue()



    //
    pub def getDisplayName(style: TextStyle, locale: Locale, x: ThaiBuddhistEra): String = 
        let x1 = marshalThaiBuddhistEra(x);
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe x1.getDisplayName(style1, locale1)
        
    // Note only ERA is a valid field, suggests we should provide `rangeEra` instead...
    pub def rangeEra(x: ThaiBuddhistEra): ValueRange = 
        let x1 = marshalThaiBuddhistEra(x);
        let cf1 = Time.Temporal.ChronoField.marshalChronoField(Time.Temporal.ChronoField.Era);
        let ans = unsafe x1.range(cf1);
        ValueRange(ans)
        


}
