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


pub mod InteropTime.Format.TextStyle {

    use JavaInterop.AdaptorExtras

    import java.time.format.{TextStyle => JTextStyle}

    pub enum TextStyle with Eq, Order, ToString, Hash {
        case Full
        case FullStandalone
        case Narrow
        case NarrowStandalone
        case Short
        case ShortStandalone
    }



    instance ToJava[TextStyle] {
        type Out = JTextStyle
        pub def toJava(x: TextStyle): JTextStyle = match x {
            case TextStyle.Full             => unsafe IO { JTextStyle.FULL }
            case TextStyle.FullStandalone   => unsafe IO { JTextStyle.FULL_STANDALONE }
            case TextStyle.Narrow           => unsafe IO { JTextStyle.NARROW }
            case TextStyle.NarrowStandalone => unsafe IO { JTextStyle.NARROW_STANDALONE }
            case TextStyle.Short            => unsafe IO { JTextStyle.SHORT }
            case TextStyle.ShortStandalone  => unsafe IO { JTextStyle.SHORT_STANDALONE }
        }
    }


    instance ToFlix[TextStyle] {
        type In = JTextStyle
        pub def toFlix(x: JTextStyle): TextStyle = unsafe IO {
            if (x.equals(JTextStyle.FULL))                      TextStyle.Full
            else if (x.equals(JTextStyle.FULL_STANDALONE))      TextStyle.FullStandalone
            else if (x.equals(JTextStyle.NARROW))               TextStyle.Narrow
            else if (x.equals(JTextStyle.NARROW_STANDALONE))    TextStyle.NarrowStandalone
            else if (x.equals(JTextStyle.SHORT))                TextStyle.Short
            else if (x.equals(JTextStyle.SHORT_STANDALONE))     TextStyle.ShortStandalone
            else bug!("toFlix[TextStyle]")
        }
    }

    
    /// predicates / comparisons

    pub def isStandalone(x: TextStyle): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isStandalone() })

    // /// Getters and Setters
    
    pub def asStandalone(x: TextStyle): TextStyle =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.asStandalone() })

    pub def asNormal(x: TextStyle): TextStyle =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.asNormal() })

    
}


