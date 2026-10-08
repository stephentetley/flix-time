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

mod TestYear {

    use ee::EffectExtras
    use ee::EffectExtras.Fail.Fail
    use ae::AdaptorExtras.InteropErr

    use Assert.{assertEq, assertTrue, assertFalse, fail};
    use ToString.toString
    use LowerBound.minValue
    use UpperBound.maxValue
    use Comparison.{LessThan, EqualTo, GreaterThan}
    
    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def toString01(): Unit \ Assert + IO - Fail[InteropErr] = 
        let proxyErr: Proxy[InteropErr] = Proxy.Proxy;
        let ans = run {
            toString(InteropTime.Year.newYear(1970))
        } with runWithIO(proxyErr);
        assertEq(expected = "1970", ans)


    pub def runWithIO(_: Proxy[err], f: Unit -> a \ ef): a \ ef + IO - Fail[err] with ToString[err] = 
        match EffectExtras.Fail.runWithResult(f) {
            case Ok(a) => a
            case Err(_) => { println("failed"); bug!("")}
        }


    // /////////////////////////////////////////////////////////////////////////////
    // // less                                                                    //
    // /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def less01(): Unit \ Assert + IO = 
    //     run {
    //         assertTrue(InteropTime.Year.newYear(2020) < InteropTime.Year.newYear(2021))
    //     } with EffectExtras.Fail.runWithIO

    // /////////////////////////////////////////////////////////////////////////////
    // // lessEq                                                                  //
    // /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def lessEq01(): Unit \ Assert + IO = 
    //     run {
    //         assertTrue(InteropTime.Year.newYear(2020) <= InteropTime.Year.newYear(2021))
    //     } with EffectExtras.Fail.runWithIO

    // /////////////////////////////////////////////////////////////////////////////
    // // greater                                                                 //
    // /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def greater01(): Unit \ Assert + IO = 
    //     run {
    //         assertTrue(InteropTime.Year.newYear(2021) > InteropTime.Year.newYear(2020))
    //     } with EffectExtras.Fail.runWithIO

    // /////////////////////////////////////////////////////////////////////////////
    // // greaterEq                                                               //
    // /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def greaterEq01(): Unit \ Assert + IO = 
    //     run {
    //         assertTrue(InteropTime.Year.newYear(2021) >= InteropTime.Year.newYear(2020))
    //     } with EffectExtras.Fail.runWithIO

    // /////////////////////////////////////////////////////////////////////////////
    // // compare                                                                 //
    // /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def compare01(): Unit \ Assert + IO = 
    //     run {
    //         assertEq(
    //              expected = LessThan,
    //             Order.compare(InteropTime.Year.newYear(2020), InteropTime.Year.newYear(2021))
    //         )
    //     } with EffectExtras.Fail.runWithIO

    // @Test
    // def compare02(): Unit \ Assert + IO = 
    //     run { 
    //         assertEq(
    //             expected = EqualTo,
    //             Order.compare(InteropTime.Year.newYear(2020), InteropTime.Year.newYear(2020))
    //         )
    //     } with EffectExtras.Fail.runWithIO

    // @Test
    // def compare03(): Unit \ Assert + IO = 
    //     run { 
    //         assertEq(
    //             expected = GreaterThan,
    //             Order.compare(InteropTime.Year.newYear(2021), InteropTime.Year.newYear(2020))
    //         )
    //     } with EffectExtras.Fail.runWithIO


    /////////////////////////////////////////////////////////////////////////////
    // until                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def until01(): Int64 \ IO = 
    //     let t1 = InteropTime.Year.year(isoYear = 2020);
    //     let t2 = InteropTime.Year.year(isoYear = 2028);
    //     let diff = InteropTime.Year.yearsUntil({ start = t1, end = t2 });
    //     println("Year.until01(): ${diff}");
    //     diff

    /////////////////////////////////////////////////////////////////////////////
    // fromTemporalAccessor                                                    //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def fromTemporalAccessor01(): Result[String, InteropTime.Year] \ IO = 
    //     let t1 = InteropTime.Year.year(isoYear = 2020);
    //     let t2 = InteropTime.Year.fromTemporalAccessor(t1);
    //     println("fromTemporalAccessor01(): ${t2}");
    //     t2

    /////////////////////////////////////////////////////////////////////////////
    // withTemporalAdjuster                                                    //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def withTemporalAdjuster01(): InteropTime.Year \ IO = 
    //     let t1 = InteropTime.Year.year(isoYear = 2020);
    //     let t2 = InteropTime.Year.year(isoYear = 2028);
    //     let t3 = InteropTime.Year.withTemporalAdjuster(t2, t1);
    //     println("withTemporalAdjuster01(): ${t3}");
    //     t3

}
