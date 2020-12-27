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


}
