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

mod Time.Internal.Temporal {

    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}

    /// Interface...

    pub enum TemporalAccessor(JTemporalAccessor)

    // pub class ImpTemporalAccessor[t: Type] {
    //     pub def toTemporalAccessor(s: t): TemporalAccessor
    //     pub def fromTemporalAccessor(s: TemporalAccessor): t
    // }

}

mod Time.Internal.Temporal.TemporalAccessor {

    use Time.Internal.Temporal.TemporalAccessor
    use Time.Internal.Temporal.TemporalAccessor.{TemporalAccessor}


}        