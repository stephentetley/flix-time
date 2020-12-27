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
    /// A wrapper around java.time.chrono.MinguoDate.
    ///
    pub opaque type MinguoDate = ##java.time.chrono.MinguoDate
    
    ///
    /// Returns the given MinguoDate `x` as a String.
    ///
    instance ToString[MinguoDate] {
        def toString(x: MinguoDate): String =
            import java.time.chrono.MinguoDate.toString();
            let MinguoDate(x1) = x;
            toString(x1) as & Pure
    }
}

namespace Time/Chrono/MinguoDate {


    use Time/Chrono.MinguoDate;
    use Time/Chrono.MinguoDate.{MinguoDate};

    ///
    /// Returns ___
    ///
    pub def now(): MinguoDate & Impure =
        import java.time.chrono.MinguoDate:now();
        MinguoDate(now())


}
