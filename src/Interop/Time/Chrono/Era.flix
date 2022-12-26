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

    /// Interface...

    pub enum Era(##java.time.chrono.Era)

    pub class ImpEra[t: Type] {
        pub def toEra(s: t): Era
        pub def fromEra(s: Era): t
    }

}

namespace Interop/Time/Chrono/Era {

    use Interop/Time/Chrono.Era
    use Interop/Time/Chrono.Era.{Era}

}
