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

namespace Interop/Time/Temporal {

    /// Interface...

    pub enum TemporalAccessor(##java.time.temporal.TemporalAccessor)

    pub class ImpTemporalAccessor[t: Type] {
        pub def toTemporalAccessor(s: t): TemporalAccessor
        pub def fromTemporalAccessor(s: TemporalAccessor): t
    }

}

namespace Interop/Time/Temporal/TemporalAccessor {

use Interop/Time/Temporal.TemporalAccessor
use Interop/Time/Temporal.TemporalAccessor.{TemporalAccessor}

    pub def getHH(x: TemporalAccessor): ##java.time.temporal.TemporalAccessor = 
        let TemporalAccessor(x1) = x;
        x1

}        