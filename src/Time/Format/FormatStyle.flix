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


    pub enum FormatStyle with Eq, Order, ToString, Hash {
        case Full
        case Long
        case Medium
        case Short
    }

}

mod Time.Format.FormatStyle {

    use Time.Format.FormatStyle
    use Time.Format.FormatStyle.{Full, Long, Medium, Short}
    import java.time.format.{FormatStyle => JFormatStyle}

    pub def marshalFormatStyle(x: FormatStyle): JFormatStyle = 
        match x {
            case Full               => unsafe JFormatStyle.FULL
            case Long               => unsafe JFormatStyle.LONG
            case Medium             => unsafe JFormatStyle.MEDIUM
            case Short              => unsafe JFormatStyle.SHORT
        }

    def primEquals(x: JFormatStyle, y: JFormatStyle): Bool =
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        unsafe x1.equals(y)

    pub def unmarshalFormatStyle(x: JFormatStyle): FormatStyle = 
        match x {
            case x1 if primEquals(x1, unsafe JFormatStyle.FULL)     => Full
            case x1 if primEquals(x1, unsafe JFormatStyle.LONG)     => Long
            case x1 if primEquals(x1, unsafe JFormatStyle.MEDIUM)   => Medium
            case x1 if primEquals(x1, unsafe JFormatStyle.SHORT)    => Short
            case _                                                  => bug!("unmarshalFormatStyle")
        }
}
