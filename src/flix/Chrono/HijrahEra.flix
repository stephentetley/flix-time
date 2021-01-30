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

namespace Time/Chrono {

    pub enum HijrahEra {
        case AH
    }   
 
}

namespace Time/Chrono/HijrahEra {

    use Time/Chrono.HijrahEra;
    use Time/Chrono.HijrahEra.{AH};

    pub def marshal(x: HijrahEra): ##java.time.chrono.HijrahEra = 
        import get java.time.chrono.HijrahEra:AH      as getAH;
        match x {
            case AH         => getAH()            
        } as & Pure

    def primEquals(x: ##java.time.chrono.HijrahEra, y: ##java.time.chrono.HijrahEra): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def unmarshal(x: ##java.time.chrono.HijrahEra): HijrahEra = 
        import get java.time.chrono.HijrahEra:AH      as getAH;
        match x {
            case x1 if primEquals(x1, getAH())     => AH
        } as & Pure

}
