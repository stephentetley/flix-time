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

namespace Time {

    ///
    /// A wrapper around a Java ZoneOffset.
    ///
    pub opaque type ZoneOffset = ##java.time.ZoneOffset

    ///
    /// Returns the given ZoneOffset `x` as a String.
    ///
    instance ToString[ZoneOffset] {
        pub def toString(x: ZoneOffset): String =
            import java.time.ZoneOffset.toString(): String & Pure;
            let ZoneOffset(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneOffset] {
        pub def eq(x: ZoneOffset, y: ZoneOffset): Bool = Time/ZoneOffset.equals(x, y)
    }

    instance Hash[ZoneOffset] {
        pub def hash(x: ZoneOffset): Int32 = Time/ZoneOffset.hashCode(x)
    }

    instance Order[ZoneOffset] {
        pub def compare(x: ZoneOffset, y: ZoneOffset): Comparison =
            Time/ZoneOffset.compareTo(x,y) |> Comparison.fromInt32
    }


    instance LowerBound[ZoneOffset] {
        pub def minValue(): ZoneOffset = Time/ZoneOffset.min()
    }

    instance UpperBound[ZoneOffset] {
        pub def maxValue(): ZoneOffset = Time/ZoneOffset.max()
    }

    instance Boxable[ZoneOffset]

}

namespace Time/ZoneOffset {


    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    use Time/Zone.ZoneRules;
    use Time/Zone.ZoneRules.{ZoneRules};

    ///
    /// ___
    ///
    pub def utc(): ZoneOffset =
        import static get java.time.ZoneOffset.UTC: ##java.time.ZoneOffset & Pure as get_UTC;
        ZoneOffset(get_UTC())

    pub def min(): ZoneOffset =
        import static get java.time.ZoneOffset.MIN: ##java.time.ZoneOffset & Pure as get_MIN;
        ZoneOffset(get_MIN())

    pub def max(): ZoneOffset =
        import static get java.time.ZoneOffset.MAX: ##java.time.ZoneOffset & Pure as get_MAX;
        ZoneOffset(get_MAX())


    pub def ofHours(hours: Int32): ZoneOffset =
        import static java.time.ZoneOffset.ofHours(Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofHours(hours))

    pub def ofHoursMinutes(r: {hours :: Int32, minutes :: Int32}): ZoneOffset =
        import static java.time.ZoneOffset.ofHoursMinutes(Int32, Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofHoursMinutes(r.hours, r.minutes))

    pub def ofHoursMinutesSeconds(r: {hours :: Int32, minutes :: Int32, seconds :: Int32}): ZoneOffset =
        import static java.time.ZoneOffset.ofHoursMinutesSeconds(Int32, Int32, Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofHoursMinutesSeconds(r.hours, r.minutes, r.seconds))

    pub def ofTotalSeconds(seconds: Int32): ZoneOffset =
        import static java.time.ZoneOffset.ofTotalSeconds(Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofTotalSeconds(seconds))


    pub def equals(x: ZoneOffset, y: ZoneOffset): Bool =
        import java.time.ZoneOffset.equals(##java.lang.Object): Bool & Pure;
        let ZoneOffset(x1) = x;
        let ZoneOffset(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZoneOffset): Int32 =
        import java.time.ZoneOffset.hashCode(): Int32 & Pure;
        let ZoneOffset(x1) = x;
        hashCode(x1)


    pub def compareTo(x: ZoneOffset, y: ZoneOffset): Int32 =
        import java.time.ZoneOffset.compareTo(##java.time.ZoneOffset): Int32 & Pure;
        let ZoneOffset(x1) = x;
        let ZoneOffset(y1) = y;
        compareTo(x1, y1)

    pub def getId(x: ZoneOffset): String =
        import java.time.ZoneOffset.getId(): String & Pure;
        let ZoneOffset(x1) = x;
        getId(x1)

    pub def getRules(x: ZoneOffset): ZoneRules =
        import java.time.ZoneOffset.getRules(): ##java.time.zone.ZoneRules & Pure;
        let ZoneOffset(x1) = x;
        ZoneRules(getRules(x1))

    pub def getTotalSeconds(x: ZoneOffset): Int32 =
        import java.time.ZoneOffset.getTotalSeconds(): Int32 & Pure;
        let ZoneOffset(x1) = x;
        getTotalSeconds(x1)

}
