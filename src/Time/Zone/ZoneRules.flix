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

    use Time.Zone.ZoneRules
    use Time.Zone.ZoneRules.{ZoneRules}

    import java.time.zone.{ZoneRules => JZoneRules}
    import java.lang.{Object}

    ///
    /// A wrapper around a Java ZoneRules.
    ///
    pub enum ZoneRules(JZoneRules)

    instance ToString[ZoneRules] {
        pub def toString(x: ZoneRules): String =
            let ZoneRules(x1) = x;
            unsafe x1.toString()
    }

    instance Eq[ZoneRules] {
        pub def eq(x: ZoneRules, y: ZoneRules): Bool = 
            let ZoneRules(x1) = x;
            let ZoneRules(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }

    instance Hash[ZoneRules] {
        pub def hash(x: ZoneRules): Int32 =
            let ZoneRules(x1) = x;
            unsafe x1.hashCode()
    }

}

mod Time.Zone.ZoneRules {

    use Time.Zone.ZoneRules
    use Time.Zone.ZoneRules.{ZoneRules}
    use Time.Zone.ZoneOffsetTransition
    use Time.Zone.ZoneOffsetTransition.{ZoneOffsetTransition}
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}
    use Time.InstantZ
    use Time.InstantZ.{InstantZ}
    use Time.LocalDateTime
    use Time.LocalDateTime.{LocalDateTime}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    import java.time.zone.{ZoneRules => JZoneRules}
    import java.time.zone.{ZoneOffsetTransition => JZoneOffsetTransition}
    import java.time.{ZoneOffset => JZoneOffset}
    
    /// Unwrap

    pub def getZoneRules(x: ZoneRules): JZoneRules = 
        let ZoneRules(x1) = x;
        x1
    

    /// Constructors

    pub def zoneRules(offset: ZoneOffset): ZoneRules =
        let ZoneOffset(x1) = offset;
        ZoneRules(unsafe JZoneRules.of(x1))

    /// ZoneRules functions

    pub def getOffset(inst: InstantZ, x: ZoneRules): ZoneOffset =
        let ZoneRules(x1) = x;
        let InstantZ(inst1) = inst;
        ZoneOffset(unsafe x1.getOffset(inst1))


    pub def getOffsetWithLocalDateTime(ldt: LocalDateTime, x: ZoneRules): ZoneOffset =
        let LocalDateTime(ldt1) = ldt;
        let ZoneRules(x1) = x;
        ZoneOffset(unsafe x1.getOffset(ldt1))


    pub def getStandardOffset(inst: InstantZ, x: ZoneRules): ZoneOffset =
        let ZoneRules(x1) = x;
        let InstantZ(inst1) = inst;
        ZoneOffset(unsafe x1.getStandardOffset(inst1))


    pub def getValidOffsets(ldt: LocalDateTime, x: ZoneRules): List[ZoneOffset] =
        let LocalDateTime(ldt1) = ldt;
        let ZoneRules(x1) = x;
        let xs = unsafe x1.getValidOffsets(ldt1);
        let xs1: List[JZoneOffset] = Adaptor.fromList(xs);
        List.map(z -> ZoneOffset(z), xs1)


    pub def getDaylightSavings(instant: InstantZ, x: ZoneRules): DurationZ =
        let ZoneRules(x1) = x;
        let InstantZ(instant1) = instant;
        DurationZ(unsafe x1.getDaylightSavings(instant1))

    pub def isDaylightSavings(instant: InstantZ, x: ZoneRules): Bool =
        let ZoneRules(x1) = x;
        let InstantZ(instant1) = instant;
        unsafe x1.isDaylightSavings(instant1)


    pub def isValidOffset(ldt: LocalDateTime, offset: ZoneOffset, x: ZoneRules): Bool =
        let ZoneRules(x1) = x;
        let LocalDateTime(ldt1) = ldt;
        let ZoneOffset(offset1) = offset;
        unsafe x1.isValidOffset(ldt1, offset1)


    pub def previousTransition(instant: InstantZ, x: ZoneRules): ZoneOffsetTransition =
        let ZoneRules(x1) = x;
        let InstantZ(instant1) = instant;
        ZoneOffsetTransition(unsafe x1.previousTransition(instant1))

    pub def getTransitions(x: ZoneRules): List[ZoneOffsetTransition] = 
        let ZoneRules(x1) = x;
        let xs = unsafe x1.getTransitions();
        let xs1: List[JZoneOffsetTransition] = Adaptor.fromList(xs);
        List.map(z -> ZoneOffsetTransition(z), xs1)

}
