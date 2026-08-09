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


pub mod InteropTime.Chrono.MinguoEra {
    
    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TextStyle.TextStyle

    use InteropLocale.Locale.Locale

    import java.time.chrono.{MinguoEra => JMinguoEra }
    import java.lang.{Enum => JEnum }



    pub enum MinguoEra with Eq, Order, ToString {
        case BEFORE_ROC
        case ROC
    }

    instance Hash[MinguoEra] {
        pub def hash(x: MinguoEra): Int32 = match x {
            case MinguoEra.BEFORE_ROC => unsafe IO { let x1 = JMinguoEra.BEFORE_ROC; x1.hashCode() }
            case MinguoEra.ROC        => unsafe IO { let x1 = JMinguoEra.ROC; x1.hashCode() }
        }
    }

    instance ToJava[MinguoEra] {
        type Out = JMinguoEra
        pub def toJava(x: MinguoEra): JMinguoEra = match x {
            case MinguoEra.BEFORE_ROC => unsafe IO { JMinguoEra.BEFORE_ROC }
            case MinguoEra.ROC        => unsafe IO { JMinguoEra.ROC }
        }
    }

    instance ToFlix[MinguoEra] {
        type In = JMinguoEra
        pub def toFlix(x: JMinguoEra): MinguoEra = unsafe IO {
            if (x.equals(JMinguoEra.BEFORE_ROC))    MinguoEra.BEFORE_ROC
            else if (x.equals(JMinguoEra.ROC))      MinguoEra.ROC
            else bug!("toFlix[MinguoEra]")
        }
    }


    pub def getValue(x: MinguoEra): Int32 = 
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getValue() })



    pub def getDisplayName(style: TextStyle, locale: Locale, x: MinguoEra): String = 
        AdaptorExtras.extract3(style, locale, x, (style1, locale1, x1) ->
            unsafe IO { x1.getDisplayName(style1, locale1) }
        )

}

