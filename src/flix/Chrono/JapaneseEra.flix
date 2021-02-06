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
    
    ///
    /// A wrapper around java.time.chrono.JapaneseEra.
    ///
    /// In Java, JapaneseEra is a class not an enum unlike HijrahEra
    ///
    pub opaque type JapaneseEra = ##java.time.chrono.JapaneseEra
    
    ///
    /// Returns the given JapaneseEra `x` as a String.
    ///
    instance ToString[JapaneseEra] {
        def toString(x: JapaneseEra): String =
            import java.time.chrono.JapaneseEra.toString();
            let JapaneseEra(x1) = x;
            toString(x1) as & Pure
    }
    
    instance Eq[JapaneseEra] {
        def eq(x: JapaneseEra, y: JapaneseEra): Bool = Time/Chrono/JapaneseEra.equals(x, y)

        def neq(x: JapaneseEra, y: JapaneseEra): Bool = not (x == y)
    }

    instance Hash[JapaneseEra] {
        def hash(x: JapaneseEra): Int = Time/Chrono/JapaneseEra.hashCode(x)
    } 
}

namespace Time/Chrono/JapaneseEra {


    use Time/Chrono.JapaneseEra;
    use Time/Chrono.JapaneseEra.{JapaneseEra};

    pub def new(japaneseEra: Int32): Option[JapaneseEra] =
        import java.time.chrono.JapaneseEra:of(Int32);
        try {
            Some(JapaneseEra(of(japaneseEra))) as & Pure
        } catch {
            case _: ##java.time.DateTimeException => None
        }

    pub def heisei(): JapaneseEra = 
        import get java.time.chrono.JapaneseEra:HEISEI as getHEISEI;
        JapaneseEra(getHEISEI()) as & Pure

    pub def meiji(): JapaneseEra = 
        import get java.time.chrono.JapaneseEra:MEIJI as getMEIJI;
        JapaneseEra(getMEIJI()) as & Pure

    /// Java 13
    /// pub def reiwa(): JapaneseEra = 
    ///     import get java.time.chrono.JapaneseEra:REIWA as getREIWA;
    ///     JapaneseEra(getREIWA()) as & Pure

    pub def showa(): JapaneseEra = 
        import get java.time.chrono.JapaneseEra:SHOWA as getSHOWA;
        JapaneseEra(getSHOWA()) as & Pure

    pub def taisho(): JapaneseEra = 
        import get java.time.chrono.JapaneseEra:TAISHO as getTAISHO;
        JapaneseEra(getTAISHO()) as & Pure

    pub def getValue(x: JapaneseEra): Int32 = 
        import java.time.chrono.JapaneseEra.getValue();
        let JapaneseEra(x1) = x;
        getValue(x1) as & Pure 

    pub def equals(x: JapaneseEra, y: JapaneseEra): Bool = 
        import java.lang.Object.equals(##java.lang.Object);
        let JapaneseEra(x1) = x;
        let JapaneseEra(y1) = y;
        equals(x1 as ##java.lang.Object, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: JapaneseEra): Int32 = 
        import java.lang.Object.hashCode();
        let JapaneseEra(x1) = x;
        hashCode(x1 as ##java.lang.Object) as & Pure

}
