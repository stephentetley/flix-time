/*
 * Copyright 2026 Stephen Tetley
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

pub mod InteropTime.Format { 

    pub trait TemporalFormat[t] {
        type Formatter[t]: Type
        type Aef[t]: Eff = {}
        pub def format(formatter: TemporalFormat.Formatter[t], x: t): String \ aef where TemporalFormat.Aef[t] ~ aef
    }

    pub trait TemporalParse[t] {
        type Formatter[t]: Type
        type Aef[t]: Eff = {}
        pub def parse(formatter: TemporalFormat.Formatter[t], s: String): Result[String, t] \ aef where TemporalFormat.Aef[t] ~ aef
    }
}
