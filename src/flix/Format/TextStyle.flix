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

    pub enum TextStyle {
        case Full
        case FullStandalone
        case Narrow
        case NarrowStandalone
        case Short
        case ShortStandalone
    }
    
    instance ToString[TextStyle] {
        pub def toString(x: TextStyle): String = match x {
            case Full => "Full"
            case FullStandalone => "FullStandalone"
            case Narrow => "Narrow"
            case NarrowStandalone => "NarrowStandalone"
            case Short => "Short"
            case ShortStandalone => "ShortStandalone"
        }
    }

}

namespace Time/Format/TextStyle {

    use Time/Format.TextStyle;
    use Time/Format.TextStyle.{Full, FullStandalone, Narrow, NarrowStandalone,
            Short, ShortStandalone};
    use Time.Error.{IllegalArgumentException};


    pub def toNative(x: TextStyle): ##java.time.format.TextStyle = 
        import get java.time.format.TextStyle:FULL              as getFULL;
        import get java.time.format.TextStyle:FULL_STANDALONE   as getFULL_STANDALONE;
        import get java.time.format.TextStyle:NARROW            as getNARROW;
        import get java.time.format.TextStyle:NARROW_STANDALONE as getNARROW_STANDALONE;	
        import get java.time.format.TextStyle:SHORT             as getSHORT;
        import get java.time.format.TextStyle:SHORT_STANDALONE  as getSHORT_STANDALONE;
        match x {
            case Full               => getFULL()
            case FullStandalone     => getFULL_STANDALONE()
            case Narrow             => getNARROW()
            case NarrowStandalone   => getNARROW_STANDALONE()
            case Short              => getSHORT()
            case ShortStandalone    => getSHORT_STANDALONE() 
        } as & Pure

    def primEquals(x: ##java.time.format.TextStyle, y: ##java.time.format.TextStyle): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def fromNative(x: ##java.time.format.TextStyle): TextStyle = 
        import get java.time.format.TextStyle:FULL              as getFULL;
        import get java.time.format.TextStyle:FULL_STANDALONE   as getFULL_STANDALONE;
        import get java.time.format.TextStyle:NARROW            as getNARROW;
        import get java.time.format.TextStyle:NARROW_STANDALONE as getNARROW_STANDALONE;	
        import get java.time.format.TextStyle:SHORT             as getSHORT;
        import get java.time.format.TextStyle:SHORT_STANDALONE  as getSHORT_STANDALONE;
        match x {
            case x1 if primEquals(x1, getFULL())                => Full
            case x1 if primEquals(x1, getFULL_STANDALONE())     => FullStandalone
            case x1 if primEquals(x1, getNARROW())              => Narrow
            case x1 if primEquals(x1, getNARROW_STANDALONE())   => NarrowStandalone
            case x1 if primEquals(x1, getSHORT())               => Short
            case x1 if primEquals(x1, getSHORT_STANDALONE())    => ShortStandalone
        } as & Pure

    
    pub def asStandalone(x: TextStyle): TextStyle =
        import java.time.format.TextStyle.asStandalone();
        let x1 = toNative(x);
        fromNative(asStandalone(x1)) as & Pure
    
    pub def asNormal(x: TextStyle): TextStyle =
        import java.time.format.TextStyle.asNormal();
        let x1 = toNative(x);
        fromNative(asNormal(x1)) as & Pure

    pub def isStandalone(x: TextStyle): Bool =
        import java.time.format.TextStyle.isStandalone();
        let x1 = toNative(x);
        isStandalone(x1) as & Pure

}
