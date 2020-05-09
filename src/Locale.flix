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

pub opaque type Locale = ##java.util.Locale

namespace Locale {

    pub def english(): Locale = 
        import get java.util.Locale:ENGLISH as getEnglish;
        Locale(getEnglish()) as & Pure

    pub def france(): Locale = 
        import get java.util.Locale:FRANCE as getFrance;
        Locale(getFrance()) as & Pure
    
    pub def french(): Locale = 
        import get java.util.Locale:FRENCH as getFrench;
        Locale(getFrench()) as & Pure
    
}