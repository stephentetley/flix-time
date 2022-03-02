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
        pub def toString(x: ValueRange): String =
            import java.time.temporal.ValueRange.toString(): String & Pure;
            let ValueRange(x1) = x;
            toString(x1)
    }

    instance Eq[ValueRange] {
        pub def eq(x: ValueRange, y: ValueRange): Bool = Time/Temporal/ValueRange.equals(x, y)
    }

    instance Hash[ValueRange] {
        pub def hash(x: ValueRange): Int32 = Time/Temporal/ValueRange.hashCode(x)
    }

}

namespace Time/Temporal/ValueRange {

    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time/Temporal.ChronoField;

    ///
    /// Return a new **Fixed** value range.
    ///
    pub def newFixedValueRange(x: {min :: Int64, max :: Int64}): ValueRange =
        import static java.time.temporal.ValueRange.of(Int64, Int64): ##java.time.temporal.ValueRange & Pure;
        ValueRange(of(x.min, x.max))


    ///
    /// Return a new variable value range.
    ///
    pub def newVariableValueRange(x: {min :: Int64, maxSmallest :: Int64, maxLargest :: Int64}): ValueRange =
        import static java.time.temporal.ValueRange.of(Int64, Int64, Int64): ##java.time.temporal.ValueRange & Pure;
        ValueRange(of(x.min, x.maxSmallest, x.maxLargest))

    ///
    /// Return a new fully variable value range.
    ///
    pub def newFullyVariableValueRange(x: {minSmallest :: Int64, minLargest :: Int64, maxSmallest :: Int64, maxLargest :: Int64}): ValueRange =
        import static java.time.temporal.ValueRange.of(Int64, Int64, Int64, Int64): ##java.time.temporal.ValueRange & Pure;
        ValueRange(of(x.minSmallest, x.minLargest, x.maxSmallest, x.maxLargest))


    pub def equals(x: ValueRange, y: ValueRange): Bool =
        import java.time.temporal.ValueRange.equals(##java.lang.Object): Bool & Pure;
        let ValueRange(x1) = x;
        let ValueRange(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ValueRange): Int32 = 
        import java.time.temporal.ValueRange.hashCode(): Int32 & Pure;
        let ValueRange(x1) = x;
        hashCode(x1) 

    pub def getMaximum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getMaximum(): Int64 & Pure;
        let ValueRange(x1) = x;
        getMaximum(x1)


    pub def checkValidValue(x: ValueRange, value: Int64, field: ChronoField): Int64 = 
        import java.time.temporal.ValueRange.checkValidValue(Int64, ##java.time.temporal.TemporalField): Int64 & Pure;
        let ValueRange(x1) = x;
        let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
        checkValidValue(x1, value, field1)

    pub def checkValidIntValue(x: ValueRange, value: Int64, field: ChronoField): Int32 = 
        import java.time.temporal.ValueRange.checkValidIntValue(Int64, ##java.time.temporal.TemporalField): Int32 & Pure;
        let ValueRange(x1) = x;
        let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
        checkValidIntValue(x1, value, field1)

    pub def getMinimum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getMinimum(): Int64 & Pure;
        let ValueRange(x1) = x;
        getMinimum(x1)

    pub def getLargestMinimum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getLargestMinimum(): Int64 & Pure;
        let ValueRange(x1) = x;
        getLargestMinimum(x1)

    pub def getSmallestMaximum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getSmallestMaximum(): Int64 & Pure;
        let ValueRange(x1) = x;
        getSmallestMaximum(x1)

    pub def isFixed(x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isFixed(): Bool & Pure;
        let ValueRange(x1) = x;
        isFixed(x1)

    pub def isIntValue(x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isIntValue(): Bool & Pure;
        let ValueRange(x1) = x;
        isIntValue(x1)

}
