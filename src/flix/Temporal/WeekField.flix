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


namespace Time/Temporal {

    pub opaque type WeekField = ##java.time.temporal.WeekFields

    instance ToString[WeekField] {
        def toString(x: WeekField): String = 
            import java.time.temporal.WeekFields.toString() as toString;
            let WeekField(x1) = x;
            toString(x1) as & Pure
    }

}

namespace Time/Temporal/WeekField {

    use Time/Temporal.WeekField;
    use Time/Temporal.WeekField.{WeekField};
    use Time.DayOfWeek;
    use Time/DayOfWeek.{unmarshal};

    pub def iso(): WeekField = 
        import get java.time.temporal.WeekFields:ISO as getISO;
        WeekField(getISO()) as & Pure

     pub def sundayStart(): WeekField = 
        import get java.time.temporal.WeekFields:SUNDAY_START as getSUNDAY_START;
        WeekField(getSUNDAY_START()) as & Pure

    pub def getFirstDayOfWeek(x: WeekField): DayOfWeek =
        import java.time.temporal.WeekFields.getFirstDayOfWeek();
        let WeekField(x1) = x;
        unmarshal(getFirstDayOfWeek(x1)) as & Pure

}