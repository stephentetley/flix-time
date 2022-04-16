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


namespace Time/Temporal/Temporal {

    use Time.Year;
    use Time.Year.{Year};

    pub class Temporal[a] with ToString[a] {
        pub def marshalToNativeTemporal(x: a): ##java.time.temporal.Temporal
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): a
    }

    instance Temporal[Year] {
        pub def marshalToNativeTemporal(x: Year): ##java.time.temporal.Temporal =         
            Time/Year.getYear(x) as ##java.time.temporal.Temporal
        
        pub def unmarshalFromNativeTemporal(x: ##java.time.temporal.Temporal): Year = 
            Year(x as ##java.time.Year)
    }

}
