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

    pub opaque type WeekFields = ##java.time.temporal.WeekFields

    instance ToString[WeekFields] {
        pub def toString(x: WeekFields): String =
            import java.time.temporal.WeekFields.toString(): String & Pure;
            let WeekFields(x1) = x;
            toString(x1)
    }
    
    instance Eq[WeekFields] {
        pub def eq(x: WeekFields, y: WeekFields): Bool = Time/Temporal/WeekFields.equals(x, y)
    }

    instance Hash[WeekFields] {
        pub def hash(x: WeekFields): Int32 = Time/Temporal/WeekFields.hashCode(x)
    }

}

namespace Time/Temporal/WeekFields {

    use Time/Temporal.WeekFields;
    use Time/Temporal.WeekFields.{WeekFields};
    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};
    use Time.DayOfWeek;
    use Time/Temporal.ChronoField;

    pub def of(r: {firstDayOfWeek :: DayOfWeek, minimalDaysInFirstWeek :: Int32}): WeekFields =
        import static java.time.temporal.WeekFields.of(##java.time.DayOfWeek, Int32): ##java.time.temporal.WeekFields & Pure;
        let firstDayOfWeek1 = Time/DayOfWeek.marshal(r.firstDayOfWeek);
        WeekFields(of(firstDayOfWeek1, r.minimalDaysInFirstWeek))

    pub def ofLocale(locale: { locale :: Locale}): WeekFields = 
        import static java.time.temporal.WeekFields.of(##java.util.Locale): ##java.time.temporal.WeekFields & Pure;
        let Locale(x1) = locale.locale;
        WeekFields(of(x1))

    pub def iso(): WeekFields = 
        import static get java.time.temporal.WeekFields.ISO: ##java.time.temporal.WeekFields & Pure as getISO;
        WeekFields(getISO())

     pub def sundayStart(): WeekFields = 
        import static get java.time.temporal.WeekFields.SUNDAY_START: ##java.time.temporal.WeekFields & Pure as getSUNDAY_START;
        WeekFields(getSUNDAY_START())

    pub def getFirstDayOfWeek(x: WeekFields): DayOfWeek =
        import java.time.temporal.WeekFields.getFirstDayOfWeek(): ##java.time.DayOfWeek & Pure;
        let WeekFields(x1) = x;
        Time/DayOfWeek.unmarshal(getFirstDayOfWeek(x1))

    pub def getMinimalDaysInFirstWeek(x: WeekFields): Int32 =
        import java.time.temporal.WeekFields.getMinimalDaysInFirstWeek(): Int32 & Pure;
        let WeekFields(x1) = x;
        getMinimalDaysInFirstWeek(x1)

    pub def equals(x: WeekFields, y: WeekFields): Bool =
        import java.time.temporal.WeekFields.equals(##java.lang.Object): Bool & Pure;
        let WeekFields(x1) = x;
        let WeekFields(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: WeekFields): Int32 =
        import java.time.temporal.WeekFields.hashCode(): Int32 & Pure;
        let WeekFields(x1) = x;
        hashCode(x1)


    /// /// TODO not sure casting to ChronoField is wise... 
    /// pub def weekBasedYear(x: WeekFields): ChronoField = 
    ///     import java.time.temporal.WeekFields.weekBasedYear(): ##java.time.temporal.TemporalField & Pure;
    ///     let WeekFields(x1) = x;
    ///     let cx1 = weekBasedYear(x1) as ##java.time.temporal.ChronoField;
    ///     Time/Temporal/ChronoField.unmarshal(cx1)

    /// pub def weekOfMonth(x: WeekFields): ChronoField = 
    ///     import java.time.temporal.WeekFields.weekOfMonth(): ##java.time.temporal.TemporalField & Pure;
    ///     let WeekFields(x1) = x;
    ///     let cx1 = weekOfMonth(x1) as ##java.time.temporal.ChronoField;
    ///     Time/Temporal/ChronoField.unmarshal(cx1)

    /// pub def weekOfWeekBasedYear(x: WeekFields): ChronoField = 
    ///     import java.time.temporal.WeekFields.weekOfWeekBasedYear(): ##java.time.temporal.TemporalField & Pure;
    ///     let WeekFields(x1) = x;
    ///     let cx1 = weekOfWeekBasedYear(x1) as ##java.time.temporal.ChronoField;
    ///     Time/Temporal/ChronoField.unmarshal(cx1)

    /// pub def weekOfYear(x: WeekFields): ChronoField = 
    ///     import java.time.temporal.WeekFields.weekOfYear(): ##java.time.temporal.TemporalField & Pure;
    ///     let WeekFields(x1) = x;
    ///     let cx1 = weekOfYear(x1) as ##java.time.temporal.ChronoField;
    ///     Time/Temporal/ChronoField.unmarshal(cx1)

}
