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

namespace Time/Format {


    pub enum FormatStyle {
        case Full
        case Long
        case Medium
        case Short
    }
    
    instance ToString[FormatStyle] {
        pub def toString(x: FormatStyle): String = match x {
            case Time/Format/FormatStyle.Full => "Full"
            case Time/Format/FormatStyle.Long => "Long"
            case Time/Format/FormatStyle.Medium => "Medium"
            case Time/Format/FormatStyle.Short => "Short"
        }
    }

}

namespace Time/Format/FormatStyle {

    use Time/Format.FormatStyle;
    use Time/Format.FormatStyle.{Full, Long, Medium, Short};

    pub def toNative(x: FormatStyle): ##java.time.format.FormatStyle = 
        import static get java.time.format.FormatStyle.FULL            as getFULL;
        import static get java.time.format.FormatStyle.LONG            as getLONG;
        import static get java.time.format.FormatStyle.MEDIUM          as getMEDIUM;
        import static get java.time.format.FormatStyle.SHORT           as getSHORT;
        match x {
            case Full               => getFULL()
            case Long               => getLONG()
            case Medium             => getMEDIUM()
            case Short              => getSHORT()
        } as & Pure

    def primEquals(x: ##java.time.format.FormatStyle, y: ##java.time.format.FormatStyle): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def fromNative(x: ##java.time.format.FormatStyle): FormatStyle = 
        import static get java.time.format.FormatStyle.FULL            as getFULL;
        import static get java.time.format.FormatStyle.LONG            as getLONG;
        import static get java.time.format.FormatStyle.MEDIUM          as getMEDIUM;
        import static get java.time.format.FormatStyle.SHORT           as getSHORT;
        match x {
            case x1 if primEquals(x1, getFULL())                => Full
            case x1 if primEquals(x1, getLONG())                => Long
            case x1 if primEquals(x1, getMEDIUM())              => Medium
            case x1 if primEquals(x1, getSHORT())               => Short
        } as & Pure


}