/*
 * Copyright 2022 Stephen Tetley
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

namespace Interop/Time/Chrono {

    /// Abstract Class...

    pub enum AbstractChronology(##java.time.chrono.AbstractChronology)

    pub class SubAbstractChronology[t: Type] {
        pub def toAbstractChronology(s: t): AbstractChronology
        pub def fromAbstractChronology(s: AbstractChronology): t
    }

}

namespace Interop/Time/Chrono/AbstractChronology {

    use Interop/Time/Chrono.AbstractChronology
    use Interop/Time/Chrono.AbstractChronology.{AbstractChronology}

    pub def toString(x: AbstractChronology): String =
        import java.time.chrono.AbstractChronology.toString(): String \ {};
        let AbstractChronology(x1) = x;
        toString(x1)

    pub def equals(x: AbstractChronology, y: AbstractChronology): Bool =
        import java.time.chrono.AbstractChronology.equals(##java.lang.Object): Bool \ {};
        let AbstractChronology(x1) = x;
        let AbstractChronology(y1) = y;
        equals(x1, checked_cast(y1))


    pub def compareTo(x: AbstractChronology, y: AbstractChronology): Int32 =
        import java.time.chrono.AbstractChronology.compareTo(##java.time.chrono.Chronology): Int32 \ {};
        let AbstractChronology(x1) = x;
        let AbstractChronology(y1) = y;
        compareTo(x1, unchecked_cast(y1 as ##java.time.chrono.Chronology))

}
