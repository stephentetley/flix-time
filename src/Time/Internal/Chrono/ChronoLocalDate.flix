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

    import java.time.chrono.{ChronoLocalDate => JChronoLocalDate}

    /// Interface...

    pub enum ChronoLocalDate(JChronoLocalDate)


}

mod Time.Internal.Chrono.ChronoLocalDate {

    use Time.Internal.Chrono.ChronoLocalDate
    use Time.Internal.Chrono.ChronoLocalDate.{ChronoLocalDate}

    import java.lang.{Object, CharSequence}

    pub def toString(x: ChronoLocalDate): String =
        let ChronoLocalDate(x1) = x;
        unsafe x1.toString()

    pub def equals(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        let obj = (checked_cast(y1) : Object);
        unsafe x1.equals(obj)


    pub def compareTo(x: ChronoLocalDate, y: ChronoLocalDate): Int32 =
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        unsafe x1.compareTo(y1)

    pub def toEpochDay(x: ChronoLocalDate): Int64 =
        let ChronoLocalDate(x1) = x;
        unsafe x1.toEpochDay()

    pub def isAfter(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        unsafe x1.isAfter(y1)

    pub def isBefore(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        unsafe x1.isBefore(y1)

    pub def isEqual(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        unsafe x1.isEqual(y1)

}
