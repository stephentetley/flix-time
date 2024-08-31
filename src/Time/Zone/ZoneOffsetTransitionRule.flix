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


mod Time.Zone {

    use Time.Zone.ZoneOffsetTransitionRule
    use Time.Zone.ZoneOffsetTransitionRule.{ZoneOffsetTransitionRule}

    import java.time.zone.{ZoneOffsetTransitionRule => JZoneOffsetTransitionRule}
    import java.lang.{Object}

    ///
    /// A wrapper around a Java ZoneOffsetTransitionRule.
    ///
    pub enum ZoneOffsetTransitionRule(JZoneOffsetTransitionRule)

    instance ToString[ZoneOffsetTransitionRule] {
        pub def toString(x: ZoneOffsetTransitionRule): String =
            let ZoneOffsetTransitionRule(x1) = x;
            unsafe x1.toString()
    }

    instance Eq[ZoneOffsetTransitionRule] {
        pub def eq(x: ZoneOffsetTransitionRule, y: ZoneOffsetTransitionRule): Bool = 
            let ZoneOffsetTransitionRule(x1) = x;
            let ZoneOffsetTransitionRule(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)

    }

    instance Hash[ZoneOffsetTransitionRule] {
        pub def hash(x: ZoneOffsetTransitionRule): Int32 = 
            let ZoneOffsetTransitionRule(x1) = x;
            unsafe x1.hashCode()
    }

}

mod Time.Zone.ZoneOffsetTransitionRule {

    use Time.Zone.ZoneOffsetTransitionRule
    use Time.Zone.ZoneOffsetTransitionRule.{ZoneOffsetTransitionRule}
    use Time.Zone.ZoneOffsetTransitionRule.TimeDefinition.{Standard, UTC, Wall}
    use Time.Zone.ZoneOffsetTransition
    use Time.Zone.ZoneOffsetTransition.{ZoneOffsetTransition}
    use Time.DayOfWeek
    use Time.Month
    use Time.LocalTime
    use Time.LocalTime.{LocalTime}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    import java.time.zone.{ZoneOffsetTransitionRule => JZoneOffsetTransitionRule}
    import java.time.zone.{ZoneOffsetTransitionRule$TimeDefinition => JTimeDefinition}
    import java.lang.{Enum => JEnum}
    
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
            case Standard           => unsafe JTimeDefinition.STANDARD
            case UTC                => unsafe JTimeDefinition.UTC
            case Wall               => unsafe JTimeDefinition.WALL
        }

    def primEqualsTimeDefinition(x: JTimeDefinition, y: JTimeDefinition): Bool =
        let x1 = (checked_cast(x) : JEnum);
        let y1 = (checked_cast(y) : JEnum);
        unsafe x1.equals(y1)

    pub def unmarshalTimeDefinition(x: JTimeDefinition): TimeDefinition = 
        match x {
            case x1 if primEqualsTimeDefinition(x1, unsafe JTimeDefinition.STANDARD)     => Standard
            case x1 if primEqualsTimeDefinition(x1, unsafe JTimeDefinition.UTC)          => UTC
            case x1 if primEqualsTimeDefinition(x1, unsafe JTimeDefinition.WALL)         => Wall
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
                                        offsetAfter = ZoneOffset}): Result[String, ZoneOffsetTransitionRule] =
        Result.tryCatch(_ -> {
            ZoneOffsetTransitionRule(unsafe JZoneOffsetTransitionRule.of(Time.Month.marshalMonth(r#month), 
                                        r#dayOfMonthIndicator,
                                        Time.DayOfWeek.marshalDayOfWeek(r#dayOfWeek),
                                        Time.LocalTime.getLocalTime(r#time),
                                        r#timeEndOfDay,
                                        marshalTimeDefinition(r#timeDefinition),
                                        Time.ZoneOffset.getZoneOffset(r#standardOffset),
                                        Time.ZoneOffset.getZoneOffset(r#offsetBefore),
                                        Time.ZoneOffset.getZoneOffset(r#offsetAfter)
                                        ))
        })

    /// predicates / comparisons
    
    pub def isMidnightEndOfDay(x: ZoneOffsetTransitionRule): Bool  = 
        let ZoneOffsetTransitionRule(x1) = x;
        unsafe x1.isMidnightEndOfDay()


    /// ZoneOffsetTransitionRule functions

    pub def createTransition(year: Int32, x: ZoneOffsetTransitionRule): ZoneOffsetTransition  = 
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffsetTransition(unsafe x1.createTransition(year))


    pub def getTimeDefinition(x: ZoneOffsetTransitionRule): TimeDefinition =
        let ZoneOffsetTransitionRule(x1) = x;
        unsafe x1.getTimeDefinition() |> unmarshalTimeDefinition

    pub def getDayOfMonthIndicator(x: ZoneOffsetTransitionRule): Int32  = 
        let ZoneOffsetTransitionRule(x1) = x;
        unsafe x1.getDayOfMonthIndicator()

    pub def getDayOfWeek(x: ZoneOffsetTransitionRule): DayOfWeek  = 
        let ZoneOffsetTransitionRule(x1) = x;
        unsafe x1.getDayOfWeek() |> Time.DayOfWeek.unmarshalDayOfWeek


    pub def getLocalTime(x: ZoneOffsetTransitionRule): LocalTime  = 
        let ZoneOffsetTransitionRule(x1) = x;
        LocalTime(unsafe x1.getLocalTime())


    pub def getStandardOffset(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffset(unsafe x1.getStandardOffset())

    pub def getOffsetBefore(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffset(unsafe x1.getOffsetBefore())


    pub def getOffsetAfter(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffset(unsafe x1.getOffsetAfter())


}
