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

mod Time.Format {

    pub enum TextStyle with Eq, Order, ToString, Hash {
        case Full
        case FullStandalone
        case Narrow
        case NarrowStandalone
        case Short
        case ShortStandalone
    }


}

mod Time.Format.TextStyle {

    use Time.Format.TextStyle;
    use Time.Format.TextStyle.{Full, FullStandalone, Narrow, NarrowStandalone,
            Short, ShortStandalone};

    import java.time.format.{TextStyle => JTextStyle}
    import java.lang.{Enum => JEnum}


    pub def marshalTextStyle(x: TextStyle): JTextStyle =
        match x {
            case Full               => unsafe IO { JTextStyle.FULL }
            case FullStandalone     => unsafe IO { JTextStyle.FULL_STANDALONE }
            case Narrow             => unsafe IO { JTextStyle.NARROW }
            case NarrowStandalone   => unsafe IO { JTextStyle.NARROW_STANDALONE }
            case Short              => unsafe IO { JTextStyle.SHORT }
            case ShortStandalone    => unsafe IO { JTextStyle.SHORT_STANDALONE }
        }

    def primEquals(x: JTextStyle, y: JTextStyle): Bool =
        unsafe IO { x.equals(y) }

    pub def unmarshalTextStyle(x: JTextStyle): TextStyle =
        match x {
            case x1 if primEquals(x1, unsafe IO { JTextStyle.FULL })               => Full
            case x1 if primEquals(x1, unsafe IO { JTextStyle.FULL_STANDALONE })    => FullStandalone
            case x1 if primEquals(x1, unsafe IO { JTextStyle.NARROW })             => Narrow
            case x1 if primEquals(x1, unsafe IO { JTextStyle.NARROW_STANDALONE })  => NarrowStandalone
            case x1 if primEquals(x1, unsafe IO { JTextStyle.SHORT })              => Short
            case x1 if primEquals(x1, unsafe IO { JTextStyle.SHORT_STANDALONE })   => ShortStandalone
            case _                                                          => bug!("unmarshalTextStyle")
        }

    
    /// predicates / comparisons

    pub def isStandalone(x: TextStyle): Bool =
        let x1 = marshalTextStyle(x);
        unsafe IO { x1.isStandalone() }

    /// Getters and Setters
    
    pub def asStandalone(x: TextStyle): TextStyle =
        let x1 = marshalTextStyle(x);
        let ans = unsafe IO { x1.asStandalone() };
        unmarshalTextStyle(ans)

    pub def asNormal(x: TextStyle): TextStyle =
        let x1 = marshalTextStyle(x);
        let ans = unsafe IO { x1.asNormal() };
        unmarshalTextStyle(ans)

}
