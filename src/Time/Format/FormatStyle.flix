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

    pub def marshalFormatStyle(x: FormatStyle): ##java.time.format.FormatStyle = 
        import static java_get_field java.time.format.FormatStyle.FULL: ##java.time.format.FormatStyle \ {} as get_FULL;
        import static java_get_field java.time.format.FormatStyle.LONG: ##java.time.format.FormatStyle \ {} as get_LONG;
        import static java_get_field java.time.format.FormatStyle.MEDIUM: ##java.time.format.FormatStyle \ {} as get_MEDIUM;
        import static java_get_field java.time.format.FormatStyle.SHORT: ##java.time.format.FormatStyle \ {} as get_SHORT;
        match x {
            case Full               => get_FULL()
            case Long               => get_LONG()
            case Medium             => get_MEDIUM()
            case Short              => get_SHORT()
        }

    def primEquals(x: ##java.time.format.FormatStyle, y: ##java.time.format.FormatStyle): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)

    pub def unmarshalFormatStyle(x: ##java.time.format.FormatStyle): FormatStyle = 
        import static java_get_field java.time.format.FormatStyle.FULL: ##java.time.format.FormatStyle \ {} as get_FULL;
        import static java_get_field java.time.format.FormatStyle.LONG: ##java.time.format.FormatStyle \ {} as get_LONG;
        import static java_get_field java.time.format.FormatStyle.MEDIUM: ##java.time.format.FormatStyle \ {} as get_MEDIUM;
        import static java_get_field java.time.format.FormatStyle.SHORT: ##java.time.format.FormatStyle \ {} as get_SHORT;
        match x {
            case x1 if primEquals(x1, get_FULL())   => Full
            case x1 if primEquals(x1, get_LONG())   => Long
            case x1 if primEquals(x1, get_MEDIUM()) => Medium
            case x1 if primEquals(x1, get_SHORT())  => Short
            case _                                  => bug!("unmarshalFormatStyle")
        }
}
