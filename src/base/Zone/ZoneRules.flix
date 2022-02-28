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
    pub opaque type ZoneRules = ##java.time.zone.ZoneRules

    instance ToString[ZoneRules] {
        pub def toString(x: ZoneRules): String =
            import java.time.zone.ZoneRules.toString(): String & Pure;
            let ZoneRules(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneRules] {
        pub def eq(x: ZoneRules, y: ZoneRules): Bool = Time/Zone/ZoneRules.equals(x, y)
    }

    instance Hash[ZoneRules] {
        pub def hash(x: ZoneRules): Int32 = Time/Zone/ZoneRules.hashCode(x)
    }

}

namespace Time/Zone/ZoneRules {

    use Time/Zone.ZoneRules;
    use Time/Zone.ZoneRules.{ZoneRules};
    use Time/Zone.ZoneOffsetTransition;
    use Time/Zone.ZoneOffsetTransition.{ZoneOffsetTransition};
//    use Time.Duration;
//    use Time.Duration.{Duration};
//    use Time.Instant;
//    use Time.Instant.{Instant};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(offset: ZoneOffset): ZoneRules =
        import static java.time.zone.ZoneRules.of(##java.time.ZoneOffset): ##java.time.zone.ZoneRules & Pure;
        let ZoneOffset(x1) = offset;
        ZoneRules(of(x1))

    pub def equals(x: ZoneRules, y: ZoneRules): Bool =
        import java.time.zone.ZoneRules.equals(##java.lang.Object): Bool & Pure;
        let ZoneRules(x1) = x;
        let ZoneRules(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZoneRules): Int32 =
        import java.time.zone.ZoneRules.hashCode(): Int32 & Pure;
        let ZoneRules(x1) = x;
        hashCode(x1) as & Pure

/*
    pub def getDaylightSavings(x: ZoneRules, instant: Instant): Duration =
        import java.time.zone.ZoneRules.getDaylightSavings(##java.time.Instant): ...;
        let ZoneRules(x1) = x;
        let Instant(instant1) = instant;
        Duration(getDaylightSavings(x1, instant1))

    pub def isDaylightSavings(x: ZoneRules, instant: Instant): Bool =
        import java.time.zone.ZoneRules.isDaylightSavings(##java.time.Instant): ...;
        let ZoneRules(x1) = x;
        let Instant(instant1) = instant;
        isDaylightSavings(x1, instant1) as & Pure
*/

    pub def isValidOffset(x: ZoneRules, localDateTime: LocalDateTime, offset: ZoneOffset): Bool =
        import java.time.zone.ZoneRules.isValidOffset(##java.time.LocalDateTime, ##java.time.ZoneOffset): Bool & Pure;
        let ZoneRules(x1) = x;
        let LocalDateTime(localDateTime1) = localDateTime;
        let ZoneOffset(offset1) = offset;
        isValidOffset(x1, localDateTime1, offset1)

/*
    pub def previousTransition(x: ZoneRules, instant: Instant): ZoneOffsetTransition =
        import java.time.zone.ZoneRules.previousTransition(##java.time.Instant);
        let ZoneRules(x1) = x;
        let Instant(instant1) = instant;
        ZoneOffsetTransition(previousTransition(x1, instant1)) as & Pure
*/

}
