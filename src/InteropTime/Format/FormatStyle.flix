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


pub mod InteropTime.Format.FormatStyle {


    import java.time.format.{FormatStyle => JFormatStyle}
    import java.lang.{Enum => JEnum}


    pub enum FormatStyle with Eq, Order, ToString, Hash {
        case Full
        case Long
        case Medium
        case Short
    }


    instance ToJava[FormatStyle] {
        type Out = JFormatStyle
        pub def toJava(x: FormatStyle): JFormatStyle = match x {
            case FormatStyle.Full   => unsafe IO { JFormatStyle.FULL }
            case FormatStyle.Long   => unsafe IO { JFormatStyle.LONG }
            case FormatStyle.Medium => unsafe IO { JFormatStyle.MEDIUM }
            case FormatStyle.Short  => unsafe IO { JFormatStyle.SHORT }
        }
    }

    instance ToFlix[FormatStyle] {
        type In = JFormatStyle
        pub def toFlix(x: JFormatStyle): FormatStyle = unsafe IO {
            if (x.equals(JFormatStyle.FULL))            FormatStyle.Full
            else if (x.equals(JFormatStyle.LONG))       FormatStyle.Long
            else if (x.equals(JFormatStyle.MEDIUM))     FormatStyle.Medium
            else if (x.equals(JFormatStyle.SHORT))      FormatStyle.Short
            else bug!("toFlix[FormatStyle]")
        }
    }

}
