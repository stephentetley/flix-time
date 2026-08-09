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

pub mod TestJapaneseChronology {

    use Assert.{assertEq, assertTrue, assertFalse, fail};
    
    
    /////////////////////////////////////////////////////////////////////////////
    // eras                                                                    //
    /////////////////////////////////////////////////////////////////////////////

    @Test
    def eras01(): Unit \ {Assert, IO} = 
        let current = InteropTime.Chrono.JapaneseChronology.getInstance();
        let xs = InteropTime.Chrono.JapaneseChronology.eras(current);
        println("Japanese eras: ${xs}");
        assertTrue(not List.isEmpty(xs))
    
        
}
