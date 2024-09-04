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

    pub enum ResolverStyle with Eq, Order, ToString, Hash {
        case Lenient
        case Smart
        case Strict
    }

}

mod Time.Format.ResolverStyle {

    use Time.Format.ResolverStyle;
    use Time.Format.ResolverStyle.{Lenient, Smart, Strict};

    import java.time.format.{ResolverStyle => JResolverStyle}
    import java.lang.{Enum => JEnum}


    pub def marshalResolverStyle(x: ResolverStyle): JResolverStyle= 
        match x {
            case Lenient            => unsafe JResolverStyle.LENIENT
            case Smart              => unsafe JResolverStyle.SMART
            case Strict             => unsafe JResolverStyle.STRICT
        }

    def primEquals(x: JResolverStyle, y: JResolverStyle): Bool =
        let x1 = (checked_cast(x) : JEnum);
        let y1 = (checked_cast(y) : JEnum);
        unsafe x1.equals(y1)

    pub def unmarshalResolverStyle(x: JResolverStyle): ResolverStyle = 
        match x {
            case x1 if primEquals(x1, unsafe JResolverStyle.LENIENT)    => Lenient
            case x1 if primEquals(x1, unsafe JResolverStyle.SMART)      => Smart
            case x1 if primEquals(x1, unsafe JResolverStyle.STRICT)     => Strict
            case _                                                      => bug!("unmarshalResolverStyle")
        }

}
