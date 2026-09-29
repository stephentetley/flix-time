/*
 * Copyright 2026 Stephen Tetley
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



mod UseClock {

    use Assert.{assertEq}
    
    use ee::EffectExtras
    use ee::EffectExtras.Fail.Fail
    use ae::JavaInterop.InteropErr

    use InteropTime.ClockZ
    use InteropTime.ClockZ.RunClock
    use InteropTime.InstantZ
    use InteropTime.MonthDay
    use InteropTime.ZoneId

    // @Test
    // pub def test01(): Unit \ Assert + IO + Time.Sleep - RunClock = 
    //     let clock = ClockZ.fixedClock(InstantZ.epoch(), ZoneId.systemDefault());
    //     let dif = run {
    //         let now1 = InstantZ.clockNow();
    //         println("InstantZ.clockNow: ${now1}");
    //         let nowmd = MonthDay.clockNow();
    //         println("MonthDay.clockNow: ${nowmd}");
    //         let millis1 = RunClock.millis();
    //         Time.Sleep.sleep(Time.Duration.seconds(2));
    //         let now2 = InstantZ.clockNow();
    //         println("InstantZ.clockNow: ${now2}");
    //         let millis2 = RunClock.millis();
    //         millis1 - millis2
    //     } with EffectExtras.Fail.runWithOption
    //       with InteropTime.ClockZ.runClock(clock);
    //     println("Fixed clock dif(): ${dif}");
    //     assertEq(expected = Some(0i64), dif)

}
