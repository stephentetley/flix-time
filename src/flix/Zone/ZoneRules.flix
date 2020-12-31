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
        def toString(x: ZoneRules): String =
            import java.time.zone.ZoneRules.toString();
            let ZoneRules(x1) = x;
            toString(x1) as & Pure
    }

}

namespace Time/Zone/ZoneRules {

    use Time/Zone.ZoneRules;
    use Time/Zone.ZoneRules.{ZoneRules};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(offset: ZoneOffset): ZoneRules =
        import java.time.zone.ZoneRules:of(##java.time.ZoneOffset);
        let ZoneOffset(x1) = offset;
        ZoneRules(of(x1)) as & Pure


}
