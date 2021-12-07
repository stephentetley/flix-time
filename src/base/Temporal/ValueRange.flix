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
            import java.time.temporal.ValueRange.toString() as toString;
            let ValueRange(x1) = x;
            toString(x1) as & Pure
    }

    instance Eq[ValueRange] {
        pub def eq(x: ValueRange, y: ValueRange): Bool = Time/Temporal/ValueRange.equals(x, y)
    }

    instance Hash[ValueRange] {
        pub def hash(x: ValueRange): Int = Time/Temporal/ValueRange.hashCode(x)
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
        import static java.time.temporal.ValueRange.of(Int64, Int64);
        ValueRange(of(x.min, x.max)) as & Pure


    ///
    /// Return a new variable value range.
    ///
    pub def newVariableValueRange(x: {min :: Int64, maxSmallest :: Int64, maxLargest :: Int64}): ValueRange =
        import static java.time.temporal.ValueRange.of(Int64, Int64, Int64);
        ValueRange(of(x.min, x.maxSmallest, x.maxLargest)) as & Pure

    ///
    /// Return a new fully variable value range.
    ///
    pub def newFullyVariableValueRange(x: {minSmallest :: Int64, minLargest :: Int64, maxSmallest :: Int64, maxLargest :: Int64}): ValueRange =
        import static java.time.temporal.ValueRange.of(Int64, Int64, Int64, Int64);
        ValueRange(of(x.minSmallest, x.minLargest, x.maxSmallest, x.maxLargest)) as & Pure


    pub def equals(x: ValueRange, y: ValueRange): Bool =
        import java.time.temporal.ValueRange.equals(##java.lang.Object);
        let ValueRange(x1) = x;
        let ValueRange(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: ValueRange): Int32 = 
        import java.time.temporal.ValueRange.hashCode();
        let ValueRange(x1) = x;
        hashCode(x1) as & Pure

    pub def getMaximum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getMaximum();
        let ValueRange(x1) = x;
        getMaximum(x1) as & Pure


    pub def checkValidValue(x: ValueRange, value: Int64, field: ChronoField): Int64 = 
        import java.time.temporal.ValueRange.checkValidValue(Int64, ##java.time.temporal.TemporalField);
        let ValueRange(x1) = x;
        let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
        checkValidValue(x1, value, field1) as & Pure

    pub def checkValidIntValue(x: ValueRange, value: Int64, field: ChronoField): Int32 = 
        import java.time.temporal.ValueRange.checkValidIntValue(Int64, ##java.time.temporal.TemporalField);
        let ValueRange(x1) = x;
        let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
        checkValidIntValue(x1, value, field1) as & Pure

    pub def getMinimum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getMinimum();
        let ValueRange(x1) = x;
        getMinimum(x1) as & Pure

    pub def getLargestMinimum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getLargestMinimum();
        let ValueRange(x1) = x;
        getLargestMinimum(x1) as & Pure

    pub def getSmallestMaximum(x: ValueRange): Int64 = 
        import java.time.temporal.ValueRange.getSmallestMaximum();
        let ValueRange(x1) = x;
        getSmallestMaximum(x1) as & Pure

    pub def isFixed(x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isFixed();
        let ValueRange(x1) = x;
        isFixed(x1) as & Pure

    pub def isIntValue(x: ValueRange): Bool = 
        import java.time.temporal.ValueRange.isIntValue();
        let ValueRange(x1) = x;
        isIntValue(x1) as & Pure

}
