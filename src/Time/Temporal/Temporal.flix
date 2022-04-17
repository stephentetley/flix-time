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

    pub class TemporalAccessor[a] with ToString[a] {
        pub def marshalToNativeTemporalAccessor(x: a): ##java.time.temporal.TemporalAccessor
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): a
    }

    pub class Temporal[a] with TemporalAccessor[a] {
        pub def marshalToNativeTemporal(x: a): ##java.time.temporal.Temporal
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): a
    }

    pub class TemporalAmount[a] with ToString[a] {
        pub def marshalToNativeTemporalAmount(x: a): ##java.time.temporal.TemporalAmount
        pub def unmarshalFromNativeTemporalAmount(x: ##java.time.temporal.TemporalAmount): a
    }

    pub class TemporalField[a] with ToString[a] {
        pub def marshalToNativeTemporalField(x: a): ##java.time.temporal.TemporalField
        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): a
    }

    pub class TemporalUnit[a] with ToString[a] {
        pub def marshalToNativeTemporalUnit(x: a): ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): a
    }    

}
