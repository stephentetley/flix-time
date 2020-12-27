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
    /// A wrapper around java.time.chrono.JapaneseDate.
    ///
    pub opaque type JapaneseDate = ##java.time.chrono.JapaneseDate
    
    ///
    /// Returns the given JapaneseDate `x` as a String.
    ///
    instance ToString[JapaneseDate] {
        def toString(x: JapaneseDate): String =
            import java.time.chrono.JapaneseDate.toString();
            let JapaneseDate(x1) = x;
            toString(x1) as & Pure
    }
}

namespace Time/Chrono/JapaneseDate {


    use Time/Chrono.JapaneseDate;
    use Time/Chrono.JapaneseDate.{JapaneseDate};

    ///
    /// Returns ___
    ///
    pub def now(): JapaneseDate & Impure =
        import java.time.chrono.JapaneseDate:now();
        JapaneseDate(now())


}
