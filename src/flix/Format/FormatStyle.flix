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


namespace Time/Format/FormatStyle {

    /// NOTE - this is inconsistent with other enums in the Time/Format namespace.
    /// Apparently the scope context of constructors is the declared namespace.
    /// The scope is not further refined by the enums name.
    /// This has implications for the design of the Time/Format namespace that we
    /// need to think about...
    pub enum FormatStyle {
        case Full
        case Long
        case Medium
        case Short
    }
    
    instance ToString[FormatStyle] {
        def toString(x: FormatStyle): String = match x {
            case Full => "Full"
            case Long => "Long"
            case Medium => "Medium"
            case Short => "Short"
        }
    }

    pub def marshal(x: FormatStyle): ##java.time.format.FormatStyle = 
        import get java.time.format.FormatStyle:FULL            as getFULL;
        import get java.time.format.FormatStyle:LONG            as getLONG;
        import get java.time.format.FormatStyle:MEDIUM          as getMEDIUM;
        import get java.time.format.FormatStyle:SHORT           as getSHORT;
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

    pub def unmarshal(x: ##java.time.format.FormatStyle): FormatStyle = 
        import get java.time.format.FormatStyle:FULL            as getFULL;
        import get java.time.format.FormatStyle:LONG            as getLONG;
        import get java.time.format.FormatStyle:MEDIUM          as getMEDIUM;
        import get java.time.format.FormatStyle:SHORT           as getSHORT;
        match x {
            case x1 if primEquals(x1, getFULL())                => Full
            case x1 if primEquals(x1, getLONG())                => Long
            case x1 if primEquals(x1, getMEDIUM())              => Medium
            case x1 if primEquals(x1, getSHORT())               => Short
        } as & Pure


}