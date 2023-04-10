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

mod Interop.Time.Chrono {

    /// Interface...

    pub enum ChronoLocalDate(##java.time.chrono.ChronoLocalDate)

    pub class ImpChronoLocalDate[t: Type] {
        pub def toChronoLocalDate(s: t): ChronoLocalDate
        pub def fromChronoLocalDate(s: ChronoLocalDate): t
    }

}

mod Interop.Time.Chrono.ChronoLocalDate {

    use Interop.Time.Chrono.ChronoLocalDate
    use Interop.Time.Chrono.ChronoLocalDate.{ChronoLocalDate}

    pub def toString(x: ChronoLocalDate): String =
        import java.time.chrono.ChronoLocalDate.toString(): String \ {};
        let ChronoLocalDate(x1) = x;
        toString(x1)

    pub def equals(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        import java.time.chrono.ChronoLocalDate.equals(##java.lang.Object): Bool \ {};
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        equals(x1, checked_cast(y1))


    pub def compareTo(x: ChronoLocalDate, y: ChronoLocalDate): Int32 =
        import java.time.chrono.ChronoLocalDate.compareTo(##java.time.chrono.ChronoLocalDate): Int32 \ {};
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        compareTo(x1, y1)

    pub def toEpochDay(x: ChronoLocalDate): Int64 =
        import java.time.chrono.ChronoLocalDate.toEpochDay(): Int64 \ {};
        let ChronoLocalDate(x1) = x;
        toEpochDay(x1)

    pub def isAfter(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        import java.time.chrono.ChronoLocalDate.isAfter(##java.time.chrono.ChronoLocalDate): Bool \ {};
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        isAfter(x1, y1)

    pub def isBefore(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        import java.time.chrono.ChronoLocalDate.isBefore(##java.time.chrono.ChronoLocalDate): Bool \ {};
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        isBefore(x1, y1)

    pub def isEqual(x: ChronoLocalDate, y: ChronoLocalDate): Bool =
        import java.time.chrono.ChronoLocalDate.isEqual(##java.time.chrono.ChronoLocalDate): Bool \ {};
        let ChronoLocalDate(x1) = x;
        let ChronoLocalDate(y1) = y;
        isEqual(x1, y1)        

}
