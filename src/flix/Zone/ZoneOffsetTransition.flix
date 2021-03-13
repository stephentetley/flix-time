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
    /// A wrapper around a Java ZoneOffsetTransition.
    ///
    pub opaque type ZoneOffsetTransition = ##java.time.zone.ZoneOffsetTransition

    instance ToString[ZoneOffsetTransition] {
        pub def toString(x: ZoneOffsetTransition): String =
            import java.time.zone.ZoneOffsetTransition.toString();
            let ZoneOffsetTransition(x1) = x;
            toString(x1) as & Pure
    }

}

namespace Time/Zone/ZoneOffsetTransition {

    use Time/Zone.ZoneOffsetTransition;
    use Time/Zone.ZoneOffsetTransition.{ZoneOffsetTransition};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    use Time.LocalDateTime;
    use Time.LocalDateTime.{LocalDateTime};

    pub def new(x: {transition: LocalDateTime, before: ZoneOffset, after: ZoneOffset}): ZoneOffsetTransition =
        import java.time.zone.ZoneOffsetTransition:of(##java.time.LocalDateTime, ##java.time.ZoneOffset, ##java.time.ZoneOffset);
        let LocalDateTime(dt1) = x.transition;
        let ZoneOffset(b1) = x.before;
        let ZoneOffset(a1) = x.after;
        ZoneOffsetTransition(of(dt1, b1, a1)) as & Pure


}
