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

    pub opaque type IsoUnit = ##java.time.temporal.TemporalUnit

    instance ToString[IsoUnit] {
        def toString(x: IsoUnit): String = 
            import java.time.temporal.TemporalUnit.toString() as toString;
            let IsoUnit(x1) = x;
            toString(x1) as & Pure
    }

}

namespace Time/Temporal/IsoUnit {

    use Time/Temporal.IsoUnit;
    use Time/Temporal.IsoUnit.{IsoUnit};
    use Time.Duration;
    use Time.Duration.{Duration};

    pub def quarterYears(): IsoUnit = 
        import get java.time.temporal.IsoFields:QUARTER_YEARS as getQUARTER_YEARS;
        IsoUnit(getQUARTER_YEARS()) as & Pure

    pub def weekBasedYears(): IsoUnit = 
        import get java.time.temporal.IsoFields:WEEK_BASED_YEARS as getWEEK_BASED_YEARS;
        IsoUnit(getWEEK_BASED_YEARS()) as & Pure

    pub def getDuration(x: IsoUnit): Duration =
        import java.time.temporal.TemporalUnit.getDuration();
        let IsoUnit(x1) = x;
        Duration(getDuration(x1)) as & Pure

}