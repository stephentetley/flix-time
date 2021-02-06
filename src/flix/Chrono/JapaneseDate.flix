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

    instance Eq[JapaneseDate] {
        def eq(x: JapaneseDate, y: JapaneseDate): Bool = Time/Chrono/JapaneseDate.equals(x, y)

        def neq(x: JapaneseDate, y: JapaneseDate): Bool = not (x == y)
    }
    
    instance Hash[JapaneseDate] {
        def hash(x: JapaneseDate): Int = Time/Chrono/JapaneseDate.hashCode(x)
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


    pub def equals(x: JapaneseDate, y: JapaneseDate): Bool = 
        import java.time.chrono.JapaneseDate.equals(##java.lang.Object);
        let JapaneseDate(x1) = x;
        let JapaneseDate(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: JapaneseDate): Int32 = 
        import java.time.chrono.JapaneseDate.hashCode();
        let JapaneseDate(x1) = x;
        hashCode(x1) as & Pure

}
