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


mod Time.Zone {

    use Time.Zone.ZoneOffsetTransition
    use Time.Zone.ZoneOffsetTransition.{ZoneOffsetTransition}

    import java.time.zone.{ZoneOffsetTransition => JZoneOffsetTransition}
    import java.lang.{Object}

    ///
    /// A wrapper around a Java ZoneOffsetTransition.
    ///
    pub enum ZoneOffsetTransition(JZoneOffsetTransition)

    instance ToString[ZoneOffsetTransition] {
        pub def toString(x: ZoneOffsetTransition): String =
            let ZoneOffsetTransition(x1) = x;
            unsafe x1.toString()
    }

    instance Eq[ZoneOffsetTransition] {
        pub def eq(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Bool =
            let ZoneOffsetTransition(x1) = x;
            let ZoneOffsetTransition(y1) = y;
            unsafe x1.equals(y1)
    }

    instance Hash[ZoneOffsetTransition] {
        pub def hash(x: ZoneOffsetTransition): Int32 =
            let ZoneOffsetTransition(x1) = x;
            unsafe x1.hashCode()
    }

    instance Order[ZoneOffsetTransition] {
        pub def compare(x: ZoneOffsetTransition, y: ZoneOffsetTransition): Comparison =
            let ZoneOffsetTransition(x1) = x;
            let ZoneOffsetTransition(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
    }


}

mod Time.Zone.ZoneOffsetTransition {

    use Time.Zone.ZoneOffsetTransition
    use Time.Zone.ZoneOffsetTransition.{ZoneOffsetTransition}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    import java.time.zone.{ZoneOffsetTransition => JZoneOffsetTransition}
    
    /// Unwrap

    pub def getZoneOffsetTransition(x: ZoneOffsetTransition): JZoneOffsetTransition = 
        let ZoneOffsetTransition(x1) = x;
        x1


    /// Constructors

    pub def zoneOffsetTransition(r: {transition = LocalDateTime, before = ZoneOffset, after = ZoneOffset}): ZoneOffsetTransition =
        use Time.ZoneOffset.{getZoneOffset};
        ZoneOffsetTransition(unsafe JZoneOffsetTransition.of(Time.LocalDateTime.getLocalDateTime(r#transition), getZoneOffset(r#before), getZoneOffset(r#after)))
    
    /// `to` functions

    pub def toEpochSecond(x: ZoneOffsetTransition): Int64 =
        let ZoneOffsetTransition(x1) = x;
        unsafe x1.toEpochSecond()


    /// predicates / comparisons

    pub def isGap(x: ZoneOffsetTransition): Bool =
        let ZoneOffsetTransition(x1) = x;
        unsafe x1.isGap()

    pub def isOverlap(x: ZoneOffsetTransition): Bool =
        let ZoneOffsetTransition(x1) = x;
        unsafe x1.isOverlap()

    /// ZoneOffsetTransition functions

    pub def getDateTimeBefore(x: ZoneOffsetTransition): LocalDateTime =
        let ZoneOffsetTransition(x1) = x;
        let ans = unsafe x1.getDateTimeBefore();
        LocalDateTime(ans)

    pub def getDateTimeAfter(x: ZoneOffsetTransition): LocalDateTime =
        let ZoneOffsetTransition(x1) = x;
        let ans = unsafe x1.getDateTimeAfter();
        LocalDateTime(ans)


    pub def getOffsetBefore(x: ZoneOffsetTransition): ZoneOffset =
        let ZoneOffsetTransition(x1) = x;
        let ans = unsafe x1.getOffsetBefore();
        ZoneOffset(ans)

    pub def getOffsetAfter(x: ZoneOffsetTransition): ZoneOffset =
        let ZoneOffsetTransition(x1) = x;
        let ans = unsafe x1.getOffsetAfter();
        ZoneOffset(ans)

    pub def getDuration(x: ZoneOffsetTransition): DurationZ =
        let ZoneOffsetTransition(x1) = x;
        let ans = unsafe x1.getDuration();
        DurationZ(ans)

    pub def getInstant(x: ZoneOffsetTransition): InstantZ =
        let ZoneOffsetTransition(x1) = x;
        let ans = unsafe x1.getInstant();
        InstantZ(ans)

}
