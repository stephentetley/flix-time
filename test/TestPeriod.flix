/*
 * Copyright 2024 Stephen Tetley
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

mod TestPeriod {
    use ae::AdaptorExtras

    use ee::EffectExtras
    use ee::EffectExtras.Fail.Fail
    use ae::AdaptorExtras.InteropErr


    use Assert.{assertEq, assertOk, assertTrue, assertFalse, fail};
    use ToString.toString
    use LowerBound.minValue
    use UpperBound.maxValue
    use Comparison.{LessThan, EqualTo, GreaterThan}
    
    /////////////////////////////////////////////////////////////////////////////
    // add                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def add01(): Unit \ Assert = 
        let p1 = InteropTime.Period.newWithYears(1);
        let ans = p1 + p1;
        assertTrue(ans == InteropTime.Period.newWithYears(2))

    @Test
    def add02(): Unit \ Assert - Fail[InteropErr] = 
        let px = AdaptorExtras.proxyInteropErr();
        let ans = run {
            let p1 = InteropTime.Period.newWithYears(10);
            p1 + InteropTime.Period.newWithMonths(10)
        } with EffectExtras.Fail.runWithResult(px);
        assertOk(ans)

    /////////////////////////////////////////////////////////////////////////////
    // negate                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def negate01(): Unit \ Assert = 
        let p1 = InteropTime.Period.newWithYears(1);
        let ans = -p1;
        assertTrue(ans == InteropTime.Period.newWithYears(-1))

}
