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


namespace Time/Zone {

    ///
    /// A wrapper around a Java ZoneOffsetTransitionRule.
    ///
    pub opaque type ZoneOffsetTransitionRule = ##java.time.zone.ZoneOffsetTransitionRule

    instance ToString[ZoneOffsetTransitionRule] {
        pub def toString(x: ZoneOffsetTransitionRule): String =
            import java.time.zone.ZoneOffsetTransitionRule.toString(): String & Pure;
            let ZoneOffsetTransitionRule(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneOffsetTransitionRule] {
        pub def eq(x: ZoneOffsetTransitionRule, y: ZoneOffsetTransitionRule): Bool = Time/Zone/ZoneOffsetTransitionRule.equals(x, y)
    }

    instance Hash[ZoneOffsetTransitionRule] {
        pub def hash(x: ZoneOffsetTransitionRule): Int32 = Time/Zone/ZoneOffsetTransitionRule.hashCode(x)
    }



}

namespace Time/Zone/ZoneOffsetTransitionRule {

    use Time/Zone.ZoneOffsetTransitionRule;
    use Time/Zone.ZoneOffsetTransitionRule.{ZoneOffsetTransitionRule};
    use Time/Zone.ZoneOffsetTransition;
    use Time/Zone.ZoneOffsetTransition.{ZoneOffsetTransition};
    use Time.DayOfWeek;
    use Time.Month;
    use Time.LocalTime;
    use Time.LocalTime.{LocalTime};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    

    pub def getZoneOffsetTransitionRule(x: ZoneOffsetTransitionRule): ##java.time.zone.ZoneOffsetTransitionRule = 
        let ZoneOffsetTransitionRule(x1) = x;
        x1

    pub enum TimeDefinition with Eq, Order, ToString, Hash, Boxable {
        case Standard
        case UTC
        case Wall
    }

    pub def marshalTimeDefinition(x: TimeDefinition): ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition = 
        import static get java.time.zone.ZoneOffsetTransitionRule$TimeDefinition.STANDARD: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition & Pure as get_STANDARD;
        import static get java.time.zone.ZoneOffsetTransitionRule$TimeDefinition.UTC: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition & Pure as get_UTC;
        import static get java.time.zone.ZoneOffsetTransitionRule$TimeDefinition.WALL: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition & Pure as get_WALL;
        match x {
            case Standard           => get_STANDARD()
            case UTC                => get_UTC()
            case Wall               => get_WALL()
        }

