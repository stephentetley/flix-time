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

namespace TestYear {

    use ToString.toString;
    use LowerBound.minValue;
    use UpperBound.maxValue;

    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def toString01(): String = toString(Time/Year.year(isoYear = 1970))

    /////////////////////////////////////////////////////////////////////////////
    // minValue                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def minValue01(): Bool = minValue() == Time/Year.year(isoYear = -999_999_999)

    /////////////////////////////////////////////////////////////////////////////
    // maxValue                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def maxValue01(): Bool = maxValue() == Time/Year.year(isoYear = 999_999_999)

    /////////////////////////////////////////////////////////////////////////////
    // less                                                                    //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def less01(): Bool = Time/Year.year(isoYear = 2020) < Time/Year.year(isoYear = 2021)

    /////////////////////////////////////////////////////////////////////////////
    // lessEq                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def lessEq01(): Bool = Time/Year.year(isoYear = 2020) <= Time/Year.year(isoYear = 2021)

    /////////////////////////////////////////////////////////////////////////////
    // greater                                                                 //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def greater01(): Bool = Time/Year.year(isoYear = 2021) > Time/Year.year(isoYear = 2020)

    /////////////////////////////////////////////////////////////////////////////
    // greaterEq                                                               //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def greaterEq01(): Bool = Time/Year.year(isoYear = 2021) >= Time/Year.year(isoYear = 2020)

    /////////////////////////////////////////////////////////////////////////////
    // compare                                                                 //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def compare01(): Bool = Order.compare(Time/Year.year(isoYear = 2020), Time/Year.year(isoYear = 2021)) == LessThan

    @test
    def compare02(): Bool = Order.compare(Time/Year.year(isoYear = 2020), Time/Year.year(isoYear = 2020)) == EqualTo

    @test
    def compare03(): Bool = Order.compare(Time/Year.year(isoYear = 2021), Time/Year.year(isoYear = 2020)) == GreaterThan

    /////////////////////////////////////////////////////////////////////////////
    // range                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def range01(): Time/Temporal.ValueRange & Impure = 
        let y1 = Time/Year.year(isoYear = 2020);        
        let r1 = Time/Year.rangeYear(y1);
        println("Year.range01(): ${r1}");
        r1


    /////////////////////////////////////////////////////////////////////////////
    // until                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    @test
    def until01(): Int64 & Impure = 
        let t1 = Time/Year.year(isoYear = 2020);
        let t2 = Time/Year.year(isoYear = 2028);
        let diff = Time/Year.until(Time/Temporal/ChronoUnit.years(), { start = t1, end = t2 });
        println("Year.until01(): ${diff}");
        diff

    /// /////////////////////////////////////////////////////////////////////////////
    /// // fromTemporalAccessor                                                    //
    /// /////////////////////////////////////////////////////////////////////////////
    /// @test
    /// def fromTemporalAccessor01(): Result[Time.Year, String] & Impure = 
    ///     let t1 = Time/Year.year(isoYear = 2020);
    ///     let t2 = Time/Year.fromTemporalAccessor(t1);
    ///     println("fromTemporalAccessor01(): ${t2}");
    ///     t2

    /////////////////////////////////////////////////////////////////////////////
    // withTemporalAdjuster                                                    //
    /////////////////////////////////////////////////////////////////////////////
    @test
    def withTemporalAdjuster01(): Time.Year & Impure = 
        let t1 = Time/Year.year(isoYear = 2020);
        let t2 = Time/Year.year(isoYear = 2028);
        let t3 = Time/Year.withTemporalAdjuster(t2, t1);
        println("withTemporalAdjuster01(): ${t3}");
        t3
}