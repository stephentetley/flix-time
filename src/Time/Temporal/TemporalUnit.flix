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

mod Time.Temporal {

    import java.time.temporal.{TemporalUnit => JTemporalUnit}

    /// Interface...
    pub enum TemporalUnit(JTemporalUnit)


}

mod Time.Temporal.TemporalUnit {

    use Time.Temporal.TemporalUnit
    use Time.Temporal.TemporalUnit.{TemporalUnit}
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}

    pub def getDuration(x: TemporalUnit): DurationZ = 
        let TemporalUnit(x1) = x;
        DurationZ(unsafe x1.getDuration())

}        