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

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Temporal.WeekFields;
    use Time/Temporal.WeekFields.{WeekFields};
    use Time/Temporal.TemporalField;

    pub def getWeekFields(x: WeekFields): ##java.time.temporal.WeekFields = 
        let WeekFields(x1) = x;
        x1

    pub def of(r: {firstDayOfWeek :: Time.DayOfWeek, minimalDaysInFirstWeek :: Int32}): WeekFields =
        import static java.time.temporal.WeekFields.of(##java.time.DayOfWeek, Int32): ##java.time.temporal.WeekFields & Pure;
        let firstDayOfWeek1 = Time/DayOfWeek.marshal(r.firstDayOfWeek);
        WeekFields(of(firstDayOfWeek1, r.minimalDaysInFirstWeek))

    pub def ofLocale(locale: {locale :: Locale}): WeekFields = 
        import static java.time.temporal.WeekFields.of(##java.util.Locale): ##java.time.temporal.WeekFields & Pure;
        let Locale(x1) = locale.locale;
        WeekFields(of(x1))

    pub def iso(): WeekFields = 
        import static get java.time.temporal.WeekFields.ISO: ##java.time.temporal.WeekFields & Pure as getISO;
        WeekFields(getISO())

     pub def sundayStart(): WeekFields = 
        import static get java.time.temporal.WeekFields.SUNDAY_START: ##java.time.temporal.WeekFields & Pure as getSUNDAY_START;
        WeekFields(getSUNDAY_START())

    pub def getFirstDayOfWeek(x: WeekFields): Time.DayOfWeek =
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

    def toStringHelper(constrName: String, x: ##java.time.temporal.TemporalField): String = 
        import java.time.temporal.TemporalField.toString(): String & Pure as toString1;
        let body = toString1(x);
        "${constrName}(${body})"

    /// DayOfWeek

    pub enum DayOfWeek { case DayOfWeek(##java.time.temporal.TemporalField) }

    instance ToString[DayOfWeek] {
        pub def toString(x: DayOfWeek): String = 
            let DayOfWeek(x1) = x;
            toStringHelper("DayOfWeekField", x1)        
    }

    pub def dayOfWeek(x: WeekFields): DayOfWeek = 
        import java.time.temporal.WeekFields.dayOfWeek(): ##java.time.temporal.TemporalField & Pure;
        let x1 = getWeekFields(x);
        DayOfWeek(dayOfWeek(x1))

    instance TemporalField[DayOfWeek] {
        pub def marshalToNativeTemporalField(x: DayOfWeek): ##java.time.temporal.TemporalField =
            let DayOfWeek(x1) = x;
            x1

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): DayOfWeek = 
            DayOfWeek(x)
    }

    /// WeekBasedYear

    pub enum WeekBasedYear { case WeekBasedYear(##java.time.temporal.TemporalField) }

    instance ToString[WeekBasedYear] {
        pub def toString(x: WeekBasedYear): String = 
            let WeekBasedYear(x1) = x;
            toStringHelper("WeekBasedYear", x1)
    }

    pub def weekBasedYear(x: WeekFields): WeekBasedYear = 
        import java.time.temporal.WeekFields.weekBasedYear(): ##java.time.temporal.TemporalField & Pure;
        let x1 = getWeekFields(x);
        WeekBasedYear(weekBasedYear(x1))

    instance TemporalField[WeekBasedYear] {
        pub def marshalToNativeTemporalField(x: WeekBasedYear): ##java.time.temporal.TemporalField =
            let WeekBasedYear(x1) = x;
            x1

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): WeekBasedYear = 
            WeekBasedYear(x)
    }

    /// WeekOfMonth

    pub enum WeekOfMonth { case WeekOfMonth(##java.time.temporal.TemporalField) }

    instance ToString[WeekOfMonth] {
        pub def toString(x: WeekOfMonth): String = 
            let WeekOfMonth(x1) = x;
            toStringHelper("WeekOfMonth", x1)
    }

    pub def weekOfMonth(x: WeekFields): WeekOfMonth = 
        import java.time.temporal.WeekFields.weekOfMonth(): ##java.time.temporal.TemporalField & Pure;
        let x1 = getWeekFields(x);
        WeekOfMonth(weekOfMonth(x1))

    instance TemporalField[WeekOfMonth] {
        pub def marshalToNativeTemporalField(x: WeekOfMonth): ##java.time.temporal.TemporalField =
            let WeekOfMonth(x1) = x;
            x1

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): WeekOfMonth = 
            WeekOfMonth(x)
    }

    /// WeekOfWeekBasedYear

    pub enum WeekOfWeekBasedYear { case WeekOfWeekBasedYear(##java.time.temporal.TemporalField) }

    instance ToString[WeekOfWeekBasedYear] {
        pub def toString(x: WeekOfWeekBasedYear): String = 
            let WeekOfWeekBasedYear(x1) = x;
            toStringHelper("WeekOfWeekBasedYear", x1)
    }

    pub def weekOfWeekBasedYear(x: WeekFields): WeekOfWeekBasedYear = 
        import java.time.temporal.WeekFields.weekOfWeekBasedYear(): ##java.time.temporal.TemporalField & Pure;
        let x1 = getWeekFields(x);
        WeekOfWeekBasedYear(weekOfWeekBasedYear(x1))

    instance TemporalField[WeekOfWeekBasedYear] {
        pub def marshalToNativeTemporalField(x: WeekOfWeekBasedYear): ##java.time.temporal.TemporalField =
            let WeekOfWeekBasedYear(x1) = x;
            x1

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): WeekOfWeekBasedYear = 
            WeekOfWeekBasedYear(x)
    }

    /// WeekOfYear

    pub enum WeekOfYear { case WeekOfYear(##java.time.temporal.TemporalField) }

    instance ToString[WeekOfYear] {
        pub def toString(x: WeekOfYear): String = 
            let WeekOfYear(x1) = x;
            toStringHelper("WeekOfYear", x1)
    }

    pub def weekOfYear(x: WeekFields): WeekOfYear = 
        import java.time.temporal.WeekFields.weekOfYear(): ##java.time.temporal.TemporalField & Pure;
        let x1 = getWeekFields(x);
        WeekOfYear(weekOfYear(x1))

    instance TemporalField[WeekOfYear] {
        pub def marshalToNativeTemporalField(x: WeekOfYear): ##java.time.temporal.TemporalField =
            let WeekOfYear(x1) = x;
            x1

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): WeekOfYear = 
            WeekOfYear(x)
    }

}
