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

    use Assert.{assertEq, assertTrue, assertFalse, fail};

    use ToString.toString
    use LowerBound.minValue
    use UpperBound.maxValue
    use Comparison.{LessThan, EqualTo, GreaterThan}

    /////////////////////////////////////////////////////////////////////////////
    // toString                                                                //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def toString01(): Unit \ Assert = 
        assertEq(expected = "1970", toString(Time.Year.year(isoYear = 1970)))


    /////////////////////////////////////////////////////////////////////////////
    // less                                                                    //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def less01(): Unit \ Assert = 
        assertTrue(Time.Year.year(isoYear = 2020) < Time.Year.year(isoYear = 2021))

    /////////////////////////////////////////////////////////////////////////////
    // lessEq                                                                  //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def lessEq01(): Unit \ Assert = 
        assertTrue(Time.Year.year(isoYear = 2020) <= Time.Year.year(isoYear = 2021))

    /////////////////////////////////////////////////////////////////////////////
    // greater                                                                 //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def greater01(): Unit \ Assert = 
        assertTrue(Time.Year.year(isoYear = 2021) > Time.Year.year(isoYear = 2020))

    /////////////////////////////////////////////////////////////////////////////
    // greaterEq                                                               //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def greaterEq01(): Unit \ Assert = 
        assertTrue(Time.Year.year(isoYear = 2021) >= Time.Year.year(isoYear = 2020))

    /////////////////////////////////////////////////////////////////////////////
    // compare                                                                 //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def compare01(): Unit \ Assert = 
         assertEq(expected = LessThan, Order.compare(Time.Year.year(isoYear = 2020), Time.Year.year(isoYear = 2021)))

    @Test
    def compare02(): Unit \ Assert = 
        assertEq(expected = EqualTo, Order.compare(Time.Year.year(isoYear = 2020), Time.Year.year(isoYear = 2020)))

    @Test
    def compare03(): Unit \ Assert = 
        assertEq(expected = GreaterThan, Order.compare(Time.Year.year(isoYear = 2021), Time.Year.year(isoYear = 2020)))


    /////////////////////////////////////////////////////////////////////////////
    // until                                                                   //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def until01(): Int64 \ IO = 
    //     let t1 = Time.Year.year(isoYear = 2020);
    //     let t2 = Time.Year.year(isoYear = 2028);
    //     let diff = Time.Year.yearsUntil({ start = t1, end = t2 });
    //     println("Year.until01(): ${diff}");
    //     diff

    /////////////////////////////////////////////////////////////////////////////
    // fromTemporalAccessor                                                    //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def fromTemporalAccessor01(): Result[String, Time.Year] \ IO = 
    //     let t1 = Time.Year.year(isoYear = 2020);
    //     let t2 = Time.Year.fromTemporalAccessor(t1);
    //     println("fromTemporalAccessor01(): ${t2}");
    //     t2

    /////////////////////////////////////////////////////////////////////////////
    // withTemporalAdjuster                                                    //
    /////////////////////////////////////////////////////////////////////////////

    // @Test
    // def withTemporalAdjuster01(): Time.Year \ IO = 
    //     let t1 = Time.Year.year(isoYear = 2020);
    //     let t2 = Time.Year.year(isoYear = 2028);
    //     let t3 = Time.Year.withTemporalAdjuster(t2, t1);
    //     println("withTemporalAdjuster01(): ${t3}");
    //     t3

}
