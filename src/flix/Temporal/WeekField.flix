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
    
    instance Eq[WeekField] {
        def eq(x: WeekField, y: WeekField): Bool = Time/Temporal/WeekField.equals(x, y)
  

        def neq(x: WeekField, y: WeekField): Bool = not (x == y)
    }

    instance Hash[WeekField] {
        def hash(x: WeekField): Int = Time/Temporal/WeekField.hashCode(x)
    }

}

namespace Time/Temporal/WeekField {

    use Time/Temporal.WeekField;
    use Time/Temporal.WeekField.{WeekField};
    use Time.DayOfWeek;
    use Time/DayOfWeek.{unmarshal};

    pub def new(x: {firstDayOfWeek: DayOfWeek, minimalDaysInFirstWeek: Int32}): WeekField = 
        import java.time.temporal.WeekFields:of(##java.time.DayOfWeek, Int32);
        let firstDayOfWeek1 = Time/DayOfWeek.marshal(x.firstDayOfWeek);
        WeekField(of(firstDayOfWeek1, x.minimalDaysInFirstWeek)) as & Pure

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

    pub def equals(x: WeekField, y: WeekField): Bool =
        import java.time.temporal.WeekFields.equals(##java.lang.Object);
        let WeekField(x1) = x;
        let WeekField(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: WeekField): Int32 =
        import java.time.temporal.WeekFields.hashCode();
        let WeekField(x1) = x;
        hashCode(x1) as & Pure

}