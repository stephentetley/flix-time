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

 namespace Time/Temporal {

    use Time/Temporal.ValueRange
    use Time/Temporal.ValueRange.{ValueRange}
    
    /// Final Class

    pub enum ValueRange(##java.time.temporal.ValueRange)


    instance Interop/Flix.Marshal[ValueRange] {
        pub def toJavaObject(x: ValueRange): ##java.lang.Object =
            let ValueRange(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): ValueRange = 
            ValueRange(unchecked_cast(o as ##java.time.temporal.ValueRange))
    }

}

namespace Time/Temporal/ValueRange {

    use Time/Temporal.ValueRange
    use Time/Temporal.ValueRange.{ValueRange}

    /// ## Unwrap

    pub def getHH(x: ValueRange): ##java.time.temporal.ValueRange = 
        let ValueRange(x1) = x;
        x1

    pub def isFixed(x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isFixed(): Bool \ {};
        let ValueRange(x1) = x;
        isFixed(x1)

    pub def isIntValue(x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isIntValue(): Bool \ {};
        let ValueRange(x1) = x;
        isIntValue(x1)

    pub def isValidValue(i: Int64, x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isValidValue(Int64): Bool \ {};
        let ValueRange(x1) = x;
        isValidValue(x1, i)

    pub def isValidIntValue(i: Int64, x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isValidIntValue(Int64): Bool \ {};
        let ValueRange(x1) = x;
        isValidIntValue(x1, i)

    pub def getMinimum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getMinimum(): Int64 \ {};
        let ValueRange(x1) = x;
        getMinimum(x1)

    pub def getLargestMinimum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getLargestMinimum(): Int64 \ {};
        let ValueRange(x1) = x;
        getLargestMinimum(x1)

    pub def getSmallestMaximum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getSmallestMaximum(): Int64 \ {};
        let ValueRange(x1) = x;
        getSmallestMaximum(x1)

    pub def getMaximum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getMaximum(): Int64 \ {};
        let ValueRange(x1) = x;
        getMaximum(x1)
}