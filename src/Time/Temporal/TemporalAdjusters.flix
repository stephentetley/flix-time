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



namespace Time/Temporal/TemporalAdjusters {

    use Time/Temporal.TemporalAdjuster;

    /// Temporal Adjusters

    def toStringHelper(constrName: String, x: ##java.time.temporal.TemporalAdjuster): String = 
        import java.lang.Object.toString(): String & Pure as toString1;
        let body = toString1(x as ##java.lang.Object);
        "${constrName}(${body})"

    pub enum FirstDayOfMonth { case FirstDayOfMonth(##java.time.temporal.TemporalAdjuster) }

    instance ToString[FirstDayOfMonth] {
        pub def toString(x: FirstDayOfMonth): String = 
            let FirstDayOfMonth(x1) = x;
            toStringHelper("FirstDayOfMonth", x1)        
    }

    pub def firstDayOfMonth(): FirstDayOfMonth = 
        import static java.time.temporal.TemporalAdjusters.firstDayOfMonth(): ##java.time.temporal.TemporalAdjuster & Pure;
        FirstDayOfMonth(firstDayOfMonth())

    instance TemporalAdjuster[FirstDayOfMonth] {
        pub def marshalToNativeTemporalAdjuster(x: FirstDayOfMonth): ##java.time.temporal.TemporalAdjuster =
            let FirstDayOfMonth(x1) = x;
            x1

        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): FirstDayOfMonth = 
            FirstDayOfMonth(x)
    }

    pub enum LastDayOfMonth { case LastDayOfMonth(##java.time.temporal.TemporalAdjuster) }

    instance ToString[LastDayOfMonth] {
        pub def toString(x: LastDayOfMonth): String = 
            let LastDayOfMonth(x1) = x;
            toStringHelper("LastDayOfMonth", x1)        
    }

    pub def lastDayOfMonth(): LastDayOfMonth = 
        import static java.time.temporal.TemporalAdjusters.lastDayOfMonth(): ##java.time.temporal.TemporalAdjuster & Pure;
        LastDayOfMonth(lastDayOfMonth())

    instance TemporalAdjuster[LastDayOfMonth] {
        pub def marshalToNativeTemporalAdjuster(x: LastDayOfMonth): ##java.time.temporal.TemporalAdjuster =
            let LastDayOfMonth(x1) = x;
            x1

        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): LastDayOfMonth = 
            LastDayOfMonth(x)
    }
}
