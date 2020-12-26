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

    pub opaque type IsoField = ##java.time.temporal.TemporalField

    instance ToString[IsoField] {
        def toString(x: IsoField): String = 
            import java.time.temporal.TemporalField.toString() as toString;
            let IsoField(x1) = x;
            toString(x1) as & Pure
    }

}

namespace Time/Temporal/IsoField {

    use Time/Temporal.IsoField;
    use Time/Temporal.IsoField.{IsoField};
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def dayOfQuarter(): IsoField = 
        import get java.time.temporal.IsoFields:DAY_OF_QUARTER as getDAY_OF_QUARTER;
        IsoField(getDAY_OF_QUARTER()) as & Pure

    pub def quarterOfYear(): IsoField = 
        import get java.time.temporal.IsoFields:QUARTER_OF_YEAR as getQUARTER_OF_YEAR;
        IsoField(getQUARTER_OF_YEAR()) as & Pure

    pub def weekBasedYear(): IsoField = 
        import get java.time.temporal.IsoFields:WEEK_BASED_YEAR as getWEEK_BASED_YEAR;
        IsoField(getWEEK_BASED_YEAR()) as & Pure

    pub def weekOfWeekBasedYear(): IsoField = 
        import get java.time.temporal.IsoFields:WEEK_OF_WEEK_BASED_YEAR as getWEEK_OF_WEEK_BASED_YEAR;
        IsoField(getWEEK_OF_WEEK_BASED_YEAR()) as & Pure

    pub def range(x: IsoField): ValueRange =
        import java.time.temporal.TemporalField.range();
        let IsoField(x1) = x;
        ValueRange(range(x1)) as & Pure

}