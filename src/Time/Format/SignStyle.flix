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

mod Time.Format {

    pub enum SignStyle with Eq, Order, ToString, Hash {
        case Always
        case ExceedsPad
        case Never
        case Normal
        case NonNegative
    }

}

mod Time.Format.SignStyle {

    use Time.Format.SignStyle;
    use Time.Format.SignStyle.{Always, ExceedsPad, Never, Normal, NonNegative};
    


    pub def marshalSignStyle(x: SignStyle): ##java.time.format.SignStyle = 
        import static java_get_field java.time.format.SignStyle.ALWAYS: ##java.time.format.SignStyle \ {} as get_ALWAYS;
        import static java_get_field java.time.format.SignStyle.EXCEEDS_PAD: ##java.time.format.SignStyle \ {} as get_EXCEEDS_PAD;
        import static java_get_field java.time.format.SignStyle.NEVER: ##java.time.format.SignStyle \ {} as get_NEVER;
        import static java_get_field java.time.format.SignStyle.NORMAL: ##java.time.format.SignStyle \ {} as get_NORMAL;
        import static java_get_field java.time.format.SignStyle.NOT_NEGATIVE: ##java.time.format.SignStyle \ {} as get_NOT_NEGATIVE;
        match x {
            case Always             => get_ALWAYS()
            case ExceedsPad         => get_EXCEEDS_PAD()
            case Never              => get_NEVER()
            case Normal             => get_NORMAL()
            case NonNegative        => get_NOT_NEGATIVE()
        }

    def primEquals(x: ##java.time.format.SignStyle, y: ##java.time.format.SignStyle): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)

    pub def unmarshalSignStyle(x: ##java.time.format.SignStyle): SignStyle = 
        import static java_get_field java.time.format.SignStyle.ALWAYS: ##java.time.format.SignStyle \ {} as get_ALWAYS;
        import static java_get_field java.time.format.SignStyle.EXCEEDS_PAD: ##java.time.format.SignStyle \ {} as get_EXCEEDS_PAD;
        import static java_get_field java.time.format.SignStyle.NEVER: ##java.time.format.SignStyle \ {} as get_NEVER;
        import static java_get_field java.time.format.SignStyle.NORMAL: ##java.time.format.SignStyle \ {} as get_NORMAL;
        import static java_get_field java.time.format.SignStyle.NOT_NEGATIVE: ##java.time.format.SignStyle \ {} as get_NOT_NEGATIVE;
        match x {
            case x1 if primEquals(x1, get_ALWAYS())             => Always
            case x1 if primEquals(x1, get_EXCEEDS_PAD())        => ExceedsPad
            case x1 if primEquals(x1, get_NEVER())              => Never
            case x1 if primEquals(x1, get_NORMAL())             => Normal
            case x1 if primEquals(x1, get_NOT_NEGATIVE())       => NonNegative
            case _                                              => bug!("unmarshalSignStyle")
        }

}
