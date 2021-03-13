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

    pub enum ResolverStyle {
        case Lenient,
        case Smart,
        case Strict
    }
    
    instance ToString[ResolverStyle] {
        pub def toString(x: ResolverStyle): String = match x {
            case Lenient => "Lenient"
            case Smart => "Smart"
            case Strict => "Strict"
        }
    }

}

namespace Time/Format/ResolverStyle {

    use Time/Format.ResolverStyle;
    use Time/Format.ResolverStyle.{Lenient, Smart, Strict};
    


    pub def marshal(x: ResolverStyle): ##java.time.format.ResolverStyle = 
        import get java.time.format.ResolverStyle:LENIENT       as getLENIENT;
        import get java.time.format.ResolverStyle:SMART         as getSMART;
        import get java.time.format.ResolverStyle:STRICT        as getSTRICT;
        match x {
            case Lenient            => getLENIENT()
            case Smart              => getSMART()
            case Strict             => getSTRICT()
        } as & Pure

    def primEquals(x: ##java.time.format.ResolverStyle, y: ##java.time.format.ResolverStyle): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def unmarshal(x: ##java.time.format.ResolverStyle): ResolverStyle = 
        import get java.time.format.ResolverStyle:LENIENT       as getLENIENT;
        import get java.time.format.ResolverStyle:SMART         as getSMART;
        import get java.time.format.ResolverStyle:STRICT        as getSTRICT;
        match x {
            case x1 if primEquals(x1, getLENIENT())             => Lenient
            case x1 if primEquals(x1, getSMART())               => Smart
            case x1 if primEquals(x1, getSTRICT())              => Strict            
        } as & Pure


}