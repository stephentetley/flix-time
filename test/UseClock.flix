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
    use EffectExtras.Fail.Fail
    use InteropTime.ClockZ
    use InteropTime.ClockZ.ClockNow
    use InteropTime.ClockZ.RunClock
    use InteropTime.InstantZ
    use InteropTime.InstantZ.InstantNow
    use InteropTime.ZoneId

    @Test
    pub def test01(): Unit \ Assert + IO + Fail + Time.Sleep = 
        let clock = ClockZ.fixedClock(InstantZ.epoch(), ZoneId.systemDefault());
        let dif = run {
            let now1: InstantZ = ClockNow.now();
            println("ClockNow.now1: ${now1}");
            let millis1 = RunClock.millis();
            Time.Sleep.sleep(Time.Duration.seconds(2));
            let now2: InstantZ = ClockNow.now();
            println("ClockNow.now2: ${now2}");
            let millis2 = RunClock.millis();
            millis1 - millis2
        } with InteropTime.InstantZ.runInstantNow
          with InteropTime.ClockZ.runClock(clock);
        println("Fixed clock dif(): ${dif}");
        assertEq(expected = 0i64, dif)

}
