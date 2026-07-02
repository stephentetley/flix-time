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
    import java.lang.{Exception => JException}

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


    instance ToJava[ZoneOffsetTransitionRule] {
        type Out = JZoneOffsetTransitionRule
        pub def toJava(x: ZoneOffsetTransitionRule): JZoneOffsetTransitionRule = 
            let ZoneOffsetTransitionRule.ZoneOffsetTransitionRule(x1) = x;
            x1
    }

    instance ToFlix[ZoneOffsetTransitionRule] {
        type In = JZoneOffsetTransitionRule
        pub def toFlix(x: JZoneOffsetTransitionRule): ZoneOffsetTransitionRule = ZoneOffsetTransitionRule.ZoneOffsetTransitionRule(x)
    }


    pub enum TimeDefinition with Eq, Order, ToString, Hash {
        case Standard
        case UTC
        case Wall
    }


    instance ToJava[TimeDefinition] {
        type Out = JTimeDefinition
        pub def toJava(x: TimeDefinition): JTimeDefinition = match x {
            case TimeDefinition.Standard    => unsafe IO { JTimeDefinition.STANDARD }
            case TimeDefinition.UTC         => unsafe IO { JTimeDefinition.UTC }
            case TimeDefinition.Wall        => unsafe IO { JTimeDefinition.WALL }
        }
    }

    instance ToFlix[TimeDefinition] {
        type In = JTimeDefinition
        pub def toFlix(x: JTimeDefinition): TimeDefinition = unsafe IO {
            if (x.equals(JTimeDefinition.STANDARD))         TimeDefinition.Standard
            else if (x.equals(JTimeDefinition.UTC))         TimeDefinition.UTC
            else if (x.equals(JTimeDefinition.WALL))        TimeDefinition.Wall
            else bug!("toFlix[TimeDefinition]")
        }
    }

    /// Constructors

    pub def zoneOffsetTransitionRule(month: {month = Month}, 
                                        dayOfMonthIndicator: {dayOfMonthIndicator = Int32}, 
                                        dayOfWeek: {dayOfWeek = DayOfWeek}, 
                                        time: {time = LocalTime},
                                        timeEndOfDay: {timeEndOfDay = Bool}, 
                                        timeDefinition: {timeDefinition = TimeDefinition},
                                        standardOffset: {standardOffset = ZoneOffset}, 
                                        offsetBefore: {offsetBefore = ZoneOffset},
                                        offsetAfter: {offsetAfter = ZoneOffset}): Result[String, ZoneOffsetTransitionRule] =
        try {
            let month1 = ToJava.toJava(month#month);
            let dayOfWeek1 = ToJava.toJava(dayOfWeek#dayOfWeek);
            let LocalTime(time1) = time#time;
            let ZoneOffset(standardOffset1) = standardOffset#standardOffset;
            let ZoneOffset(offsetBefore1) = offsetBefore#offsetBefore;
            let ZoneOffset(offsetAfter1) = offsetAfter#offsetAfter;
            ZoneOffsetTransitionRule(unsafe IO { JZoneOffsetTransitionRule.of(month1,
                                                    dayOfMonthIndicator#dayOfMonthIndicator,
                                                    dayOfWeek1,
                                                    time1,
                                                    timeEndOfDay#timeEndOfDay,
                                                    ToJava.toJava(timeDefinition#timeDefinition),
                                                    standardOffset1,
                                                    offsetBefore1,
                                                    offsetAfter1
                                                )}) |> Ok
        } catch {
            case e: JException => Err(e.getMessage())
        }

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
        ToFlix.toFlix(ans)

    pub def getDayOfMonthIndicator(x: ZoneOffsetTransitionRule): Int32  = 
        let ZoneOffsetTransitionRule(x1) = x;
        unsafe IO { x1.getDayOfMonthIndicator() }

    pub def getDayOfWeek(x: ZoneOffsetTransitionRule): DayOfWeek  = 
        let ZoneOffsetTransitionRule(x1) = x;
        let ans = unsafe IO { x1.getDayOfWeek() };
        ToFlix.toFlix(ans)


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
