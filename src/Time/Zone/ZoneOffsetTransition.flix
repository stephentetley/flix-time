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


namespace Time/Zone {

    ///
    /// A wrapper around a Java ZoneOffsetTransition.
    ///
    pub opaque type ZoneOffsetTransition = ##java.time.zone.ZoneOffsetTransition

    instance ToString[ZoneOffsetTransition] {
        pub def toString(x: ZoneOffsetTransition): String =
            import java.time.zone.ZoneOffsetTransition.toString(): String & Pure;
            let ZoneOffsetTransition(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneOffsetTransition] {
        pub def eq(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool = Time/Zone/ZoneOffsetTransition.equals(x, y)
    }

    instance Hash[ZoneOffsetTransition] {
        pub def hash(x: ZoneOffsetTransition): Int32 = Time/Zone/ZoneOffsetTransition.hashCode(x)
    }

    instance Order[ZoneOffsetTransition] {
        pub def compare(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Comparison =
            Time/Zone/ZoneOffsetTransition.compareTo(x,y) |> Comparison.fromInt32
    }

}

namespace Time/Zone/ZoneOffsetTransition {

    use Time/Zone.ZoneOffsetTransition;
    use Time/Zone.ZoneOffsetTransition.{ZoneOffsetTransition};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};

    /// ## Unwrap

    pub def getZoneOffsetTransition(x: ZoneOffsetTransition): ##java.time.zone.ZoneOffsetTransition = 
        let ZoneOffsetTransition(x1) = x;
        x1

    /// ## Constructors

    pub def zoneOffsetTransition(r: {transition :: LocalDateTime, before :: ZoneOffset, after :: ZoneOffset}): ZoneOffsetTransition =
        import static java.time.zone.ZoneOffsetTransition.of(##java.time.LocalDateTime, ##java.time.ZoneOffset, ##java.time.ZoneOffset): ##java.time.zone.ZoneOffsetTransition & Pure;
        use Time/ZoneOffset.{getZoneOffset};
        ZoneOffsetTransition(of(Time/LocalDateTime.getLocalDateTime(r.transition), getZoneOffset(r.before), getZoneOffset(r.after)))
    
    /// ## `to` functions

    pub def toEpochSecond(x: ZoneOffsetTransition): Int64 =
        import java.time.zone.ZoneOffsetTransition.toEpochSecond(): Int64 & Pure;
        let ZoneOffsetTransition(x1) = x;
        toEpochSecond(x1)


    pub def equals(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.equals(##java.lang.Object): Bool & Pure;
        let ZoneOffsetTransition(x1) = x;
        let ZoneOffsetTransition(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZoneOffsetTransition): Int32 =
        import java.time.zone.ZoneOffsetTransition.hashCode(): Int32 & Pure;
        let ZoneOffsetTransition(x1) = x;
        hashCode(x1)

    pub def compareTo(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Int32 =
        import java.time.zone.ZoneOffsetTransition.compareTo(##java.time.zone.ZoneOffsetTransition): Int32 & Pure;
        let ZoneOffsetTransition(x1) = x;
        let ZoneOffsetTransition(y1) = y;
        compareTo(x1, y1)

    pub def isGap(x: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.isGap(): Bool & Pure;
        let ZoneOffsetTransition(x1) = x;
        isGap(x1)

    pub def isOverlap(x: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.isOverlap(): Bool & Pure;
        let ZoneOffsetTransition(x1) = x;
        isOverlap(x1)


}
