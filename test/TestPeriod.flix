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

    use Assert.{assertEq, assertTrue, assertFalse, fail};
    
    use ToString.toString
    use LowerBound.minValue
    use UpperBound.maxValue
    use Comparison.{LessThan, EqualTo, GreaterThan}

    /////////////////////////////////////////////////////////////////////////////
    // add                                                                     //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def add01(): Unit \ Assert = 
        let p1 = InteropTime.Period.ofYears(1);
        let ans = p1 + p1;
        assertTrue(ans == InteropTime.Period.ofYears(2))

    @Test
    def add02(): Unit \ Assert = 
        let p1 = InteropTime.Period.ofYears(10);
        let ans = p1 + InteropTime.Period.ofMonths(10);
        assertTrue(ans == InteropTime.Period.period({years = 10, months = 10, days = 0}))


    /////////////////////////////////////////////////////////////////////////////
    // negate                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def negate01(): Unit \ Assert = 
        let p1 = InteropTime.Period.ofYears(1);
        let ans = -p1;
        assertTrue(ans == InteropTime.Period.ofYears(-1))

}
