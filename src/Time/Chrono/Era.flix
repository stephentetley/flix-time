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

mod Time.Chrono {
    
    import java.time.chrono.{Era => JEra}

    /// Interface...
    
    pub enum Era(JEra)


}

mod Time.Chrono.Era {

    use Locale.{Locale}
    use Time.Chrono.Era
    use Time.Chrono.Era.{Era}
    use Time.Format.TextStyle


    pub def getDisplayName(style: TextStyle, locale: Locale, e: Era): String =
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        let Era(e1) = e;
        unsafe e1.getDisplayName(style1, locale1)

    pub def getValue(e: Era): Int32 =
        let Era(e1) = e;
        unsafe e1.getValue()

}
