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

mod Time.Internal.Chrono {

    import java.time.chrono.{AbstractChronology => JAbstractChronology}

    /// Abstract Class...

    pub enum AbstractChronology(JAbstractChronology)


}

mod Time.Internal.Chrono.AbstractChronology {

    use Time.Internal.Chrono.AbstractChronology
    use Time.Internal.Chrono.AbstractChronology.{AbstractChronology}

    import java.time.chrono.{Chronology => JChronology}
    import java.lang.{Object}
    
    pub def toString(x: AbstractChronology): String =
        let AbstractChronology(x1) = x;
        unsafe x1.toString()

    pub def equals(x: AbstractChronology, y: AbstractChronology): Bool =
        let AbstractChronology(x1) = x;
        let AbstractChronology(y1) = y;
        let obj = (checked_cast(y1) : Object);
        unsafe x1.equals(obj)


    pub def compareTo(x: AbstractChronology, y: AbstractChronology): Int32 =
        let AbstractChronology(x1) = x;
        let AbstractChronology(y1) = y;
        let cy1 = (checked_cast(y1) : JChronology);
        unsafe x1.compareTo(cy1)

}
