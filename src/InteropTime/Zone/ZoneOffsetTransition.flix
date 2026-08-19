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


pub mod InteropTime.Zone.ZoneOffsetTransition {

    use InteropTime.Internal.AdaptorExtras

    use InteropTime.ZoneOffset.ZoneOffset
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ

    import java.time.zone.{ZoneOffsetTransition => JZoneOffsetTransition }


    ///
    /// A wrapper around a Java ZoneOffsetTransition.
    ///
    pub enum ZoneOffsetTransition(JZoneOffsetTransition)

    instance ToString[ZoneOffsetTransition] {
        pub def toString(x: ZoneOffsetTransition): String =
            let ZoneOffsetTransition.ZoneOffsetTransition(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ZoneOffsetTransition] {
        pub def eq(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool =
            let ZoneOffsetTransition.ZoneOffsetTransition(x1) = x;
            let ZoneOffsetTransition.ZoneOffsetTransition(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[ZoneOffsetTransition] {
        pub def hash(x: ZoneOffsetTransition): Int32 =
            let ZoneOffsetTransition.ZoneOffsetTransition(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance Order[ZoneOffsetTransition] {
        pub def compare(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Comparison =
            let ZoneOffsetTransition.ZoneOffsetTransition(x1) = x;
            let ZoneOffsetTransition.ZoneOffsetTransition(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance ToJava[ZoneOffsetTransition] {
        type Out = JZoneOffsetTransition
        pub def toJava(x: ZoneOffsetTransition): JZoneOffsetTransition = 
            let ZoneOffsetTransition.ZoneOffsetTransition(x1) = x;
            x1
    }

    instance ToFlix[ZoneOffsetTransition] {
        type In = JZoneOffsetTransition
        pub def toFlix(x: JZoneOffsetTransition): ZoneOffsetTransition = 
            ZoneOffsetTransition.ZoneOffsetTransition(x)
    }


    /// Constructors

    pub def zoneOffsetTransition(transition: {transition = LocalDateTime}, before: {before = ZoneOffset}, after: {after = ZoneOffset}): ZoneOffsetTransition =
        AdaptorExtras.op3(
            before#before, 
            after#after, 
            transition#transition, 
            (before1, after1, transition1) -> unsafe IO { JZoneOffsetTransition.of(transition1, before1, after1)}
        )
    
    /// `to` functions

    pub def toEpochSecond(x: ZoneOffsetTransition): Int64 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.toEpochSecond() })


    /// ZoneOffsetTransition functions

    pub def getDateTimeBefore(x: ZoneOffsetTransition): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDateTimeBefore() })

    pub def getDateTimeAfter(x: ZoneOffsetTransition): LocalDateTime =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDateTimeAfter() })


    pub def getDuration(x: ZoneOffsetTransition): DurationZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDuration() })

    pub def getInstant(x: ZoneOffsetTransition): InstantZ =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getInstant() })

    pub def getOffsetBefore(x: ZoneOffsetTransition): ZoneOffset =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getOffsetBefore() })

    pub def getOffsetAfter(x: ZoneOffsetTransition): ZoneOffset =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getOffsetAfter() })
        

    /// predicates / comparisons

    pub def isGap(x: ZoneOffsetTransition): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isGap() })

    pub def isOverlap(x: ZoneOffsetTransition): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.isOverlap() })

    pub def isValidOffset(offset: ZoneOffset, x: ZoneOffsetTransition): Bool =
        AdaptorExtras.extract2(offset, x, (offset1, x1) -> 
            unsafe IO { x1.isValidOffset(offset1) }
        )



}
