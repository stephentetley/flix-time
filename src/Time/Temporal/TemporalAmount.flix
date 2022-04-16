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


namespace Time/Temporal/TemporalAmount {
  
    use Time.Period;
    use Time.Period.{Period};
    use Time.ZDuration;
    use Time.ZDuration.{ZDuration};

    pub class TemporalAmount[a] with ToString[a] {
        pub def marshalToNativeTemporalAmount(x: a): ##java.time.temporal.TemporalAmount
        
        pub def unmarshalFromNativeTemporalAmount(x: ##java.time.temporal.TemporalAmount): a
    }

    instance TemporalAmount[ZDuration] {
        pub def marshalToNativeTemporalAmount(x: ZDuration): ##java.time.temporal.TemporalAmount = 
            let ZDuration(x1) = x;
            x1 as ##java.time.temporal.TemporalAmount

        pub def unmarshalFromNativeTemporalAmount(x: ##java.time.temporal.TemporalAmount): ZDuration= 
            ZDuration(x as ##java.time.Duration)
    }

    instance TemporalAmount[Period] {
        pub def marshalToNativeTemporalAmount(x: Period): ##java.time.temporal.TemporalAmount = 
            let Period(x1) = x;
            x1 as ##java.time.temporal.TemporalAmount

        pub def unmarshalFromNativeTemporalAmount(x: ##java.time.temporal.TemporalAmount): Period= 
            Period(x as ##java.time.Period)
    }

}
