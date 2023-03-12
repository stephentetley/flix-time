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

namespace Time/Chrono {

    /// Interface...

    pub enum Era(##java.time.chrono.Era)

    pub class ImplementsEra[t: Type] {
        pub def toEra(s: t): Era
        pub def fromEra(s: Era): t
    }

}

namespace Time/Chrono/Era {

    use Time/Chrono.Era
    use Time/Chrono.Era.{Era}
    use Time/Format.TextStyle
    use Interop/Util.Locale

    pub def getHH(x: Era): ##java.time.chrono.Era = 
        let Era(x1) = x;
        x1

    pub def getDisplayName(style: TextStyle, locale: Locale, e: Era): String =
        import java.time.chrono.Era.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let style1 = Time/Format/TextStyle.marshal(style);
        let locale1 = Interop/Util/Locale.getHH(locale);
        let Era(e1) = e;
        getDisplayName(e1, style1, locale1)

    pub def getValue(e: Era): Int32 =
        import java.time.chrono.Era.getValue(): Int32 \ {};
        let Era(e1) = e;
        getValue(e1)

}