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

namespace TestDuration {

/////////////////////////////////////////////////////////////////////////////
// parse                                                                   //
/////////////////////////////////////////////////////////////////////////////

@test
def parse01(): Bool =
    use Result.flatMap;
    let step = () -> {
        let* t1 = Time/Duration.parse("PT1M");
        let t2 = Time/Duration.fromMinutes(1i64);
        Ok(t1 == t2)
    };
    Result.getWithDefault(step(), false)

@test
def parse02(): Bool =
    use Result.flatMap;
    use Time/Duration.{parse, plus, fromMinutes, fromDays};
    let step = () -> {
        let* t1 = parse("P1DT1M");
        let t2 = fromDays(1i64) `plus` fromMinutes(1i64) ;
        Ok(t1 == t2)
    };
    Result.getWithDefault(step(), false)

}