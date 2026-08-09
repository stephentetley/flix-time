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


pub mod InteropTime.Chrono.ThaiBuddhistEra {


    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.Temporal.ChronoField.ChronoField
    use InteropTime.Temporal.ValueRange.ValueRange
    use InteropTime.Temporal.ValueRange.ValueRange.{ValueRange }

    use InteropLocale.Locale.Locale

    import java.time.chrono.{ThaiBuddhistEra => JThaiBuddhistEra }
    import java.lang.{Enum => JEnum }


    pub enum ThaiBuddhistEra with Eq, Order, ToString, Hash {
        case BEFORE_BE
        case BE
    }

    instance ToJava[ThaiBuddhistEra] {
        type Out = JThaiBuddhistEra
        pub def toJava(x: ThaiBuddhistEra): JThaiBuddhistEra = match x {
            case ThaiBuddhistEra.BEFORE_BE  => unsafe IO { JThaiBuddhistEra.BEFORE_BE }
            case ThaiBuddhistEra.BE         => unsafe IO { JThaiBuddhistEra.BE }
        }
    }

    instance ToFlix[ThaiBuddhistEra] {
        type In = JThaiBuddhistEra
        pub def toFlix(x: JThaiBuddhistEra): ThaiBuddhistEra = unsafe IO {
            if (x.equals(JThaiBuddhistEra.BEFORE_BE))   ThaiBuddhistEra.BEFORE_BE
            else if (x.equals(JThaiBuddhistEra.BE))     ThaiBuddhistEra.BE
            else bug!("toFlix[ThaiBuddhistEra]")
        }
    }

    pub def getValue(x: ThaiBuddhistEra): Int32 = 
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getValue() })



    //
    pub def getDisplayName(style: TextStyle, locale: Locale, x: ThaiBuddhistEra): String = 
        AdaptorExtras.extract3(style, locale, x, (style1, locale1, x1) -> unsafe IO { x1.getDisplayName(style1, locale1) })
        
    // Note only ERA is a valid field, suggests we should provide `rangeEra` instead...
    pub def rangeEra(x: ThaiBuddhistEra): ValueRange = 
        AdaptorExtras.op2(x, ChronoField.Era, (x1, cf1) -> unsafe IO { x1.range(cf1) })


}
