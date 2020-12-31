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


namespace Time {

    ///
    /// A wrapper around a Java Clock.
    ///
    pub opaque type Clock = ##java.time.Clock

    ///
    /// Returns the given Clock `x` as a String.
    ///
    /// This uses the `java.lang.Object.toString()` method - the result is not expected to be user friendly.
    ///
    instance ToString[Clock] {
        def toString(x: Clock): String =
            import java.lang.Object.toString();
            let Clock(x1) = x;
            let o1 = x1 as ##java.lang.Object;
            toString(o1) as & Pure
    }

    instance Eq[Clock] {
        def eq(x: Clock, y: Clock): Bool =
            import java.time.Clock.equals(##java.lang.Object);
            let Clock(x1) = x;
            let Clock(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure

        def neq(x: Clock, y: Clock): Bool = not (x == y)
    }

}

namespace Time/Clock {

    use Time.Clock;
    use Time.Clock.{Clock};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def system(x: ZoneId): Clock & Impure =
        import java.time.Clock:system(##java.time.ZoneId);
        let ZoneId(x1) = x;
        Clock(system(x1))


    pub def systemDefaultZone(): Clock & Impure =
        import java.time.Clock:systemDefaultZone();
        Clock(systemDefaultZone())

    pub def systemUTC(): Clock & Impure =
        import java.time.Clock:systemUTC();
        Clock(systemUTC())

}