    def primEqualsTimeDefinition(x: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition, y: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshalTimeDefinition(x: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition): TimeDefinition = 
        import static get java.time.zone.ZoneOffsetTransitionRule$TimeDefinition.STANDARD: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition & Pure as get_STANDARD;
        import static get java.time.zone.ZoneOffsetTransitionRule$TimeDefinition.UTC: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition & Pure as get_UTC;
        import static get java.time.zone.ZoneOffsetTransitionRule$TimeDefinition.WALL: ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition & Pure as get_WALL;
        match x {
            case x1 if primEqualsTimeDefinition(x1, get_STANDARD())           => Standard
            case x1 if primEqualsTimeDefinition(x1, get_UTC())                => UTC
            case x1 if primEqualsTimeDefinition(x1, get_WALL())               => Wall
        }




    pub def zoneOffsetTransitionRule(r: {month :: Month, 
                                        dayOfMonthIndicator :: Int32, 
                                        dayOfWeek :: DayOfWeek, 
                                        time :: LocalTime,
                                        timeEndOfDay :: Bool, 
                                        timeDefinition :: TimeDefinition,
                                        standardOffset :: ZoneOffset, 
                                        offsetBefore :: ZoneOffset,
                                        offsetAfter :: ZoneOffset}): Result[ZoneOffsetTransitionRule, String] =
        import static java.time.zone.ZoneOffsetTransitionRule.of(##java.time.Month, 
                                                                    Int32,
                                                                    ##java.time.DayOfWeek,
                                                                    ##java.time.LocalTime,
                                                                    Bool,
                                                                    ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition,
                                                                    ##java.time.ZoneOffset,
                                                                    ##java.time.ZoneOffset,
                                                                    ##java.time.ZoneOffset
                                                                    ): ##java.time.zone.ZoneOffsetTransitionRule & Pure;
        try {
            ZoneOffsetTransitionRule(of(Time/Month.marshal(r.month), 
                                        r.dayOfMonthIndicator,
                                        Time/DayOfWeek.marshal(r.dayOfWeek),
                                        Time/LocalTime.getLocalTime(r.time),
                                        r.timeEndOfDay,
                                        marshalTimeDefinition(r.timeDefinition),
                                        Time/ZoneOffset.getZoneOffset(r.standardOffset),
                                        Time/ZoneOffset.getZoneOffset(r.offsetBefore),
                                        Time/ZoneOffset.getZoneOffset(r.offsetAfter)
                                        )) |> Ok
        } catch {
            case ex: ##java.lang.Exception => Err(FlixSandbox/Marshal.unmarshalExceptionMessage(ex)) as & Pure
        }

    pub def equals(x: ZoneOffsetTransitionRule, y: ZoneOffsetTransitionRule): Bool =
        import java.time.zone.ZoneOffsetTransitionRule.equals(##java.lang.Object): Bool & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        let ZoneOffsetTransitionRule(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZoneOffsetTransitionRule): Int32 =
        import java.time.zone.ZoneOffsetTransitionRule.hashCode(): Int32 & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        hashCode(x1)


    pub def getTimeDefinition(x: ZoneOffsetTransitionRule): TimeDefinition =
        import java.time.zone.ZoneOffsetTransitionRule.getTimeDefinition(): ##java.time.zone.ZoneOffsetTransitionRule$TimeDefinition & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        getTimeDefinition(x1) |> unmarshalTimeDefinition

    pub def getDayOfMonthIndicator(x: ZoneOffsetTransitionRule): Int32  = 
        import java.time.zone.ZoneOffsetTransitionRule.getDayOfMonthIndicator(): Int32 & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        getDayOfMonthIndicator(x1)

    pub def getDayOfWeek(x: ZoneOffsetTransitionRule): DayOfWeek  = 
        import java.time.zone.ZoneOffsetTransitionRule.getDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        getDayOfWeek(x1) |> Time/DayOfWeek.unmarshal


    pub def getLocalTime(x: ZoneOffsetTransitionRule): LocalTime  = 
        import java.time.zone.ZoneOffsetTransitionRule.getLocalTime(): ##java.time.LocalTime & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        LocalTime(getLocalTime(x1))

    pub def isMidnightEndOfDay(x: ZoneOffsetTransitionRule): Bool  = 
        import java.time.zone.ZoneOffsetTransitionRule.isMidnightEndOfDay(): Bool & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        isMidnightEndOfDay(x1)

    pub def getStandardOffset(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        import java.time.zone.ZoneOffsetTransitionRule.getStandardOffset(): ##java.time.ZoneOffset & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffset(getStandardOffset(x1))

    pub def getOffsetBefore(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        import java.time.zone.ZoneOffsetTransitionRule.getOffsetBefore(): ##java.time.ZoneOffset & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffset(getOffsetBefore(x1))


    pub def getOffsetAfter(x: ZoneOffsetTransitionRule): ZoneOffset  = 
        import java.time.zone.ZoneOffsetTransitionRule.getOffsetAfter(): ##java.time.ZoneOffset & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffset(getOffsetAfter(x1))

    pub def createTransition(year: Int32, x: ZoneOffsetTransitionRule): ZoneOffsetTransition  = 
        import java.time.zone.ZoneOffsetTransitionRule.createTransition(Int32): ##java.time.zone.ZoneOffsetTransition & Pure;
        let ZoneOffsetTransitionRule(x1) = x;
        ZoneOffsetTransition(createTransition(x1, year))

}
