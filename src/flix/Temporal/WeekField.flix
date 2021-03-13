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
        pub def toString(x: WeekField): String =
            import java.time.temporal.WeekFields.toString() as toString;
            let WeekField(x1) = x;
            toString(x1) as & Pure
    }
    
    instance Eq[WeekField] {
        pub def eq(x: WeekField, y: WeekField): Bool = Time/Temporal/WeekField.equals(x, y)
        pub def neq(x: WeekField, y: WeekField): Bool = not (x == y)
    }

    instance Hash[WeekField] {
        pub def hash(x: WeekField): Int = Time/Temporal/WeekField.hashCode(x)
    }

}

namespace Time/Temporal/WeekField {

    use Time/Temporal.WeekField;
    use Time/Temporal.WeekField.{WeekField};
    use I18n.Locale;
    use I18n.Locale.{Locale};
    use Time.DayOfWeek;
    use Time/Temporal.ChronoField;

    pub def new(x: {firstDayOfWeek: DayOfWeek, minimalDaysInFirstWeek: Int32}): WeekField = 
        import java.time.temporal.WeekFields:of(##java.time.DayOfWeek, Int32);
        let firstDayOfWeek1 = Time/DayOfWeek.marshal(x.firstDayOfWeek);
        WeekField(of(firstDayOfWeek1, x.minimalDaysInFirstWeek)) as & Pure

    pub def newWithLocal(x: Locale): WeekField = 
        import java.time.temporal.WeekFields:of(##java.util.Locale);
        let Locale(x1) = x;
        WeekField(of(x1)) as & Pure

    pub def iso(): WeekField = 
        import get java.time.temporal.WeekFields:ISO as getISO;
        WeekField(getISO()) as & Pure

     pub def sundayStart(): WeekField = 
        import get java.time.temporal.WeekFields:SUNDAY_START as getSUNDAY_START;
        WeekField(getSUNDAY_START()) as & Pure

    pub def getFirstDayOfWeek(x: WeekField): DayOfWeek =
        import java.time.temporal.WeekFields.getFirstDayOfWeek();
        let WeekField(x1) = x;
        Time/DayOfWeek.unmarshal(getFirstDayOfWeek(x1)) as & Pure

    pub def getMinimalDaysInFirstWeek(x: WeekField): Int32 =
        import java.time.temporal.WeekFields.getMinimalDaysInFirstWeek();
        let WeekField(x1) = x;
        getMinimalDaysInFirstWeek(x1) as & Pure

    pub def equals(x: WeekField, y: WeekField): Bool =
        import java.time.temporal.WeekFields.equals(##java.lang.Object);
        let WeekField(x1) = x;
        let WeekField(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: WeekField): Int32 =
        import java.time.temporal.WeekFields.hashCode();
        let WeekField(x1) = x;
        hashCode(x1) as & Pure

    pub def weekBasedYear(x: WeekField): ChronoField = 
        import java.time.temporal.WeekFields.weekBasedYear();
        let WeekField(x1) = x;
        let jcf = weekBasedYear(x1) as ##java.time.temporal.ChronoField & Pure;
        Time/Temporal/ChronoField.unmarshal(jcf)

    pub def weekOfMonth(x: WeekField): ChronoField = 
        import java.time.temporal.WeekFields.weekOfMonth();
        let WeekField(x1) = x;
        let jcf = weekOfMonth(x1) as ##java.time.temporal.ChronoField & Pure;
        Time/Temporal/ChronoField.unmarshal(jcf)

    pub def weekOfWeekBasedYear(x: WeekField): ChronoField = 
        import java.time.temporal.WeekFields.weekOfWeekBasedYear();
        let WeekField(x1) = x;
        let jcf = weekOfWeekBasedYear(x1) as ##java.time.temporal.ChronoField & Pure;
        Time/Temporal/ChronoField.unmarshal(jcf)

    pub def weekOfYear(x: WeekField): ChronoField = 
        import java.time.temporal.WeekFields.weekOfYear();
        let WeekField(x1) = x;
        let jcf = weekOfYear(x1) as ##java.time.temporal.ChronoField & Pure;
        Time/Temporal/ChronoField.unmarshal(jcf)

}
