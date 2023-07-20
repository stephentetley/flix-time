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

    instance Interop.Flix.Marshal[ResolverStyle] {
        pub def toJavaObject(x: ResolverStyle): ##java.lang.Object =
            let x1 = Time.Format.ResolverStyle.marshalResolverStyle(x);
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): ResolverStyle = 
            let x1 = unchecked_cast(o as ##java.time.format.ResolverStyle);
            Time.Format.ResolverStyle.unmarshalResolverStyle(x1)
    }

}

mod Time.Format.ResolverStyle {

    use Time.Format.ResolverStyle;
    use Time.Format.ResolverStyle.{Lenient, Smart, Strict};
    


    pub def marshalResolverStyle(x: ResolverStyle): ##java.time.format.ResolverStyle = 
        import static get java.time.format.ResolverStyle.LENIENT: ##java.time.format.ResolverStyle \ {} as getLENIENT;
        import static get java.time.format.ResolverStyle.SMART: ##java.time.format.ResolverStyle \ {} as getSMART;
        import static get java.time.format.ResolverStyle.STRICT: ##java.time.format.ResolverStyle \ {} as getSTRICT;
        match x {
            case Lenient            => getLENIENT()
            case Smart              => getSMART()
            case Strict             => getSTRICT()
        }

    def primEquals(x: ##java.time.format.ResolverStyle, y: ##java.time.format.ResolverStyle): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)

    pub def unmarshalResolverStyle(x: ##java.time.format.ResolverStyle): ResolverStyle = 
        import static get java.time.format.ResolverStyle.LENIENT: ##java.time.format.ResolverStyle \ {} as getLENIENT;
        import static get java.time.format.ResolverStyle.SMART: ##java.time.format.ResolverStyle \ {} as getSMART;
        import static get java.time.format.ResolverStyle.STRICT: ##java.time.format.ResolverStyle \ {} as getSTRICT;
        match x {
            case x1 if primEquals(x1, getLENIENT())         => Lenient
            case x1 if primEquals(x1, getSMART())           => Smart
            case x1 if primEquals(x1, getSTRICT())          => Strict
            case _                                          => bug!("unmarshalResolverStyle")
        }

}
