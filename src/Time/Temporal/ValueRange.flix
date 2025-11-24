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

    use Time.Temporal.ValueRange
    use Time.Temporal.ValueRange.{ValueRange }

    import java.time.temporal.{ValueRange => JValueRange }
    
    /// Final Class

    pub enum ValueRange(JValueRange)



}

mod Time.Temporal.ValueRange {

    use Time.Temporal.ValueRange
    use Time.Temporal.ValueRange.{ValueRange }

    /// Unwrap

    pub def isFixed(x: ValueRange): Bool = 
        let ValueRange(x1) = x;
        unsafe IO { x1.isFixed() }

    pub def isIntValue(x: ValueRange): Bool = 
        let ValueRange(x1) = x;
        unsafe IO { x1.isIntValue() }

    pub def isValidValue(i: Int64, x: ValueRange): Bool = 
        let ValueRange(x1) = x;
        unsafe IO { x1.isValidValue(i) }

    pub def isValidIntValue(i: Int64, x: ValueRange): Bool = 
        let ValueRange(x1) = x;
        unsafe IO { x1.isValidIntValue(i) }

    pub def getMinimum(x: ValueRange): Int64 = 
        let ValueRange(x1) = x;
        unsafe IO { x1.getMinimum() }

    pub def getLargestMinimum(x: ValueRange): Int64 = 
        let ValueRange(x1) = x;
        unsafe IO { x1.getLargestMinimum() }

    pub def getSmallestMaximum(x: ValueRange): Int64 = 
        let ValueRange(x1) = x;
        unsafe IO { x1.getSmallestMaximum() }

    pub def getMaximum(x: ValueRange): Int64 = 
        let ValueRange(x1) = x;
        unsafe IO { x1.getMaximum() }

}
