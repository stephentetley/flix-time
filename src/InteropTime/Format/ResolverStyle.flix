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


pub mod InteropTime.Format.ResolverStyle {

    import java.time.format.{ResolverStyle => JResolverStyle}
    import java.lang.{Enum => JEnum}


    pub enum ResolverStyle with Eq, Order, ToString, Hash {
        case Lenient
        case Smart
        case Strict
    }

    pub def marshalResolverStyle(x: ResolverStyle): JResolverStyle=
        match x {
            case ResolverStyle.Lenient  => unsafe IO { JResolverStyle.LENIENT }
            case ResolverStyle.Smart    => unsafe IO { JResolverStyle.SMART }
            case ResolverStyle.Strict   => unsafe IO { JResolverStyle.STRICT }
        }

    def primEquals(x: JResolverStyle, y: JResolverStyle): Bool =
        unsafe IO { x.equals(y) }

    pub def unmarshalResolverStyle(x: JResolverStyle): ResolverStyle =
        match x {
            case x1 if primEquals(x1, unsafe IO { JResolverStyle.LENIENT })    => ResolverStyle.Lenient
            case x1 if primEquals(x1, unsafe IO { JResolverStyle.SMART })      => ResolverStyle.Smart
            case x1 if primEquals(x1, unsafe IO { JResolverStyle.STRICT })     => ResolverStyle.Strict
            case _                                                      => bug!("unmarshalResolverStyle")
        }

}
