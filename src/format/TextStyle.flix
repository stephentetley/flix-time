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

use Time/Format.TextStyle;
use Time/Format.TextStyle.{Full, FullStandalone, Narrow, NarrowStandalone, Short, ShortStandalone};
use Time.Error.{IllegalArgumentException};

namespace Time/Format {

    pub enum TextStyle {
        case Full,
        case FullStandalone,
        case Narrow,
        case NarrowStandalone,
        case Short,
        case ShortStandalone
    }

}

namespace Time/Format/TextStyle {

    pub def marshal(x: TextStyle): ##java.time.format.TextStyle = 
        import get java.time.format.TextStyle:FULL as javaFull;
        import get java.time.format.TextStyle:FULL_STANDALONE as javaFullStandalone;
        import get java.time.format.TextStyle:NARROW as javaNarrow;
        import get java.time.format.TextStyle:NARROW_STANDALONE as javaNarrowStandalone;	
        import get java.time.format.TextStyle:SHORT as javaShort;
        import get java.time.format.TextStyle:SHORT_STANDALONE as javaShortStandalone;
        match x {
            case Full               => javaFull()
            case FullStandalone     => javaFullStandalone()
            case Narrow             => javaNarrow()
            case NarrowStandalone   => javaNarrowStandalone()
            case Short              => javaShort()
            case ShortStandalone    => javaShortStandalone() 
        } as & Pure

    pub def asStandalone(x: TextStyle): TextStyle = match x {
        case Full               => FullStandalone
        case FullStandalone     => FullStandalone
        case Narrow             => NarrowStandalone
        case NarrowStandalone   => NarrowStandalone
        case Short              => ShortStandalone
        case ShortStandalone    => ShortStandalone
    }
    
    pub def asNormal(x: TextStyle): TextStyle = match x {
        case Full               => Full
        case FullStandalone     => Full
        case Narrow             => Narrow
        case NarrowStandalone   => Narrow
        case Short              => Short
        case ShortStandalone    => Short
    }

    pub def isStandalone(x: TextStyle): Bool = match x {
        case Full               => false
        case FullStandalone     => true
        case Narrow             => false
        case NarrowStandalone   => true
        case Short              => false
        case ShortStandalone    => true
    }

}