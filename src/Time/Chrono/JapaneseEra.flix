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
        pub def toString(x: JapaneseEra): String =
            import java.time.chrono.JapaneseEra.toString(): String & Pure;
            let JapaneseEra(x1) = x;
            toString(x1) 
    }
    
    instance Eq[JapaneseEra] {
        pub def eq(x: JapaneseEra, y: JapaneseEra): Bool = Time/Chrono/JapaneseEra.equals(x, y)
    }

    instance Hash[JapaneseEra] {
        pub def hash(x: JapaneseEra): Int32 = Time/Chrono/JapaneseEra.hashCode(x)
    } 
}

namespace Time/Chrono/JapaneseEra {


    use Time/Chrono.JapaneseEra;
    use Time/Chrono.JapaneseEra.{JapaneseEra};

    pub def new(japaneseEra: Int32): Option[JapaneseEra] =
        import static java.time.chrono.JapaneseEra.of(Int32): ##java.time.chrono.JapaneseEra & Pure;
        try {
            Some(JapaneseEra(of(japaneseEra)))
        } catch {
            case _: ##java.time.DateTimeException => None
        }

    pub def heisei(): JapaneseEra = 
        import static get java.time.chrono.JapaneseEra.HEISEI: ##java.time.chrono.JapaneseEra & Pure as getHEISEI;
        JapaneseEra(getHEISEI())

    pub def meiji(): JapaneseEra = 
        import static get java.time.chrono.JapaneseEra.MEIJI: ##java.time.chrono.JapaneseEra & Pure as getMEIJI;
        JapaneseEra(getMEIJI())

    /// Java 13
    /// pub def reiwa(): JapaneseEra = 
    ///     import static get java.time.chrono.JapaneseEra.REIWA: ##java.time.chrono.JapaneseEra & Pure as getREIWA;
    ///     JapaneseEra(getREIWA())

    pub def showa(): JapaneseEra = 
        import static get java.time.chrono.JapaneseEra.SHOWA: ##java.time.chrono.JapaneseEra & Pure as getSHOWA;
        JapaneseEra(getSHOWA())

    pub def taisho(): JapaneseEra = 
        import static get java.time.chrono.JapaneseEra.TAISHO: ##java.time.chrono.JapaneseEra & Pure as getTAISHO;
        JapaneseEra(getTAISHO())

    pub def getValue(x: JapaneseEra): Int32 = 
        import java.time.chrono.JapaneseEra.getValue(): Int32 & Pure;
        let JapaneseEra(x1) = x;
        getValue(x1)

    pub def equals(x: JapaneseEra, y: JapaneseEra): Bool = 
        import java.lang.Object.equals(##java.lang.Object): Bool & Pure;
        let JapaneseEra(x1) = x;
        let JapaneseEra(y1) = y;
        equals(x1 as ##java.lang.Object, y1 as ##java.lang.Object)

    pub def hashCode(x: JapaneseEra): Int32 = 
        import java.lang.Object.hashCode(): Int32 & Pure;
        let JapaneseEra(x1) = x;
        hashCode(x1 as ##java.lang.Object)

}