/*
 * Copyright 2022 Stephen Tetley
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


pub mod InteropTime.Format.SignStyle {

    import java.time.format.{SignStyle => JSignStyle}
    import java.lang.{Enum => JEnum}

    pub enum SignStyle with Eq, Order, ToString, Hash {
        case Always
        case ExceedsPad
        case Never
        case Normal
        case NonNegative
    }

    pub def marshalSignStyle(x: SignStyle): JSignStyle =
        match x {
            case SignStyle.Always       => unsafe IO { JSignStyle.ALWAYS }
            case SignStyle.ExceedsPad   => unsafe IO { JSignStyle.EXCEEDS_PAD }
            case SignStyle.Never        => unsafe IO { JSignStyle.NEVER }
            case SignStyle.Normal       => unsafe IO { JSignStyle.NORMAL }
            case SignStyle.NonNegative  => unsafe IO { JSignStyle.NOT_NEGATIVE }
        }

    def primEquals(x: JSignStyle, y: JSignStyle): Bool =
        unsafe IO { x.equals(y) }

    pub def unmarshalSignStyle(x: JSignStyle): SignStyle =
        match x {
            case x1 if primEquals(x1, unsafe IO { JSignStyle.ALWAYS })         => SignStyle.Always
            case x1 if primEquals(x1, unsafe IO { JSignStyle.EXCEEDS_PAD })    => SignStyle.ExceedsPad
            case x1 if primEquals(x1, unsafe IO { JSignStyle.NEVER })          => SignStyle.Never
            case x1 if primEquals(x1, unsafe IO { JSignStyle.NORMAL })         => SignStyle.Normal
            case x1 if primEquals(x1, unsafe IO { JSignStyle.NOT_NEGATIVE })   => SignStyle.NonNegative
            case _                                                      => bug!("unmarshalSignStyle")
        }

}
