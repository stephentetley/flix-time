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


namespace Time/Temporal {

    pub opaque type ValueRange = ##java.time.temporal.ValueRange

    instance ToString[ValueRange] {
        def toString(x: ValueRange): String = 
            import java.time.temporal.ValueRange.toString() as toString;
            let ValueRange(x1) = x;
            toString(x1) as & Pure
    }

}

namespace Time/Temporal/ValueRange {

    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};


    ///
    /// Return a new **Fixed** value range.
    ///
    pub def new(x: {min: Int64, max: Int64}): ValueRange =
        import java.time.temporal.ValueRange:of(Int64, Int64);
        ValueRange(of(x.min, x.max)) as & Pure

}