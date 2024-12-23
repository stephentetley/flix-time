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


    pub enum MinguoEra with Eq, Order, ToString, Hash {
        case BEFORE_ROC
        case ROC
    }   
  

}

mod Time.Chrono.MinguoEra {
    
    use Locale.{Locale}

    use Time.Chrono.MinguoEra
    use Time.Chrono.MinguoEra.{BEFORE_ROC, ROC}
    use Time.Format.TextStyle

    import java.time.chrono.{MinguoEra => JMinguoEra}
    import java.lang.{Enum => JEnum}

    pub def marshalMinguoEra(x: MinguoEra): JMinguoEra = 
        match x {
            case BEFORE_ROC => unsafe JMinguoEra.BEFORE_ROC
            case ROC        => unsafe JMinguoEra.ROC
        }

    def primEquals(x: JMinguoEra, y: JMinguoEra): Bool =
        unsafe x.equals(y)

    pub def unmarshalMinguoEra(x: JMinguoEra): MinguoEra =
        match x {
            case x1 if primEquals(x1, unsafe JMinguoEra.BEFORE_ROC)  => BEFORE_ROC
            case x1 if primEquals(x1, unsafe JMinguoEra.ROC)         => ROC
            case _                                      => bug!("unmarshalMinguoEra")
        }

    pub def getValue(x: MinguoEra): Int32 = 
        let x1 = marshalMinguoEra(x);
        unsafe x1.getValue()



    pub def getDisplayName(style: TextStyle, locale: Locale, x: MinguoEra): String = 
        let x1 = marshalMinguoEra(x);
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe x1.getDisplayName(style1, locale1)



}
