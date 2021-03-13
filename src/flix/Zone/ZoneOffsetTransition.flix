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
            import java.time.zone.ZoneOffsetTransition.toString();
            let ZoneOffsetTransition(x1) = x;
            toString(x1) as & Pure
    }

    instance Eq[ZoneOffsetTransition] {
        pub def eq(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool = Time/Zone/ZoneOffsetTransition.equals(x, y)

        pub def neq(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool = not (x == y)
    }

    instance Hash[ZoneOffsetTransition] {
        pub def hash(x: ZoneOffsetTransition): Int = Time/Zone/ZoneOffsetTransition.hashCode(x)
    }

    instance Order[ZoneOffsetTransition] {
        pub def less(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool = Time/Zone/ZoneOffsetTransition.compareTo(x,y) < 0
        pub def lessEqual(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool = Time/Zone/ZoneOffsetTransition.compareTo(x,y) < 0 or x == y
        pub def greater(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool = Time/Zone/ZoneOffsetTransition.compareTo(x,y) > 0
        pub def greaterEqual(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool = Time/Zone/ZoneOffsetTransition.compareTo(x,y) > 0 or x == y
        pub def compare(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Comparison = match Time/Zone/ZoneOffsetTransition.compareTo(x,y) {
            case x if x < 0 => LessThan
            case x if x == 0 => EqualTo
            case _ => GreaterThan
        }
    }

}

namespace Time/Zone/ZoneOffsetTransition {

    use Time/Zone.ZoneOffsetTransition;
    use Time/Zone.ZoneOffsetTransition.{ZoneOffsetTransition};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};

    pub def new(x: {transition: LocalDateTime, before: ZoneOffset, after: ZoneOffset}): ZoneOffsetTransition =
        import java.time.zone.ZoneOffsetTransition:of(##java.time.LocalDateTime, ##java.time.ZoneOffset, ##java.time.ZoneOffset);
        let LocalDateTime(dt1) = x.transition;
        let ZoneOffset(b1) = x.before;
        let ZoneOffset(a1) = x.after;
        ZoneOffsetTransition(of(dt1, b1, a1)) as & Pure


    pub def equals(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.equals(##java.lang.Object);
        let ZoneOffsetTransition(x1) = x;
        let ZoneOffsetTransition(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: ZoneOffsetTransition): Int32 =
        import java.time.zone.ZoneOffsetTransition.hashCode();
        let ZoneOffsetTransition(x1) = x;
        hashCode(x1) as & Pure

    pub def compareTo(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Int32 =
        import java.time.zone.ZoneOffsetTransition.compareTo(##java.time.zone.ZoneOffsetTransition);
        let ZoneOffsetTransition(x1) = x;
        let ZoneOffsetTransition(y1) = y;
        compareTo(x1, y1) as & Pure

    pub def isGap(x: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.isGap();
        let ZoneOffsetTransition(x1) = x;
        isGap(x1) as & Pure

    pub def isOverlap(x: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.isOverlap();
        let ZoneOffsetTransition(x1) = x;
        isOverlap(x1) as & Pure

    pub def toEpochSecond(x: ZoneOffsetTransition): Int64 =
        import java.time.zone.ZoneOffsetTransition.toEpochSecond();
        let ZoneOffsetTransition(x1) = x;
        toEpochSecond(x1) as & Pure
}
