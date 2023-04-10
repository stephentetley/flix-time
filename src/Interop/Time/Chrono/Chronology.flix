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

mod Interop.Time.Chrono {

    /// Interface...

    pub enum Chronology(##java.time.chrono.Chronology)

    pub class ImpChronology[t: Type] {
        pub def toChronology(s: t): Chronology
        pub def fromChronology(s: Chronology): t
    }

}

mod Interop.Time.Chrono.Chronology {


    use Time.Format.TextStyle

    use Interop.Time.Chrono.Chronology
    use Interop.Time.Chrono.Chronology.{Chronology}
    use Interop.Util.Locale
    use Interop.Util.Locale.{Locale}

    pub def getDisplayName(sty: TextStyle, loc: Locale, x: Chronology): String = 
        import java.time.chrono.Chronology.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};        
        let Locale(loc1) = loc;
        let sty1 = Time.Format.TextStyle.marshal(sty);
        let Chronology(x1) = x;
        getDisplayName(x1, sty1, loc1)

}
