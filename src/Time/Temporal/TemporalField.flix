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

    /// Interface...

    pub enum TemporalField(##java.time.temporal.TemporalField)

    // pub class ImplementsTemporalField[t: Type] {
    //     pub def toTemporalField(s: t): TemporalField
    //     pub def fromTemporalField(s: TemporalField): t
    // }

}

mod Time.Temporal.TemporalField {

    use Time.Temporal.TemporalField
    use Time.Temporal.TemporalField.{TemporalField}

    pub def getHH(x: TemporalField): ##java.time.temporal.TemporalField = 
        let TemporalField(x1) = x;
        x1

}        