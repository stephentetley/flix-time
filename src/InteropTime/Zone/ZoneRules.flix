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

pub mod InteropTime.Zone.ZoneRules {

    use JavaInterop.AdaptorExtras

    use InteropTime.Zone.ZoneOffsetTransition.ZoneOffsetTransition
    use InteropTime.DurationZ.DurationZ
    use InteropTime.InstantZ.InstantZ
    use InteropTime.LocalDateTime.LocalDateTime
    use InteropTime.ZoneOffset.ZoneOffset

    import java.time.zone.{ZoneRules => JZoneRules}
    import java.time.zone.{ZoneOffsetTransition => JZoneOffsetTransition}
    import java.time.{ZoneOffset => JZoneOffset}


    ///
    /// A wrapper around a Java ZoneRules.
    ///
    pub enum ZoneRules(JZoneRules)

    instance ToString[ZoneRules] {
        pub def toString(x: ZoneRules): String =
            let ZoneRules.ZoneRules(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ZoneRules] {
        pub def eq(x: ZoneRules, y: ZoneRules): Bool =
            let ZoneRules.ZoneRules(x1) = x;
            let ZoneRules.ZoneRules(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[ZoneRules] {
        pub def hash(x: ZoneRules): Int32 =
            let ZoneRules.ZoneRules(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    
    instance ToJava[ZoneRules] {
        type Out = JZoneRules
        pub def toJava(x: ZoneRules): JZoneRules = 
            let ZoneRules.ZoneRules(x1) = x;
            x1
    }

    instance ToFlix[ZoneRules] {
        type In = JZoneRules
        pub def toFlix(x: JZoneRules): ZoneRules = 
            ZoneRules.ZoneRules(x)
    }


    /// Constructors

    pub def zoneRules(offset: ZoneOffset): ZoneRules =
        AdaptorExtras.op(offset, offset1 -> unsafe IO { JZoneRules.of(offset1) })

    /// ZoneRules functions

    pub def getOffset(inst: InstantZ, x: ZoneRules): ZoneOffset =
        AdaptorExtras.op2(inst, x, (inst1, x1) ->  unsafe IO { x1.getOffset(inst1) })


    pub def getOffsetWithLocalDateTime(ldt: LocalDateTime, x: ZoneRules): ZoneOffset =
        AdaptorExtras.op2(ldt, x, (ldt1, x1) -> unsafe IO { x1.getOffset(ldt1) })


    pub def getStandardOffset(inst: InstantZ, x: ZoneRules): ZoneOffset =
        AdaptorExtras.op2(inst, x, (inst1, x1) -> unsafe IO { x1.getStandardOffset(inst1) })


    pub def getValidOffsets(ldt: LocalDateTime, x: ZoneRules): List[ZoneOffset] =
        AdaptorExtras.extract2(ldt, x, (ldt1, x1) -> {
            let jlist = unsafe IO { x1.getValidOffsets(ldt1) };
            let xs: List[JZoneOffset] = Adaptor.fromList(jlist);
            List.map(z -> ToFlix.toFlix(z), xs)
        })


    pub def getDaylightSavings(inst: InstantZ, x: ZoneRules): DurationZ =
        AdaptorExtras.op2(inst, x, (inst1, x1) -> unsafe IO { x1.getDaylightSavings(inst1) })

    pub def isDaylightSavings(inst: InstantZ, x: ZoneRules): Bool =
        AdaptorExtras.extract2(inst, x, (inst1, x1) -> unsafe IO { x1.isDaylightSavings(inst1) })


    pub def isValidOffset(ldt: LocalDateTime, offset: ZoneOffset, x: ZoneRules): Bool =
        AdaptorExtras.extract3(ldt, offset, x, (ldt1, offset1, x1) -> 
            unsafe IO { x1.isValidOffset(ldt1, offset1) }
        )


    pub def previousTransition(inst: InstantZ, x: ZoneRules): ZoneOffsetTransition =
        AdaptorExtras.op2(inst, x, (inst1, x1) -> unsafe IO { x1.previousTransition(inst1) })

    pub def getTransitions(x: ZoneRules): List[ZoneOffsetTransition] = 
        AdaptorExtras.extract(x, x1 -> {
            let xs = unsafe IO { x1.getTransitions() };
            let xs1: List[JZoneOffsetTransition] = Adaptor.fromList(xs);
            List.map(z -> ZoneOffsetTransition(z), xs1)
        })

}
