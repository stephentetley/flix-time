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

mod Time.Internal.Chrono {

    import java.time.chrono.{Chronology => JChronology}

    /// Interface...

    pub enum Chronology(JChronology)


}

mod Time.Internal.Chrono.Chronology {


    use Time.Format.TextStyle

    use Time.Internal.Chrono.Chronology
    use Time.Internal.Chrono.Chronology.{Chronology}
    use Locale.{Locale}

    pub def getDisplayName(sty: TextStyle, loc: Locale, x: Chronology): String = 
        let Locale(loc1) = loc;
        let sty1 = Time.Format.TextStyle.marshalTextStyle(sty);
        let Chronology(x1) = x;
        unsafe x1.getDisplayName(sty1, loc1)

}
