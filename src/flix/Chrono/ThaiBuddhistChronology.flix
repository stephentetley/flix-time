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

namespace Time/Chrono {

    pub opaque type ThaiBuddhistChronology = ##java.time.chrono.ThaiBuddhistChronology

}

namespace Time/Chrono/ThaiBuddhistChronology {

    use Time/Chrono.ThaiBuddhistChronology;
    use Time/Chrono.ThaiBuddhistChronology.{ThaiBuddhistChronology};

    pub def getInstance(): ThaiBuddhistChronology & Impure = 
        import get java.time.chrono.ThaiBuddhistChronology:INSTANCE      as getINSTANCE;
        ThaiBuddhistChronology(getINSTANCE())

    pub def getCalendarType(x: ThaiBuddhistChronology): String  = 
        import java.time.chrono.ThaiBuddhistChronology.getCalendarType();
        let ThaiBuddhistChronology(x1) = x;
        getCalendarType(x1) as & Pure

}
