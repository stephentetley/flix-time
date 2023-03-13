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
    pub enum ZoneOffsetTransition(##java.time.zone.ZoneOffsetTransition)

    instance ToString[ZoneOffsetTransition] {
        pub def toString(x: ZoneOffsetTransition): String =
            import java.time.zone.ZoneOffsetTransition.toString(): String \ {};
            let ZoneOffsetTransition(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneOffsetTransition] {
        pub def eq(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool =
            import java.time.zone.ZoneOffsetTransition.equals(##java.lang.Object): Bool \ {};
            let ZoneOffsetTransition(x1) = x;
            let ZoneOffsetTransition(y1) = y;
            equals(x1, checked_cast(y1))
    }

    instance Hash[ZoneOffsetTransition] {
        pub def hash(x: ZoneOffsetTransition): Int32 =
            import java.time.zone.ZoneOffsetTransition.hashCode(): Int32 \ {};
            let ZoneOffsetTransition(x1) = x;
            hashCode(x1)
    }

    instance Order[ZoneOffsetTransition] {
        pub def compare(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Comparison =
            import java.time.zone.ZoneOffsetTransition.compareTo(##java.time.zone.ZoneOffsetTransition): Int32 \ {};
            let ZoneOffsetTransition(x1) = x;
            let ZoneOffsetTransition(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }
        
    instance Boxable[ZoneOffsetTransition]

    instance Interop/Flix.Marshal[ZoneOffsetTransition] {
        pub def toJavaObject(x: ZoneOffsetTransition): ##java.lang.Object =
            let ZoneOffsetTransition(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): ZoneOffsetTransition = 
            ZoneOffsetTransition(unchecked_cast(o as ##java.time.zone.ZoneOffsetTransition))
    }

}

namespace Time/Zone/ZoneOffsetTransition {

    use Time/Zone.ZoneOffsetTransition;
    use Time/Zone.ZoneOffsetTransition.{ZoneOffsetTransition};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.DurationZ;
    use Time.DurationZ.{DurationZ};
    use Time.InstantZ;
    use Time.InstantZ.{InstantZ};

    /// ## Unwrap

    pub def getZoneOffsetTransition(x: ZoneOffsetTransition): ##java.time.zone.ZoneOffsetTransition = 
        let ZoneOffsetTransition(x1) = x;
        x1

    /// ## Constructors

    pub def zoneOffsetTransition(r: {transition = LocalDateTime, before = ZoneOffset, after = ZoneOffset}): ZoneOffsetTransition =
        import static java.time.zone.ZoneOffsetTransition.of(##java.time.LocalDateTime, ##java.time.ZoneOffset, ##java.time.ZoneOffset): ##java.time.zone.ZoneOffsetTransition \ {};
        use Time/ZoneOffset.{getZoneOffset};
        ZoneOffsetTransition(of(Time/LocalDateTime.getLocalDateTime(r.transition), getZoneOffset(r.before), getZoneOffset(r.after)))
    
    /// ## `to` functions

    pub def toEpochSecond(x: ZoneOffsetTransition): Int64 =
        import java.time.zone.ZoneOffsetTransition.toEpochSecond(): Int64 \ {};
        let ZoneOffsetTransition(x1) = x;
        toEpochSecond(x1)


    /// ## predicates / comparisons

    pub def isGap(x: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.isGap(): Bool \ {};
        let ZoneOffsetTransition(x1) = x;
        isGap(x1)

    pub def isOverlap(x: ZoneOffsetTransition): Bool =
        import java.time.zone.ZoneOffsetTransition.isOverlap(): Bool \ {};
        let ZoneOffsetTransition(x1) = x;
        isOverlap(x1)

    /// ## ZoneOffsetTransition functions

    pub def getDateTimeBefore(x: ZoneOffsetTransition): LocalDateTime =
        import java.time.zone.ZoneOffsetTransition.getDateTimeBefore(): ##java.time.LocalDateTime \ {};
        let ZoneOffsetTransition(x1) = x;
        LocalDateTime(getDateTimeBefore(x1))

    pub def getDateTimeAfter(x: ZoneOffsetTransition): LocalDateTime =
        import java.time.zone.ZoneOffsetTransition.getDateTimeAfter(): ##java.time.LocalDateTime \ {};
        let ZoneOffsetTransition(x1) = x;
        LocalDateTime(getDateTimeAfter(x1))


    pub def getOffsetBefore(x: ZoneOffsetTransition): ZoneOffset =
        import java.time.zone.ZoneOffsetTransition.getOffsetBefore(): ##java.time.ZoneOffset \ {};
        let ZoneOffsetTransition(x1) = x;
        ZoneOffset(getOffsetBefore(x1))

    pub def getOffsetAfter(x: ZoneOffsetTransition): ZoneOffset =
        import java.time.zone.ZoneOffsetTransition.getOffsetAfter(): ##java.time.ZoneOffset \ {};
        let ZoneOffsetTransition(x1) = x;
        ZoneOffset(getOffsetAfter(x1))

    pub def getDuration(x: ZoneOffsetTransition): DurationZ =
        import java.time.zone.ZoneOffsetTransition.getDuration(): ##java.time.Duration \ {};
        let ZoneOffsetTransition(x1) = x;
        DurationZ(getDuration(x1))

    pub def getInstant(x: ZoneOffsetTransition): InstantZ =
        import java.time.zone.ZoneOffsetTransition.getInstant(): ##java.time.Instant \ {};
        let ZoneOffsetTransition(x1) = x;
        InstantZ(getInstant(x1))

}
