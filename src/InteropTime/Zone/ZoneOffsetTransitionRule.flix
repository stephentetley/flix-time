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


pub mod InteropTime.Zone.ZoneOffsetTransitionRule {

    use InteropTime.Zone.ZoneOffsetTransitionRule.ZoneOffsetTransitionRule
    use InteropTime.Zone.ZoneOffsetTransitionRule.ZoneOffsetTransitionRule.{ZoneOffsetTransitionRule}

    use InteropTime.Zone.ZoneOffsetTransitionRule.TimeDefinition.{Standard, UTC, Wall}
    use InteropTime.Zone.ZoneOffsetTransition.ZoneOffsetTransition
    use InteropTime.Zone.ZoneOffsetTransition.ZoneOffsetTransition.{ZoneOffsetTransition}
    use InteropTime.DayOfWeek.DayOfWeek
    use InteropTime.Month.Month
    use InteropTime.LocalTime.LocalTime
    use InteropTime.LocalTime.LocalTime.{LocalTime}
    use InteropTime.ZoneOffset.ZoneOffset
    use InteropTime.ZoneOffset.ZoneOffset.{ZoneOffset}

    import java.time.zone.{ZoneOffsetTransitionRule => JZoneOffsetTransitionRule}
    import java.time.zone.{ZoneOffsetTransitionRule$TimeDefinition => JTimeDefinition}
    import java.lang.{Enum => JEnum}

    ///
    /// A wrapper around a Java ZoneOffsetTransitionRule.
    ///
    pub enum ZoneOffsetTransitionRule(JZoneOffsetTransitionRule)

    instance ToString[ZoneOffsetTransitionRule] {
        pub def toString(x: ZoneOffsetTransitionRule): String =
            let ZoneOffsetTransitionRule(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ZoneOffsetTransitionRule] {
        pub def eq(x: ZoneOffsetTransitionRule, y: ZoneOffsetTransitionRule): Bool =
            let ZoneOffsetTransitionRule(x1) = x;
            let ZoneOffsetTransitionRule(y1) = y;
            unsafe IO { x1.equals(y1) }

    }

    instance Hash[ZoneOffsetTransitionRule] {
        pub def hash(x: ZoneOffsetTransitionRule): Int32 =
            let ZoneOffsetTransitionRule(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    /// Unwrap

    pub def getZoneOffsetTransitionRule(x: ZoneOffsetTransitionRule): JZoneOffsetTransitionRule = 
        let ZoneOffsetTransitionRule(x1) = x;
        x1

    pub enum TimeDefinition with Eq, Order, ToString, Hash {
        case Standard
        case UTC
        case Wall
    }

    pub def marshalTimeDefinition(x: TimeDefinition): JTimeDefinition = 
        match x {
            case Standard           => unsafe IO { JTimeDefinition.STANDARD }
            case UTC                => unsafe IO { JTimeDefinition.UTC }
            case Wall               => unsafe IO { JTimeDefinition.WALL }
        }

    def primEqualsTimeDefinition(x: JTimeDefinition, y: JTimeDefinition): Bool =
        unsafe IO { x.equals(y) }

    pub def unmarshalTimeDefinition(x: JTimeDefinition): TimeDefinition = 
        match x {
            case x1 if primEqualsTimeDefinition(x1, unsafe IO { JTimeDefinition.STANDARD} )     => Standard 
            case x1 if primEqualsTimeDefinition(x1, unsafe IO { JTimeDefinition.UTC } )          => UTC 
            case x1 if primEqualsTimeDefinition(x1, unsafe IO { JTimeDefinition.WALL } )         => Wall 
            case _                                                      => bug!("unmarshalTimeDefinition")
        }


    /// Constructors

    pub def zoneOffsetTransitionRule(r: {month = Month, 
                                        dayOfMonthIndicator = Int32, 
                                        dayOfWeek = DayOfWeek, 
                                        time = LocalTime,
                                        timeEndOfDay = Bool, 
                                        timeDefinition = TimeDefinition,
                                        standardOffset = ZoneOffset, 
                                        offsetBefore = ZoneOffset,
                                        offsetAfter = ZoneOffset }): Result[String, ZoneOffsetTransitionRule] =
        Result.tryCatch(_ -> {
            let ZoneOffset(standardOffset1) = r#standardOffset;
            let ZoneOffset(offsetBefore1) = r#offsetBefore;
            let ZoneOffset(offsetAfter1) = r#offsetAfter;
            ZoneOffsetTransitionRule(unsafe IO { JZoneOffsetTransitionRule.of(InteropTime.Month.marshalMonth(r#month),
                                        r#dayOfMonthIndicator,
                                        InteropTime.DayOfWeek.marshalDayOfWeek(r#dayOfWeek),
                                        InteropTime.LocalTime.getLocalTime(r#time),
                                        r#timeEndOfDay,
                                        marshalTimeDefinition(r#timeDefinition),
                                        standardOffset1,
                                        offsetBefore1,
                                        offsetAfter1
                                        )})
        })

    /// predicates / comparisons
    
    pub def isMidnightEndOfDay(x: ZoneOffsetTransitionRule): Bool  = 
        let ZoneOffsetTransitionRule(x1) = x;
        unsafe IO { x1.isMidnightEndOfDay() }


    /// ZoneOffsetTransitionRule functions

    pub def createTransition(year: Int32, x: ZoneOffsetTransitionRule): ZoneOffsetTransition  = 
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.createTransition(year) };
        ZoneOffsetTransition(ans)


    pub def getTimeDefinition(x: ZoneOffsetTransitionRule): TimeDefinition =
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.getTimeDefinition() };
        unmarshalTimeDefinition(ans)

    pub def getDayOfMonthIndicator(x: ZoneOffsetTransitionRule): Int32  = 
        let ZoneOffsetTransitionRule(x1) = x;
        unsafe IO { x1.getDayOfMonthIndicator() }

    pub def getDayOfWeek(x: ZoneOffsetTransitionRule): DayOfWeek  = 
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.getDayOfWeek() };
        InteropTime.DayOfWeek.unmarshalDayOfWeek(ans)


    pub def getLocalTime(x: ZoneOffsetTransitionRule): LocalTime  = 
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.getLocalTime() };
        LocalTime(ans)


    pub def getStandardOffset(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.getStandardOffset() };
        ZoneOffset(ans)

    pub def getOffsetBefore(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.getOffsetBefore() };
        ZoneOffset(ans)


    pub def getOffsetAfter(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.getOffsetAfter() };
        ZoneOffset(ans)


}
