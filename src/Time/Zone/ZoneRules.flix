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
    /// A wrapper around a Java ZoneRules.
    ///
    pub enum ZoneRules(##java.time.zone.ZoneRules)

    instance ToString[ZoneRules] {
        pub def toString(x: ZoneRules): String =
            import java.time.zone.ZoneRules.toString(): String \ {};
            let ZoneRules(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneRules] {
        pub def eq(x: ZoneRules, y: ZoneRules): Bool = 
            import java.time.zone.ZoneRules.equals(##java.lang.Object): Bool \ {};
            let ZoneRules(x1) = x;
            let ZoneRules(y1) = y;
            equals(x1, y1 as ##java.lang.Object)
    }

    instance Hash[ZoneRules] {
        pub def hash(x: ZoneRules): Int32 =
            import java.time.zone.ZoneRules.hashCode(): Int32 \ {};
            let ZoneRules(x1) = x;
            hashCode(x1)

    }

    instance Interop/Flix.Marshal[ZoneRules] {
        pub def toJavaObject(x: ZoneRules): ##java.lang.Object =
            let ZoneRules(x1) = x;
            x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): ZoneRules = 
            ZoneRules(o as ##java.time.zone.ZoneRules)
    }

}

namespace Time/Zone/ZoneRules {

    use Time/Zone.ZoneRules;
    use Time/Zone.ZoneRules.{ZoneRules};
    use Time/Zone.ZoneOffsetTransition;
    use Time/Zone.ZoneOffsetTransition.{ZoneOffsetTransition};
    use Time.DurationZ;
    use Time.DurationZ.{DurationZ};
    use Time.InstantZ;
    use Time.InstantZ.{InstantZ};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    /// ## Unwrap

    pub def getZoneRules(x: ZoneRules): ##java.time.zone.ZoneRules = 
        let ZoneRules(x1) = x;
        x1
    
    /// ## Constructors

    pub def zoneRules(offset: ZoneOffset): ZoneRules =
        import static java.time.zone.ZoneRules.of(##java.time.ZoneOffset): ##java.time.zone.ZoneRules \ {};
        let ZoneOffset(x1) = offset;
        ZoneRules(of(x1))

    /// ## ZoneRules functions

    pub def getOffset(inst: InstantZ, x: ZoneRules): ZoneOffset =
        import java.time.zone.ZoneRules.getOffset(##java.time.Instant): ##java.time.ZoneOffset \ {};
        let ZoneRules(x1) = x;
        let InstantZ(inst1) = inst;
        ZoneOffset(getOffset(x1, inst1))


    pub def getOffsetWithLocalDateTime(ldt: LocalDateTime, x: ZoneRules): ZoneOffset =
        import java.time.zone.ZoneRules.getOffset(##java.time.LocalDateTime): ##java.time.ZoneOffset \ {};
        let LocalDateTime(ldt1) = ldt;
        let ZoneRules(x1) = x;
        ZoneOffset(getOffset(x1, ldt1))


    pub def getStandardOffset(inst: InstantZ, x: ZoneRules): ZoneOffset =
        import java.time.zone.ZoneRules.getStandardOffset(##java.time.Instant): ##java.time.ZoneOffset \ {};
        let ZoneRules(x1) = x;
        let InstantZ(inst1) = inst;
        ZoneOffset(getStandardOffset(x1, inst1))


    pub def getValidOffsets(ldt: LocalDateTime, x: ZoneRules): List[ZoneOffset] =
        region r {
            import java.time.zone.ZoneRules.getValidOffsets(##java.time.LocalDateTime): ##java.util.List \ {};
            let LocalDateTime(ldt1) = ldt;
            let ZoneRules(x1) = x;
            getValidOffsets(x1, ldt1) |> Interop/Util/ListZ.wrapHH(r) |> Interop/Util/ListZ.toFlixList
        }

    pub def getDaylightSavings(instant: InstantZ, x: ZoneRules): DurationZ =
        import java.time.zone.ZoneRules.getDaylightSavings(##java.time.Instant): ##java.time.Duration \ {};
        let ZoneRules(x1) = x;
        let InstantZ(instant1) = instant;
        DurationZ(getDaylightSavings(x1, instant1))

    pub def isDaylightSavings(instant: InstantZ, x: ZoneRules): Bool =
        import java.time.zone.ZoneRules.isDaylightSavings(##java.time.Instant): Bool \ {};
        let ZoneRules(x1) = x;
        let InstantZ(instant1) = instant;
        isDaylightSavings(x1, instant1)


    pub def isValidOffset(ldt: LocalDateTime, offset: ZoneOffset, x: ZoneRules): Bool =
        import java.time.zone.ZoneRules.isValidOffset(##java.time.LocalDateTime, ##java.time.ZoneOffset): Bool \ {};
        let ZoneRules(x1) = x;
        let LocalDateTime(ldt1) = ldt;
        let ZoneOffset(offset1) = offset;
        isValidOffset(x1, ldt1, offset1)


    pub def previousTransition(instant: InstantZ, x: ZoneRules): ZoneOffsetTransition =
        import java.time.zone.ZoneRules.previousTransition(##java.time.Instant): ##java.time.zone.ZoneOffsetTransition \ {};
        let ZoneRules(x1) = x;
        let InstantZ(instant1) = instant;
        ZoneOffsetTransition(previousTransition(x1, instant1))

    pub def getTransitions(x: ZoneRules): List[ZoneOffsetTransition] =
        region r { 
            import java.time.zone.ZoneRules.getTransitions(): ##java.util.List \ {};
            let ZoneRules(x1) = x;
            getTransitions(x1) |> Interop/Util/ListZ.wrapHH(r) |> Interop/Util/ListZ.toFlixList
        }

}
